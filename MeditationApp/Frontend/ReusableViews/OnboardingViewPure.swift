//
//  OnboardingViewPure.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 20/04/2021.
//

import SwiftUI

struct OnboardingViewPure: View {
    
    //MARK: Variable declerations
    // Related data variables
    var data: [OnboardingDataModel]
    var doneFunction: () -> ()
    @State var slideGesture: CGSize = CGSize.zero
    @State var curSlideIndex = 0
    
    // View variable declerations
    let backgroundColor : Color
    let width: CGFloat = UIScreen.main.bounds.width
    let height: CGFloat = UIScreen.main.bounds.height
    var distance: CGFloat = UIScreen.main.bounds.size.width
    
    //MARK: Body
    var body: some View {
        VStack{
            ZStack {
                backgroundColor.edgesIgnoringSafeArea(.all)
                ZStack(alignment: .center) {
                    ForEach(0..<data.count) { i in
                        OnboardingStepView(data: self.data[i]) // The content
                            .offset(x: CGFloat(i) * self.distance)
                            .offset(x: self.slideGesture.width - CGFloat(self.curSlideIndex) * self.distance)
                            .animation(.spring())
                            .gesture(DragGesture().onChanged{ value in
                                self.slideGesture = value.translation
                            }
                            .onEnded{ value in
                                if self.slideGesture.width < -50 {
                                    if self.curSlideIndex < self.data.count - 1 {
                                        withAnimation {
                                            self.curSlideIndex += 1
                                        }
                                    }
                                }
                                if self.slideGesture.width > 50 {
                                    if self.curSlideIndex > 0 {
                                        withAnimation {
                                            self.curSlideIndex -= 1
                                        }
                                    }
                                }
                                self.slideGesture = .zero
                            })
                    }
                }
            }
            VStack {
                self.progressView() // Dots showing progress
                    .frame(width: width * 0.25, height: height * 0.05, alignment: .center)
                    .padding(.bottom, height * 0.025)
                Spacer()
                Button(action: nextButton) { // End button
                    self.arrowView()
                }
                Spacer()
            }
            .padding(20)
        }
    }
    
    //MARK: View declerations
    func nextButton() {
        if self.curSlideIndex == self.data.count - 1 {
            doneFunction()
            return
        }
        if self.curSlideIndex < self.data.count - 1 {
            withAnimation {
                self.curSlideIndex += 1
            }
        }
    }
    
    func arrowView() -> some View {
        Group {
            if self.curSlideIndex == self.data.count - 1 {
                HStack {
                    Text("Done")
                        .font(.system(size: 27, weight: .medium, design: .rounded))
                        .foregroundColor(Color(.systemBackground))
                }
                .frame(width: 120, height: 50)
                .background(Color(.label))
                .cornerRadius(25)
            } else {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .foregroundColor(Color(.label))
                    .scaledToFit()
                    .frame(width: 120, height: 50)
            }
        }.padding(.bottom, height * 0.05)
    }
    
    func progressView() -> some View {
        HStack {
            ForEach(0..<data.count) { i in
                Circle()
                    .scaledToFit()
                    .frame(width: 10)
                    .foregroundColor(self.curSlideIndex >= i ? Color(red: 0.95, green: 0.32, blue: 0.34) : Color(.systemGray))
            }
        }
    }
}
