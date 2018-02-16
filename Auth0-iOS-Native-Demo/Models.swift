//
//  StartRequest.swift
//  Auth0-iOS-Native-Demo
//
//  Created by Andrey Radchishin on 2/16/18.
//  Copyright © 2018 Andrey Radchishin. All rights reserved.
//

import Foundation

struct StartRequest: Codable {
    let client_id: String
    let connection: String
    let phone_number: String
    let send: String
    let authParams: AuthParams
}

struct AuthParams: Codable {
    let response_type: String
    let redirect_uri: String
    let _csrf: String
    let state: String
}

struct LoginRequest: Codable {
    let client_id: String
    let username: String
    let otp: String
    let realm: String
    let credential_type: String
}

struct LoginResponse: Codable {
    let login_ticket: String
}
