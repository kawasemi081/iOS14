//
//  ContentView.swift
//  MyDemo
//
//  Created by MIsono on 2020/06/23.
//
//import AVKit
//import MapKit

//import StoreKit
import SpriteKit
import SwiftUI
//class Customer: ObservableObject {
//    var name: String = "Taylor"
//    var isAninoyed = false
//}
//struct SampleRow: View {
//    let id: Int
//    var body: some View {  Text("Row \(id)") }
//    init(id: Int) {
//        self.id = id
//        print("Loading row \(id)")
//    }
//}

class GameScene: SKScene {
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let box = SKSpriteNode(color: .systemRed, size: CGSize(width: 50, height: 50))
        box.position = location
        box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        addChild(box)
    }
}

struct ContentView: View {
    @State private var showApp = false
    
//    @StateObject var customer = Customer()
    
//    @ScaledMetric(relativeTo: .title) var imageSize: CGFloat = 100
//    @AppStorage("emailaddress") var emailAddress = "https://github.com/midori2012"
    
//    @State private var emailAddress = "https://github.com/midori2012"
//    @State private var color = Color.white
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    @State private var downloadAmount = 0.0
//    @State private var text = "Hello, world!"
    var scene: SKScene {
        let scene = GameScene()
        scene.size = CGSize(width: 300, height: 400)
        scene.scaleMode = .fill
        return scene
    }
    var body: some View {
        SpriteView(scene: scene)
            .frame(width: 300, height: 400)
        
//        Button("Show other app"){
//            self.showApp.toggle()
//        }.appStoreOverlay(isPresented: $showApp) {
//            SKOverlay.AppConfiguration(appIdentifier: "id1440611372", position: .bottom)
//        }
        
//        NavigationView {
//            List(1...1000, id: \.self) { i in
//                NavigationLink(
//                    destination: Text("Detail"),
//                    label: {
//                        /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
//                    })
//                Text("Row \(i)")
//            }
//        }.tabItem {
//            Image(systemName: "pencil.slash")
//            Text("Tab")
//        }
//        Text(customer.name)
        
        
//        Rectangle().frame(width: imageSize, height: imageSize)
        
        
//        TextField("Enter your email address", text: $emailAddress).textFieldStyle(RoundedBorderTextFieldStyle())
//            .onChange(of: emailAddress) { newValue in
//                print("Email address was changed to \(emailAddress)")
//            }
//
        
//        ScrollView {
//            ScrollViewReader { value in
//                VStack {
//                    Button("Scroll to item") {
//                        withAnimation(Animation.easeIn(duration: 3)) {
//                            value.scrollTo(5, anchor: .center)
//
//                        }
//                    }
//
//                    Text("Hello World!").frame(height: 200)
//                    Text("Hello World!").frame(height: 200)
//                    Text("Hello World!").frame(height: 200)
//                    Text("Hello World!").frame(height: 200)
//                    Text("Hello World!").frame(height: 200)
//                    Text("Show me!").frame(height: 200).id(5)
//                    Text("Hello World!").frame(height: 200)
//                    Text("Hello World!").frame(height: 200)
//                }.frame( maxWidth: .infinity)
//            }
//        }

//        VideoPlayer(player: AVPlayer(url: URL(string: "https://bit.ly/swswift")!)) {
//            Text("Hello World!")
//                .padding()
//                .background(Color.black.opacity(0.8))
//        }
        
//        ColorPicker("Pick a color", selection: $color)
        
//        Map(coordinateRegion: $region)
        
//        ScrollView{
//            /// scrollバーの位置が違うの注目(エッジ)
//            LazyVStack {
//                ForEach(0...1000, id: \.self, content: SampleRow.init)
//            }
//            /// scrollバーの位置が違うの注目(データのすぐ横)
////            VStack {
////                ForEach(0...1000, id: \.self, content: SampleRow.init)
////            }
//        }
//        VStack {
//            ProgressView("Loading...", value: downloadAmount, total: 100)
//            Button("Move along please") {
//                downloadAmount += 5
//            }
//        }
        
//        TextEditor(text: $text)
//            .padding()
//            .foregroundColor(.blue)
//            .font(.custom("Geogia", size: 24, relativeTo: .largeTitle))
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
