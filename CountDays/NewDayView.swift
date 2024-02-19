//
//  NewDayView.swift
//  CountDays
//
//  Created by Hana Azizah on 20/02/24.
//

import SwiftUI

struct NewDayView: View {
    @Binding var newDayPresented: Bool
    @Binding var selectedDate: Date?
    @State private var dayFrom = Date()
    
    var body: some View {
        
        NavigationView {
            
            Form {
                DatePicker("Day From", selection: $dayFrom)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .padding(.vertical, 100)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        newDayPresented = false
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
                        selectedDate = dayFrom
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
