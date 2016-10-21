//
//  LoginWireframe.swift
//  Photostream
//
//  Created by Mounir Ybanez on 13/08/2016.
//  Copyright © 2016 Mounir Ybanez. All rights reserved.
//

import UIKit

class LoginWireframe: LoginWireframeInput {

    weak var loginViewController: LoginViewController!
    var loginPresenter: LoginPresenter!
    var rootWireframe: RootWireframe!

    init() {
        let presenter = LoginPresenter()
        let service = AuthenticationServiceProvider()
        let interactor = LoginInteractor(service: service)
        interactor.output = presenter
        presenter.interactor = interactor
        presenter.wireframe = self

        self.loginPresenter = presenter
    }

    func navigateLoginInterfaceFromWindow(_ window: UIWindow!) {
        let sb = UIStoryboard(name: "LoginModuleStoryboard", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginViewController = vc
        loginPresenter.view = vc
        vc.presenter = loginPresenter
        rootWireframe.showRootViewController(vc, window: window)
    }

    func navigateHomeInterface() {
        let homeWireframe = HomeWireframe()
        homeWireframe.rootWireframe = rootWireframe
        homeWireframe.navigateHomeInterfaceFromWindow(loginViewController.view.window)
    }

    func navigateRegistrationInterface() {
        let registrationWireframe = RegistrationWireframe()
        registrationWireframe.navigateRegistrationInterfaceFromViewController(loginViewController)
    }

    func navigateLoginErrorAlert(_ error: NSError!) {
        let alert = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(okAction)
        loginViewController.present(alert, animated: true, completion: nil)
    }
}
