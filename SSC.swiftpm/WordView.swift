//
//  WordView.swift
//  SSC
//
//  Created by Irfan on 17/02/25.
//
import SwiftUI

struct WordView: View {
    @State private var width: CGFloat = 0
    @State private var percent: Int = 0
    @State private var currentWord: Int = 0
    @State private var showMeaningCard: Bool = false
    @State private var isSheetPresented: Bool = false
    @State private var dragStartLocation: CGFloat = 0
    @State private var cardScale: CGFloat = 0.5
    @State private var cardOffset: CGFloat = 100

    let wordEntries: [WordEntry] = loadPredefinedData()
    
    var body: some View {
        ZStack {
            Color("Col1").ignoresSafeArea()
            
            VStack {
                // Progress Bar
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: 800, height: 20)
                        .foregroundColor(.black.opacity(0.2))
                    
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .frame(width: width, height: 20)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.green.opacity(0.7)]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        )
                        .foregroundColor(.clear)
                        .animation(.easeInOut(duration: 0.5), value: width)
                }
                .padding(.top, 150)
                
                // Word Display
                VStack {
                    if !wordEntries.isEmpty {
                        Text(wordEntries[currentWord].word)
                            .font(.system(size: 130, design: .serif))
                            .padding(20)
                        
                        if showMeaningCard {
                            VStack(spacing: 10) {
                                Text("Meaning")
                                    .font(.system(size: 30, weight: .bold))
                                Text(wordEntries[currentWord].definition)
                                    .font(.system(size: 40, weight: .semibold))
                                    .multilineTextAlignment(.center)
                                    .padding([.horizontal], 30)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(20)
                            .shadow(radius: 10)
                            .scaleEffect(cardScale)
                            .offset(y: cardOffset)
                            .animation(.spring(response: 0.5, dampingFraction: 0.4), value: cardScale)
                            .animation(.easeOut(duration: 0.5), value: cardOffset)
                        }
                    } else {
                        Text("No words available")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 300)
                
                Spacer()
                
                // Drag Gesture Area
                Rectangle()
                    .fill(Color("Col1"))
                    .frame(height: 50)
                    .gesture(
                        DragGesture(minimumDistance: 20)
                            .onChanged { gesture in
                                dragStartLocation = gesture.startLocation.x
                            }
                            .onEnded { gesture in
                                if dragStartLocation < 100 && gesture.translation.height < -50 {
                                    isSheetPresented = true
                                }
                            }
                    )
                    .ignoresSafeArea(edges: .bottom)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            currentWord = (currentWord + 1) % wordEntries.count
            percent = (currentWord * 100) / wordEntries.count
            width = CGFloat(currentWord) * 800 / CGFloat(wordEntries.count)
            
            showMeaningCard = false
            cardScale = 0.5
            cardOffset = 100
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                showMeaningCard = true
                withAnimation {
                    cardOffset = 0
                }
                withAnimation(.spring(response: 0.5, dampingFraction: 0.4)) {
                    cardScale = 1.0
                }
            }
        }
       // .sheet(isPresented: $isSheetPresented) {
        //    ContentView() // Content for the sheet
        //}
    }

}

#Preview {
    WordView()
}
