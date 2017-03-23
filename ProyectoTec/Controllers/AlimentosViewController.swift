//
//  AlimentosViewController.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 22/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit
import SwiftyJSON
 
class AlimentosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet var collectionViewInfo: UICollectionView?
    
    var restaurant: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = restaurant?["name"].string
        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "AlimentosCell", bundle: nil)
        self.collectionViewInfo?.register(nib, forCellWithReuseIdentifier: "AlimentosCell")
        
        self.collectionViewInfo?.dataSource = self
        self.collectionViewInfo?.delegate = self
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (restaurant?["food"].array?.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlimentosCell", for: indexPath) as! AlimentosCell
        
        let food: JSON = (restaurant?["food"].array![indexPath.row])!
        
        cell.name?.text = food["name"].string
        cell.price?.text = food["price"].string
        cell.picture?.image = UIImage(named: food["image"].string!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 202)
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
