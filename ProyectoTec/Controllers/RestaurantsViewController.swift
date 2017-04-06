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
import CoreData

class RestaurantsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate{

    @IBOutlet var tableInfo: UITableView?
    @IBOutlet var map: MKMapView?
    
    var restaurants: JSON?
    var listRestaurants: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableInfo?.delegate = self
        tableInfo?.dataSource = self
        
        map?.delegate = self
        map?.isHidden = true
        
        loadRestaurants()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (listRestaurants.count)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 225
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as! RestaurantCell
        let restaurantInfo: NSManagedObject = listRestaurants[indexPath.row]
        
        let urlImage: String = restaurantInfo.value(forKey: "image") as! String
        
        cell.picture?.af_setImage(withURL: URL(string: urlImage)!)
        
        cell.name?.text = restaurantInfo.value(forKey: "name") as? String
        cell.info?.text = restaurantInfo.value(forKey: "information") as? String
        
        let starCount: Int = (restaurantInfo.value(forKey: "stars") as! Int)
        let priceCount: Int = (restaurantInfo.value(forKey: "price") as! Int)
        
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
    
    func loadAnnotationsOnMap() -> Void {
        var index = 0
        for restaurant in (restaurants?.array)!{
            let annotation = RestaurantAnnotation(title: restaurant["name"].stringValue, subtitle: restaurant["description"].stringValue, coordinate: CLLocationCoordinate2D(latitude: CLLocationDegrees(restaurant["latitude"].floatValue), longitude: CLLocationDegrees(restaurant["longitude"].floatValue)), tag: index)
            //annotation.image = UIImage(named: "marker")
            map?.addAnnotation(annotation)
            index += 1
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? RestaurantAnnotation {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                let buttonCall = UIButton(type: .detailDisclosure)
                buttonCall.addTarget(self, action: #selector(gotToMenu(sender:)), for: .touchUpInside)
                buttonCall.tag = annotation.tag!
                view.rightCalloutAccessoryView = buttonCall
            }
            //view.image = UIImage(named: "marker")
            return view
        }
        return nil
    }
    
    @IBAction func gotToMenu(sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AlimentosView") as! AlimentosViewController
        vc.restaurant = restaurants?[sender.tag]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func loadJSONInfo() -> Void {
        if let path = Bundle.main.path(forResource: "info", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                restaurants = JSON(data: data)
                loadAnnotationsOnMap()
                saveOnCoreData()
                //tableInfo?.reloadData()
            } catch let error {
                print(error.localizedDescription)
                
            }
        } else {
            print("Invalid filename/path")
        }
    }
    
    func saveOnCoreData() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let manageContext = appDelegate?.persistentContainer.viewContext
        
        do {
            for restaurant: JSON in (restaurants?.array)! {
                let entity = NSEntityDescription.entity(forEntityName: "Restaurants", in: manageContext!)
                let newRestaurant = NSManagedObject(entity: entity!, insertInto: manageContext)
                
                newRestaurant.setValue(restaurant["name"].stringValue, forKey: "name")
                newRestaurant.setValue(restaurant["description"].stringValue, forKey: "information")
                newRestaurant.setValue(restaurant["image"].stringValue, forKey: "image")
                newRestaurant.setValue(restaurant["price"].intValue, forKey: "price")
                newRestaurant.setValue(restaurant["stars"].intValue, forKey: "stars")
                newRestaurant.setValue(restaurant["latitude"].floatValue, forKey: "latitude")
                newRestaurant.setValue(restaurant["longitude"].floatValue, forKey: "longitude")
                
                try manageContext?.save()
            }
            
            loadRestaurants()
        } catch let errorView as NSError {
            print("No se pudo guardar: \(errorView), \(errorView.userInfo)")
        }
    }
    
    func loadRestaurants() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let manageContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurants")
        
        do {
            self.listRestaurants = try manageContext?.fetch(fetchRequest) as! [NSManagedObject]
            if self.listRestaurants.count > 0 {
                tableInfo?.reloadData()
            } else {
                loadJSONInfo()
            }
        } catch let error as NSError {
            print("No se obtener la información: \(error), \(error.userInfo)")
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
