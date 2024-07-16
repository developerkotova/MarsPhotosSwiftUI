//
//  CalendarView.swift
//  MarsDiscovery
//
//  Created by Liza Kotova  on 13.07.2024.
//

import SwiftUI

struct CalendarView: View {
    @Binding var shouldShowCalendar: Bool
    @Binding var selectedDate: Date
    @State private var showAlert = false

    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.white)
                    .frame(height: 372)
                    .cornerRadius(50)
                    .padding(.horizontal, 20)
                    .overlay(
                        VStack {
                            HStack(alignment: .center) {
                                Button(action: {
                                    shouldShowCalendar = false
                                }) {
                                    Image("close")
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                }
                                Spacer()
                                Text("Date")
                                    .font(.custom("SF Pro Display Bold", size: 22))
                                    .foregroundColor(.black)
                                    .padding(.top, 1)
                                Spacer()
                                Button(action: {
                                    if selectedDate < Date() {
                                        shouldShowCalendar = false
                                    } else {
                                        showAlert = true
                                    }
                                }) {
                                    Image("tick")
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                }
                            }
                            .padding(.top, 22)
                            .padding(.horizontal, 42)
                            
                            DatePicker("", selection: $selectedDate, displayedComponents: [.date])
                                .datePickerStyle(.wheel)
                                .padding(.trailing, 40)
                                .padding(.top, 24)
                                .padding(.bottom, 20)
                                .preferredColorScheme(.light)
                            Spacer()
                        }
                    )
                Spacer()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Error"), message: Text("Please select another date."), dismissButton: .default(Text("OK")))
        }
    }
}

#Preview {
    CalendarView(shouldShowCalendar: .constant(true), selectedDate: .constant(Date()))
}
