//
//  Background.swift
//  iCinema
//
//  Created by Ahmed Yamany on 27/01/2023.
//

import SwiftUI
import UIKit

struct BackgroundView: View {
    @State var animate: Bool = false
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    var body: some View {
        ZStack {
            CircleBackground(color: Color("circle1"))
                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? -30 : -130, y: animate ? -30 : -100)
                .task {
                    withAnimation(.easeInOut(duration: 7).repeatForever()){
                        animate.toggle()
                    }
                }

            CircleBackground(color: Color("circle2"))

                .blur(radius: animate ? 30 : 100)
                .offset(x: animate ? 30 : 130, y: animate ? 30 : 100)

            if colorScheme == .dark {
                VisualEffect(style: .systemChromeMaterialDark)
                    .ignoresSafeArea()


            } else{
                VisualEffect(style: .regular)
                    .ignoresSafeArea()

            }

            VStack(spacing: 30.0) {}
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)

        }
        .background(LinearGradient(colors: [Color("backgroundColor1"), Color("backgroundColor2")], startPoint: .top, endPoint: .bottom))
        
    }
}

struct Background_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}

struct VisualEffect: UIViewRepresentable {
    @State var style : UIBlurEffect.Style // 1
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style)) // 2
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
    } // 3
}


 struct CircleBackground: View {
     @State var color: Color
     
     var body: some View {
         Circle()
             .frame(width: 300, height: 300)
             .foregroundColor(color)
     }
 }
