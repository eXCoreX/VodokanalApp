//
//  App.swift
//
//
//  Created by Litvinov Rostyslav on 18.12.2022.
//

import TokamakDOM
import JavaScriptKit
import Foundation
import JavaScriptEventLoop

@main
struct TokamakApp: App {
    var body: some Scene {
        WindowGroup("Водоканал") {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var users: [VodokanalUser] = []
    @State private var navigation = Navigation.home

    @State private var authorizedAdmin = false

    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ZStack {
                Image("vodokanal-background.jpeg")
                    .resizable()
                    .aspectRatio(1030 / 684, contentMode: .fit)
                    .frame(width: 1440, height: 800)

                LinearGradient(colors: [.black.opacity(0.6), .black.opacity(0)], startPoint: .top, endPoint: .bottom)
                    .frame(width: 1440, height: 180)
                    .frame(width: 1440, height: 800, alignment: .top)

                Image("cute-cat.jpeg")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
                    .padding(24)
                    .frame(width: 1440, height: 800, alignment: .topLeading)

                Button {
                    navigation = navigation == .adminMode ? .home : .adminMode
                } label: {
                    Text("Подивитись всіх користувачів")
                        .font(.caption)
                        .padding()
                        .background(.background0)
                        .cornerRadius(20)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(24)
                .frame(width: 1440, height: 800, alignment: .topTrailing)


                switch navigation {
                case .home:
                    VStack {
                        Button {
                            navigation = .sendReadings
                        } label: {
                            Text("Передати показники")
                                .font(.title)
                                .bold()
                                .padding()
                                .background(.color1)
                                .cornerRadius(20)
                        }.buttonStyle(PlainButtonStyle())
                    }
                case .sendReadings:
                    VStack {
                        SendReadingsView {
                            navigation = .home
                            Task {
                                users = (try? await VodokanalUsersRepository.shared.users) ?? []
                            }
                        }
                    }
                    .background(
                        Color.background4
                    )
                    .cornerRadius(16)
                case .adminMode:
                    if authorizedAdmin {
                        VodokanalUsersView(users: users)
                            .task {
                                users = (try? await VodokanalUsersRepository.shared.users) ?? []
                            }
                    } else {
                        AdminAutheticationView(authorized: $authorizedAdmin) { navigation = $0 ? .adminMode : .home }
                    }
                }
            }
            .frame(width: 1440, height: 800)
            .background(
                Color.background1
            )
        }
    }

    private enum Navigation {
        case home
        case sendReadings
        case adminMode
    }
}

extension Binding where Value == Double {
    func toString() -> Binding<String> {
        Binding<String> {
            "\(wrappedValue)"
        } set: { newValue in
            guard let newDouble = Double(newValue) else { return }
            wrappedValue = newDouble
        }
    }
}
