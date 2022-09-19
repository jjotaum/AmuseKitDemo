//
//  MainView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 2/09/22.
//

import AVFoundation
import SwiftUI

extension MainView {
    struct Model {
        var albums: [MediaItemCollection] = []
        var artists: [MediaItemCollection] = []
        var musicVideos: [MediaItem] = []
        var playlists: [MediaItemCollection] = []
        var songs: [MediaItem] = []
        var stations: [MediaItemCollection] = []
    }
}

struct MainView: View {
    var player = AVPlayer()
    @StateObject var controller: MainViewController
    @State var queryText: String = ""
    
    var body: some View {
        NavigationView {
            #if os(macOS)
                EmptyView()
                contentView()
            #else
                contentView()
            #endif
        }
        .onSubmit(of: .search) {
            controller.search(query: queryText)
        }
    }
    
    @ViewBuilder
    private func contentView() -> some View {
        List {
            SectionView(title: "Albums", elements: controller.model.albums, content: { album in
                mediaItemView(album)
            })
            SectionView(title: "Artists", elements: controller.model.artists, content: { artist in
                mediaItemView(artist)
            })
            SectionView(title: "Music Videos", elements: controller.model.musicVideos, content: { musicVideo in
                mediaItemView(musicVideo)
            })
            SectionView(title: "Playlists", elements: controller.model.playlists, content: { playlist in
                mediaItemView(playlist)
            })
            SectionView(title: "Songs", elements: controller.model.songs, content: { song in
                mediaItemView(song)
            })
            SectionView(title: "Stations", elements: controller.model.stations, content: { station in
                mediaItemView(station)
            })
        }
        .listStyle(.plain)
        .navigationTitle("Search")
        .searchable(text: $queryText, placement: .toolbar, prompt: "albums, artist, genres, songs...")
    }
    
    @ViewBuilder
    private func mediaItemView(_ mediaItem: MediaItem) -> some View {
        if let mediaCollection = mediaItem as? MediaItemCollection {
            NavigationLink {
                MediaItemCollectionDetailsView(
                    controller: .init(dataProvider: controller.dataProvider,
                                      id: mediaItem.id,
                                      title: mediaCollection.title,
                                      artworkURL: mediaCollection.artworkURL,
                                      items: mediaCollection.items)
                )
            } label: {
                MediaItemListView(model: .init(title: mediaCollection.title,
                                               subTitle: mediaCollection.subTitle,
                                               artworkURL: mediaCollection.thumbURL))
            }

        } else {
            MediaItemListView(model: .init(title: mediaItem.title,
                                           subTitle: mediaItem.subTitle,
                                           artworkURL: mediaItem.thumbURL)).onTapGesture {
                guard let url = mediaItem.previewURL else { return }
                player.replaceCurrentItem(with: .init(url: url))
                player.play()
            }
        }
    }
}

struct SectionView<Content: View>: View {
    let title: String
    let elements: [MediaItem]
    let content: (MediaItem) -> Content
    
    var body: some View {
        Section {
            if elements.isEmpty {
                Text("There are not results for \(title)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(elements, id: \.id) { element in
                    content(element)
                }
            }
        } header: {
            Text(title)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(controller: .init(dataProvider: .shared()))
    }
}
