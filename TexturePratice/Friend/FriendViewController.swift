//
//  FriendViewController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import SkeletonView

class FriendViewController: ASViewController<ASCollectionNode> {
    
    var filterButton: UIBarButtonItem!
    var searchBar: UISearchBar!
    var maskView: UIView!
    var slideView: UIView!
    var shopCollectionNode: ASCollectionNode
    var data: Photo?
    var page = 1
    var needMore = false
    var isOpen = false
    var tapGesture: UITapGestureRecognizer!
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 45) / 2, height: 250)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        shopCollectionNode = ASCollectionNode(collectionViewLayout: layout)
        super.init(node: shopCollectionNode)
        shopCollectionNode.dataSource = self
        shopCollectionNode.delegate = self
        shopCollectionNode.leadingScreensForBatching = 1.5
        shopCollectionNode.backgroundColor = .lightGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        getPhoto()
        addRightBarButton()
        addSearchBar()
    }
    
    func getPhoto() {
        let key = "563492ad6f91700001000001dcca59d4842b4be2b825e465cd592584"
        guard let url = URL(string: "https://api.pexels.com/v1/curated?per_page=40&page=\(page)") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            if err != nil {
                print(err!)
            }
            guard let data = data else {return}
            do {
                let photos = try JSONDecoder().decode(Photo.self, from: data)
                self.data = photos
                //                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                //                    self.shopCollectionNode.reloadData()
                //                    self.needMore = true
                //
                //                })
                DispatchQueue.main.async {
                    self.shopCollectionNode.reloadData()
                    self.needMore = true
                }
            }catch {
                print(error)
            }
            }.resume()
    }
    
    func getMorePhoto(context: ASBatchContext) {
        context.beginBatchFetching()
        self.page += 1
        self.needMore = false
        let key = "563492ad6f91700001000001dcca59d4842b4be2b825e465cd592584"
        guard let url = URL(string: "https://api.pexels.com/v1/curated?per_page=40&page=\(page)") else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(key, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: urlRequest) { (data, res, err) in
            if err != nil {
                print(err!)
            }
            guard let data = data else {return}
            do {
                let photos = try JSONDecoder().decode(Photo.self, from: data)
                for photo in photos.photos {
                    self.data?.photos.append(photo)
                }
                DispatchQueue.main.async {
                    self.addRowsIntoCollectionNode(newPhotoCount: photos.photos.count)
                    self.needMore = true
                    context.completeBatchFetching(true)
                }
            }catch {
                print(error)
            }
            }.resume()
    }
    
    func addRowsIntoCollectionNode(newPhotoCount newPhotos: Int) {
        guard let count = data?.photos.count else {return}
        let indexRange = (count - newPhotos..<count)
        let indexPaths = indexRange.map { IndexPath(row: $0, section: 0) }
        self.shopCollectionNode.insertItems(at: indexPaths)
    }
    
    func addRightBarButton() {
        filterButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(filterButtonDidTap))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    func addSearchBar() {
        searchBar = UISearchBar()
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
    }
    
    @objc func filterButtonDidTap() {
        isOpen.toggle()
        if isOpen {
            maskView = UIView(frame: view.frame)
            maskView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            maskView.isUserInteractionEnabled = true
            tapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewDidTap))
            maskView.addGestureRecognizer(tapGesture)
            view.addSubview(maskView)
            slideView = UIView(frame: CGRect(x: view.frame.width, y: 0, width: (view.frame.width / 2) + 40, height: view.frame.height))
            slideView.backgroundColor = .white
            slideView.isSkeletonable = true
            view.addSubview(slideView)
            openAnimation()
        }else {
            openAnimation()
        }
        shopCollectionNode.view.isScrollEnabled = !isOpen
        navigationController?.hidesBarsOnSwipe = !isOpen
    }
    
    @objc func maskViewDidTap() {
        shopCollectionNode.view.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.4, animations: {
            self.slideView.frame = CGRect(x: self.view.frame.width, y: 0, width: (self.view.frame.width / 2) + 40, height: self.view.frame.height)
        }) { (_) in
            self.maskView.removeGestureRecognizer(self.tapGesture)
            self.maskView.removeFromSuperview()
            self.slideView.removeFromSuperview()
            self.isOpen = false
            self.shopCollectionNode.view.isScrollEnabled = true
            self.navigationController?.hidesBarsOnSwipe = true
            self.shopCollectionNode.view.isUserInteractionEnabled = true
        }
    }
    
    func openAnimation() {
        if isOpen {
            UIView.animate(withDuration: 0.4, animations: {
                self.slideView.frame = CGRect(x: self.view.frame.width - ((self.view.frame.width / 2) + 40), y: 0, width: (self.view.frame.width / 2) + 40, height: self.view.frame.height)
            }) { (_) in
                //
            }
        }else {
            UIView.animate(withDuration: 0.4, animations: {
                self.slideView.frame = CGRect(x: self.view.frame.width, y: 0, width: (self.view.frame.width / 2) + 40, height: self.view.frame.height)
            }) { (_) in
                self.maskView.removeGestureRecognizer(self.tapGesture)
                self.maskView.removeFromSuperview()
                self.slideView.removeFromSuperview()
            }
        }
    }
    
}

extension FriendViewController: ASCollectionDelegate, ASCollectionDataSource {
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        if let count = data?.photos.count {
            return count
        }
        return 10
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let cellNodeBlock = { () -> ASCellNode in
            return FriendCellNode(list: self.data?.photos[indexPath.item])
        }
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        guard let node = collectionNode.nodeForItem(at: indexPath) as? FriendCellNode else {return}
        let vc = FriendDetailViewController()
        vc.image = node.imageNode.image
        searchBar.resignFirstResponder()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func shouldBatchFetch(for collectionNode: ASCollectionNode) -> Bool {
        return needMore
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, willBeginBatchFetchWith context: ASBatchContext) {
        getMorePhoto(context: context)
    }
    
}
