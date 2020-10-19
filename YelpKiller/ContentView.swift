//
//  ContentView.swift
//  YelpKiller
//
//  Created by Ryan Cornel on 10/17/20.
//

import SwiftUI
//import Foundation
//import Combine
//import CoreLocation
//
//class LocationViewModel: NSObject, ObservableObject{
//
//  @Published var userLatitude: Double = 0
//  @Published var userLongitude: Double = 0
//
//  private let locationManager = CLLocationManager()
//
//  override init() {
//    super.init()
//    self.locationManager.delegate = self
//    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    self.locationManager.requestWhenInUseAuthorization()
//    self.locationManager.startUpdatingLocation()
//  }
//}
//
//struct LocationView: View {
//
//  @ObservedObject var locationViewModel = LocationViewModel()
//
//  var body: some View {
//    VStack {
//      Text("Your location is:")
//      HStack {
//        Text("Latitude: \(locationViewModel.userLatitude)")
//        Text("Longitude: \(locationViewModel.userLongitude)")
//      }
//    }
//  }
//}
//
//extension LocationViewModel: CLLocationManagerDelegate {
//
//  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    guard let location = locations.last else { return }
//    userLatitude = location.coordinate.latitude
//    userLongitude = location.coordinate.longitude
//    print(location)
//  }
//}

struct ContentView: View {
    @State var show = false
    @State var viewState = CGSize.zero
    @State var showCard = false
    @State var swipeCard = false
    @State var bottomState = CGSize.zero
    @State var showFull = false
    @State var userReview = String.self
    
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
                .offset(x: swipeCard ? -500 : 0)
                .offset(x: swipeCard ? 500 : 0)
                .blendMode(.hardLight)
                .animation(.spring(response: 0.3, dampingFraction: 0.6, blendDuration: 0))
                .onTapGesture(count: 1, perform: {
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
//                        if self.viewState.width > -240 {
//                            self.swipeCard = 500
//                        }
                        self.show = false
                    }
                )
            
//            Text("\(bottomState.height)").offset(y: -300)
//            Text("\(viewState.width)").offset(y: -280)
            
            BottomCardView()
                .offset(x: 0, y: showCard ? 400 : 1000)
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
                    
                })
//            Text(/*@START_MENU_TOKEN@*/"Placeholder"/*@END_MENU_TOKEN@*/)

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
                    Text("Cafe Duo")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    Text("❤️❤️❤️")
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
                Text("Cafe Duo")
                    .font(/*@START_MENU_TOKEN@*/.largeTitle/*@END_MENU_TOKEN@*/)
                    .fontWeight(.bold)
                    .foregroundColor(Color("card1"))
                Spacer()
            }
            .padding()
            Image("Background1")
            Spacer()
        }
        TextEditor(text: .constant("Reviews...")).offset(x: 145, y: 550)
    }
}

struct BottomCardView: View {
    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .frame(width: 40, height: 5, alignment: .center)
                .cornerRadius(3)
                .opacity(0.1)
            Text("Coffe & Tea. Specializing in Matcha Tea. Vegan options and gluten-free options available.")
                .fontWeight(.black)
                .multilineTextAlignment(.center)
                .font(.footnote)
                .lineSpacing(4)
            TextField("Enter Review Here", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding([.top, .leading, .bottom])
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
        
        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
            Text("submit")
        }
        .accentColor(.black)
        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        .offset(y: -230)
        .font(.footnote)
    }
}
