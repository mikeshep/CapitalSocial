//
//  LoginViewViewController.swift
//  CapitalSocial
//
//  Created by Miguel angel olmedo perez on 11/5/18.
//  Copyright © 2018 Miguel angel olmedo perez. All rights reserved.
//

import UIKit
import QRCodeReader
import AVFoundation


protocol LoginViewControllerProtocol: BaseProtocol {
    var viewModel: LoginViewModelProtocol? { get set }
    
    func presentPromotionsViewController()
}


class LoginViewController: UIViewController, LoginViewControllerProtocol {

    
    
    @IBOutlet weak var btnScanQR: UIButton!
    @IBOutlet weak var btnEnterEmail: UIButton!
    @IBOutlet weak var tfUser: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    var viewModel: LoginViewModelProtocol?
    
    //QR Reader
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton         = true
            $0.preferredStatusBarStyle = .lightContent
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        return QRCodeReaderViewController(builder: builder)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnScanQR.setTitle(CSString.Login.qrScanCodeButton, for: .normal)
        btnEnterEmail.setTitle(CSString.Login.emailPasswordInput, for: .normal)
        tfUser.placeholder = CSString.Login.user
        tfPassword.placeholder = CSString.Login.password
        btnLogin.setTitle(CSString.Login.signIn, for: .normal)
        btnRegister.setTitle(CSString.Login.signUp, for: .normal)
        btnForgotPassword.setTitle(CSString.Login.passwordForgot, for: .normal)
        btnRegister.coloredBorder()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        view.endEditing(true)
        guard
            let user = tfUser.text, !user.isEmpty,
            let password = tfPassword.text, !password.isEmpty else {
                self.showMessage(message: CSString.Login.withoutPasswordOrUser)
                return
        }
        viewModel?.actionLogin(user: user, password: password)
    }
    
    //Launch QR Reader
    @IBAction func scannQRcode(_ sender: Any) {
        guard checkScanPermissions() else { return }
        readerVC.modalPresentationStyle = .formSheet
        readerVC.delegate = self
        present(readerVC, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapOnContainerView(_ sender: Any) {
        view.endEditing(true)
    }
    
}

extension LoginViewController {
    
    func presentPromotionsViewController() {
        let navigationViewController: PromotionsNavigationController = UIStoryboard.storyboard(storyboard: .main).instantiateNViewController()
        present(navigationViewController, animated: true, completion: nil)
    }
    
}

//MARK: - CAMERA PERMISSIONS ************//
extension LoginViewController {
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            switch error.code {
            case -11852:
                showMessage(message: CSString.Login.withoutPermissions)
            default:
                showMessage(message: CSString.Login.notSupported)
            }
            return false
        }
    }
}


//MARK: - QRCodeReader Delegate Methods
extension LoginViewController: QRCodeReaderViewControllerDelegate {
    

    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
        tfPassword.text = result.value
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        dismiss(animated: true, completion: nil)
    }
    
}
