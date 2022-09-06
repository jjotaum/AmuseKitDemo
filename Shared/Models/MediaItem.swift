//
//  MediaItem.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 6/09/22.
//

import AmuseKit
import Foundation

protocol MediaItem {
    var id: String { get }
    var title: String { get }
    var subTitle: String { get }
    
    var artworkURL: URL? { get }
    var previewURL: URL? { get }
    var thumbURL: URL? { get }
}

extension AmuseKit.Song: MediaItem {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        attributes?.artistName ?? ""
    }
    
    var artworkURL: URL? {
        attributes?.artwork.formattedURL()
    }
    
    var previewURL: URL? {
        attributes?.previews.compactMap({ URL(string: $0.url) }).first
    }
    
    var thumbURL: URL? {
        attributes?.artwork.formattedURL(size: (48, 48))
    }
}

extension AmuseKit.MusicVideo: MediaItem {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        attributes?.artistName ?? ""
    }
    
    var artworkURL: URL? {
        attributes?.artwork.formattedURL()
    }
    
    var previewURL: URL? {
        attributes?.previews.compactMap({ URL(string: $0.url) }).first
    }
    
    var thumbURL: URL? {
        attributes?.artwork.formattedURL(size: (48, 48))
    }
}
