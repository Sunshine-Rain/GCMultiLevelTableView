//
//  MultiTableViewData.swift
//  MultiTableViewDemo
//
//  Created by quan on 2021/12/10.
//

import Foundation

open class MultiTableViewData {
    public enum SizeChange {
        case increase(_ count: Int)
        case decrease(_ count: Int)
    }
    
    open var identifier: String
    open var data: Any
    open weak var parent: MultiTableViewData?
    open var childs: [MultiTableViewData]
    
    open var isFold: Bool {
        didSet {
            let size = calculateCacheDispalySize(childs)
            updateSizeBubbleUp(
                value: isFold ? .decrease(size) : .increase(size)
            )
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
        updateSizeBubbleUp(
            value: .increase(data.displaySize())
        )
    }
    
    open func appendChilds(_ datas: [MultiTableViewData]) {
        datas.forEach { $0.parent = self }
        childs.append(contentsOf: datas)
        updateSizeBubbleUp(
            value: .increase(calculateCacheDispalySize(datas))
        )
    }
    
    open func insertChild(_ data: MultiTableViewData, at index: Int) {
        data.parent = self
        childs.insert(data, at: index)
        updateSizeBubbleUp(
            value: .increase(data.displaySize())
        )
    }
    
    open func insertChilds(_ datas: [MultiTableViewData], at index: Int) {
        datas.forEach { d in
            d.parent = self
        }
        childs.insert(contentsOf: datas, at: 0)
        updateSizeBubbleUp(
            value: .increase(calculateCacheDispalySize(datas))
        )
    }
    
    @discardableResult
    open func removeChildAt(_ index: Int) -> MultiTableViewData {
        let data = childs.remove(at: index)
        updateSizeBubbleUp(
            value: .decrease(data.displaySize())
        )
        return data
    }
    
    @discardableResult
    open func removeAllChilds() -> [MultiTableViewData] {
        return replaceChilds([])
    }
    
    @discardableResult
    open func replaceChilds(_ newChilds: [MultiTableViewData]) -> [MultiTableViewData] {
        let originalChilds = childs
        childs = newChilds
        
        let originalSize = calculateCacheDispalySize(originalChilds)
        let newSize = calculateCacheDispalySize(newChilds)
        let delta = newSize - originalSize
        updateSizeBubbleUp(
            value: delta >= 0 ? .increase(delta) : .decrease(-delta)
        )
        return originalChilds
    }
    
    open func updateSizeBubbleUp(value: SizeChange) {
        var updateNode: MultiTableViewData? = self
        while updateNode != nil {
            switch value {
            case .increase(let cnt):
                updateNode!._totalSize += cnt
            case .decrease(let cnt):
                updateNode!._totalSize -= cnt
            }
            updateNode = updateNode?.parent
        }
    }
    
    /// Calculate display size using 'func displaySize()'
    @inline(__always)
    private func calculateCacheDispalySize(_ items: [MultiTableViewData]) -> Int {
        return items.reduce(0) { partialResult, d in
            return partialResult + d.displaySize()
        }
    }
    
    /// Re Calculate Size
    public static func sizeFor(_ data: MultiTableViewData) -> Int {
        if data.isFold { return 1 }
        return data.childs.reduce(1) { partialResult, data in
            return partialResult + Self.sizeFor(data)
        }
    }
}
