//
//  WelcomeViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import UserNotifications

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
    
    private let descreptionLabel: UILabel = {
        let label = UILabel()
        label.text = .welcome.descriptionLabel
        return label
    }()
    
    private lazy var registerButton: ICinemaButton = ICinemaButton(title: .register, action: self.registerButtonTapped)
        
    private let guestButton: UIButton = {
        let button = UIButton()
        button.heightConstraints(.iCinemaButton.size.height)
        button.backgroundColor = .white
        button.layer.shadowColor = UIColor.iCinemaYellowColor.cgColor
        button.setTitleColor(.iCinemaOnlyGray, for: .normal)
        button.setTitle(.welcome.guest, for: .normal)
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.layer.cornerRadius = .iCinemaButton.cornerRadius
        button.titleLabel?.font = .button
        return button
    }()
        
    
    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        addImageView()
        addDescriptionLabel()
        addRegisterAndGuestButtons()
        
        UNUserNotificationCenter.current().delegate = self
        
    }
    
    // MARK: - Update UI Methods
    //
    private func addImageView() {
        view.addSubview(imageView)
        imageView.sizeConstraints(width: 250, height: 250)
        imageView.centerXInSuperview()
        imageView.makeConstraints(topAnchor: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func addDescriptionLabel() {
        view.addSubview(descreptionLabel)
        descreptionLabel.makeDescreptionLabel()
        descreptionLabel.centerYInSuperview()
    }
    
    private func addRegisterAndGuestButtons() {
        let stackview = UIStackView(arrangedSubviews: [registerButton, guestButton])
        stackview.axis = .vertical
        stackview.spacing = 10
        stackview.distribution = .fill
        
        view.addSubview(stackview)
        stackview.centerXInSuperview()
        stackview.makeConstraints(bottomAnchor: view.safeAreaLayoutGuide.bottomAnchor,
                                  padding: UIEdgeInsets(top: 0, left: 0, bottom: .view.padding.bottom, right: 0))
        
        guestButton.addTarget(self, action: #selector(self.guestButtonTapped(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    //
    private func registerButtonTapped() {
        self.coordinator?.push()
    }
    
    @objc private func guestButtonTapped(_ sender: ICinemaButton) {
        sender.addAnimate { 
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

