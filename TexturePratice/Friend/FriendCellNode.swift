//
//  FriendCellNode.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import SkeletonView

class FriendCellNode: ASCellNode {
    
    var nameNode: ASTextNode!
    var ageNode: ASTextNode!
    var sexNode: ASTextNode!
    var imageNode: ASNetworkImageNode!
    var isFirstLoading = true
    
    init(list: Photos?) {
        super.init()
        imageNode = ASNetworkImageNode()
        //        imageNode.placeholderColor = UIColor.gray
        imageNode.delegate = self
        nameNode = ASTextNode()
        ageNode = ASTextNode()
        sexNode = ASTextNode()
        backgroundColor = .white
        if let photo = list {
            imageNode.url = URL(string: photo.src.large)
            nameNode = createTextNode(attributedString: NSAttributedString(string: photo.photographer, attributes: [NSAttributedString.Key.foregroundColor : UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13, weight: .regular)]))
            ageNode = createTextNode(attributedString: NSAttributedString(string: "\(photo.id)", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 230/255, green: 60/255, blue: 47/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
            sexNode = createTextNode(attributedString: NSAttributedString(string: "55555", attributes: [NSAttributedString.Key.foregroundColor : UIColor(red: 230/255, green: 60/255, blue: 47/255, alpha: 1), NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: .medium)]))
        }
        ageNode.maximumNumberOfLines = 1
        sexNode.maximumNumberOfLines = 1
        nameNode.maximumNumberOfLines = 2
        automaticallyManagesSubnodes = true
    }
    
    override func didEnterVisibleState() {
        if isFirstLoading {
            view.showAnimatedGradientSkeleton()
        }
    }
    //
    override func didLoad() {
        imageNode.view.isSkeletonable = true
        nameNode.view.isSkeletonable = true
        ageNode.view.isSkeletonable = true
        sexNode.view.isSkeletonable = true
    }
    
    fileprivate func createTextNode(attributedString: NSAttributedString) -> ASTextNode {
        let textNode = ASTextNode()
        textNode.attributedText = attributedString
        return textNode
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let bottomInsets = UIEdgeInsets(top: 7, left: 10, bottom: 5, right: 10)
        let photoImageViewAbsolute = ASAbsoluteLayoutSpec(children: [imageNode])
        let bottomStack = ASStackLayoutSpec.vertical()
        bottomStack.spacing = 3
        bottomStack.justifyContent = .start
        nameNode.style.minSize = CGSize(width: constrainedSize.max.width - 20, height: 34)
        sexNode.style.alignSelf = .end
        bottomStack.children = [nameNode,ageNode, sexNode]
        let bottomView = ASInsetLayoutSpec(insets: bottomInsets, child: bottomStack)
        photoImageViewAbsolute.style.flexBasis = ASDimensionMake("66%")
        bottomView.style.flexBasis = ASDimensionMake("34%")
        let verticalStack = ASStackLayoutSpec.vertical()
        verticalStack.children = [photoImageViewAbsolute, bottomView]
        return verticalStack
    }
    
}

extension FriendCellNode: ASNetworkImageNodeDelegate {
    
    func imageNodeDidFinishDecoding(_ imageNode: ASNetworkImageNode) {
        isFirstLoading = false
        view.hideSkeleton()
        isUserInteractionEnabled = false
    }
    
}
