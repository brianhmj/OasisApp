//
//  SecondViewController.swift
//  Oasis
//
//  Created by Brian Jung on 7/1/20.
//  Copyright © 2020 Brian Jung. All rights reserved.
//

import UIKit
import MapKit
import AVFoundation

class SecondViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var PopUp: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var JarvisButton: UIButton!
    
    
    private var mappins: [Mappins] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        PopUp.isHidden = true
        let initialLocation = CLLocation(latitude: 22.291694, longitude: 114.181652)
        mapView.centerToLocation(initialLocation)
        
        mapView.delegate = self
        
//        mapView.register(
//        MappinsView.self,
//        forAnnotationViewWithReuseIdentifier:
//          MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        mapView.register(
        MappinsMarkerView.self,
        forAnnotationViewWithReuseIdentifier:
          MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        loadInitialData()
        mapView.addAnnotations(mappins)
        
        let regionRadius = 250.0
        let circle = [MKCircle(center: CLLocationCoordinate2D(latitude: 22.313656, longitude: 114.189660), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.333494, longitude: 114.209467), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.278112, longitude: 114.175677), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.301300, longitude: 114.173635), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.375918, longitude: 114.170963), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.287714, longitude: 114.149631), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.277712, longitude: 114.179064), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.295125, longitude: 113.949886), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.304351, longitude: 114.163152), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.335115, longitude: 114.160267), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.313643, longitude: 114.189557), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.333613, longitude: 114.209392), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.303402, longitude: 114.167474), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.499780, longitude: 114.110437), radius: regionRadius),
        MKCircle(center: CLLocationCoordinate2D(latitude: 22.310942, longitude: 114.224626), radius: regionRadius)]
        mapView.addOverlays(circle)
    }
    
    
    let synthesizer = AVSpeechSynthesizer()
    var utterance = AVSpeechUtterance(string: "hi")
    
    
    @IBAction func DismissIsPressed(_ sender: UIButton) {
        PopUp.isHidden = true
        synthesizer.stopSpeaking(at: .immediate)
    }

 
    @IBAction func JarvisIsPressed(_ sender: UIButton) {
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.4
        synthesizer.speak(utterance)
    }
    
    
    private func loadInitialData() {
      guard
        let fileName = Bundle.main.url(forResource: "HKAttractions", withExtension: "geojson"),
        let mappinsData = try? Data(contentsOf: fileName)
        else {
          return
      }
      do {
        let features = try MKGeoJSONDecoder()
          .decode(mappinsData)
          .compactMap { $0 as? MKGeoJSONFeature }
        let validWorks = features.compactMap(Mappins.init)
        mappins.append(contentsOf: validWorks)
      } catch {
        print("Unexpected error: \(error).")
      }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let circleRenderer = MKCircleRenderer(overlay: overlay)
        circleRenderer.strokeColor = UIColor.red
        circleRenderer.fillColor = UIColor(red: 255, green: 0, blue: 0, alpha: 0.3)
        circleRenderer.lineWidth = 1.0
        return circleRenderer
    }
    
}

private extension MKMapView {
  func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 16000) {
    let coordinateRegion = MKCoordinateRegion(
      center: location.coordinate,
      latitudinalMeters: regionRadius,
      longitudinalMeters: regionRadius)
    setRegion(coordinateRegion, animated: true)
  }
}

extension SecondViewController: MKMapViewDelegate {
  func mapView(
    _ mapView: MKMapView,
    annotationView view: MKAnnotationView,
    calloutAccessoryControlTapped control: UIControl
  ) {
    guard let mappins = view.annotation as? Mappins else {
      return
    }
    
    enum CalloutAccessoryType : Int {
      case info = 0
      case maps = 1
    }
    
    let accessoryType = CalloutAccessoryType.init(rawValue: control.tag)!
    switch accessoryType {
    case .maps:
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mappins.mapItem?.openInMaps(launchOptions: launchOptions)
    case .info:
        PopUp.isHidden = false
        self.titleLabel.text = mappins.title
        titleLabel.numberOfLines = 1
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.5
        self.infoLabel.text = mappins.placedescription
        infoLabel.adjustsFontSizeToFitWidth = true
        infoLabel.minimumScaleFactor = 0.5
        
        JarvisButton.layer.cornerRadius = 5
        JarvisButton.layer.borderWidth = 1
        JarvisButton.layer.borderColor = UIColor.black.cgColor
        
        utterance = AVSpeechUtterance(string: mappins.placedescription ?? "default value")
            }
     }
    
}
