//
//  ShopView.swift
//  Loty
//
//  Created by Akmal Hakim on 24/06/24.
//

import SwiftUI

struct ShopView: View {
    @StateObject private var viewModel = SongViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Shop")
                .font(.title)
                .fontWeight(.bold)
                .padding(.leading)
            
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    ForEach(viewModel.songs) { song in
                        SongCardView(viewModel: viewModel, song: song)
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    ShopView()
}
