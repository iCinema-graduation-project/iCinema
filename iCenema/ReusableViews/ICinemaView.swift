//
//  ICinemaView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 26/03/2023.
//

import SwiftUI

struct ICinemaView<Content: View>: View {
    @ViewBuilder var content: Content

    var body: some View {
        VStack {
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaBackgroundColor))
    }
}

struct ICinemaView_Previews: PreviewProvider {
    static var previews: some View {
        ICinemaView(content: {})
    }
}
