//
//  ProductListRow.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import SwiftUI

struct ProductListRow: View {
    
    @State var product: Product
    @State private var showFullDescription = false
    @State private var rating = 3
    
    var body: some View {
        GroupBox {
            HStack {
                productImage(imageUrl: product.image)
                    .frame(width: 75)
                VStack(alignment: .leading) {
                    Text(product.title)
                        .font(.system(size: 16, weight: .medium))
                    Text(product.description)
                        .font(.system(size: 12))
                        .lineLimit(showFullDescription ? nil : 2)
                    Button(action: {
                        showFullDescription.toggle()
                    }, label: {
                        Text(showFullDescription ? "Read less" : "Read more")
                            .font(.system(size: 14))
                    })
                    HStack {
                        Text("$\(String(format: "%.2f", product.price))")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.red)
                            .padding(.top, 1)
                        Spacer()
                        RatingView(rating: $rating, actionMode: false)
                    }
                }
            }
        }
    }
}

private extension ProductListRow {
    
    @ViewBuilder
    func productImage(imageUrl: String) -> some View {
        
        if let imageUrl = URL(string: imageUrl) {
            AsyncImage(url: imageUrl) { phase in
                switch phase {
                case .empty:
                    Image(systemName: "photo")
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    Image(systemName: "photo")
                }
            }
        } else {
            Image(systemName: "photo")
        }
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
    return ProductListRow(product: product)
}
