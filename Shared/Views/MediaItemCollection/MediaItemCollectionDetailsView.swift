//
//  MediaItemCollectionDetailsView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 6/09/22.
//

import SwiftUI

extension MediaItemCollectionDetailsView {
    struct Model {
        let title: String?
        let artworkURL: URL?
        var items: [MediaItem]
    }
}

struct MediaItemCollectionDetailsView: View {
    @StateObject var controller: MediaItemCollectionViewController
    
    var body: some View {
        List {
            Section {
                ForEach(controller.model.items, id: \.id) { mediaItem in
                    MediaItemListView(model: .init(title: mediaItem.title,
                                                   subTitle: mediaItem.subTitle,
                                                   artworkURL: mediaItem.thumbURL))
                }
            } header: {
                AsyncImage(url: controller.model.artworkURL) { image in
                    image.resizable()
                } placeholder: {
                    Rectangle()
                }
                .aspectRatio(contentMode: .fit)
                .cornerRadius(16)
                .padding(.bottom)
            }
        }
        .navigationTitle(controller.model.title ?? "<Unknown>")
        .onAppear {
            controller.onAppear()
        }
    }
}

struct CollectionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemCollectionDetailsView(
            controller: .init(
                id: "1",
                title: "Title",
                artworkURL: nil,
                items: [])
        )
    }
}
