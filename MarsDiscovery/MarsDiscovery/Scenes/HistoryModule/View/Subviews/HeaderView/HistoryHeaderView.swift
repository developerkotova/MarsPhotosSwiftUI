//
//  HistoryHeaderView.swift
//  Test
//
//  Created by Liza Kotova on 12.07.2024.
//

import SwiftUI

struct HistoryHeaderView: View {
    var backAction: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            Color("MainOrange")
            
            HStack {
                Button(action: {
                    backAction()
                }) {
                    Image("left")
                        .scaledToFit()
                        .frame(width: 44, height: 44)
                }
                .padding(.leading, 20)
                Spacer()
                Text("History")
                    .font(.custom("SF Pro Display Bold", size: 34))
                    .foregroundColor(.black)
                    .padding(.trailing, 64)
                Spacer()
            }
            .padding(.top, 56)
        }
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    HistoryHeaderView {
    }
}

