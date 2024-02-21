//
//  DayView.swift
//  CountDays
//
//  Created by Hana Azizah on 20/02/24.
//

import SwiftUI

struct DayView: View {
    @State private var showingNewDayView: Bool = false
    @StateObject var viewModel = DayViewModel()
    
    var body: some View {
        
        NavigationView {
            VStack {
                Image(systemName: "calendar")
                    .resizable()
                    .frame(width: 80, height: 70)
                    .foregroundStyle(.tint)
                    .tint(.red)
                    .padding(.bottom)
                
                Text("\(viewModel.months) months \(viewModel.days) days from \(viewModel.formattedDate)")
                    .font(.system(size: 25))
                    .bold()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewDayView = true
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(.tint)
                            .tint(.brown)
                    }
                }
            }
            .sheet(isPresented: $showingNewDayView) {
                NewDayView(newDayPresented: $showingNewDayView, selectedDate: viewModel.selectedDateBinding)
            }

        }
        
    }
}

#Preview {
    DayView()
}
