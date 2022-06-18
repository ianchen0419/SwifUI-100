//
//  EditView-ViewModel.swift
//  BucketList
//
//  Created by Yi An Chen on 2022/3/13.
//

import Foundation

extension EditView {
    @MainActor class ViewModel: ObservableObject {
        enum LoadingState {
            case loading, loaded, failed
        }
        
        @Published var name: String
        @Published var description: String
        @Published var loadingState = LoadingState.loading
        @Published var pages = [Page]()
        @Published var location: Location
        
        func fetchNearbyPlaces() async {
            let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"
            
            guard let url = URL(string: urlString) else {
                print("Bad URL: \(urlString)")
                return
            }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let items = try JSONDecoder().decode(Result.self, from: data)
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .loaded
            } catch {
                self.loadingState = .failed
            }
        }
        
        init(name: String, description: String, location: Location) {
            self.name = name
            self.description = description
            self.location = location
        }
    }
}
