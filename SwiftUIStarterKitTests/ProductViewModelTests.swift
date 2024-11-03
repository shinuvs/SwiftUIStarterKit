//
//  ProductViewModelTests.swift
//  SwiftUIStarterKitTests
//
//  Created by Shinu Vs on 2024-11-03.
//

import XCTest

@testable import SwiftUIStarterKit // Replace with your actual module name

class ProductViewModelTests: XCTestCase {
    var viewModel: ProductViewModel!
    var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        
        mockAPIService = MockAPIService()
        viewModel = ProductViewModel(apiService: mockAPIService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockAPIService = nil
        
        super.tearDown()
    }
    
    func testFetchProductsSuccess() {
        //Given
        let expectedProducts = [
            Product(id: 1, title: "Product 1", price: 10.0, description: "Description 1", category: "Category 1", image: "Image 1", rating: Product.Rating(rate: 4.5, count: 100)),
            Product(id: 2, title: "Product 2", price: 20.0, description: "Description 2", category: "Category 2", image: "Image 2", rating: Product.Rating(rate: 3.5, count: 200))
        ]
        
        mockAPIService.responseToReturn = expectedProducts
        mockAPIService.shouldReturnError = false
        
        // Create an expectation
        let expectation = self.expectation(description: "Fetching products")
        
        //When
        viewModel.fetchProducts()
        
        //Then
        // Use a slight delay to allow for the async operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Then
            XCTAssertEqual(self.viewModel.products.count, expectedProducts.count)
            XCTAssertEqual(self.viewModel.products, expectedProducts)
            XCTAssertEqual(self.viewModel.loadingState, .success)

            // Fulfill the expectation to indicate that the async task is done
            expectation.fulfill()
        }
        
        // Wait for expectations
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
    
    func testFetchProductsFailure() {
        // Given
        mockAPIService.shouldReturnError = true
        
        // Create an expectation
        let expectation = self.expectation(description: "Fetching products")
        
        // When
        viewModel.fetchProducts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Then
            XCTAssertEqual(self.viewModel.loadingState, .failure(.unknown))
            XCTAssertTrue(self.viewModel.products.isEmpty)
            
            // Fulfill the expectation to indicate that the async task is done
            expectation.fulfill()
        }
        
        // Wait for expectations
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }
    
    func testFetchProductsWithUrlEncodingFailure() {
        // Given
        mockAPIService.shouldReturnMalformedURL = true // Set this flag to simulate URL encoding failure

        // Create an expectation
        let expectation = self.expectation(description: "Expecting a URL encoding failure")

        // When
        viewModel.fetchProducts()

        // Allow a little time for the async operation to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Then
            XCTAssertEqual(self.viewModel.loadingState, .failure(.urlEncodingFailed))
            XCTAssertTrue(self.viewModel.products.isEmpty)

            // Fulfill the expectation to indicate that the async task is done
            expectation.fulfill()
        }

        // Wait for expectations
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                XCTFail("Expectation failed with error: \(error)")
            }
        }
    }

}
