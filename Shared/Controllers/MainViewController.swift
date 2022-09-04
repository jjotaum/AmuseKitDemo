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
    static let devToken = "YOUR_DEV_TOKEN_HERE"
    private var subscriptions: Set<AnyCancellable> = []
    let amuseProvider: AmuseKit.DataProvider
    
    @Published var model: MainView.Model = .init()
    
    init() {
        let configuration = AmuseKit.StorageConfiguration(serviceName: "com.jjotaum.akdemo",
                                                          developerTokenKey: "com.jjotaum.akdemo.dt",
                                                          userTokenKey: "com.jjotaum.akdemo.utk")
        amuseProvider = AmuseKit.DataProvider(configuration)
        amuseProvider.setDeveloperToken(Self.devToken)
        
    }
    
    func search(query: String) {
        do {
            try amuseProvider.catalogSearch(searchTerm: query)
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
