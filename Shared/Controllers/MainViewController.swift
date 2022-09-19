//
//  MainViewController.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 2/09/22.
//

import AmuseKit
import AVFoundation
import Combine
import Foundation

class MainViewController: ObservableObject {
    let dataProvider: AmuseKit.DataProvider
    let mediaPlayer: AVPlayer
    private var subscriptions: Set<AnyCancellable> = []
    
    @Published var model: MainView.Model = .init()
    
    init(dataProvider: AmuseKit.DataProvider, mediaPlayer: AVPlayer) {
        self.dataProvider = dataProvider
        self.mediaPlayer = mediaPlayer
    }
    
    func search(query: String) {
        do {
            try dataProvider.catalogSearch(searchTerm: query)
                .sink { _ in
                } receiveValue: { [weak self] response in
                    guard let strongSelf = self else { return }
                    var aModel = strongSelf.model
                    aModel.sections = []
                    aModel.conditionallyAppendSection(with: .albums,
                                                      mediaItems: response.results?.albums?.data)
                    aModel.conditionallyAppendSection(with: .artists,
                                                      mediaItems: response.results?.artists?.data)
                    aModel.conditionallyAppendSection(with: .musicVideos,
                                                      mediaItems: response.results?.musicVideos?.data)
                    aModel.conditionallyAppendSection(with: .songs,
                                                      mediaItems: response.results?.songs?.data)
                    aModel.conditionallyAppendSection(with: .stations,
                                                      mediaItems: response.results?.stations?.data)
                    strongSelf.model = aModel
                }.store(in: &subscriptions)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func didSelect(_ mediaItem: MediaItem) {
        guard let url = mediaItem.previewURL else { return }
        mediaPlayer.replaceCurrentItem(with: .init(url: url))
        mediaPlayer.play()
    }
}

fileprivate extension MainView.Model {
    mutating func conditionallyAppendSection(with type: MediaType, mediaItems: [MediaItem]?) {
        guard let mediaItems = mediaItems,
              let section = SectionViewModel(rawValue: (type, mediaItems)) else { return }
        sections.append(section)
    }
}
