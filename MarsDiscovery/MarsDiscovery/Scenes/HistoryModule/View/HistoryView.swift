//
//  HistoryView.swift
//  MarsDiscovery
//
//  Created by  Liza Kotova on 12.07.2024.
//

import SwiftUI
import RealmSwift

import SwiftUI
import RealmSwift

struct HistoryView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedDate: Date
    @Binding var rover: Rovers
    @Binding var camera: Cameras?
    @State var selectedFilter: HistoryModel?
    @Binding var choosenFilter: HistoryModel?
    @State private var showActionSheet = false
    @ObservedResults(HistoryModel.self) var historyData
    private let realm = RealmManager.shared
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0) {
                HistoryHeaderView {
                    presentationMode.wrappedValue.dismiss()
                }
                .frame(height: 78)
                
                if historyData.isEmpty {
                    VStack {
                        Image("empty")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 145, height: 145)
                        Text("Browsing history is empty.")
                            .font(.custom("SF Pro Display Regular", size: 16))
                            .foregroundColor(Color("GreyText"))
                            .padding(.top, 20)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white)
                } else {
                    List {
                        ForEach(historyData) { filter in
                            HistoryFilterView(viewModel: filter)
                                .onTapGesture {
                                    selectedFilter = filter
                                    showActionSheet = true
                                }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .listRowInsets(EdgeInsets())
                    .padding(.top, 0)
                    .padding(.horizontal, -20)
                }
            }
        }
        .actionSheet(isPresented: $showActionSheet) {
            ActionSheet(
                title: Text("Menu Filter"),
                buttons: [
                    .default(Text("Use")) {
                        guard let selectedFilter = selectedFilter else { return }
                        choosenFilter = selectedFilter
                        presentationMode.wrappedValue.dismiss()
                    },
                    .destructive(Text("Delete")) {
                        guard let selectedFilter = selectedFilter else { return }
                        deleteFilter(selectedFilter)
                    },
                    .cancel()
                ]
            )
        }
    }
    
    private func useFilter(_ filter: HistoryModel) {
        selectedDate = filter.date
        rover = Rovers(rawValue: filter.rover) ?? .curiosity
        camera = Cameras(rawValue: filter.camera ?? "All")
        presentationMode.wrappedValue.dismiss()
    }
    
    private func deleteFilter(_ filter: HistoryModel) {
        realm.historyData.forEach { historyFilter in
            if filter.id == historyFilter.id {
                RealmManager.shared.delete(historyModel: historyFilter)
                return
            }
        }
    }
}

#Preview {
    HistoryView(
        selectedDate: .constant(Date()),
        rover: .constant(.curiosity),
        camera: .constant(nil),
        choosenFilter: .constant(nil))
}
