//
//  SectionListView.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-10-29.
//

import SwiftUI

struct SectionListView: View {
    let items = ["Item 1", "Item 2", "Item 3"]
    var body: some View {
        List {
            Section(header:
                        Text("Section 1")
                .font(.title)
                .foregroundStyle(.white)
                .textCase(.none)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            ){
                Text("Text 1")
            }
            Section(header: Text("Section 2")) {
                ForEach(items, id: \.self) { item in
                    Text(item)
                }
            }
        }
        .listStyle(PlainListStyle())
        .cornerRadius(20)
        .padding()
        .background(
                            RoundedRectangle(cornerRadius: 20) // This will provide the corner radius to the List as a whole
                                .fill(Color.white) // Background color for the list
                                .shadow(radius: 5) // Optional shadow for depth
                        )
       // .background(.pink)
      //  .scrollContentBackground(.hidden)
    }
}

#Preview {
    SectionListView()
}
