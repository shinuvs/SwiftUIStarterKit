//
//  Queue.swift
//  SwiftUIStarterKit
//
//  Created by Shinu Vs on 2024-11-04.
//

import Foundation

class Queue {
    
    func testQueue() {
        DispatchQueue.global(qos: .background).async {
            
        }
        
        DispatchQueue.global(qos: .userInteractive).async {
            
        }
        
        DispatchQueue.global(qos: .background).async {
            // Simulating a time-consuming task
            for i in 1...5 {
                print("Background Task \(i)")
                sleep(1) // Simulate work
            }
            
            // Update UI on main queue
            DispatchQueue.main.async {
                print("Background task completed. Update UI here.")
            }
        }
        
        func performAsyncTasks() async {
            await Task { () -> Void in
                for i in 1...5 {
                    print("Async Task \(i)")
                    try? await Task.sleep(nanoseconds: 1_000_000_000) // Simulates a delay of 1 second
                }
            }.value
            
            print("All async tasks completed.")
        }
    }
}
