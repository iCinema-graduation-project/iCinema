//
//  BookingStepperView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 21/03/2023.
//

import SwiftUI
import UIKit

struct StepperView: View {
    let countOfSteps: Int
    let currentStep: Int

    var body: some View {
        HStack {
            ForEach(0..<countOfSteps, id: \.self) { index in
                Circle()
                    .frame(width: 15, height: 15)
                    .foregroundColor(self.getForgroundColor(at: index))
                    .overlay {
                        Circle()
                            .stroke(index == currentStep ? Color(uiColor: .iCinemaYellowColor) : .clear, lineWidth: 2)
                    }
                if index < countOfSteps - 1 {
                    Spacer()
                        .frame(height: 3)
                        .background(.gray)
                }
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color(uiColor: .iCinemaBackgroundColor))
    }
    
    
    private func getForgroundColor(at index: Int) -> Color {
        if index == currentStep {
            return Color.clear
        } else if index > currentStep {
            return Color.gray
        } else {
            return Color(uiColor: .iCinemaYellowColor)
        }
    }
}


extension ICinemaViewController {
    func addStepperView() {
        guard let coordinator = coordinator else { return }
        let steperView = StepperView(countOfSteps: coordinator.viewControllers.count - 1,
                                     currentStep: coordinator.currentIndex).hostigView()
        
        steperView.widthConstraints(Constants.screenBounds.width/2)
        navigationItem.addTitleView(view: steperView)
    }
}


