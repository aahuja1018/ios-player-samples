//
//  BCOVVideo+Helpers.swift
//  OfflinePlayer
//
//  Copyright © 2018 Brightcove, Inc. All rights reserved.
//

import BrightcovePlayerSDK

extension BCOVVideo {
    
    func matches(offlineVideo: BCOVVideo) -> Bool {
        // Returns true if the two video objects reference the same video asset.
        // Specifically, they have the same account and same video Id.
        let v1Account = properties[kBCOVVideoPropertyKeyAccountId] as? String
        let v1Id = properties[kBCOVVideoPropertyKeyId] as? String
        let v2Account = offlineVideo.properties[kBCOVVideoPropertyKeyAccountId] as? String
        let v2Id = offlineVideo.properties[kBCOVVideoPropertyKeyId] as? String
        
        return (v1Account == v2Account) && (v1Id == v2Id)
    }
    
    func licenseString() -> String {

        if !usesFairPlay {
            return "clear"
        }
        
        if let purchaseNumber = properties[kBCOVFairPlayLicensePurchaseKey] as? NSNumber, purchaseNumber.boolValue == true {
            return "purchase"
        }

        if let absoluteExpirationNumber = properties[kBCOVOfflineVideoLicenseAbsoluteExpirationTimePropertyKey] as? NSNumber {
            
            let absoluteExpirationTime = absoluteExpirationNumber.doubleValue
            let expirationDate = Date(timeIntervalSinceReferenceDate: absoluteExpirationTime)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: expirationDate)
            return "rental (expires \(dateString))"
            
        } else if let rentalDurationNumber = properties[kBCOVFairPlayLicenseRentalDurationKey] as? NSNumber, let startTimeNumber = properties[kBCOVOfflineVideoDownloadStartTimePropertyKey] as? NSNumber {
            
            let rentalDuration = rentalDurationNumber.doubleValue
            let startTime = startTimeNumber.doubleValue
            let startDate = Date(timeIntervalSinceReferenceDate: startTime)
            let expirationDate = startDate.addingTimeInterval(rentalDuration)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.timeStyle = .short
            let dateString = dateFormatter.string(from: expirationDate)
            return "rental (expires \(dateString))"
        }
        
        return "unknown license"
        
    }
    
}
