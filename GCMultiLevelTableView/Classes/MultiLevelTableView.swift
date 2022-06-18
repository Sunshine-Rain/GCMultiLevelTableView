//
//  MultiLevelTableView.swift
//  MultiTableViewDemo
//
//  Created by quan on 2021/12/9.
//

import UIKit

public protocol MultiLevelTableViewDelegate: AnyObject {
    func multiTableView(_ tableView: MultiLevelTableView, cellForRowAt indexPath: IndexPath, data: MultiTableViewData) -> UITableViewCell
    func multiTableView(_ tableView: MultiLevelTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath, data: MultiTableViewData)
    func multiTableView(_ tableView: MultiLevelTableView, didSelectRowAt indexPath: IndexPath, data: MultiTableViewData)
}

open class MultiLevelTableView: UITableView {
    
    open var multiLevelDelegate: MultiLevelTableViewDelegate?
    
    open var items: [MultiTableViewData] = [] {
        didSet {
            calculateSize()
            reloadData()
        }
    }
    
    open var optimizeFold: Bool = true
    
    open var optimizeFoldCount: Int = 500
    
    open var reloadAnimationType: UITableView.RowAnimation = .automatic
    
    open var insertAnimationType: UITableView.RowAnimation = .automatic
    
    open var deleteAnimationType: UITableView.RowAnimation = .automatic
    
    private var _cachedItemSize: Int = 0

    override public init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .plain)
        basicSetups()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        basicSetups()
    }
    
    /// Use changes items
    open func performDataOperations(operations: (()->Void)) {
        assert(Thread.isMainThread, "Main thread is required.")
        operations()
        calculateSize()
        reloadData()
    }
    
    private func basicSetups() {
        self.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        self.dataSource = self
        self.delegate = self
    }
    
    private func calculateSize() {
        _cachedItemSize = items.reduce(0, { partialResult, data in
            return partialResult + data.displaySize()
        })
    }
    
    private func getDataFor(_ indexPath: IndexPath) -> MultiTableViewData {
        assert(indexPath.row < _cachedItemSize, "Index out of bounds.")
        var index = indexPath.row
        for item in items {
            if index >= item.displaySize() {
                index -= item.displaySize()
                continue
            }
            return item.dataAt(index)
        }
        fatalError("Never occur")
    }
}


extension MultiLevelTableView: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _cachedItemSize
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let delegate = multiLevelDelegate else {
            return tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        }
        return delegate.multiTableView(self, cellForRowAt: indexPath, data: getDataFor(indexPath))
    }
    
    public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let delegate = multiLevelDelegate {
            delegate.multiTableView(self, willDisplay: cell, forRowAt: indexPath, data: getDataFor(indexPath))
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = getDataFor(indexPath)
        if data.canFold && data.autoFold && data.childs.count > 1 {
            let optimized = handleDataFoldOptimized(data)
            if optimized.0 { return }
            
            if #available(iOS 11.0, *), false {
                tableView.performBatchUpdates {
                    self.handleDataFoldAndReload(data, indexPath: indexPath , displaySize: optimized.1)
                }
            }
            else {
                tableView.beginUpdates()
                self.handleDataFoldAndReload(data, indexPath: indexPath , displaySize: optimized.1)
                tableView.endUpdates()
            }
        }
        
        if let delegate = multiLevelDelegate {
            delegate.multiTableView(self, didSelectRowAt: indexPath, data: data)
        }
    }
    
    /// TableView update for optimized.
    private func handleDataFoldOptimized(_ data: MultiTableViewData) -> (Bool, Int) {
        var displaySize = data.displaySize()
        data.isFold.toggle()
        self.calculateSize()
        if data.isFold == false { displaySize = data.displaySize() }

        if optimizeFold && displaySize > optimizeFoldCount {
            reloadData()
            return (true, -1)
        }
        
        return (false, displaySize)
    }
    
    /// TableView update for non optimized.
    private func handleDataFoldAndReload(_ data: MultiTableViewData, indexPath: IndexPath, displaySize: Int) {
        let lower = indexPath.row + 1
        let upper = indexPath.row + displaySize
        let indexPaths = Range(uncheckedBounds: (lower, upper)).map { index in
            IndexPath(row: index, section: indexPath.section)
        }
        if data.isFold {
            self.deleteRows(at: indexPaths, with: deleteAnimationType)
        }
        else {
            self.insertRows(at: indexPaths, with: insertAnimationType)
        }
        self.reloadRows(at: [indexPath], with: reloadAnimationType)
    }
}
