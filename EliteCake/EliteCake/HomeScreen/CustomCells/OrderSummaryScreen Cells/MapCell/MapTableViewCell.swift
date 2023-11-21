//
//  MapTableViewCell.swift
//  EliteCake
//
//  Created by Apple - 1 on 04/05/23.
//

import UIKit
import MapKit
import GoogleMaps

class MapTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackingMapView: MKMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let coordinates: [CLLocationCoordinate2D] = [
                    CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0),
                    CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0),
                    CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2),
                    CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2),
                    CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0)
                ]

                var polylineSegments: [MKPolyline] = []

                for i in 0..<coordinates.count - 1 {
                    let sourceCoordinate = coordinates[i]
                    let destinationCoordinate = coordinates[i + 1]

                    let segment = MKPolyline(coordinates: [sourceCoordinate, destinationCoordinate], count: 2)
                    polylineSegments.append(segment)
                }

                trackingMapView.addOverlays(polylineSegments)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    
    //    private func animatePolyline(_ polyline: MKPolyline) {
    //        guard let renderer = trackOrderMapView.renderer(for: polyline) as? MKPolylineRenderer else { return }
    //
    //        let pointCount = polyline.pointCount
    //        var index = 0
    //        var subCoordinates: [CLLocationCoordinate2D] = []
    //
    //        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
    //            if index >= pointCount {
    //                timer.invalidate()
    //                return
    //            }
    //
    //            let point = polyline.points()[index]
    //            let coordinate = CLLocationCoordinate2D(latitude: point.x, longitude: point.y)
    //            subCoordinates.append(coordinate)
    //
    //            let subPolyline = MKPolyline(coordinates: subCoordinates, count: subCoordinates.count)
    //
    //            // Remove the old polyline
    //            self.trackOrderMapView.removeOverlay(polyline)
    //
    //            // Add the new polyline
    //            self.trackOrderMapView.addOverlay(subPolyline)
    //
    //            index += 1
    //        }
    //    }
    //
    //    func drawPolylineWithAnimation(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
    //        let sourcePlacemark = MKPlacemark(coordinate: source)
    //        let destinationPlacemark = MKPlacemark(coordinate: destination)
    //
    //        let sourceMapItem = MKMapItem(placemark: sourcePlacemark)
    //        let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
    //
    //        let directionRequest = MKDirections.Request()
    //        directionRequest.source = sourceMapItem
    //        directionRequest.destination = destinationMapItem
    //        directionRequest.transportType = .automobile
    //
    //        let directions = MKDirections(request: directionRequest)
    //        directions.calculate { [weak self] (response, error) in
    //            guard let response = response else { return }
    //            let route = response.routes[0]
    //
    //            // Add the route polyline to the map
    //            self?.trackOrderMapView.addOverlay(route.polyline)
    //
    //            // Set the visible map region to include the route
    //            self?.trackOrderMapView.setVisibleMapRect(route.polyline.boundingMapRect, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: true)
    //        }
    //    }
}

//extension MapTableViewCell: MKMapViewDelegate {
//    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//        if let polyline = overlay as? MKPolyline {
//            let renderer = MKPolylineRenderer(polyline: polyline)
//            renderer.strokeColor = UIColor.blue
//            renderer.lineWidth = 5
//            return renderer
//        }
//        return MKOverlayRenderer(overlay: overlay)
//    }
//}

extension MapTableViewCell: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = UIColor.blue
            renderer.lineWidth = 5
            return renderer
        }
        return MKOverlayRenderer(overlay: overlay)
    }
}
