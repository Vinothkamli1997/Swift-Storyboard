//
//  GoogleMapViewController.swift
//  EliteCake
//
//  Created by TechnoTackle on 12/09/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class GoogleMapViewController: UIViewController, GMSMapViewDelegate, UIGestureRecognizerDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var googleMapView: GMSMapView!
    
    @IBOutlet weak var currentLocationBgView: UIView!
    @IBOutlet weak var currentLocationImage: UIImageView!
    @IBOutlet weak var currentLbl: UILabel!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var addressLbl: UILabel!

    @IBOutlet weak var bottomBgView: UIView!
    
    @IBOutlet weak var bottomImage: UIImageView!
    
    @IBOutlet weak var completeAddressBtn: UIButton!

    @IBOutlet weak var mapImageLogo: UIImageView!
    
    var currentLocationMarker: GMSMarker?
    var geocoder = GMSGeocoder()
    var marker: GMSMarker?
        
    var customerID: String = ""
    var selecteAddress: String = ""
    var editAddress: String = ""
    var floorAddress: String = ""
    var screenType: String = ""
    var addres_ID: String = ""
    var locationAddress: String = ""
    
    var latitude: Double?
    var longitude: Double?
    
    var addressValue: [Address] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
        
        googleMapView.settings.compassButton = false
        
        googleMapView.settings.myLocationButton = true
        
//        googleMapView.isMyLocationEnabled = true

        googleMapView.delegate = self
        
        googleMapView.clear()
        
        marker?.map = nil
                
        //Google map sdk - user Location
        googleMapView.isMyLocationEnabled = true
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        checkLocationAuthorization()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(currentLocationTapped))
        currentLocationBgView.addGestureRecognizer(tapGestureRecognizer)
        currentLocationBgView.isUserInteractionEnabled = true
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureInMapViewDidRecognize(_:)))
         googleMapView.addGestureRecognizer(panGestureRecognizer)
    }
    
    
    @IBAction func backBtnAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func currentLocationTapped() {
        locationManager.stopUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func completeAddressBtnAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "HomeScreen", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CompleteAddressViewController") as! CompleteAddressViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.selectedAddress = selecteAddress
        vc.latitude = self.latitude
        vc.longitude = self.longitude
        vc.editAddress = editAddress
        vc.floorAddress = selecteAddress
        vc.screenType = screenType
        vc.addres_ID = addres_ID
        vc.floorAddressValue = selecteAddress
        vc.context = self.navigationController
        self.present(vc, animated: false, completion: nil)
    }
    
    func setUp() {
        googleMapView.addObserver(self, forKeyPath: "myLocation", options: NSKeyValueObservingOptions.new, context: nil)
        
        googleMapView.settings.myLocationButton = true
        googleMapView.settings.scrollGestures = true
        
        titleLbl.text = "New Address"
        titleLbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        backBtn.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBtn.tintColor = UIColor(hexFromString: ColorConstant.BLACK)
        
        currentLbl.text = "Use Current Location"
        currentLbl.textColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        currentLbl.font = UIFont.boldSystemFont(ofSize: 14)
        
        mapImageLogo.translatesAutoresizingMaskIntoConstraints = false
        mapImageLogo.image = UIImage(named: "pinNew")
        
        bottomImage.image = UIImage(named: "location")
        
        let currentImage = UIImage(named: "aim")?.withRenderingMode(.alwaysTemplate)
        currentLocationImage.image = currentImage
        currentLocationImage.tintColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        
        currentLocationBgView.layer.borderWidth = 2
        currentLocationBgView.layer.borderColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR).cgColor
        
        currentLocationBgView.backgroundColor = UIColor(hexFromString: ColorConstant.ADDITEMPINK)
        currentLocationBgView.layer.cornerRadius = 10
        
        bottomBgView.roundCorners(corners: [.topRight, .topLeft], radius: 20)
        setShadow(view: bottomBgView)
        
        completeAddressBtn.setTitle("Enter Complete Address", for: .normal)
        completeAddressBtn.tintColor = UIColor.white
        completeAddressBtn.backgroundColor = UIColor(hexFromString: ColorConstant.PRIMARYCOLOR)
        completeAddressBtn.layer.cornerRadius = 25
        setShadow(view: completeAddressBtn)
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            // Location services are authorized
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // Location services are denied, show an alert
            showLocationDeniedAlert()
            break
        case .notDetermined:
            // Location services are not determined, request authorization
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // Location services are restricted, show an alert
            showLocationRestrictedAlert()
            break
        @unknown default:
            break
        }
    }

    func showLocationDeniedAlert() {
        let alert = UIAlertController(
            title: "Location Services Disabled",
            message: "Please enable location services in Settings to use this feature.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            // Open the app settings where the user can enable location services
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })

        present(alert, animated: true, completion: nil)
    }

    func showLocationRestrictedAlert() {
        let alert = UIAlertController(
            title: "Location Services Restricted",
            message: "Location services are restricted on this device.",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alert, animated: true, completion: nil)
    }

    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "myLocation" {
            // Hide the default "My Location" icon
            googleMapView.settings.myLocationButton = false
        }
    }

    deinit {
        googleMapView.removeObserver(self, forKeyPath: "myLocation")
    }
    
    @objc func panGestureInMapViewDidRecognize(_ panGestureRecognizer: UIPanGestureRecognizer) {
        switch panGestureRecognizer.state {
        case .began:
            // The pan gesture began
            print("Pan gesture began")
        case .changed:
            // The user is currently panning the map
            print("Panning the map")
        case .ended:
            // The pan gesture ended
            print("Pan gesture ended")
        default:
            break
        }
    }
    
    func mapView(_ mapView: GMSMapView, idleAt cameraPosition: GMSCameraPosition) {
        // This method is called when the user stops panning (scrolling) the map.
        // You can perform actions here based on the new camera position.
        
        let centerCoordinate = cameraPosition.target
        
        // Reverse geocode the coordinates to get the address
        reverseGeocodeCoordinate(centerCoordinate)
    }

    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { (response, error) in
            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                return
            }
            
            if let result = response?.firstResult() {
                var addressComponents: [String] = []
                
                if let subLocality = result.subLocality {
                    addressComponents.append(subLocality)
                }
                
                if let locality = result.locality {
                    addressComponents.append(locality)
                }
                
                if let administrativeArea = result.administrativeArea {
                    addressComponents.append(administrativeArea)
                }
                
                if let postalCode = result.postalCode {
                    addressComponents.append(postalCode)
                }
                
                // Join the address components with a comma and display them
                let address = addressComponents.joined(separator: ", ")
                self.addressLbl.text = address
                
                self.latitude = coordinate.latitude
                self.longitude = coordinate.longitude
                
                print("latitute \(coordinate.latitude)")
                print("latitute longitit \(coordinate.longitude)")
                
                self.floorAddress = result.locality!
                self.selecteAddress = address
                
            } else {
                print("Address not found")
            }
        }
    }


    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
      mapView.clear()
    }

    func updateAddressLabel(forCoordinate coordinate: CLLocationCoordinate2D) {
        geocoder.reverseGeocodeCoordinate(coordinate) { [weak self] response, error in
            guard let self = self else { return }

            if let error = error {
                print("Reverse geocoding error: \(error.localizedDescription)")
                self.addressLbl.text = "Address not found"
                return
            }

            if let result = response?.firstResult() {
                // Extract address components as needed
                if let subLocality = result.subLocality, let locality = result.locality {
                    let address = "\(subLocality), \(locality)"
                    self.addressLbl.text = address
                } else {
                    self.addressLbl.text = "Address not found"
                }
            } else {
                self.addressLbl.text = "Address not found"
            }
        }
    }

}

