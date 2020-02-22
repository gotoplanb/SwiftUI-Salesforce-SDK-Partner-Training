//
//  MapView.swift
//  RedwoodsInsurance
//
//  Created by Kevin Poorman on 1/13/20.
//  Copyright © 2020 RedwoodsInsuranceOrganizationName. All rights reserved.
//

import Foundation
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  @EnvironmentObject var env: Env
  @Binding var mapView: MKMapView
  let address: String
  let contactName: String
  
  func makeUIView(context: Context) -> MKMapView {
    mapView.delegate = context.coordinator
    return mapView
  }
  
  func updateUIView(_ view: MKMapView, context: Context) {
    let annotation = MKPointAnnotation()
    annotation.coordinate = context.coordinator.coordiantes(from: address).coordinate
    
    annotation.title = contactName
    annotation.subtitle = address
    view.addAnnotation(annotation)
  }
  
  func makeCoordinator() -> MapView.Coordinator {
    Coordinator(self)
  }
  
  class Coordinator: NSObject, MKMapViewDelegate {
    var parent: MapView
    let locationManager = CLLocationManager()
    var mkMapView: MKMapView!
    let regionRadius = 150.0
    
    init(_ parent: MapView) {
      self.parent = parent
      self.mkMapView = self.parent.mapView
      super.init()
      
      locationManager.desiredAccuracy = kCLLocationAccuracyBest
      
      if checkLocationAuthorizationStatus() == true {
        centerMap(on: coordiantes(from: self.parent.address))
      }
      
      mkMapView.mapType = .standard
      mkMapView.isZoomEnabled = true
      mkMapView.isScrollEnabled = true
      mkMapView.clipsToBounds = true
      mkMapView.layer.cornerRadius = 6
    }
    
    func checkLocationAuthorizationStatus() -> Bool? {
      if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
        locationManager.startUpdatingLocation()
        return true
      } else {
        locationManager.requestWhenInUseAuthorization()
        return nil
      }
    }
    
    func coordiantes(from address: String) -> CLLocation {
      let geoCoder = CLGeocoder()
      var location: CLLocation = CLLocation()
      geoCoder.geocodeAddressString(address){ (placemarks, error) in
        guard let placemarks = placemarks,
          let firstLocation = placemarks.first?.location
          else {
            return
        }
        
        location = firstLocation
        self.centerMap(on: firstLocation)
      }
      return location
    }
    
    private func centerMap(on location: CLLocation) {
      let coordinateRegion = MKCoordinateRegion.init(center: location.coordinate,
                                                     latitudinalMeters: regionRadius,
                                                     longitudinalMeters: regionRadius)
      self.mkMapView?.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
      _ = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
    }
  }
  
}
