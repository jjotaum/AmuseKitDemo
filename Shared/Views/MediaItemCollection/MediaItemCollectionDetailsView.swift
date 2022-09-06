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
        let items: [MediaItem]
    }
}

struct MediaItemCollectionDetailsView: View {
    @State var model: Model
    
    var body: some View {
        VStack {
            AsyncImage(url: model.artworkURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
            }
            .aspectRatio(contentMode: .fit)
            List {
                ForEach(model.items, id: \.id) { mediaItem in
                    MediaItemListView(model: .init(title: mediaItem.title,
                                                   subTitle: mediaItem.subTitle,
                                                   artworkURL: mediaItem.thumbURL))
                }
            }
        }
        .navigationTitle(model.title ?? "<Unknown>")
    }
}

struct CollectionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemCollectionDetailsView(model: .init(title: "Title", artworkURL: nil, items: []))
    }
}
