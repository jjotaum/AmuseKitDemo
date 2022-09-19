//
//  MediaItemCollectionViewController.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 19/09/22.
//

import AmuseKit
import Combine
import Foundation

class MediaItemCollectionViewController: ObservableObject {
    private let dataProvider: AmuseKit.DataProvider
    private let id: String
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var model: MediaItemCollectionDetailsView.Model
    
    init(dataProvider: AmuseKit.DataProvider,
         id: String,
         title: String,
         artworkURL: URL?,
         items: [MediaItem]) {
        self.dataProvider = dataProvider
        self.id = id
        self.model = .init(title: title,
                           artworkURL: artworkURL,
                           items: items)
    }
    
    func onAppear() {
        do {
            try dataProvider.catalog(.albums, ids: [id]).sink { _ in
            } receiveValue: { [weak self] response in
                DispatchQueue.main.async {
                    self?.model.items = response.data?.first?.relationships?.tracks?.data ?? []
                }
            }.store(in: &subscriptions)
        } catch {
            print(error.localizedDescription)
        }
    }
}
