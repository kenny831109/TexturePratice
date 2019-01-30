//
//  Model.swift
//  TexturePratice
//
//  Created by 逸唐陳 on 2019/1/30.
//  Copyright © 2019 逸唐陳. All rights reserved.
//

import Foundation

struct FriendList {
    let name: String
    let age: String
    let sex: String
}

struct Photo: Decodable {
    var photos: [Photos]
}

struct Photos: Decodable {
    let id: Int
    let photographer: String
    let src: Src
}

struct Src: Decodable {
    let original: String
    let medium: String
    let large: String
}
