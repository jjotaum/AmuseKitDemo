//
//  MainViewController.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 2/09/22.
//

import AmuseKit
import Combine
import Foundation

class MainViewController: ObservableObject {
    let dataProvider: AmuseKit.DataProvider
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var model: MainView.Model = .init()
    
    init(dataProvider: AmuseKit.DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func search(query: String) {
        do {
            try dataProvider.catalogSearch(searchTerm: query)
                .sink { _ in
                } receiveValue: { [weak self] response in
                    guard let strongSelf = self else { return }
                    var aModel = strongSelf.model
                    aModel.albums = response.results?.albums?.data ?? []
                    aModel.artists = response.results?.artists?.data ?? []
                    aModel.musicVideos = response.results?.musicVideos?.data ?? []
                    aModel.playlists = response.results?.playlists?.data ?? []
                    aModel.stations = response.results?.stations?.data ?? []
                    aModel.songs = response.results?.songs?.data ?? []
                    strongSelf.model = aModel
                }.store(in: &subscriptions)
        } catch {
            print(error.localizedDescription)
        }
    }
}
