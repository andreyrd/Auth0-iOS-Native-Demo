//
//  Constants.swift
//  Auth0-iOS-Native-Demo
//
//  Created by Andrey Radchishin on 2/16/18.
//  Copyright © 2018 Andrey Radchishin. All rights reserved.
//

import Foundation

struct Constants {
    static let domain = "REPLACEME.auth0.com"
    static let clientId = "REPLACEME"
    static let audience = "REPLACEME"
    static let redirectUri = "REPLACEME"

    // This one I'm not 100% sure about. If I set it to https:// + the auth0 domain it works
    // If I set it to the app identifier, it still works, but shows an error in Auth0 logs
    static let origin = "REPLACEME"
}
