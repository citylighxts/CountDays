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
                    .tint(.accentColor)
                    .padding(.bottom)
                
                Text("**\(viewModel.years)** *years* **\(viewModel.months)** *months* **\(viewModel.days)** *days*")
                    .font(.system(size: 25))
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text("from: \(viewModel.formattedDate)")
                    .font(.system(size: 25))
                    .bold()
                    .multilineTextAlignment(.center)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingNewDayView = true
                    }) {
                        Image(systemName: "pencil")
                            .resizable()
                            .frame(width: 25, height: 25)
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
