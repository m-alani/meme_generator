//
//  Memes.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import Foundation
import UIKit


/// Meme Struct to hold a meme object.
struct Meme {
    
    /// The text of the top text field
    var topText = ""
    
    /// The text of the bottom text field
    var bottomText = ""
    
    /// UIImage object of the original image
    var originalImg = UIImage()
    
    /// UIImage object of the generated meme from the original image & 2 text fields
    var memeImg = UIImage()
}

/// Memes Views Struct to hold a global reference to the 2 views used to display the memes library
struct MemesViews {
    var collection: UICollectionView?
    var table: UITableView?
}

/// The runtime container of memes & views
var memesList = [Meme]()
var memesViews = MemesViews()

