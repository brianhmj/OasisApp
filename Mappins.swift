//
//  Mappins.swift
//  Oasis
//
//  Created by Brian Jung on 7/1/20.
//  Copyright © 2020 Brian Jung. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class Mappins: NSObject, MKAnnotation {
  let title: String?
  let locationName: String?
  let discipline: String?
  let placedescription: String?
  let coordinate: CLLocationCoordinate2D
  
  init(
    title: String?,
    locationName: String?,
    discipline: String?,
    placedescription: String?,
    coordinate: CLLocationCoordinate2D
  ) {
    self.title = title
    self.locationName = locationName
    self.discipline = discipline
    self.placedescription = placedescription
    self.coordinate = coordinate
    
    super.init()
  }
  
  init?(feature: MKGeoJSONFeature) {
    guard
      let point = feature.geometry.first as? MKPointAnnotation,
      let propertiesData = feature.properties,
      let json = try? JSONSerialization.jsonObject(with: propertiesData),
      let properties = json as? [String: Any]
      else {
        return nil
    }
    
    title = properties["title"] as? String
    locationName = properties["location"] as? String
    discipline = properties["discipline"] as? String
    placedescription = properties["description"] as? String
    coordinate = point.coordinate
    super.init()
  }
  
  var subtitle: String? {
    return locationName
  }
  
  var mapItem: MKMapItem? {
    guard let location = locationName else {
      return nil
    }
    
    let addressDict = [CNPostalAddressStreetKey: location]
    let placemark = MKPlacemark(
      coordinate: coordinate,
      addressDictionary: addressDict)
    let mapItem = MKMapItem(placemark: placemark)
    mapItem.name = title
    return mapItem
  }
  
  var markerTintColor: UIColor  {
    switch discipline {
    case "Monument":
      return .red
    case "Tourist Attraction":
      return #colorLiteral(red: 1, green: 0.4823951199, blue: 0.6289330051, alpha: 1)
    case "Landmark":
      return .blue
    case "Island":
      return .purple
    case "Museum","History Museum", "Art Museum", "Heritage Museum":
      return #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
    case "Hiking Trail", "Path", "Trail", "Street":
      return #colorLiteral(red: 0.1608518836, green: 0.5, blue: 0.04363762842, alpha: 1)
    case "Building", "Skycraper", "Tower":
      return #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    case "Beach", "Ocean", "Bay":
      return #colorLiteral(red: 0.1608518836, green: 0.04390517979, blue: 0.8992669092, alpha: 1)
    case "Park":
      return #colorLiteral(red: 0.8721907106, green: 0.1692529966, blue: 0.8992669092, alpha: 1)
    case "Market":
      return #colorLiteral(red: 0.8721907106, green: 0.1477151113, blue: 0.2296125856, alpha: 1)
    case "Amusement Park Ride", "Amusement Park", "Theme Park":
      return #colorLiteral(red: 0.260541524, green: 0.1477151113, blue: 0.6796607449, alpha: 1)
    default:
        return .yellow
    }
  }
    
    var image: UIImage {
      guard let name = discipline else {
        return #imageLiteral(resourceName: "Binoculars")
      }

      switch name {
      case "Monument":
        return #imageLiteral(resourceName: "Monuments")
      case "Tourist Attraction":
        return #imageLiteral(resourceName: "Camera1")
      case "Landmark":
        return #imageLiteral(resourceName: "Tower")
      case "Island":
        return #imageLiteral(resourceName: "Island")
      case "Museum","History Museum", "Art Museum", "Heritage Museum":
        return #imageLiteral(resourceName: "Museum")
      case "Building", "Skycraper", "Tower":
        return #imageLiteral(resourceName: "Building")
      case "Hiking Trail", "Path", "Trail", "Street":
        return #imageLiteral(resourceName: "Trail")
      case "Beach", "Ocean", "Bay":
        return #imageLiteral(resourceName: "Beach")
      case "Park":
        return #imageLiteral(resourceName: "Park")
      case "Market":
        return #imageLiteral(resourceName: "Market")
      case "Amusement Park Ride", "Amusement Park", "Theme Park":
        return #imageLiteral(resourceName: "AmusementPark")
      default:
        return #imageLiteral(resourceName: "Binoculars")
      }
    }
    
}
