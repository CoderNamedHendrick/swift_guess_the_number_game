//
//  AppScaffold.swift
//  Guess the number game
//
//  Created by Sebastine Odeh on 02/02/2023.
//

import SwiftUI

struct AppScaffold : View {
    
    var body: some View {
        VStackLayout {
            HStack {
                Spacer()
                
                Text("iOS Guess the number Game")
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding(EdgeInsets(top: CGFloat(12), leading: CGFloat(12), bottom: CGFloat(12), trailing: CGFloat(12)))
                Spacer()
            }
            .frame(width: .infinity, alignment: .center)
            
            Spacer()
            
            ScaffoldBody()
            Spacer()
            
        }
    }
}

struct AppScaffold_Previews: PreviewProvider {
    static var previews: some View {
        AppScaffold()
    }
}
