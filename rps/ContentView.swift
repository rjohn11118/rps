import SwiftUI

struct ContentView: View {
    let choices = ["Rock", "Paper", "Scissors"]
    
    @State private var botChoice = ""
    @State private var playerChoice = ""
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var correct = 0
    @State private var rounds = 0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Rock, Paper, Scissors")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    Text("Choose your move")
                        .foregroundStyle(.secondary)
                        .font(.headline.weight(.bold))

                    ForEach(0..<3) { number in
                        Button {
                            choiceTapped(number)
                        } label: {
                            Text(choices[number])
                                .font(.title2.bold())
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(.white)
                                .foregroundColor(.black)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()
                
                Text("Score: \(correct)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Play Again", action: askQuestion)
        } message: {
            Text("Your choice: \(playerChoice)\nBot's choice: \(botChoice)\nScore: \(correct).")
        }
    }

    func choiceTapped(_ number: Int) {
        playerChoice = choices[number]
        botChoice = choices.randomElement() ?? "Rock"
        
        if playerChoice == botChoice {
            scoreTitle = "It's a draw!"
        } else if (playerChoice == "Rock" && botChoice == "Scissors") ||
                  (playerChoice == "Paper" && botChoice == "Rock") ||
                  (playerChoice == "Scissors" && botChoice == "Paper") {
            scoreTitle = "You Win!"
            correct += 1
        } else {
            scoreTitle = "You Lose!"
        }
        
        rounds += 1
        showingScore = true
    }

    func askQuestion() {
        botChoice = choices.randomElement() ?? "Rock"
    }
}

#Preview {
    ContentView()
}
