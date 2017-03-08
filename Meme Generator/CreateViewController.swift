//
//  CreateViewController.swift
//  Meme Generator
//
//  Created by Marwan Alani on 2017-03-05.
//  Copyright © 2017 Marwan Alani. All rights reserved.
//

import UIKit

// MARK: - CreateViewController base declarations & interfaces
class CreateViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName: -3.0]
    
    var editingTopText = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        self.saveButtonEnabler()
        topText.delegate = self
        topText.defaultTextAttributes = memeTextAttributes
        topText.textAlignment = .center
        bottomText.delegate = self
        bottomText.defaultTextAttributes = memeTextAttributes
        bottomText.textAlignment = .center
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.subscribeToKeyboardNotifications()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let meme = Meme(topText: self.topText.text!,
                        bottomText: self.bottomText.text!,
                        originalImg: self.imageView.image!,
                        memeImg: self.generateMemedImage())
        memesList.append(meme)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UIImagePickerControllerDelegate Functions
extension CreateViewController {
    @IBAction func addButtonPressed(_ sender: Any) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .photoLibrary
        self.present(pickController, animated: true, completion: nil)
    }
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        let pickController = UIImagePickerController()
        pickController.delegate = self
        pickController.sourceType = .camera
        self.present(pickController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.saveButtonEnabler()
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
             self.imageView.image = image
        }
        self.saveButtonEnabler()
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate Functions
extension CreateViewController {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            textField.text = textField.text == "TOP" ? "" : textField.text
            self.editingTopText = true
        } else {
            textField.text = textField.text == "BOTTOM" ? "" : textField.text
            self.editingTopText = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Notification & Keyboard Helper Functions
extension CreateViewController {
    func keyboardWillShow(_ notification:Notification) {
        if !self.editingTopText {
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if !self.editingTopText {
            view.frame.origin.y = 0
            self.editingTopText = false
        }
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
}

// MARK: - Other Helper Functions
extension CreateViewController {
    
    // D.R.Y: function to handle enabling/disabling the Action & Save buttons based on having an image/meme
    func saveButtonEnabler() {
        if self.imageView.image == nil {
            self.saveButton.isEnabled = false
        } else {
            self.saveButton.isEnabled = true
        }
    }
    
    // Helper function to generate a meme from the current view
    func generateMemedImage() -> UIImage {
        // Hide & adjust the current subviews
        self.navigationBar.isHidden = true
        self.toolBar.isHidden = true
        bottomText.frame.origin.y += 20
        topText.frame.origin.y -= 20
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // Show & reposition the subvies
        self.navigationBar.isHidden = false
        self.toolBar.isHidden = false
        self.bottomText.frame.origin.y -= 20
        self.topText.frame.origin.y += 20
        
        return memedImage
    }
}
