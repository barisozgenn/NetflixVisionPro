//
//  ContentAPI.swift
//  NetflixCloneVisionPro
//
//  Created by Baris OZGEN on 24.06.2023.
//

import Foundation
import Combine
import Observation

@Observable final class ContentAPI {
    var contents: [ContentModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchContentsFromJSON(forName: "movies")
    }
    
    private func fetchContentsFromJSON(forName fileName: String) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, _ in
                try JSONDecoder().decode([ContentModel].self, from: data)
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    print("DEBUG: parsing json error: \(error)")
                }
            }, receiveValue: { [weak self] jsonData in
                self?.contents = jsonData
            })
            .store(in: &cancellables)
    }
}
