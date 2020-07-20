//
//  ContentView.swift
//  DogCare
//
//  Created by user167535 on 6/15/20.
//  Copyright © 2020 user167535. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Profile")
                .tabItem{
                    Image()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
