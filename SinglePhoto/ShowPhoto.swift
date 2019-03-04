//
//  ShowPhoto.swift
//  SinglePhoto
//
//  Created by admin on 04/03/2019.
//  Copyright © 2019 SUPINFO. All rights reserved.
//

import UIKit
import Photos

class ShowPhoto: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    @IBOutlet weak var collectView: UICollectionView!
    
    var imageArray = [UIImage]()
    var duplicateArray = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPhotos()
        parsePicture()
        collectView.dataSource = self
        collectView.delegate = self

        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectView.frame.size.width - 20)/2, height: self.collectView.frame.size.width/2)
        collectView.collectionViewLayout = layout
        // Do any additional setup after loading the view.
    }
    
    func parsePicture(){
        for i in 0..<imageArray.count{
            for j in 0..<imageArray.count{
                print(String(i) + " " + String(j))
                if i != j{
                    if imageArray[i].pngData() == imageArray[j].pngData(){
                        duplicateArray.append(imageArray[i])
                    }
                }
            }
        }
    }
    
    
    
    func grabPhotos(){
        let imgManager = PHImageManager.default ()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .opportunistic
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        if let fetchResult : PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions) {
            
            if fetchResult.count>0 {
                for i in 0..<fetchResult.count {
                    imgManager.requestImage(for: fetchResult.object(at: i) , targetSize: CGSize(width: (self.collectView.frame.size.width - 20)/2, height: self.collectView.frame.size.width/2), contentMode: .aspectFill, options: requestOptions, resultHandler: {
                        image, error in
                        self.imageArray.append(image!)
                    })
                }
            } else {
                print("no photos")
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return duplicateArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let imageView = cell.viewWithTag(1) as! UIImageView
        imageView.image = duplicateArray[indexPath.row]
        
        return cell
    }
    
    
    /*func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }*/
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
