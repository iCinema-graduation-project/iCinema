//
//  HorizontalScrollableView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 05/05/2023.
//

import SwiftUI

struct ScrollableSectionView<Content: View, TrailingContent: View>: View {
    let title: String
    var axis: Axis.Set
    var hasDivider: Bool = true
    var scrollable: Bool = true
    var content: (() -> Content)
    var trailingContent: (()-> TrailingContent)
    
    init(title: String, hasDivider: Bool = true,
         axis: Axis.Set = .horizontal,
         scrollable: Bool = true,
         @ViewBuilder content: @escaping () -> Content,
         @ViewBuilder trailingContent: @escaping () -> TrailingContent = {VStack {}}) {
        self.title = title
        self.axis = axis
        self.hasDivider = hasDivider
        self.scrollable = scrollable
        self.content = content
        self.trailingContent = trailingContent
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            HStack {
                Text(title)
                    .foregroundColor(Color(uiColor: .iCinemaTextColor))
                    .font(Font(UIFont.title3))
                Spacer()
                trailingContent()
                
            }
            .padding(.horizontal, .cell.padding.left * 2)

            
            if scrollable {
                ScrollView(self.axis, showsIndicators: false) {
                    HStack {
                        content()
                    }
                    .padding(.horizontal, .cell.padding.left * 2)
                }
            } else {
                content()
            }
            
            if hasDivider {
                Divider()
                    .padding(.cell.padding.left * 2)
            }
        }
    }
}


