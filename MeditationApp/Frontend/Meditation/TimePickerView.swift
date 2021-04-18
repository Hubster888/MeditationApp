//
//  TimePickerView.swift
//  MeditationApp
//
//  Created by Hubert Rzeminski on 13/04/2021.
//

import SwiftUI

struct TimePickerView: View {
    
    @State var timeValueSeconds: CGFloat = 120.0
    @State var angleValue: CGFloat = 12.090501685614829
    let config = Config(minimumValue: 30.0,
                        maximumValue: 3600.0,
                        totalValue: 3600.0,
                        knobRadius: 15.0,
                        radius: 125.0)
    @EnvironmentObject var meditationViewModel : MeditationViewModel
    
    var body: some View {
        ZStack{
            Circle()
                .fill(Color(ColorConfig().getDefaultMainColor()).opacity(0.8))
                .frame(width: config.radius * 2, height: config.radius * 2)
                .scaleEffect(1.2)
                        
            Circle()
                .stroke(Color(ColorConfig().getMusicListColor()),
                        style: StrokeStyle(lineWidth: 3, lineCap: .butt, dash: [3, 23.18]))
                .frame(width: config.radius * 2, height: config.radius * 2)
                        
            Circle()
                .trim(from: 0.0, to: timeValueSeconds/config.totalValue)
                .stroke(Color(ColorConfig().getStartColor()), lineWidth: 4)
                .frame(width: config.radius * 2, height: config.radius * 2)
                .rotationEffect(.degrees(-90))
                        
            Circle()
                .fill(timeValueSeconds < config.maximumValue/2 ? Color(ColorConfig().getStartColor()) : Color(ColorConfig().getPauseColor()))
                .frame(width: config.knobRadius * 2, height: config.knobRadius * 2)
                .padding(10)
                .offset(y: -config.radius)
                .rotationEffect(Angle.degrees(Double(angleValue)))
                .gesture(DragGesture(minimumDistance: 0.0)
                            .onChanged({ value in
                                change(location: value.location)
                            }))
                        
            Text(Int(timeValueSeconds) > 3300 ? "unlimited" : "\(String.init(format: "%01d min", secondsToHoursMinutesSeconds(seconds: Int(timeValueSeconds)).1))")
                    .font(.system(size: 60))
                    .foregroundColor(Color(ColorConfig().getDefaultBackColor()))
        }
    }
    
    private func change(location: CGPoint) {
        // creating vector from location point
        let vector = CGVector(dx: location.x, dy: location.y)
            
        // geting angle in radian need to subtract the knob radius and padding
        let angle = atan2(vector.dy - (config.knobRadius + 10), vector.dx - (config.knobRadius + 10)) + .pi/2.0
            
        // convert angle range from (-pi to pi) to (0 to 2pi)
        let fixedAngle = angle < 0.0 ? angle + 2.0 * .pi : angle
        // convert angle value to temperature value
        let value = fixedAngle / (2.0 * .pi) * config.totalValue
            
        if value >= config.minimumValue && value <= config.maximumValue {
            timeValueSeconds = value
            meditationViewModel.timeSelected = Int(value)
            angleValue = fixedAngle * 180 / .pi // converting to degree
        }
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}

struct TimePickerView_Previews: PreviewProvider {
    static var previews: some View {
        TimePickerView()
    }
}

struct Config {
    let minimumValue: CGFloat
    let maximumValue: CGFloat
    let totalValue: CGFloat
    let knobRadius: CGFloat
    let radius: CGFloat
}
