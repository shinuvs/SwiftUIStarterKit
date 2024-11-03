//
//  RatingView.swift
//  Interview
//
//  Created by Shinu Vs on 2024-11-02.
//

import SwiftUI

struct RatingView: View {
    
    @Binding var rating: Int
    var maxRating: Int = 5
    @State var actionMode = false
    
    var body: some View {
        HStack {
            ForEach(1...maxRating, id: \.self) { index in
                Image(systemName: index <= rating ? "star.fill" : "star")
                    .frame(height: 24)
                    .foregroundColor(index <= rating ? .yellow : .gray)
                    .onTapGesture {
                        if actionMode {
                            rating = index
                        }
                    }
            }
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
