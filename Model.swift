struct Photo: Codable{
    var id: String
    var secret: String
    var server: String
    var farm: Int
}

struct ResultPhotos: Codable{
    var page: Int
    var total: String
    var photo: [Photo]
}

struct ResultsSeach: Codable{
    var photos: ResultPhotos
}
