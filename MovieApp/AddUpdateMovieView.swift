//
//  AddMovieView.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import SwiftUI

struct EditMovieConfig {
    var title: String = ""
    
    init(movie: Movie? = nil) {
        guard let movie = movie else { return }
        self.title = movie.title ?? ""
    }
}

struct AddUpdateMovieView: View {
    
    var movie: Movie?
    
    @State private var editMovieConfig = EditMovieConfig()
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss
    
    private func saveOrUpdateMovie() {
        let movie = movie ?? Movie(context: viewContext)
        movie.title = editMovieConfig.title
        do {
            try movie.save()
            dismiss()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section(header: Text("Título do Filme")) {
                        TextField("Digite o título", text: $editMovieConfig.title)
                            .textInputAutocapitalization(.words)
                    }
                }
                
                Spacer()
                
                Button(action: saveOrUpdateMovie) {
                    HStack {
                        Spacer()
                        Label("Salvar", systemImage: "checkmark.circle.fill")
                            .font(.headline)
                        Spacer()
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                .padding(.bottom, 24) // espaço do fundo
            }
            .navigationTitle(movie == nil ? "Adicionar Filme" : "Editar Filme")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let movie = movie {
                    editMovieConfig = EditMovieConfig(movie: movie)
                }
            }
        }
    }
}

#Preview {
    AddUpdateMovieView()
        .environment(\.managedObjectContext, CoreDataProvider.shared.viewContext)
}
