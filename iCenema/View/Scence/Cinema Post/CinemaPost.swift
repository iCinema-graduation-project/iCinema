//
//  File.swift
//  iCinema
//
//  Created by Ahmed Yamany on 08/03/2023.
//

import SwiftUI



struct PostHeader: View {
    var body: some View {
        HStack{
            HStack{
                Image("cinema")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .mask(Circle())
                    .overlay {
                        Circle()
                            .stroke(LinearGradient(colors: [.red, .purple, .red, .orange, .yellow, .orange], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 1)
                            .frame(width: 35, height: 35)
                    }
                Text("Cat Catty")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            Spacer()
            Button {
                
            } label: {
                Image("more")
                
            }
        }
        .padding(10)
    }
}


struct PostContent: View {
    var body: some View {
        Image("SliderImage3")
            .resizable()
            .frame(width: .infinity)
            .aspectRatio(contentMode: .fit)
        
        HStack{
            Image("heart")
            Image("comment")
            Image("share")
            Spacer()
            Image("bookmark")
        }
        .padding(.vertical, 9)
        .padding(.horizontal, 12)
        
    }
}

struct CinemaPost: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0.0) {
            PostHeader()
            PostContent()
            
            Text("Liked by Meng To and others")
                .font(.footnote)
                .frame(width: .infinity)
                .padding(.horizontal, 12)
            Text("I miss traveling to Japan")
                .font(.footnote)
                .frame(width: .infinity)
                .padding(.horizontal, 12)
            HStack {
                HStack {
                    Image("cinema")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .mask(Circle())
                    Text("Add comment...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                HStack {
                    Text("😍")
                    Text("🤣")
                    Image(systemName: "plus.circle")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CinemaPost()
    }
}
