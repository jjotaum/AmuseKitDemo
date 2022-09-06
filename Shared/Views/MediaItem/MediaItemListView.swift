//
//  MediaItemListView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 6/09/22.
//

import SwiftUI

extension MediaItemListView {
    struct Model {
        var title: String?
        var subTitle: String?
        var artworkURL: URL?
    }
}

struct MediaItemListView: View {
    @State var model: Model
    
    var body: some View {
        HStack {
            AsyncImage(url: model.artworkURL) { image in
                image.resizable()
            } placeholder: {
                Rectangle()
            }
            .frame(width: 48, height: 48)
            .cornerRadius(4)
            
            VStack(alignment: .leading) {
                Text(model.title ?? "<unknown>")
                    .font(.headline)
                    .lineLimit(1)
                Text(model.subTitle ?? "")
                    .font(.subheadline)
                    .lineLimit(1)
            }
            Spacer()
        }
    }
}

struct MediaItemListView_Previews: PreviewProvider {
    static var previews: some View {
        MediaItemListView(model:
                .init(title: "Title",
                      subTitle: "SubTitle",
                      artworkURL: nil)
        )
    }
}
