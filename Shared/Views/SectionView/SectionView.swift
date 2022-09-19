//
//  SectionView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 19/09/22.
//

import SwiftUI

enum SectionViewModel {
    case albums([MediaItem])
    case artists([MediaItem])
    case musicVideos([MediaItem])
    case songs([MediaItem])
    case stations([MediaItem])
}

struct SectionView<Content: View>: View {
    let model: SectionViewModel
    let content: (MediaItem) -> Content
    var body: some View {
        Section {
            ForEach(model.rawValue.mediaItems, id: \.id) { mediaItem in
                content(mediaItem)
            }
        } header: {
            Text(model.rawValue.type.rawValue)
        }
    }
}

extension SectionViewModel: RawRepresentable, Identifiable {
    var id: String {
        rawValue.type.rawValue
    }
    
    
    typealias RawValue = (type: MediaType, mediaItems: [MediaItem])
    
    init?(rawValue: (type: MediaType, mediaItems: [MediaItem])) {
        switch rawValue.type {
        case .albums:
            self = .albums(rawValue.mediaItems)
        case .artists:
            self = .artists(rawValue.mediaItems)
        case .musicVideos:
            self = .musicVideos(rawValue.mediaItems)
        case .songs:
            self = .songs(rawValue.mediaItems)
        case .stations:
            self = .stations(rawValue.mediaItems)
        }
    }
    
    var rawValue: (type: MediaType, mediaItems: [MediaItem]) {
        switch self {
        case .albums(let mediaItems):
            return (.albums, mediaItems)
        case .artists(let mediaItems):
            return (.artists, mediaItems)
        case .musicVideos(let mediaItems):
            return (.musicVideos, mediaItems)
        case .songs(let mediaItems):
            return (.songs, mediaItems)
        case .stations(let mediaItems):
            return (.stations, mediaItems)
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(model: .albums([]), content: { _ in Rectangle() })
    }
}
