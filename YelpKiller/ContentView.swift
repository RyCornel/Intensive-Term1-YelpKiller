//
//  ContentView.swift
//  YelpKiller
//
//  Created by Ryan Cornel on 10/17/20.
//

import SwiftUI

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    
    var body: some View {
        ZStack {
            TitleView()
                .blur(radius: show ? 20 : 0)
                .opacity(showCard ? 0.4 : 1)
                .offset(y:showCard ? -20 : 0)
                .animation(
                    Animation
                        .default
                        .delay(0.1)
//                        .speed(2)
//                        .repeatCount(3, autoreverses: false)
                )
            
            BackCardView()
                .frame(width: showCard ? 300 : 340, height: 220, alignment: .center)
                
                .background(show ? Color("card1") : Color("card4"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -400 : -40)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -180 : 0)
                .scaleEffect(showCard ? 1 : 0.9)
                .rotationEffect(.degrees(show ? 0 : 10))
                .rotationEffect(Angle(degrees: showCard ? -10 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 10), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeInOut(duration: 0.5))

            
            BackCardView()
                .frame(width: 340, height: 220, alignment: .center)
                
                .background(show ? Color("accent") : Color("card3"))
                .cornerRadius(20)
                .shadow(radius: 20)
                .offset(x: 0, y: show ? -200 : -20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -140 : 0)
                .scaleEffect(showCard ? 1 : 0.95)
                .rotationEffect(.degrees(show ? 0 : 5))
                .rotationEffect(Angle(degrees: showCard ? -5 : 0))
                .rotation3DEffect(Angle(degrees: showCard ? 0 : 5), axis: (x: 10.0, y: 0, z: 0))
                .blendMode(.hardLight)
                .animation(.easeIn(duration: 0.3))
            
            
            CardView()
                .frame(width: showCard ? 375 : 340.0, height: 220.0)
                .background(Color.black)
//                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: showCard ? 30 : 20, style: .continuous))
                .shadow(radius: 20)
                .offset(x: viewState.width, y: viewState.height)
                .offset(y: showCard ? -100 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                    self.showCard.toggle()
                        
                })
                .gesture(
                    DragGesture().onChanged {
                        value in
                        self.viewState =  value.translation
                        self.show = true
                    }
                    .onEnded {
                        value in
                        self.viewState = .zero
                        self.show = false
                    }
                )
            Text("\(bottomState.height)").offset(y: -300)
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 420 : 1000)
                .offset(y: bottomState.height)
                .blur(radius: show ? 200 : 0)
                .animation(.timingCurve(0.2, 0.8, 0.2, 0.2, duration: 0.45))
                .gesture(DragGesture().onChanged {
                    value in
                    self.bottomState = value.translation
                    if self.showFull {
                        self.bottomState.height += -330
                    }
                    if self.bottomState.height < -330 {
                        self.bottomState.height = -330
                    }
                }
                .onEnded {
                    value in
                    if self.bottomState.height > 185 {
                        self.showCard = false
                    }
                    if (self.bottomState.height < -185 && !self.showFull) || (self.bottomState.height < -250 && self.showFull) {
                        self.bottomState.height = -330
                        self.showFull = true
                    } else {
                        self.bottomState = .zero
                        self.showFull = false
                    }
                    
                }
                )

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("UI Design!")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("certificate")
                        .foregroundColor(Color("accent"))
                }
                Spacer()
                Image("Logo1")
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            Spacer()
            Image("Card1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 300, height: 110, alignment: .top)
        }
        
    }
}

struct BackCardView: View {
    var body: some View {
        VStack {
            Spacer()
        }
        
    }
}

struct TitleView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Certificates")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color("card1"))
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5, alignment: .center)
                .cornerRadius(3)
                .opacity(0.1)
            Text("This certificate is proof that Ryan Cornel has achieved the UI Design course with approval from Design+Code instructor.")
                .multilineTextAlignment(.center)
                .font(.subheadline)
                .lineSpacing(4)
            Spacer()
        }
        .padding(.top, 8)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: 20)
        
    }
}
