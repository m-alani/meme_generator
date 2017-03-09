//
//  LibraryTableViewController.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

// MARK: - LibraryTableViewController base declarations & interfaces
class LibraryTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tableView.alpha = 0
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.25, animations: {
            self.tableView.alpha = 1
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        UIView.animate(withDuration: 0.15, animations: {
            self.tableView.alpha = 0
        })
    }
}

// MARK: - UITableViewDelegate Methods
extension LibraryTableViewController {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - handle selecting a row (meme) action
    }
}

// MARK: - UITableViewDataSource Methods
extension LibraryTableViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesList.count == 0 ? 1 : memesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCustomCell

        if memesList.count > 0 {
            cell.isUserInteractionEnabled = true
            cell.cellTopLabel.text = memesList[indexPath.row].topText
            cell.cellBottomLabel.text = memesList[indexPath.row].bottomText
            cell.cellImage.image = memesList[indexPath.row].originalImg
        }
        
        return cell
    }
}
