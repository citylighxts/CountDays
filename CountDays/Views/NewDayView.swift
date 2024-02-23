//
//  NewDayView.swift
//  CountDays
//
//  Created by Hana Azizah on 20/02/24.
//

import SwiftUI

struct NewDayView: View {
    @Binding var newDayPresented: Bool
    @Binding var selectedDate: Date
    @State private var currentDate = Date()
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Day From", selection: $currentDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        newDayPresented = false
                        selectedDate = Date()
                    } label: {
                        HStack {
                            Text("Back")
                                .font(.system(size: 20))
                                .foregroundStyle(Color.black)
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        newDayPresented = false
                        selectedDate = currentDate
//                        print(selectedDate)
                    } label: {
                        Text("Save")
                            .font(.system(size: 20))
                            .foregroundStyle(Color.black)
                    }
                }
                
            }
        }
    }
}


#Preview {
    NewDayView(newDayPresented: Binding(get:{return true},
                                            set: {_ in
    }), selectedDate: Binding(get:{return Date()},
                              set: {_ in
    }))
}
