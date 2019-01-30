//
//  VideoCellNode.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import SkeletonView

class VideoCellNode: ASCellNode {
    
    var videoNode: ASVideoNode!
    var isFirstLoading = true
    
    init(video: Videos?) {
        super.init()
        backgroundColor = .white
        videoNode = ASVideoNode()
        videoNode.shouldAutoplay = true
        videoNode.shouldAutorepeat = true
        videoNode.muted = true
        videoNode.delegate = self
        if let video = video {
            if let file = video.video_files.filter({$0.quality == "hd"}).first {
                let asset = AVAsset(url: URL(string: file.link)!)
                DispatchQueue.main.async {
                    self.videoNode.asset = asset
                }
            }
        }
        automaticallyManagesSubnodes = true
    }
    
    override func didEnterVisibleState() {
        if isFirstLoading {
            videoNode.view.showAnimatedGradientSkeleton()
        }
    }
    
    //    override func didExitVisibleState() {
    //        videoNode.pause()
    //    }
    
    override func didLoad() {
        videoNode.view.isSkeletonable = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let videoNodeLayout = ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: videoNode)
        return videoNodeLayout
    }
    
}

extension VideoCellNode: ASVideoNodeDelegate {
    
    func videoNodeDidFinishInitialLoading(_ videoNode: ASVideoNode) {
        isFirstLoading = false
        videoNode.view.hideSkeleton()
    }
    
}

