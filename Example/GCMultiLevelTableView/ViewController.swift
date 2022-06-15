//
//  ViewController.swift
//  GCMultiLevelTableView
//
//  Created by 1137576021@qq.com on 06/15/2022.
//  Copyright (c) 2022 1137576021@qq.com. All rights reserved.
//

import UIKit
import GCMultiLevelTableView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        let d1 = MultiTableViewData(identifier: "1", data: 1, childs: [
            MultiTableViewData(identifier: "2", data: 2, childs: [
                MultiTableViewData(identifier: "1的笋子1", data: Int.random(in: 1000...2000), childs: [
                    MultiTableViewData(identifier: "x1", data: Int.random(in: 6000...7000), childs: [
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5)
                    ], tag: 4),
                    MultiTableViewData(identifier: "x2", data: Int.random(in: 6000...7000), childs: [
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5)
                    ], tag: 4),
                    MultiTableViewData(identifier: "x3", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x4", data: Int.random(in: 6000...7000), childs: [
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5),
                        MultiTableViewData(identifier: "", data: Int.random(in: 10000...11000), tag: 5)
                    ], tag: 4),
                    MultiTableViewData(identifier: "x5", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x6", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x7", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x8", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x9", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "x10", data: Int.random(in: 6000...7000), tag: 4)
                ], tag: 3),
                MultiTableViewData(identifier: "1的笋子2", data: Int.random(in: 1000...2000), tag: 3),
                MultiTableViewData(identifier: "1的笋子3", data: Int.random(in: 1000...2000), childs: [
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4),
                    MultiTableViewData(identifier: "", data: Int.random(in: 6000...7000), tag: 4)
                ], tag: 3),
                MultiTableViewData(identifier: "1的笋子4", data: Int.random(in: 1000...5000), tag: 3),
                MultiTableViewData(identifier: "1的笋子5", data: Int.random(in: 1000...5000), tag: 3),
            ], tag: 2),
            MultiTableViewData(identifier: "3", data: 3, tag: 2),
            MultiTableViewData(identifier: "4", data: 4, childs: [
                MultiTableViewData(identifier: "1的笋子41", data: Int.random(in: 1000...5000), tag: 3),
                MultiTableViewData(identifier: "1的笋子42", data: Int.random(in: 1000...5000), tag: 3),
                MultiTableViewData(identifier: "1的笋子43", data: Int.random(in: 1000...5000), tag: 3),
                MultiTableViewData(identifier: "1的笋子44", data: Int.random(in: 1000...5000), tag: 3),
                MultiTableViewData(identifier: "1的笋子45", data: Int.random(in: 1000...5000), tag: 3),
            ], tag: 2),
            MultiTableViewData(identifier: "5", data: 5, tag: 2)
        ], tag: 1)
        
        let d2 = MultiTableViewData(identifier: "6", data: 6, childs: [
            MultiTableViewData(identifier: "7", data: 7, tag: 2),
            MultiTableViewData(identifier: "8", data: 8, tag: 2),
            MultiTableViewData(identifier: "9", data: 9, tag: 2),
            MultiTableViewData(identifier: "10", data: 10, tag: 2),
            MultiTableViewData(identifier: "11", data: 11, tag: 2),
            MultiTableViewData(identifier: "12", data: 12, tag: 2),
            MultiTableViewData(identifier: "13", data: 13, tag: 2),
            MultiTableViewData(identifier: "14", data: 14, tag: 2)
        ], tag: 1)
        
        let d3 = MultiTableViewData(identifier: "15", data: 15, childs: [
            MultiTableViewData(identifier: "16", data: 16, tag: 2),
            MultiTableViewData(identifier: "17", data: 17, tag: 2),
            MultiTableViewData(identifier: "18", data: 18, tag: 2),
            MultiTableViewData(identifier: "19", data: 19, tag: 2)
        ], tag: 1)
        
        /*
        let cnt = 1000
        let d0 = MultiTableViewData(identifier: "0", data: 0, childs: [d1, d2, d3])
        let dx = MultiTableViewData(
            identifier: "root",
            data: -9999,
            childs: Array(repeating: d0, count: cnt)
        )
        
        
        let s1 = CACurrentMediaTime()
        let simple = Array(repeating: Int.random(in: 0...50000), count: cnt * 20 + 1)
        for i in 0..<simple.count {
            print(simple[i])
        }
        let e1 = CACurrentMediaTime()
        print("第一个时间：\(e1 - s1)")
        
        let nodestart = CACurrentMediaTime()
        for i in 0..<dx.displaySize() {
            print(dx.dataAt(i).data as! Int)
        }
        let nodeend = CACurrentMediaTime()
        print("第二个时间：\(nodeend - nodestart)")
         */
        
        
        let t = MultiLevelTableView(frame: .zero, style: .plain)
        t.multiLevelDelegate = self
        t.translatesAutoresizingMaskIntoConstraints = false
        t.items = [d1, d2, d3]
        view.addSubview(t)
        NSLayoutConstraint.activate([
            t.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            t.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            t.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            t.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        
        t.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            t.performDataOperations {
                d1.insertChild(MultiTableViewData(identifier: "", data: "插入值", childs: [
                    MultiTableViewData(identifier: "", data: "插入值的孩子1", tag: 3),
                    MultiTableViewData(identifier: "", data: "插入值的孩子2", tag: 3),
                    MultiTableViewData(identifier: "", data: "插入值的孩子3", tag: 3)
                ], tag: 2), at: 0)
            }
        }
    }


}

extension ViewController: MultiLevelTableViewDelegate {
    func multiTableView(_ tableView: MultiLevelTableView, cellForRowAt indexPath: IndexPath, data: MultiTableViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var indent = ""
        var tag = data.tag
        while tag > 1 {
            indent += "    "
            tag -=  1
        }
        cell.textLabel?.text = "\(indent) Level \(data.tag) - \(data.data)"
        return cell
    }
    
    func multiTableView(_ tableView: MultiLevelTableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath, data: MultiTableViewData) {
        
    }
    
    func multiTableView(_ tableView: MultiLevelTableView, didSelectRowAt indexPath: IndexPath, data: MultiTableViewData) {
        print("点击了：\(data.tag)-\(data.data)")
    }
    
    
    
}

