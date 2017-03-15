//
//  RestaurantsViewController.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 15/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableInfo: UITableView?
    
    var restaurants: NSArray? = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadJSONInfo()
        tableInfo?.delegate = self
        tableInfo?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (restaurants?.count)!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        let restaurantInfo: [String: AnyObject] = restaurants![indexPath.row] as! [String: AnyObject]
        
        print(restaurantInfo)
        
        cell.picture?.image = UIImage(named: restaurantInfo["image"] as! String)
        cell.name?.text = restaurantInfo["name"] as? String
        cell.info?.text = restaurantInfo["description"] as? String
        
        let starCount: Int = (restaurantInfo["stars"] as! Int)
        let priceCount: Int = (restaurantInfo["price"] as! Int)
        
        cell.star_1?.isHidden = true
        cell.star_2?.isHidden = true
        cell.star_3?.isHidden = true
        cell.star_4?.isHidden = true
        cell.star_5?.isHidden = true
        
        cell.money_1?.isHidden = true
        cell.money_2?.isHidden = true
        cell.money_3?.isHidden = true
        cell.money_4?.isHidden = true
        cell.money_5?.isHidden = true
        
        for x in 1...starCount {
            switch x {
            case 1:
                cell.star_1?.isHidden = false
            case 2:
                cell.star_2?.isHidden = false
            case 3:
                cell.star_3?.isHidden = false
            case 4:
                cell.star_4?.isHidden = false
            case 5:
                cell.star_5?.isHidden = false
            default:
                cell.star_5?.isHidden = false
            }
        }
        
        for x in 1...priceCount {
            switch x {
            case 1:
                cell.money_1?.isHidden = false
            case 2:
                cell.money_2?.isHidden = false
            case 3:
                cell.money_3?.isHidden = false
            case 4:
                cell.money_4?.isHidden = false
            case 5:
                cell.money_5?.isHidden = false
            default:
                cell.money_5?.isHidden = false
            }
        }
        
        return cell
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
