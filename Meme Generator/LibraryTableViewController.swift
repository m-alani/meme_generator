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
        memesViews.table = self.tableView
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        self.tableView.alpha = 0
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
        tableView.cellForRow(at: indexPath)?.isSelected = false
        currentMemeIndex = indexPath.row
        performSegue(withIdentifier: "tableToCreate", sender: self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return memesList.count != 0
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            memesList.remove(at: indexPath.row)
            tableView.alpha = 0
            tableView.reloadData()
            UIView.animate(withDuration: 0.25, animations: {
                tableView.alpha = 1
            })
        }
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
        } else {
            cell.isUserInteractionEnabled = false
            cell.cellTopLabel.text = "IT'S EMPTIER THAN A BLACK HOLE OVER HERE"
            cell.cellBottomLabel.text = "GO MAKE SOME MEMES!"
            cell.cellImage.image = #imageLiteral(resourceName: "Black_hole")
        }
        return cell
    }
}
