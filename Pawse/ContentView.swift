//
//  ContentView.swift
//  Pawse
//
//  Created by hendra on 21/06/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var authViewModel: AuthenticationViewModel = AuthenticationViewModel()
    
    @State private var selectedTab: Tab = .mood
    
    enum Tab {
        case mood
        case shop
        case profile
    }
    
    var body: some View {
        Group {
            NavigationStack {
                if authViewModel.isLoggedIn {
                    TabView {
                        Group {
                            MoodView()
                                .tabItem {
                                    Image(systemName: "face.smiling.fill")
                                    Text("Mood")
                                }
                                .tag(Tab.mood)

                            ShopView()
                                .tabItem {
                                    Image(systemName: "music.note.house.fill")
                                    Text("Shop")
                                }
                                .tag(Tab.shop)

                            ProfileView()
                                .tabItem {
                                    Image(systemName: "person.circle")
                                    Text("Profile")
                                }
                                .tag(Tab.profile)
                        }
                    }
                } else {
                    LoginView()
                }
            }
            .environmentObject(authViewModel)
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            UITabBar.appearance().backgroundColor = .white
        }
    }
}

#Preview {
    ContentView()
}
