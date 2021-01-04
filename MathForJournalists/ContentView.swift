//
//  ContentView.swift
//  MathForJournalists
//
//  Created by Girish Gupta on 17/12/2020.
//

import SwiftUI
import Foundation

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
                Currency().tabItem { Image(systemName: "dollarsign.circle"); Text("Currency").tag(1) }
                Inflation().tabItem {
                    Image(systemName: "cart");
                    Text("Inflation").tag(2) }
                //                Text("Tab Content 4").tabItem {
                //                    Image(systemName: "square.and.pencil");
                //                    Text("Surveys/Polls").tag(3) }
                About().tabItem {
                    Image(systemName: "info");
                    Text("About").tag(3) }
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
                Text("This iOS app was created by investigative/multimedia reporter, programmer and physics graduate Girish Gupta.").padding()
                Link(destination: URL(string: "https://www.girishgupta.com/")!) {
                    Image(systemName: "link")
                    //                    .font(.largeTitle)
                    Text("Girish Gupta")
                }.padding() // https://www.hackingwithswift.com/quick-start/swiftui/how-to-open-web-links-in-safari
                Text("Feel free to browse the code or commit to it yourself!").padding()
                Link(destination: URL(string: "https://www.github.com/jammastergirish/MathForJournalists")!) {
                    Image(systemName: "link")
                    //                    .font(.largeTitle)
                    Text("GitHub")
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
                    Text("Calculating percentage changes between two values is a fundamental means of explaining changes over time.\n\nThis could apply to anything from budgets to prices.\n\nDon't forget to check the sign!").padding()
                    
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
                        Text("[Subject] is up \(abs(self.calc), specifier: "%.0f") per cent in [time period].").italic().padding()
                    }
                }
            }.navigationBarTitle(Text("Percentage Change"))
            .gesture(TapGesture().onEnded{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}) // https://stackoverflow.com/a/59704606 https://developer.apple.com/documentation/swiftui/tapgesture (https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield)
        }
    }
}

struct Currency: View
{
    @State private var time: Bool = false
    
    @State private var old: Double = 5
    @State private var new: Double = 8
    
    var calc: Double { 100 * ((1/new) - (1/old)) / (1/old) } // https://stackoverflow.com/a/58140902
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                VStack
                {
                    Text("Journalists from the New York Times to Associated Press have made the mistake of using standard percentage changes when looking at exchange rate changes over time.\n\nYou want the percentage change in value with respect to another currency (likely the U.S. dollar).").padding()
                    
                    HStack(alignment: .center)
                    {
                        VStack
                        {
                            Text("Old Rate").padding()
                            Text("New Rate").padding()
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
                        Text("[Foreign currency] has weakened \(abs(self.calc), specifier: "%.0f") per cent against the [reference currency] in [time period].").italic().padding()
                    }
                    else
                    {
                        Text("[Foreign currency] has strengthened \(abs(self.calc), specifier: "%.0f") per cent against the [reference currency] in [time period].").italic().padding()
                    }
                }
                
                Link(destination: URL(string: "https://www.reuters.com/article/us-venezuela-economy-idUSKBN1FP2WK")!) {
                    Image(systemName: "link")
                    //                    .font(.largeTitle)
                    Text("Example")}.padding()
            }.navigationBarTitle(Text("Currency Change"))
            .gesture(TapGesture().onEnded{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}) // https://stackoverflow.com/a/59704606 https://developer.apple.com/documentation/swiftui/tapgesture (https://www.hackingwithswift.com/quick-start/swiftui/how-to-dismiss-the-keyboard-for-a-textfield)
        }
    }
}

struct Inflation: View
{
    @State private var monthly: Bool = false
    @State private var inflation: Double = 1.2
    
    var monthly_given_annual: Double { 100 * (pow((1 + (inflation / 100)), (1/12)) - 1) }
    var annual_given_monthly: Double { 100 * (pow((1 + (inflation / 100)), (12)) - 1) }
    
    @State private var factor: Double = 2
    
    var calc_factor_given_annual: Double { 12 * log(factor) / log((inflation / 100) + 1) }
    
    var calc_factor_given_monthly: Double { 12 * log(factor) / log((annual_given_monthly / 100) + 1) }
    
    var body: some View
    {
        NavigationView
        {
            VStack
            {
                VStack
                {
                    Text("Inflation is just the percentage change between a price index at two points in time. That's covered by the first tab.\n\nBut, given an inflation rate (either annual or monthly), you may want to know more about what that implies for prices.").padding()
                    
                    Toggle(isOn: $monthly)
                    {
                        Text("I've got monthly inflation data.")
                    }.padding() // https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-toggle-switch
                    
                    HStack(alignment: .center)
                    {
                        VStack
                        {
                            Text(monthly ? "Monthly inflation" : "Annual inflation").padding()
                        }
                        
                        VStack
                        {
                            TextField("", text: Binding<String>(
                                        get: { String(format: "%.1f", self.inflation) },
                                        set: {
                                            if let value = NumberFormatter().number(from: $0) {
                                                self.inflation = value.doubleValue
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
                        
                        if monthly{
                            Text("Annual inflation: ")
                            Text("\(self.annual_given_monthly, specifier: "%.1f")").font(.system(size: 60)) //https://www.hackingwithswift.com/quick-start/swiftui/formatting-interpolated-strings-in-swiftui
                        }
                        else
                        {
                            Text("Monthly inflation: ")
                            Text("\(self.monthly_given_annual, specifier: "%.1f")").font(.system(size: 60)) //https://www.hackingwithswift.com/quick-start/swiftui/formatting-interpolated-strings-in-swiftui
                        }
                        Text("%")
                    }.padding()
                    
                    HStack
                    {
                        Text("Time for prices to multiply by a factor of... ").padding(.trailing)
                        Text("2")
                        Slider(value: $factor, in: 2...10, step: 1) //https://www.simpleswiftguide.com/swiftui-slider-tutorial-how-to-create-and-use-slider-in-swiftui/
                        Text("10")
                    }.padding()
                    
                    if monthly
                    {
                        Text("It would take \(self.calc_factor_given_monthly, specifier: "%.0f") months for prices to increase \(self.factor, specifier: "%.0f")-fold.").italic().padding()
                    }
                    else
                    {
                        Text("It would take \(self.calc_factor_given_annual, specifier: "%.0f") months for prices to increase \(self.factor, specifier: "%.0f")-fold.").italic().padding()
                        //Let's copy this text to the clipboard using https://stackoverflow.com/a/63998380/7207315
                    }
                    Link(destination: URL(string: "https://journalism.girishgupta.com/sp.php?id=2013")!) {
                        Image(systemName: "link")
                        //                    .font(.largeTitle)
                        Text("More...")}.padding()
                }
            }.navigationBarTitle(Text("Inflation Rates"))
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
