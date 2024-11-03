//
//  ContentView.swift
//  SwiftUIStarterKit
//
//  Created by Shinu Vs on 2024-11-03.
//

import SwiftUI

struct ContentView: View {
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(searchResults, id: \.self) { component in
                    NavigationLink {
                        UseCaseView(component: component)
                    } label: {
                        Text(component.rawValue)
                    }
                }
            }
            .navigationTitle("Components")
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [Components] {
        if searchText.isEmpty {
            return Components.allCases
        } else {
            return Components.allCases.filter { $0.rawValue.localizedCaseInsensitiveContains(searchText)}
        }
    }
}

#Preview {
    ContentView()
}
