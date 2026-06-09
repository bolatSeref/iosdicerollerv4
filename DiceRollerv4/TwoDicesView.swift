//
//  TwoDicesView.swift
//  DiceRollerApp
//
//  Created by Test on 09.06.26.
//

import SwiftUI
import AVFoundation

struct TwoDicesView: View {
    @State private var dice1 = 1
    @State private var dice2 = 1
    @State private var rotation1: Double = 0
    @State private var rotation2: Double = 0
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            HStack(spacing: 40) {
                Image("dice_\(dice1)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .rotation3DEffect(
                        .degrees(rotation1),
                        axis: (x: 0, y: 1, z: 0)
                    )

                Image("dice_\(dice2)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .rotation3DEffect(
                        .degrees(rotation2),
                        axis: (x: 0, y: 1, z: 0)
                    )
            }

            Text("Total: \(dice1 + dice2)")
                .font(.title)
                .fontWeight(.bold)

            Button(action: rollBothDice) {
                Text("Roll Both Dice")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 220, height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            Spacer()
        }
        .navigationTitle("Two Dice")
    }

    private func rollBothDice() {
        if let url = Bundle.main.url(forResource: "dice_sound", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        withAnimation(.easeInOut(duration: 1.0)) {
            rotation1 += 360
            rotation2 += 360
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            dice1 = Int.random(in: 1...6)
            dice2 = Int.random(in: 1...6)
        }
    }
}
