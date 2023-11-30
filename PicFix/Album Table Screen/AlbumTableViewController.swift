//
//  AlbumTableViewController.swift
//  PicFix
//
//  Created by Yige Sun on 2023/12/3.
//

import UIKit
import FirebaseFirestore

class AlbumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var albums: [Album] = [] // Replace 'Album' with your album model
    private let albumView = AlbumView()

    override func loadView() {
        view = albumView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Albums"
        albumView.tableView.delegate = self
        albumView.tableView.dataSource = self
        fetchAlbums()
    }

    // Fetch albums from database
    private func fetchAlbums() {
        
    }

    // UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = albums[indexPath.row].name // Replace with your album name property
        return cell
    }

    // UITableViewDelegate methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Navigate to PhotoGridViewController with selected album
        let photoGridViewController = PhotoGridViewController()
        // Pass the selected album information to the photo grid view controller
        navigationController?.pushViewController(photoGridViewController, animated: true)
    }
}
