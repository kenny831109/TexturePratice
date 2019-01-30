//
//  MarketViewController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class MarketViewController: ASViewController<ASTableNode> {
    
    let listNode: ASTableNode
    //    let data = ["文具","家具","飲食","健康","生活"]
    var data = [MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false),
                MarketList(category: "文具", views: "66", isSelected: false),
                MarketList(category: "家具", views: "6", isSelected: false),
                MarketList(category: "飲食", views: "102", isSelected: false),
                MarketList(category: "健康", views: "91", isSelected: false),
                MarketList(category: "生活", views: "120", isSelected: false)]
    
    init() {
        listNode = ASTableNode(style: UITableView.Style.plain)
        super.init(node: listNode)
        listNode.dataSource = self
        listNode.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        listNode.view.allowsSelection = false
        listNode.view.tableFooterView = UIView()
    }
    
}

extension MarketViewController: ASTableDataSource, ASTableDelegate {
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return data.count
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        //        return data.count
        if data[section].isSelected {
            return 2
        }else {
            return 1
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let object = data[indexPath.section]
        let cellNodeBlock = { () -> ASCellNode in
            return MarketListCellNode(marketList: object)
        }
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        data[indexPath.section].isSelected.toggle()
        tableNode.reloadSections(IndexSet(integer: indexPath.section), with: UITableView.RowAnimation.automatic)
    }
    
}
