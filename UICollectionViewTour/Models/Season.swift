
import Foundation

struct Season: Hashable {
    let id = UUID().uuidString
    let name: String
    let imageName: String
    let year: String

    static func == (lhs: Season, rhs: Season) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Season {
    static var theWireSeasons: [Season] {
        return [
            Season(name: "Season 1", imageName: "TheWire_Season_1", year: "2002"),
            Season(name: "Season 2", imageName: "TheWire_Season_2", year: "2003"),
            Season(name: "Season 3", imageName: "TheWire_Season_3", year: "2004"),
            Season(name: "Season 4", imageName: "TheWire_Season_4", year: "2006"),
            Season(name: "Season 5", imageName: "TheWire_Season_5", year: "2008")
        ]
    }
}


