//
//  MediaItemCollection.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 6/09/22.
//

import AmuseKit
import Foundation

protocol MediaItemCollection: MediaItem {
    var items: [MediaItem] { get }
}

extension MediaItemCollection {
    var previewURL: URL? {
        nil
    }
}

extension AmuseKit.Album: MediaItemCollection {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        attributes?.artistName ?? ""
    }
    
    var artworkURL: URL? {
        attributes?.artwork.formattedURL()
    }
    
    var items: [MediaItem] {
        relationships?.tracks?.data ?? []
    }
    
    var thumbURL: URL? {
        attributes?.artwork.formattedURL(size: (48, 48))
    }
}

extension AmuseKit.Artist: MediaItemCollection {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        ""
    }
    
    var artworkURL: URL? {
        nil
    }
    
    var items: [MediaItem] {
        []
    }
    
    var thumbURL: URL? {
        nil
    }
}

extension AmuseKit.Playlist: MediaItemCollection {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        attributes?.curatorName ?? ""
    }
    
    var artworkURL: URL? {
        attributes?.artwork?.formattedURL()
    }
    
    var items: [MediaItem] {
        relationships?.tracks?.data ?? []
    }
    
    var thumbURL: URL? {
        attributes?.artwork?.formattedURL(size: (48, 48))
    }
}

extension AmuseKit.Station: MediaItemCollection {
    var title: String {
        attributes?.name ?? ""
    }
    
    var subTitle: String {
        attributes?.stationProviderName ?? ""
    }
    
    var artworkURL: URL? {
        attributes?.artwork.formattedURL()
    }
    
    var items: [MediaItem] {
        []
    }
    
    var thumbURL: URL? {
        attributes?.artwork.formattedURL(size: (48, 48))
    }
}
