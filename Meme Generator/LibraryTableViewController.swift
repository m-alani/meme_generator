//
//  LibraryTableViewController.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

class LibraryTableViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - UITableViewDelegate Methods
extension LibraryTableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: - handle selecting a row (meme) for editing
    }
}

// MARK: - UITableViewDataSource Methods
extension LibraryTableViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memesList.count == 0 ? 1 : memesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.imageView?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        cell.imageView?.backgroundColor = UIColor(colorLiteralRed: 0.15, green: 0.94, blue: 0.36, alpha: 1)
        cell.imageView?.contentMode = .scaleAspectFit

        if memesList.count == 0 {
            cell.textLabel?.text = "It's emptier than a black hole here!"
            cell.detailTextLabel?.text = "GO MAKE SOME MEMES!"
            cell.imageView?.image = #imageLiteral(resourceName: "Black_hole")
            cell.isUserInteractionEnabled = false
        } else {
            cell.textLabel?.text = memesList[indexPath.row].topText
            cell.detailTextLabel?.text = memesList[indexPath.row].bottomText
            cell.imageView?.image = memesList[indexPath.row].originalImg
        }
        
        return cell
    }
}
