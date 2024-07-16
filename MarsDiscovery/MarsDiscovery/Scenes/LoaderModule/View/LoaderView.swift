//
//  LoaderUIViewController.swift
//  Test
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI

struct LoaderView: View {
    
    var changeRootView: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color("MainOrange"))
                    .frame(width: 123, height: 123)
                    .cornerRadius(30)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.black, lineWidth: 1)
                    )
                    .shadow(color: Color.black.opacity(0.5), radius: 30, x: 5, y: 5)
                    .padding(.top, 250)
                Spacer()
                LoaderAnimationView(filename: "LoaderTest")
                    .frame(width: 300, height: 200)
                    .padding(.top, 100)

            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                changeRootView()
            }
        }
    }
}

#Preview {
    LoaderView(changeRootView: {})
}
