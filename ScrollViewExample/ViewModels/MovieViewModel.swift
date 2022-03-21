import Foundation

class MovieViewModel {
    
    let movies: [MovieCategory] = [
        MovieCategory(category: "Action", names: [
            "Venom",
            "Spider Man"
        ]),
        MovieCategory(category: "Horror", names: [
            "Alien",
            "Halloween",
            "Black Friday"
        ]),
        MovieCategory(category: "Cartoon", names: [
            "Frozen",
            "Lion King",
            "Kung Fu Panda"
        ])
    ]
}

struct MovieCategory {
    let category: String
    let names: [String]
}
