//
//  Helper.swift
//  Calendar
//
//  Created by 이다영 on 2021/05/07.
//

import Foundation
import UIKit

class Helper {
    static func show(message: String) {
        let alertController = UIAlertController(title: "Calendar", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(dismissAction)
        
        let pushedViewControllers = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewControllers.last
        
        presentedViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension DateComponents {
    var asString: String? {
        if let date = Calendar.current.date(from: self) {
            let dateFormatter = DateFormatter()
            
            dateFormatter.locale = Locale.current
            dateFormatter.dateStyle = .medium
            
            let dateString = dateFormatter.string(from: date)
            
            return dateString
        }
        return nil
    }
}
