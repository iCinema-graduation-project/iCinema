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

//struct BookingStepperView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookingStepperView(currentStep: 2)
//            .preferredColorScheme(.dark)
//    }
//}


