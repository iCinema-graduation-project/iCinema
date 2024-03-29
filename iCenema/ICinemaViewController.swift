//
//  ViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import Coordinator
import NetworkLayer
import SPAlert

class ICinemaViewController: CoordinatorViewController {
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavegationControllar()
        view.backgroundColor = .iCinemaBackgroundColor
        
//        self.addSkipButton()

    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.endEditing()
    }
    
    // end editing whene user begin touching
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing()
    }
    
    // MARK: - Helper Methods
    //
    private func configureNavegationControllar() {
        navigationController?.navigationBar.tintColor = .iCinemaTextColor
        navigationItem.backButtonTitle = ""
        
        // change navigarionBar back button Image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.square")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.square")
    }
    
    // MARK: - Public Methods
    //
    public func getViewByTag(_ tag: Int) -> UIView?{
        return self.view.viewWithTag(tag)
    }
    
    @objc public func endEditing(){
        self.view.endEditing(true)
    }
    
    public func selectNextTextFieldByTagOrEndEditing(_ textField: UITextField){
        let nextTFTag = textField.tag + 1
        guard let nextTextField = self.getViewByTag(nextTFTag) as? UITextField else{
            self.endEditing()
           return
       }
        nextTextField.isEnabled = true
       nextTextField.becomeFirstResponder()
    }
    
    /// handels error
    public func handelError(_ error: NetworkError?) {
        if let error = error {
           let errorMessage = NetworkError.getErrorMessage(from: error)
            SPAlert.showAlert(with: errorMessage)
       }else {
           SPAlert.showUnKnownError()
       }

    }

}

extension ICinemaViewController {
    public func addSkipButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "skip", style: .done, target: self, action: #selector(self.skip))
    }
    
    @objc private func skip() {
        self.coordinator?.push()
    }
}
