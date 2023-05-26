//
//  QRCodeViewController.swift
//  ICinemaForCinemas
//
//  Created by Ahmed Yamany on 24/05/2023.
//

import UIKit
import QRScanner
import AVFoundation
import MakeConstraints
import Coordinator


class QRCodeViewController: ICinemaViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupQRScanner()
    }
    
    private func setupQRScanner() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setupQRScannerView()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                if granted {
                    DispatchQueue.main.async { [weak self] in
                        self?.setupQRScannerView()
                    }
                }
            }
        default:
            showAlert()
        }
    }

    private func setupQRScannerView() {
        let qrScannerView = QRScannerView(frame: self.view.bounds)
        view.addSubview(qrScannerView)
        
        qrScannerView.focusImage = UIImage.cinemaUser.scanQR
            .withTintColor(.iCinemaYellowColor, renderingMode: .alwaysOriginal)
        qrScannerView.tintColor = .iCinemaYellowColor
        
        qrScannerView.focusImagePadding = 8.0
        qrScannerView.animationDuration = 0.5


        qrScannerView.configure(delegate: self, input: .init(isBlurEffectEnabled: true))
        qrScannerView.startRunning()
        
    }

    private func showAlert() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            let alert = UIAlertController(title: "Error", message: "Camera is required to use in this application", preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }

    
}


extension QRCodeViewController: QRScannerViewDelegate {
    func qrScannerView(_ qrScannerView: QRScannerView, didFailure error: QRScannerError) {
        print(error)
    }
    
    func qrScannerView(_ qrScannerView: QRScannerView, didSuccess code: String) {
        print(code)
        dismiss(animated: true)
    }
}

