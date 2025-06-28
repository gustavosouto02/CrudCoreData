//
//  ContentView.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import SwiftUI

struct ContentView: View {
    
    @FetchRequest(fetchRequest: Movie.all)
    private var movieResults: FetchedResults<Movie>
    private func deleteMovie(indexSet: IndexSet) {
        
        guard let index = indexSet.map({ $0 }).first else{
            return
        }
        
        let movie = movieResults[index]
        do{
            try movie.delete()
        } catch{
            print(error)
        }
        
    }
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Group {
                if movieResults.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "film")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Text("Nenhum filme adicionado")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text("Toque em '+' para adicionar seu primeiro filme.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .multilineTextAlignment(.center)
                } else {
                    List{
                        ForEach(movieResults) { movie in
                            NavigationLink(destination: {
                                AddUpdateMovieView(movie: movie)
                            }) {
                                Text(movie.title ?? "Sem título")
                            }
                        }
                        .onDelete(perform: deleteMovie)
                    }
                }
            }
            .navigationTitle("Filmes")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isPresented = true
                    } label: {
                        Label("Adicionar", systemImage: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $isPresented) {
            AddUpdateMovieView()
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
}
