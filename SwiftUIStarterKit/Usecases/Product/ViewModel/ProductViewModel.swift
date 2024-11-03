//
//  ProductViewModel.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import Foundation

class ProductViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var loadingState: LoadingState = .loading
    @Published var isLoadingMore = false
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService()) {
        self.apiService = apiService
    }
    
    func fetchProducts() {
        loadingState = .loading
        
        guard let url = ApiEndPoint.products.apiURL else {
            loadingState = .failure(.urlEncodingFailed)
            return
        }
        
        apiService.fetch(from: url, shouldAuthenticate: false) { (result: Result<[Product], APIError>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    self.products = products
                    self.loadingState = .success
                case .failure(let error):
                    self.loadingState = .failure(error)
                }
            }
        }
    }
    
    func deleteProduct(product: Product) {
        // Testing action
    }
    
    func AddToFavourite(product: Product) {
        // Testing action
    }
}

enum LoadingState: Equatable {
    case loading
    case success
    case failure(APIError)
}
