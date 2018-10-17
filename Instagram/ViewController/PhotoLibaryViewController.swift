//
//  PhotoLibaryViewController.swift
//  Instagram
//
//  Created by Allen Lozano on 10/15/18.
//  Copyright © 2018 Allen Lozano. All rights reserved.
//

import UIKit
import Parse

class PhotoLibaryViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

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
    
    @IBAction func photoSelect(_ sender: Any) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(vc, animated: true, completion: nil)
        print("It worked")
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.performSegue(withIdentifier: "backSegue", sender: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        _ = info[UIImagePickerControllerOriginalImage] as! UIImage

        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        photoSelectedImageView.image = editedImage
        photoSelection = true
        
        
        dismiss(animated: true, completion: nil)
    }

    @IBAction func createPost(_ sender: Any) {
        let caption = captionTextField.text
         let image = photoSelectedImageView.image
        
        Post.postUserImage(image: image, withCaption: caption) { (success, error) in
            if (error != nil) {
                print(error.debugDescription)
            }
        }
    }
    
}
