//
//  IGStory.swift
//
//  Created by Ranjith Kumar on 9/8/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

public class IGStory: Codable {
    public var id: Int

    public var snapsCount: Int = 1
    
    public var count_likes: Int?
    public var count_comments: Int?
    
    public var snaps: [IGSnap]
    public var user: IGUser
   
    var lastPlayedSnapIndex = 0
    var isCompletelyVisible = false
    var isCancelledAbruptly = false
    
    enum CodingKeys: String, CodingKey {
        case count_likes = "count_likes"
        case count_comments = "count_comments"
        case snaps = "snaps"
        case id = "id"
        case user = "cinema"
    }
}

extension IGStory: Equatable {
    public static func == (lhs: IGStory, rhs: IGStory) -> Bool {
        return lhs.id == rhs.id
    }
}
