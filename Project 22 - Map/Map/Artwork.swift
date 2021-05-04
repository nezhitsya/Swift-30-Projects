//
//  Artwork.swift
//  Map
//
//  Created by 이다영 on 2021/05/04.
//

import Foundation
import MapKit
import Contacts


class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    var subtitle: String? {
        return locationName
    }
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    func mapItem() -> MKMapItem {
        if let subtitle = subtitle {
            let addressDict = [CNPostalAddressStreetKey: subtitle]
            let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = title
            
            return mapItem
        } else {
            fatalError("Subtitle is nil")
        }
    }
    
    func pinColor() -> UIColor {
        switch discipline {
        case "Sculpture", "Plaque":
            return MKPinAnnotationView.redPinColor()
        case "Mural", "Monument":
            return MKPinAnnotationView.purplePinColor()
        default:
            return MKPinAnnotationView.greenPinColor()
        }
    }
    
    static func fromJSON(json: [JSONValue]) -> Artwork? {
        let locationName = json[12].string
        let discipline = json[15].string
        let latitude = (json[18].string! as NSString).doubleValue
        let longitude = (json[19].string! as NSString).doubleValue
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        return Artwork(title: json[16].string ?? "", locationName: locationName!, discipline: discipline!, coordinate: coordinate)
    }
}
