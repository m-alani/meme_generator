//
//  LibraryGridViewController.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

class LibraryGridViewController: UIViewController{

    @IBOutlet weak var myCollectionView: UICollectionView!
    
    fileprivate let sectionInsets = UIEdgeInsets(top: 30.0, left: 15.0, bottom: 30.0, right: 15.0)
    fileprivate let itemsPerRow: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
extension LibraryGridViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.myCollectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! GridCustomCell
        cell.memeImage.image = memesList[indexPath.row].memeImg
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout Methods
extension LibraryGridViewController : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
