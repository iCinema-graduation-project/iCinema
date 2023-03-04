//
//  InterstsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import SwiftUI

struct InterstsView: View {
    @State var categories: [String] = ["Adventure", "Drama", "Sport", "Action", "Thriller", "Crime", "Comedy", "Animation", "Romance", "Fantasy", "Scinece Fiction", "Family", "Horror"]
    
    
    var body: some View {
        TagView(items: categories)
    }
}


struct TagView: View {
    let items: [String]
    var groupedItems: [[String]] = []
    let screenWidth = UIScreen.main.bounds.width
    
    init(items: [String]) {
        self.items = items
        groupedItems = createGroupedItems(items: items)
    }
    
    var body: some View {
        VStack {
            ForEach(groupedItems, id: \.self) { subitems in
                HStack {
                    ForEach(subitems, id: \.self) { subitem in
                        Text(subitem)
                            .font(.system(size: 18))
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(Color(uiColor: .iCinemaSecondBackgroudColor))
                            .cornerRadius(15)
                    }
                }
                
                
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaBackgroundColor))
    }
    
    
    private func createGroupedItems(items: [String]) -> [[String]] {
        var groupedItems: [[String]] = []
        var tempItems: [String] = []
        var width: CGFloat = 0
        
        for word in items {
            let label = UILabel()
            label.text = word
            label.font = .systemFont(ofSize: 18)
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 36
            
            if (width + labelWidth + 36) < screenWidth {
                width += labelWidth
                tempItems.append(word)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(word)
            }
            
        }
        if tempItems.count > 1 {
            groupedItems.append(tempItems)
        }
        groupedItems.append(tempItems)
        
        return groupedItems
    }
}

struct InterstsView_Previews: PreviewProvider {
    static var previews: some View {
        InterstsView()
        
    }
}
