//
//  StarsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/05/2023.
//

import SwiftUI

struct StarsView: View {
  private static let COLOR = Color.iCinemaYellowColor

  @Binding var rating: Int

  var body: some View {
    HStack {
        ForEach(1..<6) { index in
            if rating > index {
                fullStar
                    .onTapGesture {
                        withAnimation {
                            rating = index + 1
                        }
                    }
            }else {
                emptyStar
                    .onTapGesture {
                        withAnimation {
                            rating = index + 1
                        }
                    }
            }
        }
     }
  }

  private var fullStar: some View {
    Image(systemName: "star.fill").foregroundColor(StarsView.COLOR)
  }

  private var halfFullStar: some View {
    Image(systemName: "star.lefthalf.fill").foregroundColor(StarsView.COLOR)
  }

  private var emptyStar: some View {
    Image(systemName: "star").foregroundColor(StarsView.COLOR)
  }
}
