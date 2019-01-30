//
//  TagViewController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TagViewController: ASViewController<ASCollectionNode> {
    
    var videoCollectionNode: ASCollectionNode
    var needMore: Bool = false
    var data: Video?
    var barHeight: CGFloat {
        if let navBarHeight = navigationController?.navigationBar.frame.height {
            return navBarHeight + UIApplication.shared.statusBarFrame.height
        }else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
        layout.minimumLineSpacing = 20
        videoCollectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(node: videoCollectionNode)
        videoCollectionNode.delegate = self
        videoCollectionNode.dataSource = self
        videoCollectionNode.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        print(navigationController?.navigationBar.frame.height)
        //        print(UIApplication.shared.statusBarFrame.height)
        getVideos()
    }
    
    func getVideos() {
        let key = "563492ad6f91700001000001dcca59d4842b4be2b825e465cd592584"
        guard let url = URL(string: "https://api.pexels.com/videos/popular?per_page=40&page=1") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            if err != nil {
                print(err!)
            }
            guard let data = data else {return}
            do {
                let video = try JSONDecoder().decode(Video.self, from: data)
                self.data = video
                DispatchQueue.main.async {
                    self.videoCollectionNode.reloadData()
                    self.needMore = true
                }
            }catch {
                print(error)
            }
            }.resume()
    }
    
}

extension TagViewController: ASCollectionDelegate, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if let count = data?.videos.count {
            return count
        }
        return 5
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        let cellNodeBlock = { () -> ASCellNode in
            return VideoCellNode(video: self.data?.videos[indexPath.item])
        }
        return cellNodeBlock
    }
    
    
    //    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    //        if videoCollectionNode.contentOffset.y == -barHeight {
    //            print("table at top")
    //            guard   let topIndexPath = videoCollectionNode.indexPathsForVisibleItems.first,
    //                let videoNodeCell = videoCollectionNode.nodeForItem(at: topIndexPath) as? VideoCellNode else {return}
    //            videoNodeCell.videoNode.play()
    //            return
    //        }
    //
    //        if(!scrollView.isDecelerating && !scrollView.isDragging) {
    //            videoCollectionNode.visibleNodes.forEach { (node) in
    //                guard let indexPath = videoCollectionNode.indexPath(for: node) else {return}
    //                let nodeRect = videoCollectionNode.view.layoutAttributesForItem(at: indexPath)?.frame
    //                let superNode = videoCollectionNode.supernode
    //                let convertedRect = videoCollectionNode.convert(nodeRect!, to: superNode)
    //                let intersect = videoCollectionNode.frame.intersection(convertedRect)
    //                let visibleHeight = intersect.height
    //                print("VISIBLE HEIGHT = \(visibleHeight)")
    //                if visibleHeight > nodeRect!.height * 0.6 {
    //                    guard let videoCellNode = node as? VideoCellNode else {return}
    //                    videoCellNode.videoNode.play()
    //                    print("autoplay cell at \(indexPath.item)")
    //                }
    //            }
    //
    //        }
    //    }
    
    
}
