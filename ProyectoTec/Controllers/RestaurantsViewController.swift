//
//  RestaurantsViewController.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 15/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController {

    var restaurants: NSArray? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadJSONInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func loadJSONInfo() -> Void {
        if let path = Bundle.main.path(forResource: "info", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let info = try JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                restaurants = info
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path")
        }
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
