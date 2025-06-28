//
//  AddMovieView.swift
//  MovieApp
//
//  Created by Gustavo Souto Pereira on 27/06/25.
//

import SwiftUI

struct AddUpdateMovieView: View {
    
    @State private var title: String = ""
    
    var body: some View {
        Form{
            TextField("Title", text: $title)
        }
    }
}

#Preview {
    AddUpdateMovieView()
}
 
