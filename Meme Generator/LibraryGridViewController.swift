//
//  LibraryGridViewController.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

// MARK: - LibraryGridViewCotroller base declarations & interfaces
class LibraryGridViewController: UIViewController ,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memesViews.collection = self.myCollectionView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        memesViews.collection?.reloadData()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        memesViews.collection?.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

// MARK: - UICollectionViewDataSource Methods
extension LibraryGridViewController {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesList.count == 0 ? 1 : memesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GridCustomCell
        if memesList.count > 0  {
            cell.isUserInteractionEnabled = true
            cell.memeImage.image = memesList[indexPath.row].memeImg
        }
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension LibraryGridViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = COLLECTION_INSETS.left * (COLLECTION_CELLS_PER_ROW + 1)
        let availableWidth = view.frame.width - paddingSpace - 40
        let widthPerItem = availableWidth / COLLECTION_CELLS_PER_ROW
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return COLLECTION_INSETS
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return COLLECTION_INSETS.left
    }
}
