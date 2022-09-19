//
//  MainView.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 2/09/22.
//

import SwiftUI

extension MainView {
    struct Model {
        var sections: [SectionViewModel] = []
    }
}

struct MainView: View {
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
        VStack {
            if controller.model.sections.isEmpty {
                Text("No Results")
                    .font(.title)
                    .foregroundColor(.secondary)
                
            } else {
                List {
                    ForEach(controller.model.sections) { section in
                        SectionView(model: section) { mediaItem in
                            mediaItemView(mediaItem)
                        }
                    }
                }
            }
        }
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
                controller.didSelect(mediaItem)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
