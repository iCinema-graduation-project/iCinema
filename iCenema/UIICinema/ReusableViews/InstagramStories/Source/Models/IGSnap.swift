//
//  IGSnap.swift
//
//  Created by Ranjith Kumar on 9/28/17
//  Copyright (c) DrawRect. All rights reserved.
//

import Foundation

public enum MimeType: String {
    case image
    case video
    case unknown
}
public class IGSnap: Codable {
    public let mimeType: String = "video"
    public let lastUpdated: String
    public let url: String
    // Store the deleted snaps id in NSUserDefaults, so that when app get relaunch deleted snaps will not display.

    public var kind: MimeType {
        switch mimeType {
            case MimeType.image.rawValue:
                return MimeType.image
            case MimeType.video.rawValue:
                return MimeType.video
            default:
                return MimeType.unknown
        }
    }
    enum CodingKeys: String, CodingKey {
        case mimeType = "mime_type"
        case lastUpdated = "created_at"
        case url = "url"
    }
}
