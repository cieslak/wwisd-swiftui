//
//  ContentView.swift
//  Shared
//
//  Created by Chris Cieslak on 9/12/21.
//

import SwiftUI

struct ContentView: View {
    @State private var foundIt = false
    var body: some View {
        ZStack {
            MapView(foundIt: $foundIt)
                .edgesIgnoringSafeArea(.all)
            if foundIt {
                FoundItView(foundIt: $foundIt)
            }
        }
    }
}

struct FoundItView: View {
    @Binding var foundIt: Bool
    @State private var opacity = 1.0
    var body: some View {
        VStack {
            Text("YOU GOT IT")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .background(Color.red)
                .opacity(opacity)
                .onAppear {
                    withAnimation {
                        opacity = 0.0
                    }
                }
                .animation(
                    .easeInOut(duration: 1.0)
                        .repeatForever(autoreverses: true)
                )
            Button("Try Again") {
                foundIt = false
            }
#if os(iOS)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
#endif
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
