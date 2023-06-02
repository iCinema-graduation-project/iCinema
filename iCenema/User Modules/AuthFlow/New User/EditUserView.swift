//
//  PhoneViewController.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import UIKit
import SwiftUI
import SPAlert
import NetworkLayer
import UIICinema
import Kingfisher
import Alamofire

class EditUserProfileViewController: ICinemaViewController {
    
    // MARK: - Views
    //
    private let scrollView = UIScrollView()
    
    let avatarView = AvatarView(size: 120, borderColor: .iCinemaYellowColor)

    private let StackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = .view.spacing
        return stackView
    }()
    
    private let fullNameTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.fullName)
    
    private let ageTextField: ICinemaTextField = ICinemaTextField(placeholder: .newUser.age)
    
    private lazy var genderView = GenderView(presenterView: view)
    
    private lazy var interstsView = InterstsView(viewModel: self.viewModel).hostigView()
    
    private lazy var createAccountButton = ICinemaButton(title: .saveEdits, action: self.saveEditsButtonTapped)
    
    // MARK: - Properties
    var viewModel = EditUserProfileViewModel()
    
    // MARK: - Life Cycle
    //
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        TabBarViewModel.shared.hide()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUI()
        self.genderView.delegate = self
        self.avatarView.delegate = self
        self.bindPublishers()
        self.fetchProfile()
        self.fetchCategories()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(self.endEditing))
        scrollView.addGestureRecognizer(gesture)
    
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.viewModel.service.cancelAllPublishers()
        self.viewModel.profileFeatcher.cancelAllPublishers()
        self.viewModel.categoriesFeatcher.cancelAllPublishers()
    }
    
    // MARK: - Update UI
    //
    private func updateUI() {
        navigationItem.addTitleView(title: .newUser.newUser)
        self.addScrollView()
        self.updateAvatarView()
        self.updateFullNameTextField()
        self.updateAgeTextField()
        self.addStackViewArrangedViews()
        self.updateInterstsView()
        self.addCreateAccountButton()
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        scrollView.fillSuperviewConstraints()
        scrollView.isScrollEnabled = true
        scrollView.contentSize = CGSize(width: CGFloat.screenBounds.width,
                                        height: CGFloat.screenBounds.height + 500)        
    }

    private func updateAvatarView() {
        avatarView.indicatorButton.tintColor = .iCinemaYellowColor
    }
    
    private func updateFullNameTextField() {
        fullNameTextField.font = .textfeild
        fullNameTextField.addTarget(self, action: #selector(self.fullNameTFEditingChanged), for: .editingChanged)
    }
    
    private func updateAgeTextField() {
        ageTextField.keyboardType = .numberPad
        ageTextField.font = .textfeild
        ageTextField.addTarget(self, action: #selector(self.ageTFEditingChanged), for: .editingChanged)
    }
    
    private func addStackViewArrangedViews() {
        scrollView.addSubview(StackView)
        StackView.centerXInSuperview()
        StackView.makeConstraints(topAnchor: scrollView.topAnchor)
        
        StackView.addArrangedSubview(avatarView)
        StackView.addArrangedSubview(fullNameTextField)
        StackView.addArrangedSubview(ageTextField)
        StackView.addArrangedSubview(genderView.view)
        StackView.addArrangedSubview(interstsView)
        StackView.arrangedSubviews[1...].forEach {$0.widthConstraints(.view.width)}
    
        genderView.updateGenders()
    
    }
    
    private func updateInterstsView() {
        interstsView.heightConstraints(800)
        interstsView.backgroundColor = .clear
    }
    
    private func addCreateAccountButton(){
        view.addSubview(createAccountButton)
        createAccountButton.addToitsSuperView()
    }
    
    // MARK: - Helpers
    
    private func bindPublishers() {
        self.viewModel.$fullName.sink { self.fullNameTextField.text = $0 }.store(in: &viewModel.service.cancellableSet)
        self.viewModel.$age.sink { self.ageTextField.text = $0 > 0 ? String($0) : "" }.store(in: &viewModel.service.cancellableSet)
        self.viewModel.$gender.sink { self.genderView.gender = $0 }.store(in: &viewModel.service.cancellableSet)
        self.viewModel.$profile.sink { profile in
            guard let imageURl = profile?.user.image else { return }
            self.avatarView.avatar.kf.setImage(with: URL(string: imageURl))
        }
        .store(in: &viewModel.service.cancellableSet)
    }
    
    // MARK: - Actions
    func saveEditsButtonTapped() {
        if self.isReadyToUpdateProfile() {
            guard let imageDate = self.avatarView.avatar.image?.jpegData(compressionQuality: 0.25) else { return }
            let indicator = ActivityIndicator.shared
            indicator.play()
            self.viewModel.service.request(multiPart: ["image": .init(type: .image, extention: "png", data: imageDate)])
                .sink { response in
                    
                    indicator.stop()
                    if let value = response.value {
                        SPAlertView.init(title: value.msg, preset: .done).present()
                        self.coordinator?.push()
                    } else {
                        
                        self.handelError(response.error)
                    }
                    
                }
                .store(in: &self.viewModel.service.cancellableSet)
            
        }
    }
    
    private func isReadyToUpdateProfile() -> Bool {
        if self.viewModel.fullName.count < 3 {
            
            self.fullNameTextField.setState(.fail, with: "", for: .editing)
            self.fullNameTextField.becomeFirstResponder()
            return false
            
        } else if self.viewModel.age < 10 {
            
            self.ageTextField.setState(.fail, with: "", for: .editing)
            self.ageTextField.becomeFirstResponder()
            return false
            
        } else if self.viewModel.gender == .none {
            
            self.genderView.view.setState(.fail, for: .disabled)
            self.genderView.view.becomeFirstResponder()
            return false
            
        } else if self.viewModel.selectedCategories.count == 0 {
            
            SPAlertView(message: "select Genre before contenu").present()
            return false
        }
        return true
    }
    
    @objc private func fullNameTFEditingChanged() {
        self.viewModel.fullName = fullNameTextField.text ?? ""
    }
    
    @objc private func ageTFEditingChanged() {
        self.viewModel.age = Int(ageTextField.text ?? "") ?? 0
    }
        
        
    // MARK: - Fetche Servecies
    /// Method That Fetches The Categories
    private func fetchCategories() {
        let indicator = ActivityIndicator()
        indicator.play()
        
        self.viewModel.categoriesFeatcher.request { response in
            indicator.stop()
            
            if let value = response.value {
                
                self.viewModel.categories = value.data
                
            } else {
                self.handelError(response.error)
            }
        }
        
    }
    
    /// Method That Fetches The user's Profile
    private func fetchProfile() {
        let indicator = ActivityIndicator()
        indicator.play()
        
        self.viewModel.profileFeatcher.request { response in
            indicator.stop()
            if let profile = response.value {
                self.updatePublishers(with: profile)
                
            } else {
                self.handelError(response.error)
            }
        }
    }
    
    /// update publishers with profile data when network request fineshes without errors
    private func updatePublishers(with profile: ProfileModel) {
        self.viewModel.profile = profile
        self.viewModel.fullName = profile.user.name ?? ""
        self.viewModel.age = profile.user.age ?? 0
        self.viewModel.gender = Gender(rawValue: profile.user.gender ?? "") ?? .none
        self.viewModel.selectedCategories = profile.user.categories ?? []
    }
    
}

// MARK: - GenderViewDelegate
extension EditUserProfileViewController: GenderViewDelegate {
    func genderDidChanged(_ gender: Gender) {
        self.viewModel.gender = gender
    }
}

// MARK: - AvatarViewDelegate
extension EditUserProfileViewController: AvatarViewDelegate {
    func imageDidChanged(_ image: UIImage) {
        self.viewModel.image = image
    }
}



struct NewUserView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: Context) -> UIViewController {
        return UINavigationController(rootViewController: EditUserProfileViewController())
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

struct NewUserView_Previews: PreviewProvider {
    static var previews: some View {
        NewUserView()
            .ignoresSafeArea()
    }
}
