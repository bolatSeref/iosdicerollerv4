import SwiftUI
import AVFoundation

struct ContentView: View {
    @State private var diceValue = 1
    @State private var rotationAngle: Double = 0
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            Image("dice_\(diceValue)")
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 160)
                .rotation3DEffect(
                    .degrees(rotationAngle),
                    axis: (x: 0, y: 1, z: 0)
                )

            Button(action: rollDice) {
                Text("Roll Dice")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .frame(width: 200, height: 50)
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }

            NavigationLink(destination: TwoDicesView()) {
                Text("Two Dice Mode")
                    .font(.headline)
                    .foregroundColor(.accentColor)
            }

            Spacer()
        }
        .navigationTitle("Dice Roller")
    }

    private func rollDice() {
        if let url = Bundle.main.url(forResource: "dice_sound", withExtension: "mp3") {
            audioPlayer = try? AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        }
        withAnimation(.easeInOut(duration: 1.0)) {
            rotationAngle += 360
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            diceValue = Int.random(in: 1...6)
        }
    }
}
