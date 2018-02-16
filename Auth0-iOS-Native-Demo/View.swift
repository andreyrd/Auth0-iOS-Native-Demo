//
//  View.swift
//  Auth0-iOS-Native-Demo
//
//  Created by Andrey Radchishin on 2/16/18.
//  Copyright © 2018 Andrey Radchishin. All rights reserved.
//

import UIKit

class View: UIView {

    public var onSendTapped: (() -> Void)?
    public var onVerifyTapped: (() -> Void)?

    public var phone: String { return phoneField.text ?? "" }
    public var code: String { return codeField.text ?? "" }

    public var token: String? {
        get { return tokenLabel.text }
        set { tokenLabel.text = newValue }
    }

    private let phoneField = UITextField(frame: CGRect(x: 2, y: 2, width: 150, height: 31))
    private let sendButton = UIButton(frame: CGRect(x: 170, y: 2, width: 50, height: 31))
    private let codeField = UITextField(frame: CGRect(x: 2, y: 44, width: 150, height: 31))
    private let verifyButton = UIButton(frame: CGRect(x: 170, y: 44, width: 50, height: 31))
    private let tokenLabel = UILabel(frame: CGRect(x: 0, y: 84, width: 200, height: 200))

    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 222, height: 294))

        backgroundColor = .white

        addSubview(phoneField)
        addSubview(sendButton)
        addSubview(codeField)
        addSubview(verifyButton)
        addSubview(tokenLabel)

        phoneField.borderStyle = .line
        codeField.borderStyle = .line
        tokenLabel.numberOfLines = 0
        tokenLabel.font = .systemFont(ofSize: 12)

        sendButton.setTitle("Send", for: .normal)
        sendButton.setTitleColor(.black, for: .normal)
        verifyButton.setTitle("Verify", for: .normal)
        verifyButton.setTitleColor(.black, for: .normal)

        sendButton.addTarget(self, action: #selector(didTapSend), for: .touchUpInside)
        verifyButton.addTarget(self, action: #selector(didTapVerify), for: .touchUpInside)
    }

    @objc func didTapSend() {
        onSendTapped?()
    }

    @objc func didTapVerify() {
        onVerifyTapped?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
