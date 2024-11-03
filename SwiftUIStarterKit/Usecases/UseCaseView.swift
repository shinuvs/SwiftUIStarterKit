//
//  UseCaseView.swift
//  Baseframework
//
//  Created by Shinu Vs on 2024-04-01.
//

import SwiftUI

struct UseCaseView: View {
    
    let component: Components
    
    var body: some View {
        usecaseView()
    }
}

extension UseCaseView {
    
    @ViewBuilder
    func usecaseView() -> some View {
        switch component {
        case .textField:
            textFieldInformationView()
        case .textFieldGroup:
            textFieldGroupInformationView()
        case .productList:
            ProductListView()
        }
    }
    
    @ViewBuilder
    func textFieldInformationView() -> some View {
        Text("Title")
    }
    
    @ViewBuilder
    func textFieldGroupInformationView() -> some View {
        Text("Title")
    }
}

#Preview {
    UseCaseView(component: .textField)
}
