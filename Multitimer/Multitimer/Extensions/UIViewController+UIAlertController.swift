//
//  UIViewController+UIAlertController.swift
//  Multitimer
//
//  Created by Danil Nurgaliev on 12.07.2021.
//

import UIKit

extension UIViewController {
    func showAlert(alertTitle: String, alertMessage: String, defaultButtonTitle: String) {
        let alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: defaultButtonTitle, style: .default))
        present(alertController, animated: true, completion: nil)
    }
}
