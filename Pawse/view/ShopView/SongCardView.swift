//
//  SongCardView.swift
//  Loty
//
//  Created by Akmal Hakim on 24/06/24.
//

import SwiftUI

struct SongCardView: View {
    @ObservedObject var viewModel: SongViewModel
    let song: Song
    
    var body: some View {
        ZStack {
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 72))
                .position(x:-10.2457, y:89.12981)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 36))
                .position(x:159, y:74.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 22))
                .position(x:222, y:23.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 48))
                .position(x:320.5, y:104.5)
            
            VStack(alignment: .leading, spacing: 24) {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                        .transition(.opacity)
                        .animation(.easeInOut, value: viewModel.errorMessage)
                }
                HStack(alignment: .center) {
                    VStack(alignment: .leading, spacing: 2) {
                        Text(song.name)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                        Text(song.description)
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                    Spacer()
                    if song.isBought {
                        VStack {
                            HStack {
                                Text("Purchased")
                                    .font(.caption)
                                    .fontWeight(.medium)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.green.opacity(0.2))
                                    .foregroundColor(.green)
                                    .cornerRadius(8)
                                    .padding(8)
                            }
                        }
                    } else {
                        VStack(alignment: .center, spacing: 0) {
                            Image(systemName:"star.circle.fill")
                                .frame(width: 20.2832, height: 19.9316)
                                .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                            Text("\(song.coin) points")
                                .font(.footnote)
                                .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                        }
                        .padding(0)
                    }
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .top)
                
                HStack {
                    if !song.isBought {
                        Button("Preview") {
                            viewModel.playPreview(song: song)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color(red: 0.85, green: 0.84, blue: 0.84))
                        .cornerRadius(16)
                        .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                    }
                    
                    if song.isBought {
                        Button(viewModel.currentlyPlayingSong?.id == song.id && viewModel.isPlaying ? "Stop" : "Play") {
                            if viewModel.currentlyPlayingSong?.id == song.id && viewModel.isPlaying {
                                viewModel.stopSong()
                            } else {
                                viewModel.playSong(song)
                            }
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(
                            viewModel.currentlyPlayingSong?.id == song.id && viewModel.isPlaying
                            ? Color.red
                            : Color(red: 0.2, green: 0.68, blue: 0.9)
                        )
                        .cornerRadius(16)
                        .foregroundColor(Color(red: 0.99, green: 0.96, blue: 0.92))
                    } else {
                        Button("Buy") {
                            viewModel.buySong(song)
                        }
                        .padding(8)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color(red: 0.2, green: 0.68, blue: 0.9))
                        .cornerRadius(16)
                        .foregroundColor(Color(red: 0.99, green: 0.96, blue: 0.92))
                    }
                }
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(width: 356, height: 138, alignment: .leading)
        .background(Color(red: 0.99, green: 0.96, blue: 0.92))
        .cornerRadius(25)
        .overlay(
            RoundedRectangle(cornerRadius: 25)
                .inset(by: 0.5)
                .stroke(Color(red: 1, green: 0.85, blue: 0.64), lineWidth: 1)
        )
    }
}

struct BoughtSongCardView: View {
    var body: some View {
        ZStack {
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 72))
                .position(x:-10.2457, y:89.12981)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 36))
                .position(x:159, y:74.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 22))
                .position(x:222, y:23.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 48))
                .position(x:320.5, y:104.5)
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .center) {
                  // Space Between
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Weightless")
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                          .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                        Text("if you need to calm down your anxiety")
                            .font(.caption)
                            .fontWeight(.medium)
                          .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                  Spacer()
                  // Alternative Views and Spacers
                    VStack(alignment: .center, spacing: 0) {
                        Image(systemName:"star.circle.fill")
                          .frame(width: 20.2832, height: 19.9316)
                          .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                        Text("5 points")
                            .font(.footnote)
                          .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                    }
                    .padding(0)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .top)
                HStack {
                    Button("Bought") {
                        // action here
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 0.85, green: 0.84, blue: 0.84))

                    .cornerRadius(16)
                    .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                    Button("Play") {
                        // action here
                    }
                    .padding(8)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(red: 0.2, green: 0.68, blue: 0.9))
                    .cornerRadius(16)
                    .foregroundColor(Color(red: 0.99, green: 0.96, blue: 0.92))
                }
            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(width: 356, height: 138, alignment: .leading)
        .background(Color(red: 0.99, green: 0.96, blue: 0.92))
        .cornerRadius(25)
        .overlay(
          RoundedRectangle(cornerRadius: 25)
            .inset(by: 0.5)
            .stroke(Color(red: 1, green: 0.85, blue: 0.64), lineWidth: 1)
    )
    }
}

struct LockedSongCardView: View {
    var body: some View {
        ZStack {
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 72))
                .position(x:-10.2457, y:89.12981)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 36))
                .position(x:159, y:74.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 22))
                .position(x:222, y:23.5)
            Image(systemName: "music.note")
                .foregroundColor(Color(red: 0.97, green: 0.92, blue: 0.86))
                .font(.system(size: 48))
                .position(x:320.5, y:104.5)
            VStack(alignment: .leading, spacing: 24) {
                HStack(alignment: .center) {
                  // Space Between
                    VStack(alignment: .leading, spacing: 2) {
                        Text("???")
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                          .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))
                        Text("???")
                            .font(.caption)
                            .fontWeight(.medium)
                          .foregroundColor(Color(red: 0.5, green: 0.5, blue: 0.5))
                          .frame(maxWidth: .infinity, alignment: .topLeading)
                    }
                    .padding(0)
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                  Spacer()
                  // Alternative Views and Spacers
                    VStack(alignment: .center, spacing: 0) {
                        Image(systemName:"star.circle.fill")
                          .frame(width: 20.2832, height: 19.9316)
                          .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                        Text("???")
                            .font(.footnote)
                          .foregroundColor(Color(red: 0.92, green: 0.7, blue: 0.03))
                    }
                    .padding(0)
                }
                .padding(0)
                .frame(maxWidth: .infinity, alignment: .top)
                Button("Locked") {
                    // action here
                }
                .padding(8)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(red: 0.85, green: 0.84, blue: 0.84))

                .cornerRadius(16)
                .foregroundColor(Color(red: 0.24, green: 0.26, blue: 0.31))

            }
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 16)
        .frame(width: 356, height: 138, alignment: .leading)
        .background(Color(red: 0.99, green: 0.96, blue: 0.92))
        .opacity(0.5)
        .cornerRadius(25)
        .overlay(
          RoundedRectangle(cornerRadius: 25)
            .inset(by: 0.5)
            .stroke(Color(red: 1, green: 0.85, blue: 0.64), lineWidth: 1)
    )
    }
}

#Preview {
    BoughtSongCardView()
}
