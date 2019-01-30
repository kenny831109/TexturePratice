//
//  Model.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation

struct Video: Decodable {
    let videos: [Videos]
}

struct Videos: Decodable {
    let video_files: [Video_files]
}

struct Video_files: Decodable {
    let file_type: String
    let width: Int?
    let height: Int?
    let link: String
    let quality: String
}
