//
//  MapViewController.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import UIKit
import SkeletonView

class MapViewController: UIViewController {
    
    var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSkeletonable = true
        //        view.backgroundColor = .green
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.showAnimatedGradientSkeleton()
    }
    
}
