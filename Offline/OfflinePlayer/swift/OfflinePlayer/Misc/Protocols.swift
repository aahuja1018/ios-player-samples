//
//  Protocols.swift
//  OfflinePlayer
//
//  Copyright © 2018 Brightcove, Inc. All rights reserved.
//

import Foundation
import BrightcovePlayerSDK

protocol ReloadDelegate: class {
    func reloadData()
    func reloadRow(forVideo video: BCOVVideo)
}
