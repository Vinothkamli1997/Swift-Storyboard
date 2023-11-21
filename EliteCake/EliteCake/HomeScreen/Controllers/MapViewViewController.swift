//
//  MapViewViewController.swift
//  EliteCake
//
//  Created by Apple - 1 on 23/03/23.
//

import UIKit
import MapKit
import CoreLocation

class MapViewViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var bottomBgView: UIView!
    
    @IBOutlet weak var mapImageLogo: UIImageView!
    
    @IBOutlet weak var addressLbl: UILabel!
    
    @IBOutlet weak var changeBtn: UIButton!
    
    @IBOutlet weak var completeAddressBtn: UIButton!
    
    @IBOutlet weak var currentLocationBgView: UIView!
    @IBOutlet weak var currentLocationImage: UIImageView!
    @IBOutlet weak var currentLbl: UILabel!
    
    @IBOutlet weak var pinImageView: UIImageView!
    
    var customerID: String = ""
    var selecteAddress: String = ""
    var editAddress: String = ""
    var floorAddress: String = ""
    var screenType: String = ""
    var addres_ID: String = ""
    var currentLocation: CLLocation? = nil
    
    var latitude: Double?
    var longitude: Double?
    
    var locationManager = CLLocationManager()
    var tapGesture: UITapGestureRecognizer!
    var currentAnnotation: MKPointAnnotation?
    var locationAddress: String = ""
    
    var addressValue: [Address] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialView()
        
        initLocation()
                
        currentLocationBtnAction()
        
        mapView.showsUserLocation = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        updatePinPosition()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureInMapViewDidRecognize(panGestureRecognizer:)))
        panGestureRecognizer.delegate = self
        mapView.addGestureRecognizer(panGestureRecognizer)
    }
    
    func initialView() {
        
        changeBtn.isHidden = true
        
        titleLbl.text = "New Address"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        addressLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        currentLbl.text = "Use Current Location"
        currentLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        currentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        let currentImage = UIImage(named: "aim")?.withRenderingMode(.alwaysTemplate)
        currentLocationImage.image = currentImage
        currentLocationImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        bottomBgView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        setShadow(view: bottomBgView)
        
        changeBtn.setTitle("Change", for: .normal)
        changeBtn.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        completeAddressBtn.setTitle("Enter Complete Address", for: .normal)
        completeAddressBtn.tintColor = UIColor.white
        completeAddressBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        completeAddressBtn.layer.cornerRadius = 25
        setShadow(view: completeAddressBtn)
        
        currentLocationBgView.layer.borderWidth = 2
        currentLocationBgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        currentLocationBgView.backgroundColor = UIColor(hexFromString: ColorConstant.ADDITEMPINK)
        currentLocationBgView.layer.cornerRadius = 10
        
        mapImageLogo.image = UIImage(named: "location")
    }
    
    func initLocation() {
        locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func tapGestureMap() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        mapView.addGestureRecognizer(tapGesture)
    }
    
    func currentLocationBtnAction() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleLocationTap(_:)))
        currentLocationBgView.isUserInteractionEnabled = true
        currentLocationBgView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        
        mapView.showsUserLocation = false
        
        let location = sender.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, error in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found for coordinate: \(coordinate)")
                return
            }
            self.addressLbl.text = placemark.subLocality ?? placemark.locality ?? ""
        }
        
        if let currentAnnotation = currentAnnotation {
            mapView.removeAnnotation(currentAnnotation)
        }

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)

        currentAnnotation = annotation
        
        if let currentAnnotation = currentAnnotation {
            mapView.removeAnnotation(currentAnnotation)
            self.currentAnnotation = nil // Clear the reference
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Get Current Location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last!
        
        if currentLocation == nil {
            currentLocation = location
        }
        
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.latitude
        
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if error == nil {
                if let firstLocation = placemarks?.first {
                    let address = "\(firstLocation.subLocality ?? ""), \(firstLocation.locality ?? "")"
                    self.selecteAddress = address
                    self.addressLbl.text = address
                    
                    self.locationAddress = "\(firstLocation.subLocality ?? "")"
                    
                    
                    if let currentAnnotation = self.currentAnnotation {
                        self.mapView.removeAnnotation(currentAnnotation)
                    }
                    
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                    
                    self.currentAnnotation = annotation
                    
                   
                    // Center the map view on the new annotation's coordinate
                    let region = MKCoordinateRegion(center: self.currentAnnotation!.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.mapView.setRegion(region, animated: true)
                    
                    if let currentAnnotation = self.currentAnnotation {
                        self.mapView.removeAnnotation(currentAnnotation)
                        self.currentAnnotation = nil // Clear the reference
                    }
                    
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
    @objc func handleLocationTap(_ gestureRecognizer: UITapGestureRecognizer) {
        let location = currentLocation
        
        
        self.latitude = location!.coordinate.latitude
        self.longitude = location!.coordinate.latitude
        
        
        if let currentAnnotation = self.currentAnnotation {
            self.mapView.removeAnnotation(currentAnnotation)
        }
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location!.coordinate
        mapView.addAnnotation(annotation)
        currentAnnotation = annotation
        
        // Center the map view on the new annotation's coordinate
        let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        
        if let currentAnnotation = currentAnnotation {
            mapView.removeAnnotation(currentAnnotation)
            self.currentAnnotation = nil // Clear the reference
        }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location!) { (placemarks, error) in
            if error == nil {
                if let firstLocation = placemarks?.first {
                    let address = "\(firstLocation.subLocality ?? ""), \(firstLocation.locality ?? "")"
                    self.selecteAddress = address
                    self.addressLbl.text = address
                }
            } else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
            }
        }
    }
    
    // Update the pin position based on the current map center
    func updatePinPosition() {
        let center = mapView.convert(mapView.center, to: view)
        pinImageView.center = center
    }

    @objc func handleMapDrag(_ gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == .began {
            let translation = gestureRecognizer.translation(in: mapView)
            
            // Calculate the new center for the pinImageView
            let newCenter = CGPoint(x: pinImageView.center.x + translation.x, y: pinImageView.center.y + translation.y)
            pinImageView.center = newCenter
            
            // Update the gesture translation to zero to avoid accumulating translations
            gestureRecognizer.setTranslation(CGPoint.zero, in: mapView)
            
            // Convert the new pin position to a map coordinate
            let newPinCoordinate = mapView.convert(pinImageView.center, toCoordinateFrom: view)
            
            // Update the annotation's coordinates
            currentAnnotation?.coordinate = newPinCoordinate
            
            // Update the map center based on the new pin position
            mapView.setCenter(newPinCoordinate, animated: false)
            
            // Perform reverse geocoding to get location details
            let geocoder = CLGeocoder()
            let location = CLLocation(latitude: newPinCoordinate.latitude, longitude: newPinCoordinate.longitude)
            
            geocoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding failed: \(error.localizedDescription)")
                    return
                }
                
                guard let placemark = placemarks?.first else {
                    print("No placemark found for coordinate: \(newPinCoordinate)")
                    return
                }
                
                // Get address components from the placemark
                 var addressComponents: [String] = []
                 if let name = placemark.subLocality {
                     addressComponents.append(name)
                 }
                 if let locality = placemark.locality {
                     addressComponents.append(locality)
                 }
                 // ... Continue adding other address components as needed
                 
                 // Update the address label with the address details
                 let fullAddress = addressComponents.joined(separator: ", ")
                 self.addressLbl.text = fullAddress
                
                self.locationAddress = fullAddress
                
                // Get location details from the placemark (e.g., placemark.name, placemark.locality, etc.)
            }
        }
    }
    
    // MARK: Gesture Recognizer
    @objc func panGestureInMapViewDidRecognize(panGestureRecognizer: UIPanGestureRecognizer) {
        print("Draggedddddd \(panGestureRecognizer.state)")
        print("drag pan \(panGestureRecognizer)")
        switch(panGestureRecognizer.state) {
        case .began:
            print("draggedd succussfully")
        default:
            break
        }
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // Get the address for a given coordinate
    func getAddressForCoordinate(_ coordinate: CLLocationCoordinate2D) {
        // Implement your reverse geocoding logic here
        print("get address \(coordinate.latitude)")
        
        let geocoder = CLGeocoder()
                geocoder.reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, error in
                    if let error = error {
                        print("Reverse geocoding failed: \(error.localizedDescription)")
                        return
                    }
        
                    guard let placemark = placemarks?.first else {
                        print("No placemark found for coordinate: \(coordinate)")
                        return
                    }
        
                    var addressComponents: [String] = []

                    if let locality = placemark.subLocality {
                        addressComponents.append(locality)
                    }
                    if let subLocality = placemark.locality {
                        addressComponents.append(subLocality)
                    }
        
                    let fullAddress = addressComponents.joined(separator: ", ")
                    self.addressLbl.text = fullAddress
                    
                    self.locationAddress = fullAddress
                }
    }

    // Handle map region changes
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        updatePinPosition()
        getAddressForCoordinate(mapView.centerCoordinate)
    }
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func completeAddressBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompleteAddressViewController") as! CompleteAddressViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedAddress = selecteAddress
        vc.latitude = self.latitude
        vc.longitude = self.longitude
        vc.editAddress = editAddress
        vc.floorAddress = floorAddress
        vc.screenType = screenType
        vc.addres_ID = addres_ID
        vc.floorAddressValue = self.locationAddress
        vc.context = self.navigationController
        self.present(vc, animated: false, completion: nil)
    }
}


