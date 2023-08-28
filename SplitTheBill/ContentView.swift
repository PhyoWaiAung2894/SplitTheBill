//
//  ContentView.swift
//  SplitTheBill
//
//  Created by PhyoWai Aung on 6/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkBill = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercent = 10
    let tipPercentage = 0..<101
    
    var totalPerson : (splitBill : Double,orignalValue : Double){
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercent)
        let tipValue = checkBill / 100 * tipSelection
        let originalValue = tipValue + checkBill
        let splitBill = originalValue / peopleCount
        return (splitBill,originalValue)
    }
    
    let formatt : FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "USD")
    
    @FocusState private var amountToFocus : Bool
    
    var body: some View {
        
        
        NavigationView{
            Form{
                Section{
                    TextField("Amount",value:$checkBill,format: formatt)
                        .keyboardType(.decimalPad)
                        .focused($amountToFocus)
                
                    Picker("Number of people",selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                            }
                        }
                    }
                Section{
                    Picker("Tip Percentage",selection: $tipPercent){
                        ForEach(tipPercentage, id: \.self){
                            Text($0 , format: .percent)
                        }
                    }
                }header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(totalPerson.splitBill, format: formatt)
                } header: {
                    Text("Amount per person")
                        
                }
                
                Section{
                    if tipPercent == 0{
                        Text(totalPerson.orignalValue,format: formatt)
                            .foregroundColor(.red)
                    }else{
                        Text(totalPerson.orignalValue,format: formatt)
                    }
                }header: {
                    Text("Total Amount for the check")
                }
                
            }
            .navigationTitle("We Split Bill")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard)
                {
                    Spacer()
                    Button("Done"){
                        amountToFocus = false
                    }
                }
            }
            
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
