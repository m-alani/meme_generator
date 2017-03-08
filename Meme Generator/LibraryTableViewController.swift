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
    
    var startupAnimation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if startupAnimation {
            startupAnimation = false
            self.view.center.y += 750
            UIView.animate(withDuration: 0.25, animations: {
                self.view.center.y -= 750
            })
        }
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
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCustomCell

        if memesList.count == 0 {
            cell.isUserInteractionEnabled = false
        } else {
            cell.cellTopLabel.text = memesList[indexPath.row].topText
            cell.cellBottomLabel.text = memesList[indexPath.row].bottomText
            cell.cellImage.image = memesList[indexPath.row].originalImg
        }
        
        return cell
    }
}
