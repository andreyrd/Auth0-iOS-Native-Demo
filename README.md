# Auth0-iOS-Native-Demo

This is a very quick and dirty example implementation of native passwordless SMS login using the latest OIDC compliant Auth0 endpoints.

It's meant to be a one time example implementation as a proof of concept, so please don't actually use it anywhere. :) There's a lot of hacky unwraps and view positioning in it.

## Reference
https://github.com/auth0/Auth0.swift/issues/186

## Usage
* Enter the values from your Auth0 account into Constants.swift.
* Launch the app.
* Enter a phone number in E.164 format (ex: +12065550000) into the first text field.
* Tap send.
* Enter the code you receive into the second text field.
* Tap verify.
* The access_token will show up on the screen.