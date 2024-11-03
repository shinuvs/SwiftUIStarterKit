//
//  ProductListView.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import SwiftUI

struct ProductListView: View {
    
    @StateObject var viewModel = ProductViewModel()
    @State private var showDeleteConfirmation = false
    
    private typealias stringConstant = StringConstants.Product
    
    var body: some View {
        contentView()
            .onAppear {
                viewModel.fetchProducts()
            }
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("Delete Confirmation"),
                    message: Text("Do you want to delete the product"),
                    primaryButton: .destructive(Text("Delete")) {
                       // Handle delete action
                    },
                    secondaryButton: .cancel()
                )
            }
    }
}

extension ProductListView {
    
    @ViewBuilder
    func contentView() -> some View {
        switch viewModel.loadingState {
        case .loading:
            ProgressView()
        case .success:
            productList()
        case .failure(let apiError):
            Text(apiError.localizedDescription)
        }
    }
    
    @ViewBuilder
    func productList() -> some View {
        List { 
            ForEach(viewModel.products) { product in
                NavigationLink(destination: ProductDetailView()) {
                    ProductListRow(product: product)
                        .listRowSeparator(.hidden)
                        .onAppear {
                            if product == viewModel.products.last {
                                viewModel.isLoadingMore = true // Hide this loadmore in the pagination api successful response
                                //viewModel.fetchProducts()
                            }
                        }
                }
                .listRowSeparator(.hidden)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button {
                        viewModel.AddToFavourite(product: product)
                    } label: {
                        Label("Favourite", systemImage: "heart")
                    }
                    .tint(.yellow)
                    
                    Button(role: .destructive) {
                        showDeleteConfirmation = true
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
            
            //Display loading for pagination
            if viewModel.isLoadingMore {
                HStack(alignment: .center) {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .tint(Color.red)
                }
                .frame(maxWidth: .infinity)
            }
            
        }
        .listStyle(PlainListStyle())
        .padding(0)
        //.background(.gray.opacity(6.0))
        .navigationTitle("Products List")
    }
}



#Preview {
    let product = Product(
        id: 1,
        title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops",
        price: 109.50,
        description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday",
        category: "men's clothing",
        image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg",
        rating: Product.Rating(
            rate: 3.9,
            count: 120
        )
    )
    return ProductListView()
}
