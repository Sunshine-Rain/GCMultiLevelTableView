//
//  MultiTableViewData.swift
//  MultiTableViewDemo
//
//  Created by quan on 2021/12/10.
//

import Foundation

open class MultiTableViewData {
    open var identifier: String
    open var data: Any
    open weak var parent: MultiTableViewData?
    open var childs: [MultiTableViewData]
    
    open var isFold: Bool {
        didSet {
            updateSizeBubbleUp()
        }
    }
    open var autoFold: Bool
    open var canFold: Bool
    
    open var tag: Int = 0
    
    private var _totalSize: Int = 0
    
    public init(identifier: String,
                data: Any,
                parent: MultiTableViewData? = nil,
                childs: [MultiTableViewData] = [],
                isFold: Bool = false,
                canFold: Bool = true,
                autoFold: Bool = true,
                tag: Int = 0) {
        self.identifier = identifier
        self.data = data
        self.childs = childs
        self.isFold = isFold
        self.canFold = canFold
        self.autoFold = autoFold
        self.tag = tag
        
        self._totalSize = Self.sizeFor(self)
        
        self.childs.forEach { $0.parent = self }
    }
    
    // 0 means self
    open func dataAt(_ index: Int) -> MultiTableViewData {
        assert(index >= 0 && index < _totalSize, "Range out of bounds.")
        
        if index == 0 { return self }
        
        if displaySize() == 1 + self.childs.count {
            return childs[index - 1]
        }
        
        var visitedCnt = 0
        var newIndex = index
        for child in childs {
            visitedCnt += child.displaySize()
            
            if visitedCnt > index - 1 {
                return child.dataAt(newIndex - 1)
            }
            newIndex -= child.displaySize()
        }
        
        fatalError("NEVER OCCUR ERROR")
    }
    
    open func displaySize() -> Int {
        return _totalSize
    }
    
    open func appendChild(_ data: MultiTableViewData) {
        data.parent = self
        childs.append(data)
        updateSizeBubbleUp()
    }
    
    open func appendChilds(_ datas: [MultiTableViewData]) {
        datas.forEach { $0.parent = self }
        childs.append(contentsOf: datas)
        updateSizeBubbleUp()
    }
    
    open func insertChild(_ data: MultiTableViewData, at index: Int) {
        data.parent = self
        childs.insert(data, at: index)
        updateSizeBubbleUp()
    }
    
    open func removeChildAt(_ index: Int) -> MultiTableViewData {
        let data = childs.remove(at: index)
        updateSizeBubbleUp()
        return data
    }
    
    open func updateSizeBubbleUp() {
        var updateNode: MultiTableViewData? = self
        while updateNode != nil {
            updateNode?._totalSize = Self.sizeFor(updateNode!)
            updateNode = updateNode?.parent
        }
    }
    
    public static func sizeFor(_ data: MultiTableViewData) -> Int {
        if data.isFold { return 1 }
        return data.childs.reduce(1) { partialResult, data in
            return partialResult + Self.sizeFor(data)
        }
    }
}
