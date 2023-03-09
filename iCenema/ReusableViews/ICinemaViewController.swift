//
//  ViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit


class ICinemaViewController: ViewController {
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavegationControllar()
        view.backgroundColor = .iCinemaBackgroundColor
    }
    
    // end editing whene user begin touching
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing()
    }
    
    // MARK: - Helper Functions
    //
    private func configureNavegationControllar() {
        navigationController?.navigationBar.tintColor = .iCinemaTextColor
        navigationItem.backButtonTitle = ""
        
        // change navigarionBar back button Image
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward.square")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward.square")
    }
    
    
    // MARK: - Public Functions
   
    
    
    func getViewByTag(_ tag: Int) -> UIView?{
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

}


