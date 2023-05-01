//
//  CinemaProfileViewModel.swift
//  iCinema
//
//  Created by Ahmed Yamany on 28/03/2023.
//

import SwiftUI
import SPAlert

class CinemaProfileViewPresenter: ProfileViewDelegate {
    var dismissAction: (() -> Void) = { }
    
    @Published var bookNow: ((_ movieId: Int) -> Void) = { _ in }
    @Published var showMore: ((_ movieId: Int) -> Void) = { _ in }
    
    @Published var cinema: Cinema? = nil
    
    var cinemaFollowing = CinemaFollowing()
    
    let view: ICinemaViewController
    init(view: ICinemaViewController) {
        self.view = view
    }

    public func followButtonTapped() {
        guard let cinema = cinema else { return }
        
        cinemaFollowing.update(id: cinema.id)
        
        cinemaFollowing.request { response in
            if let value = response.value {
                SPAlert.showAlert(with: value.msg)
                
            } else {
                self.view.handelError(response.error)
            }
        }

    }
    
   
}
