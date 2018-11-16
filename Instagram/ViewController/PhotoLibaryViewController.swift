//
//  PhotoLibaryViewController.swift
//  Instagram
//
//  Created by Allen Lozano on 10/15/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import UIKit
import Parse

class PhotoLibaryViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var photoSelectedImageView: UIImageView!
    
    @IBOutlet weak var captionTextField: UITextField!
    var photoSelection = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Delegate Protocols
    internal func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        photoSelectedImageView.image = editedImage
        photoSelection = true
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: Any) {
        func back(_ sender: Any) {
            
            self.performSegue(withIdentifier: "backSegue", sender: nil)
        }
    }
    
    
    @IBAction func onSelect(_ sender: Any) {
        self.selectPhoto()
    }
    func selectPhoto() {
            let vc = UIImagePickerController()
            vc.delegate = self
            vc.allowsEditing = true
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                //print("Camera is available 📸")
                vc.sourceType = .camera
            } else {
                //print("Camera 🚫 available so we will use photo library instead")
                vc.sourceType = .photoLibrary
            }
            self.present(vc, animated: true, completion: nil)
        }
    
    
    @IBAction func createPost(_ sender: Any) {
        let caption = captionTextField.text ?? ""
        let image = photoSelectedImageView.image
        if (!photoSelection) {
            let alertController = UIAlertController(title: "Photo Not Chosen", message: "Please choose a photo to create a new post.", preferredStyle: .alert)
            let dismissAction = UIAlertAction(title: "Dismiss", style: .default)
            alertController.addAction(dismissAction)
            present(alertController, animated: true) { }
            return;
        }
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
    }
}






