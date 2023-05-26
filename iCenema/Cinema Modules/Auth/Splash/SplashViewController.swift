//
//  SplashViewController.swift
//  FoodRecipe_UIKit
//
//  Created by Ahmed Yamany on 20/05/2023.
//

import UIKit
import Coordinator

class SplashViewController: ICinemaViewController {
    // MARK: - Views
    //
    @IBOutlet weak private var startButton: UIButton!
    @IBOutlet weak private var getCookiesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: - Life Cycle
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .iCinemaBackgroundColor
        self.updateStartButton()
        self.updateTitleLabels()
        self.updateGetCookiesLabels()
        self.updateDescriptionLabels()
    }

    // MARK: - Update UI
    //
    private func updateStartButton() {
//        startButton.applyButtonStyle(.primary)
        startButton.setTitle(L10n.App.Splash.button, for: .normal)

    }

    private func updateTitleLabels() {
        titleLabel.textColor = .iCinemaTextColor
        titleLabel.text = L10n.App.Splash.title
        titleLabel.font = .title2
    }

    private func updateGetCookiesLabels() {
        getCookiesLabel.textColor = .iCinemaTextColor
        getCookiesLabel.text = L10n.App.Splash.getCookies
        getCookiesLabel.font = .custom(size: 50)
    }

    private func updateDescriptionLabels() {
        descriptionLabel.textColor = .iCinemaTextColor
        descriptionLabel.text = L10n.App.Splash.description
        descriptionLabel.font = .footnote
    }

    // MARK: - Actions
    //
    @IBAction private func startButtonDidTapped(_ sender: UIButton) {
        self.coordinator?.push()
    }
}
