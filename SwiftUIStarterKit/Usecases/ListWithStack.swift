//
//  ListWithStack.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-10-29.
//

import SwiftUI

struct ListWithStack: View {
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6", "Item 7", "Item 8", "Item 9", "Item 12", "Item 13", "Item 14", "Item 15", "Item 16", "Item 17", "Item 18", "Item 19", "Item 20", "Item 21", "Item 22", "Item 23", "Item 24", "Item 25", "Item 26", "Item 27", "Item 28", "Item 29", "Item 30", "Item 31", "Item 32", "Item 33", "Item 34", "Item 35", "Item 36", "Item 37", "Item 38", "Item 39", "Item 40", ]
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
            }
        }
        .safeAreaInset(edge: .bottom){
            Text("Bottom View")
                .font(.title3)
                .foregroundColor(.indigo)
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(.green)
        }
        .padding(.top)
    }
}

#Preview {
    ListWithStack()
}
