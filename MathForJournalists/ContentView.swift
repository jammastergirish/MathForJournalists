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
                About().tabItem {
                    Image(systemName: "info");
                    Text("About").tag(4) }
            }
//            .foregroundColor(.black)
            .accentColor(.orange)
        }
    }
}

struct About: View
{
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                Text("Math for Journalists was created by Girish Gupta, a former investigative and multimedia journalist working in Venezuela, the Americas and Middle East with everyone from Reuters to the New Yorker.\n\nGirish has a Master's in physics and two decades of full-stack programming experience.\n\nThis iOS app was created as a quick final project for Harvard's excellent CS50 computer science course.").padding()
                Link(destination: URL(string: "https://www.girishgupta.com/")!) {
                    Image(systemName: "link")
    //                    .font(.largeTitle)
                    Text("girishgupta.com")
                }.padding() // https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari
            }.navigationBarTitle(Text("About"))
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
                    Text("Calculating percentage changes between two values is a fundamental means of explaining changes in time.\n\nThis could apply to anything from budgets to prices.\n\nDon't forget to check the sign!").padding()
                    
//                    Toggle(isOn: $time)
//                    {
//                        Text("Firstly, is there a time-element here?")
//                    }.padding() // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toggle-switch
//
//                    if (time)
//                    {
//                        Text("There's a time element so you're going to show that the old value has risen/fallen X%. ").padding()
//                    }
//                    else
//                    {
//                        Text("There's no time element so we're showing that one value is X% of another.").padding()
//                    }
                    
                    HStack(alignment: .center)
                    {
                        VStack
                        {
                            Text("Old Value").padding()
                            Text("New Value").padding()
                        }
                        
                        VStack
                        {
//                            TextField("", value: $old, formatter: NumberFormatter()) // https://www.simpleswiftguide.com/swiftui-textfield-complete-tutorial/ https://stackoverflow.com/a/59509242
                            TextField("", text: Binding<String>(
                                get: { String(format: "%.1f", self.old) },
                                set: {
                                    if let value = NumberFormatter().number(from: $0) {
                                        self.old = value.doubleValue
                                    }})) // https://stackoverflow.com/a/61270145
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                                .padding()
                            
                            TextField("", text: Binding<String>(
                                get: { String(format: "%.1f", self.new) },
                                set: {
                                    if let value = NumberFormatter().number(from: $0) {
                                        self.new = value.doubleValue
                                    }})) // https://stackoverflow.com/a/61270145
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .keyboardType(.decimalPad) // https://programmingwithswift.com/numbers-only-textfield-with-swiftui/
                                .padding()
                        }
                    }
                }
                
                VStack
                {
                    HStack(alignment: .center)
                    {
                        Text("\(self.calc, specifier: "%.0f")") //https://www.hackingwithswift.com/quick-start/swiftui/formatting-interpolated-strings-in-swiftui
                            .font(.system(size: 60))
                        Text("%")
                    }.padding()
                    
                    if (self.calc<0)
                    {
                        Text("[Subject] is down \(abs(self.calc), specifier: "%.0f") per cent in [time period].").padding()
                    }
                    else
                    {
                        Text("[Subject] is up \(abs(self.calc), specifier: "%.0f") per cent in [time period].").padding()
                    }
                }
            }.navigationBarTitle(Text("Percentage Change"))
            .gesture(TapGesture().onEnded{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}) // https://stackoverflow.com/a/59704606 https://developer.apple.com/documentation/swiftui/tapgesture (https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield)
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
