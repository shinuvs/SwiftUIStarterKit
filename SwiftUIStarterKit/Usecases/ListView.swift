//
//  ListView.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-10-29.
//

import SwiftUI

struct Fruit: Identifiable, Hashable {
    let id = UUID()
    let name: String
}

struct ListView: View {
    let fruits = [Fruit(name: "Apple"), Fruit(name: "Banana"), Fruit(name: "Cherry")]
    @State var showCustomCell: Bool = false
    @State private var navigateToDetail: Bool = false
    
    var body: some View {
        NavigationView {
            if showCustomCell {
                List(fruits) { fruit in
                    contentCellWithCustomDiscloreColor(fruit: fruit)
                }
                .navigationTitle("Fruits")
            } else {
                NavigationStack {
                    List(fruits) { fruit in
                        contentCell(fruit: fruit)
                    }
                    .navigationDestination(for: Fruit.self) { fruit in
                        FruitDetailView(fruit: fruit)
                    }
                    .navigationTitle("Fruits")
                }
            }
        }
    }
}

private extension ListView {
    
    // With navigation link and default style
    @ViewBuilder
    func contentCell(fruit: Fruit) -> some View {
        NavigationLink(value: fruit) {
            Text(fruit.name)
        }
    }
    
    // If you want to customise disclosure icon color
    // You need to custimize like this
    @ViewBuilder
    func contentCellWithCustomDiscloreColor(fruit: Fruit) -> some View {
            Button(action: {
                navigateToDetail = true
            }) {
                HStack {
                    Text(fruit.name)
                        .foregroundColor(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.blue)
                }
            }
            .buttonStyle(PlainButtonStyle())
            .navigationDestination(isPresented: $navigateToDetail) {
                FruitDetailView(fruit: fruit)
            }
    }
}

#Preview {
    ListView(showCustomCell: false)
}


struct FruitDetailView: View {
    let fruit: Fruit  // Pass the selected fruit object

    var body: some View {
        Text("Details about \(fruit.name)")
            .font(.title)
            .padding()
    }
}
