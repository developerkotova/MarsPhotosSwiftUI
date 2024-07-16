//
//  PhotoView.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 14.07.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct PhotoView: View {
    
    @State private var scale: CGFloat = 1.0
    @Environment(\.presentationMode) var presentationMode
    
    let imageStringUrl: String
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            ScrollView([.horizontal, .vertical], showsIndicators: false) {
                
                WebImage(url: URL(string: imageStringUrl))
                    .resizable()
                    .indicator(.activity)
                    .transition(.fade(duration: 0.5))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.main.bounds.width, height: 300)
                    .scaleEffect(scale)
                    .gesture(
                        MagnificationGesture()
                            .onChanged { value in
                                self.scale = value
                            }
                    )
                    .background(Color.clear)
            }
            .frame(
                width: UIScreen.main.bounds.width,
                height: UIScreen.main.bounds.height)
            .background(Color.black)
            
            VStack {
                HStack(alignment: .top) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("closeCircle")
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                    }
                    .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, -(UIScreen.main.bounds.height / 2) + 44)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PhotoView(imageStringUrl: "https://upload.wikimedia.org/wikipedia/ru/1/1a/The_sublime_moment_by_Dali.jpg")
    }
}


