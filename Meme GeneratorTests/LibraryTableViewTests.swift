//
//  LibraryTableViewTests.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-11.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import XCTest
@testable import Meme_Generator

class LibraryTableViewTests: XCTestCase {
    
    var viewController: LibraryTableViewController?
    
    override func setUp() {
        super.setUp()
        let bundle = Bundle(identifier: "ca.alani.Meme-Generator")
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        viewController = storyboard.instantiateViewController(withIdentifier: "listView") as? LibraryTableViewController
        _ = viewController?.view
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    // Tests the behaviour of the TableView when the memes list is empty
    func testOnEmptyMemesList() {
        XCTAssert(viewController?.tableView.numberOfSections == 1)
        XCTAssert(viewController?.tableView.numberOfRows(inSection: 0) == 1)
    }
    
    // Tests the contents of the default cell when the memes list is empty
    func testCellOnEmptyMemesList() {
        let cell = viewController?.tableView.dequeueReusableCell(withIdentifier: "Cell", for: IndexPath(row: 0, section: 0)) as! TableCustomCell
        // let cell = viewController?.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! TableCustomCell
        XCTAssert(cell.cellTopLabel.text == "IT'S EMPTIER THAN A BLACK HOLE HERE")
        XCTAssert(cell.cellBottomLabel.text == "GO MAKE SOME MEMES!")
        let cellData = UIImagePNGRepresentation(cell.cellImage.image!)
        let expectedData = UIImagePNGRepresentation(#imageLiteral(resourceName: "Black_hole"))
        XCTAssert(cellData == expectedData)
    }
    
}
