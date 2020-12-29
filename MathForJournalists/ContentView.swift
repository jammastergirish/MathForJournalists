//
//  ContentView.swift
//  MathForJournalists
//
//  Created by Girish Gupta on 17/12/2020.
//

import SwiftUI

struct ContentView: View
{
    @State private var SelectedTab = 0
    @State private var Title = "Percentages"
    
    var body: some View
    {
        ZStack
        {
            TabView(selection: $SelectedTab) // https://www.youtube.com/watch?v=jG5PFD5aLI4&t=6s
            {
                Percentages().tabItem { Image(systemName: "percent"); Text("Percentages").tag(0) }
                Text("Tab Content 2").tabItem { Image(systemName: "dollarsign.circle"); Text("Currency").tag(1) }
                Text("Tab Content 3").tabItem {
                    Image(systemName: "cart");
                    Text("Inflation").tag(2) }
                Text("Tab Content 4").tabItem {
                    Image(systemName: "square.and.pencil");
                    Text("Surveys/Polls").tag(3) }
                Text("About").tabItem {
                    Image(systemName: "info");
                    Text("About").tag(4) }
            }
//            .foregroundColor(.black)
            .accentColor(.orange)
        }
    }
}

struct Percentages: View
{
    @State private var time: Bool = false
    
    @State private var old: Double = 5
    @State private var new: Double = 8
    
    
    var calc: Double { 100 * (new - old) / old } // https://stackoverflow.com/a/58140902
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                VStack
                {
                    Text("Calculating percentage differences or changes between two values is a fundamental means of explaining complex figures.").padding()
                    
                    Toggle(isOn: $time)
                    {
                        Text("Firstly, is there a time-element here?")
                    }.padding() // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toggle-switch
                    
                    if (time)
                    {
                        Text("There's a time element so you're going to show that the old value has risen/fallen X%. ").padding()
                    }
                    else
                    {
                        Text("There's no time element so we're showing that one value is X% of another.").padding()
                    }
                    
                    HStack
                    {
                        VStack
                        {
                            Text(time ? "Old Value" : "First Value").padding()
                            Text(time ? "New Value" : "Second Value").padding()
                        }
                        
                        VStack
                        {
                            
                            TextField("", value: $old, formatter: NumberFormatter()) // https://www.simpleswiftguide.com/swiftui-textfield-complete-tutorial/ https://stackoverflow.com/a/59509242
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                                .padding()
                            
                            TextField("New Value", value: $new, formatter: NumberFormatter()) // https://www.simples)wiftguide.com/swiftui-textfield-complete-tutorial/
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                                .padding()
                        }
                    }
                }
                
                VStack
                {
                    Text("\(self.calc, specifier: "%.1f") %") //https://www.hackingwithswift.com/quick-start/swiftui/formatting-interpolated-strings-in-swiftui
                        .font(.system(size: 60))
                    
                }.navigationBarTitle(Text("Percentages"))
            }
        }
    }
}
    
struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            
            ContentView()
                .environment(\.colorScheme, .dark)
        }
    }
}
