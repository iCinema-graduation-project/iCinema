//
//  WelcomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import UserNotifications
import ViewAnimator
import SPAlert
import NetworkLayer
import MakeConstraints
import LocationManager

extension UILabel {
    func makeDescreptionLabel() {
        textAlignment = .center
        numberOfLines = 0
        textColor = .iCinemaTextColor
        font = .footnote
        centerXInSuperview()
        fillXSuperViewConstraints(paddingLeft: .view.padding.left,
                                  paddingRight: .view.padding.right)
        
        guard let superview = superview else { return }
        makeConstraints(topAnchor: superview.safeAreaLayoutGuide.topAnchor,
                                         padding: CGFloat.view.padding)
    }
}


class WelcomeViewController: ICinemaViewController {
    // MARK: - Views
    //
    private let imageView: UIImageView = UIImageView(image: .welcomeImage)
    private let descreptionLabel: UILabel = UILabel()
    private lazy var registerButton: ICinemaButton = ICinemaButton(title: .register, action: self.registerButtonTapped)
    private lazy var guestButton = CancelButton(title: .welcome.guest, action: self.guestButtonTapped)

    // MARK: - Properties
    var timer: Timer!
    var imageViewConstraints: AnchoredConstraints!
    
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        UNUserNotificationCenter.current().delegate = self
        
        LocationManager.shared.startUpdatingLocation()
        
    }

    // MARK: - Update UI Methods
    //
    private func updateUI() {
        addImageView()
        addDescriptionLabel()
        addRegisterAndGuestButtons()
    }
    
    private func addImageView() {
        view.addSubview(imageView)
        imageView.sizeConstraints(width: 250, height: 250)
        imageView.centerXInSuperview()
        imageViewConstraints = imageView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
        
        let animation = AnimationType.zoom(scale: 0.2)
        imageView.animate(animations: [animation])
        self.timer = .scheduledTimer(timeInterval: 3.05,
                                     target: self,
                                     selector: #selector(self.animateImageView),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.makeDescreptionLabel()
        descreptionLabel.centerYInSuperview()
        descreptionLabel.text = .welcome.descriptionLabel
    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [registerButton, guestButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                  padding: CGFloat.view.padding)
        
    }
    
    @objc private func animateImageView() {
        
        UIView.animate(withDuration: 1.5) {
            self.imageViewConstraints.top?.constant = 20
            self.view.layoutIfNeeded()

        }completion: { _ in
            UIView.animate(withDuration: 1.5) {
                self.imageViewConstraints.top?.constant = 0
                self.view.layoutIfNeeded()
            }
        }
                
    }
    
    // MARK: - Actions
    //
    private func registerButtonTapped() {
        self.coordinator?.push()
    }
    
    @objc private func guestButtonTapped() {
        guestButton.addAnimate {
            UNUserNotificationCenter.current().requestAuthorization(options: [.sound, .alert, .badge]) { granted, error in
                if granted {
                    self.schenualNotification()
                } else {
                    
                }
            }
        }
    }
    
    func schenualNotification() {
        // 1 Notificatio content
        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.subtitle = "Hello How are you"
        content.body = "We remind you that you have a movie at galaxy cinema at 2AM"
        content.sound = .default
        content.launchImageName = "cinema"
        content.userInfo = ["name": "Ahmed Yamany"]
        
        // 2 Time Interval trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(5), repeats: false)
//        var dateComponents = DateComponents()
//
//        dateComponents.calendar = Calendar.current
//        dateComponents.weekday = 5
//        dateComponents.hour = 17
//        dateComponents.minute = 34
        
//        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        // 3 Request
        let request = UNNotificationRequest(identifier: "test1", content: content, trigger: trigger)
    
        
        // 4 add to notification center
        UNUserNotificationCenter.current().add(request)
    }
    
}

extension WelcomeViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Clicked")
        let userInfo = response.notification.request.content.userInfo
        print(userInfo["name"] ?? "Ahmed")
        
    }
    
  
}

