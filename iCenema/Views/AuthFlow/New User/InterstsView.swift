//
//  InterstsView.swift
//  iCinema
//
//  Created by Ahmed Yamany on 04/03/2023.
//

import SwiftUI

struct InterstsView: View {
    @ObservedObject var viewModel: EditUserProfileViewModel
        
    @State var title: String = ""
    var body: some View {
        VStack {
            Text(title)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TagView(viewModel: viewModel, title: $title)
                .cornerRadius(.view.cornerRadius)
        }
    }
    
}


struct TagView: View {
    @ObservedObject var viewModel: EditUserProfileViewModel
        
    @State private var groupedItems: [[Category]] = []
    @Binding var title: String
    
    var body: some View {
        
        VStack{
            ForEach(groupedItems, id: \.self) { categories in
                HStack {
                    ForEach(categories, id: \.self) { category in
                        
                        Text(category.name)
                            .font(.system(size: 18))
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(self.getBackgroundColor(for: category))
                            .foregroundColor(self.getForgroundColor(for: category))
                            .cornerRadius(15)
                            .onTapGesture {
                                self.onTapGesure(for: category)
                            }
                    }
                }
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(uiColor: .iCinemaSecondBackgroudColor))
        .onAppear {
            self.viewModel.categoriesFeatcher.getCategories { result in
                switch result {
                case .success(let categories):
                    let data = categories.data.first!
                    self.title = data.title
                    self.groupedItems = self.createGroupedItems(categories: data.children)

                case .failure(_):
                    print("")
                }
            }
        }
    }
    
    // MARK: - Update Modifiders
    private func getBackgroundColor(for category: Category) -> Color {
        
        if self.viewModel.selectedCategories.contains(category) {
            return Color(uiColor: .iCinemaYellowColor)
        }
        
        return Color(uiColor: .iCinemaBackgroundColor)
    }
    
    private func getForgroundColor(for category: Category) -> Color {
        
        if self.viewModel.selectedCategories.contains(category) {
            return Color(uiColor: .iCinemaTextColorReverce)
        }
        
        return Color(uiColor: .iCinemaTextColor)
    }
    
    // MARK: - Actions
    private func onTapGesure(for category: Category) {
        if self.viewModel.selectedCategories.contains(category) {
            if let index = self.viewModel.selectedCategories.firstIndex(of: category) {
                self.viewModel.selectedCategories.remove(at: index)
            }
        } else {
            self.viewModel.selectedCategories.append(category)
        }
    }
    
    // MARK: - Helper
    private func createGroupedItems(categories: [Category]) -> [[Category]] {
        var groupedItems: [[Category]] = []
        var tempItems: [Category] = []
        var width: CGFloat = 0
        
        for category in categories {
            let word = category.name
            let label = UILabel()
            label.text = word
            label.font = .systemFont(ofSize: 24)
            label.sizeToFit()
            
            let labelWidth = label.frame.size.width + 40
            
            if (width + labelWidth + 36) < Constants.screenBounds.width {
                width += labelWidth
                tempItems.append(category)
            } else {
                width = labelWidth
                groupedItems.append(tempItems)
                tempItems.removeAll()
                tempItems.append(category)
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
        InterstsView(viewModel: EditUserProfileViewModel())        
    }
}
