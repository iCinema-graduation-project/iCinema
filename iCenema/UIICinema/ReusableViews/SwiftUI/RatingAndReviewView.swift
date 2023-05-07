//
//  RatingAndReviewView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/05/2023.
//

import SwiftUI


struct RatingAndReviewView: View {
//    @Binding var rate: Int
//    @Binding var title: String
//    @Binding var review: String
    
    @ObservedObject var viewModel: RatingViewModel
    
    var body: some View {
        VStack {
            Text("Write a Review")
                .font(.custom.title3)
            
            StarsView(rating: $viewModel.rate)

            TextField("Title", text: $viewModel.title)
                .frame(height: 44)
                .padding(.horizontal, 8)
                .background(Color.iCinemaBackgroundColor)
                .cornerRadius(.iCinemaButton.cornerRadius)
                .padding(.vertical)
            
            TextField("Review (Optional)", text: $viewModel.review)
                .multilineTextAlignment(.leading)
                .padding(8)
                .frame(maxHeight: .infinity, alignment: .top)
                .background(Color.iCinemaBackgroundColor)
                .cornerRadius(.iCinemaButton.cornerRadius)
        }
        .padding()
        .foregroundColor(.iCinemaTextColor)
    }
}
