//
//  ListViewController.swift
//  UIKitStarter
//
//  Created by Shinu Vs on 2024-11-04.
//

import UIKit
import SwiftUI

class ListViewController: UIViewController {
    
    var tableView = UITableView()
    var items: [String] = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged) // Step 3: Add action
        tableView.refreshControl = refreshControl // Attach the refresh control to the table view
    }
    
    @objc private func refreshData() {
        // Simulate data fetching or updating
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // This is where you'd typically reload your data
            self.tableView.reloadData() // Reload the table view data
            self.refreshControl.endRefreshing() // End the refreshing animation
        }
    }
    
    @objc private func showSwiftUIView() {
        let swiftUIView = ProductListView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        // Push the SwiftUI view controller onto the navigation stack
        navigationController?.pushViewController(hostingController, animated: true)
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        cell.titleLabel.text = items[indexPath.row]
        return cell
    }
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Handle click action
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
