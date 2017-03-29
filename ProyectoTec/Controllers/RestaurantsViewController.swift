//
//  RestaurantsViewController.swift
//  ProyectoTec
//
//  Created by Alex Mejicanos on 15/03/17.
//  Copyright © 2017 Alex Mejicanos. All rights reserved.
//

import UIKit
import MapKit
import SwiftyJSON
import AlamofireImage

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableInfo: UITableView?
    @IBOutlet var map: MKMapView?
    
    var restaurants: JSON?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadJSONInfo()
        tableInfo?.delegate = self
        tableInfo?.dataSource = self
        
        map?.isHidden = true
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
        let restaurantInfo: JSON = restaurants![indexPath.row]
        
        print(restaurantInfo)
        let urlImage: String = restaurantInfo["image"].stringValue
        print(urlImage)
        
        
        cell.picture?.af_setImage(withURL: URL(string: urlImage)!)
        cell.picture?.layoutIfNeeded()
        cell.name?.text = restaurantInfo["name"].string
        cell.info?.text = restaurantInfo["description"].string
        
        let starCount: Int = (restaurantInfo["stars"].int)!
        let priceCount: Int = (restaurantInfo["price"].int)!
        
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AlimentosView") as! AlimentosViewController
        vc.restaurant = restaurants?[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadJSONInfo() -> Void {
        if let path = Bundle.main.path(forResource: "info", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                restaurants = JSON(data: data)
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path")
        }
    }
    
    @IBAction func esconderView(sender: UISegmentedControl) {
        if(sender.selectedSegmentIndex == 0) {
            //MOSTRAR LISTA
            tableInfo?.isHidden = false
            map?.isHidden = true
        } else {
            //MOSTRA MAPA
            tableInfo?.isHidden = true
            map?.isHidden = false
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
