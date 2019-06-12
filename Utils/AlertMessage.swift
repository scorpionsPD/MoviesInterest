//
//  AlertMessage.swift
//  SwipeDemo
//
//  Created by Pradeep Dahiya on 03.02.18.
//  Copyright © 2018 notimeforthat.org. All rights reserved.
//

import UIKit

class AlertMessage {
    var title: String
    var message: String
    var action: String
    var cancel: String?

    init(title: String,
         message: String,
         action: String,
         cancel: String? = nil) {
        self.title = title
        self.message = message
        self.action = action
        self.cancel = cancel
    }
}

class Alert: AlertMessage {
    static let connectionError =
        AlertMessage(title: .errorTitle,
                     message: .connectionErrorMessage,
                     action: .okAction)
}

extension UIViewController {
    func showAlert(withMessage message: AlertMessage,
                   defaultActionHandler: (() -> Void)? = nil,
                   cancelActionHandler: (() -> Void)? = nil) {

        let alert = UIAlertController(message)
        let action = UIAlertAction(title: message.action,
                                   style: .default) { _ in
            defaultActionHandler?()
        }
        alert.addAction(action)

        if let cancelTitle = message.cancel {
            let action = UIAlertAction(title: cancelTitle,
                                       style: .cancel) { _ in
                cancelActionHandler?()
            }
            alert.addAction(action)
        }

        DispatchQueue.main.async {
            self.present(alert, animated: true)
        }
    }
}

private extension UIAlertController {
    convenience init(_ message: AlertMessage) {
        self.init(title: message.title,
                  message: message.message,
                  preferredStyle: .alert)
    }
}
