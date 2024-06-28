import SwiftUI
struct LoadingJournalView: View {
    @State private var progress: Double = 0.0
    @State private var timer: Timer? = nil
    @State private var currentQuoteIndex: Int = 0
    @State private var typingAnimationProgress: CGFloat = 0.0
    @State private var typingTimer: Timer? = nil
    @State private var isDelay: Bool = false
    @State private var shouldNavigate = false
    
    let motivationalQuotes = [
        "Each time you write your journal, you embark on an epic journey within yourself, a vital quest for mental well-being.",
        "It's an inner adventure where every word guides you closer to understanding and healing, crucial for maintaining mental health."
    ]
    
    var body: some View {
        ZStack{
            Color(.systemBackground)
                .ignoresSafeArea()
                .frame(height: .infinity)
            VStack(alignment: .center, spacing: 10) {
                
                Spacer()
                LottieView(name: "loading screen").frame(width: 400, height: 400)
                VStack{
                    Text("Loading...")
                        .font(.callout)
                        .fontWeight(.light)
                }.padding()
                    
                
                Divider()
                
                VStack() {
                    Text("")
                        .font(
                            Font.custom("SF Pro", size: 16)
                                .weight(.medium)
                        )
                        .padding(.horizontal)
                    
                        .typingText(percentage: typingAnimationProgress, text: motivationalQuotes[currentQuoteIndex])
                }.padding(25)
                
                Spacer()
            }.padding()
                .onAppear {
                    startLoading()
                    startTypingAnimation()
                }
                .onDisappear {
                    stopLoading()
                    stopTypingAnimation()
                }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $shouldNavigate, destination: {
            ContentView()
        })
        
    }
    func startLoading() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            if progress < 1.0 {
                progress += 0.04
            } else {
                timer?.invalidate()
                timer = nil
            }
        }
    }
    
    func stopLoading() {
        timer?.invalidate()
        timer = nil
    }
    
    func startTypingAnimation() {
        typingTimer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { _ in
            if isDelay {
                return
            }
            if typingAnimationProgress < 1.0 {
                typingAnimationProgress += 0.02
            } else {
                isDelay = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    typingAnimationProgress = 0.0
                    currentQuoteIndex = (currentQuoteIndex + 1) % motivationalQuotes.count
                    isDelay = false
                    shouldNavigate = true
                }
            }
        
        
    }

}
func stopTypingAnimation() {
        typingTimer?.invalidate()
        typingTimer = nil
    }
    
    struct LoadingView_Previews: PreviewProvider {
        static var previews: some View {
            LoadingView()
        }
    }
}


#Preview {
    LoadingJournalView()
}

