//
//  ViewController.swift
//  Auth0-iOS-Native-Demo
//
//  Created by Andrey Radchishin on 2/16/18.
//  Copyright © 2018 Andrey Radchishin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionTaskDelegate {

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    private let appView = View()

    private var state = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(appView)
        appView.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 120)

        appView.onSendTapped = passwordlessStart
        appView.onVerifyTapped = passwordlessLogin
    }

    func passwordlessStart() {
        print("passwordless start")

        state = UUID().uuidString

        let url = URL(string: "https://\(Constants.domain)/passwordless/start")!
        let body = StartRequest(
            client_id: Constants.clientId,
            connection: "sms",
            phone_number: appView.phone,
            send: "code",
            authParams: AuthParams(
                response_type: "token",
                redirect_uri: Constants.redirectUri,
                _csrf: "deprecated",
                state: state
            )
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! encoder.encode(body)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        print(String(data: request.httpBody!, encoding: .utf8)!)

        URLSession.shared.dataTask(with: request) { data, response, err in
            if let err = err {
                print(err)
                return
            }

            print(response)

            if let data = data {
                print(String(data: data, encoding: .utf8))
            }
        }.resume()
    }

    func passwordlessLogin() {
        print("passwordless login")

        let url = URL(string: "https://\(Constants.domain)/co/authenticate")!
        let body = LoginRequest(
            client_id: Constants.clientId,
            username: appView.phone,
            otp: appView.code,
            realm: "sms",
            credential_type: "http://auth0.com/oauth/grant-type/passwordless/otp"
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try! encoder.encode(body)
        request.addValue(Constants.origin, forHTTPHeaderField: "Origin")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, err in
            if let err = err {
                print(err)
                return
            }

            print(response)

            if let data = data {
                print(String(data: data, encoding: .utf8))

                if let response = try? self.decoder.decode(LoginResponse.self, from: data) {
                    let url = URL(string: "https://\(Constants.domain)/authorize"
                        + "?audience=\(self.escape(Constants.audience))"
                        + "&client_id=\(self.escape(Constants.clientId))"
                        + "&login_ticket=\(self.escape(response.login_ticket))"
                        + "&realm=sms"
                        + "&redirect_uri=\(self.escape(Constants.redirectUri))"
                        + "&state=\(self.escape(self.state))"
                        + "&_csrf=deprecated"
                        + "&response_type=token"
                    )!

                    URLSession(configuration: .default, delegate: self, delegateQueue: nil).dataTask(with: url).resume()
                } else {
                    print("could not decode data")
                }
            } else {
                print("no data")
            }
        }.resume()
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse,
                    newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        let fragment = request.url?.fragment
        let params = fragment?.split(separator: "&")
        let tokenParam = params?.first(where: { $0.starts(with: "access_token") })

        DispatchQueue.main.async {
            self.appView.token = String(tokenParam?.split(separator: "=")[1] ?? "")
            print(self.appView.token)
        }
    }

    private func escape(_ string: String) -> String {
        return string.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

