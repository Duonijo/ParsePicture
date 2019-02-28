//
//  ViewController.swift
//  SinglePhoto
//
//  Created by admin on 05/02/2019.
//  Copyright © 2019 SUPINFO. All rights reserved.
//

import UIKit
import Photos



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func importButton(_ sender: AnyObject) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.allowsEditing = false
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(image, animated: true)
        {
            //after it is complete
            print(image.title as Any)
        }
    }
    
    
    func Autorize(){

        switch PHPhotoLibrary.authorizationStatus(){
            case .authorized:
                NSLog("PHAuthorizationStatusAuthorized");
                break;
            case .denied:
                NSLog("PHAuthorizationStatusDenied");
                break;
            case .restricted:
                NSLog("PHAuthorizationStatusRestricted");
                break;
        case .notDetermined:
            print("hello");
            break;
        }
    }
    
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        {
            imageView.image = image
            print("worked")
        }
        else{
            //Error message
            print("errooooooor")
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
       
        super.viewDidLoad()
         Autorize()
        // Do any additional setup after loading the view, typically from a nib.
    }


}


