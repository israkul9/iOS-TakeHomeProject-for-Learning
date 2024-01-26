//
//  OnboardingView.swift
//  GithubFollowers
//
//  Created by Tusher on 1/26/24.
//

import SwiftUI

struct OnboardingView: View {
    var doneButtonAction: (() -> Void)?
    var body: some View {
        VStack {
            Text("Welcome to the Github Followers list!").padding(10)
            Button("Continue") {
              //  print("Done tapped")
                doneButtonAction?()
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
