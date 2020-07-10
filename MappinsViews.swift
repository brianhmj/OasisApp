//
//  MappinsViews.swift
//  Oasis
//
//  Created by Brian Jung on 7/2/20.
//  Copyright © 2020 Brian Jung. All rights reserved.
//

import Foundation
import MapKit

class MappinsMarkerView: MKMarkerAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let mappins = newValue as? Mappins else {
        return
      }
      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
    
      enum CalloutAccessoryType : Int {
        case info = 0
        case maps = 1
      }
        
      let mapsButton = UIButton(frame: CGRect(
          origin: CGPoint.zero,
          size: CGSize(width: 48, height: 48)))
      mapsButton.tag = CalloutAccessoryType.maps.rawValue
      mapsButton.setBackgroundImage(#imageLiteral(resourceName: "AppleMaps"), for: .normal)
        
      let infoButton = UIButton(frame: CGRect(
          origin: CGPoint.zero,
          size: CGSize(width: 36, height: 36)))
      infoButton.tag = CalloutAccessoryType.info.rawValue
      infoButton.setBackgroundImage(#imageLiteral(resourceName: "CityGuide"), for: .normal)
        
      let detailLabel = UILabel()
      detailLabel.numberOfLines = 0
      detailLabel.font = detailLabel.font.withSize(12)
      detailLabel.text = mappins.subtitle
      detailCalloutAccessoryView = detailLabel
        
      rightCalloutAccessoryView = mapsButton
      leftCalloutAccessoryView = infoButton
      markerTintColor = mappins.markerTintColor
      glyphImage = mappins.image
        
      
    }
  }
}


//If you want just the image but needs to work on making sure the two UIButtons are set up properly
class MappinsView: MKAnnotationView {
  override var annotation: MKAnnotation? {
    willSet {
      guard let mappins = newValue as? Mappins else {
        return
      }

      canShowCallout = true
      calloutOffset = CGPoint(x: -5, y: 5)
      rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
      leftCalloutAccessoryView = UIButton(type: .detailDisclosure)

      image = mappins.image
    }
  }
}
