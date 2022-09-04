//
//  MainView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 2/09/22.
//

import AmuseKit
import AVFoundation
import SwiftUI

extension MainView {
    struct Model {
        var albums: [AmuseKit.Album] = []
        var artists: [AmuseKit.Artist] = []
        var musicVideos: [AmuseKit.MusicVideo] = []
        var playlists: [AmuseKit.Playlist] = []
        var songs: [AmuseKit.Song] = []
        var stations: [AmuseKit.Station] = []
    }
}

struct MainView: View {
    private var player = AVPlayer()
    @StateObject var controller = MainViewController()
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
                elementView(title: album.attributes?.name,
                            subTitle: album.attributes?.artistName,
                            imageURL: album.attributes?.artwork.formattedURL()) {
                    // Do nothing
                }
            })
            SectionView(title: "Artists", elements: controller.model.artists, content: { artist in
                elementView(title: artist.attributes?.name,
                            imageURL: nil) {
                    // Do nothing
                }
            })
            SectionView(title: "Music Videos", elements: controller.model.musicVideos, content: { musicVideo in
                elementView(title: musicVideo.attributes?.name,
                            imageURL: musicVideo.attributes?.artwork.formattedURL()) {
                    if let stringURL = musicVideo.attributes?.previews.first?.url, let url = URL(string: stringURL) {
                        player.replaceCurrentItem(with: .init(url: url))
                        player.play()
                    }
                }
            })
            SectionView(title: "Playlists", elements: controller.model.playlists, content: { playlist in
                elementView(title: playlist.attributes?.name,
                            subTitle: playlist.attributes?.curatorName,
                            imageURL: playlist.attributes?.artwork?.formattedURL()) {
                    // Do nothing
                }
            })
            SectionView(title: "Songs", elements: controller.model.songs, content: { song in
                elementView(title: song.attributes?.name,
                            imageURL: song.attributes?.artwork.formattedURL()) {
                    if let stringURL = song.attributes?.previews.first?.url, let url = URL(string: stringURL) {
                        player.replaceCurrentItem(with: .init(url: url))
                        player.play()
                    }
                }
            })
            SectionView(title: "Stations", elements: controller.model.stations, content: { station in
                elementView(title: station.attributes?.name,
                            imageURL: station.attributes?.artwork.formattedURL()) {
                    // Do nothing
                }
            })
        }
        .listStyle(.plain)
        .navigationTitle("Search")
        .searchable(text: $queryText, placement: .toolbar, prompt: "albums, artist, genres, songs...")
    }
    
    @ViewBuilder
    private func elementView(title: String?, subTitle: String? = nil, imageURL: URL?, onTapGesture: @escaping () -> Void) -> some View {
        HStack {
            AsyncImage(url: imageURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
            }
            .frame(width: 48, height: 48)
            .cornerRadius(4)
            
            VStack(alignment: .leading) {
                Text(title ?? "<unknown>")
                    .font(.headline)
                    .lineLimit(1)
                Text(subTitle ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: onTapGesture)
    }
}

struct SectionView<Element: Identifiable, Content: View>: View {
    let title: String
    let elements: [Element]
    let content: (Element) -> Content
    
    var body: some View {
        Section {
            if elements.isEmpty {
                Text("There are not results for \(title)")
                    .font(.headline)
                    .foregroundColor(.secondary)
            } else {
                ForEach(elements) { element in
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
        MainView()
    }
}
