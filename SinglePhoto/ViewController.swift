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

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var Result: UILabel!
    let imagePickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        checkPermission()
        imagePickerController.delegate = self

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    @IBAction func startButton(_ sender: Any) {
        let data1 = imageView.image?.pngData();
        let data2 = imageView2.image?.pngData()!;
        
        if(data1 == data2){
            Result.text = "They are equal"
        } else {
            Result.text = "They are differents"
            
        }
    }
    
    @IBAction func importButton(_ sender: Any) {
        print("j'ai cliqué")
        

        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a photo", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController.sourceType = .camera
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Library", style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        
        self.present(actionSheet, animated: true, completion: nil)

    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized: print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in print("status is \(newStatus)")
                if newStatus == PHAuthorizationStatus.authorized { print("success") } })
                case .restricted:  print("User do not have access to photo album.")
                case .denied:  print("User has denied the permission.") } }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img_base = #imageLiteral(resourceName: "Khet")
   
        
        if let image = info[.originalImage] as?UIImage{
            print(image.hash)
            
            if((imageView.image?.isEqual(img_base))!){
                imageView.image = image
                instructionLabel.text = "Choose the second picture"
                
            } else {
                imageView2.image = image
            }
        } else{print("erooooooooor")}
       
   
        picker.dismiss(animated: true, completion: nil)
        dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