extension GoogleMapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }

        // Stop updating location once you have it
            locationManager.stopUpdatingLocation()

            // Clear existing markers from the map
            googleMapView.clear()

            // Hide the default Google marker and remove it
            googleMapView.isMyLocationEnabled = false
        
            marker?.map = nil

        // Create a GMSGeocoder instance
        let geocoder = GMSGeocoder()

        geocoder.reverseGeocodeCoordinate(location.coordinate) { (response, error) in
            if let error = error {
                print("Reverse geocoding failed: \(error.localizedDescription)")
                return
            }

            if let result = response?.firstResult() {
                // Extract address components as needed
                if let subLocality = result.subLocality,
                   let locality = result.locality {
                    let address = "\(subLocality), \(locality)"
                    print("User's Address: \(address)")

                    // Update your UI with the user's address
                    DispatchQueue.main.async {
                        self.addressLbl.text = address
                    }
                } else {
                    print("User's Address not found")
                }
            }

            // Focus on the user's current location and add a marker
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
            self.googleMapView.camera = camera

            // Create a marker for the user's current location
            let marker = GMSMarker()
            marker.position = location.coordinate
            marker.title = "Current Location"
            marker.map = self.googleMapView
        }
    }

}

extension GoogleMapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        print("Place Name: \(String(describing: place.name))")
        
        
    }

    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Google Error \(error.localizedDescription)")
    }

    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    }
}

