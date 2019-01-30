//
//  MarketListCellNode.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MarketListCellNode: ASCellNode {
    
    fileprivate var category: ASTextNode!
    fileprivate var views: ASTextNode!
    
    init(marketList: MarketList) {
        super.init()
        selectionStyle = .none
        self.accessoryType = .disclosureIndicator
        category = createTextNode(attributedString: NSAttributedString(string: marketList.category, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 22, weight: .regular)]))
        views = createTextNode(attributedString: NSAttributedString(string: marketList.views, attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12, weight: .light)]))
        automaticallyManagesSubnodes = true
        //        self.addSubnode(category)
    }
    
    fileprivate func createTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.attributedText = attributedString
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let nameLocationStack = ASStackLayoutSpec.horizontal()
        nameLocationStack.style.flexShrink = 1.0
        nameLocationStack.style.flexGrow = 1.0
        category.style.preferredSize = CGSize(width: 100, height: 30)
        nameLocationStack.child = category
        
        let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 40,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [nameLocationStack, views])
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 30, left: 10, bottom: 30, right: 10), child: headerStackSpec)
    }
    
}
