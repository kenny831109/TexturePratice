//
//  FriendDetailViewController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation
import UIKit

class FriendDetailViewController: UIViewController {
    
    let photoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let imageSize = image?.size else {return}
        let height = (view.frame.width / imageSize.width) * imageSize.height
        view.backgroundColor = .white
        view.addSubview(photoImageView)
        photoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        photoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        photoImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
        photoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 60).isActive = true
        photoImageView.image = image
    }
    
}
