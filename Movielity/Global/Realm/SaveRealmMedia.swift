//
//  SaveRealmMedia.swift
//  Movielity
//
//  Created by 이윤지 on 10/14/24.
//

import RealmSwift

class SaveRealmMedia: Object {
    @Persisted(primaryKey: true) var id: Int
    @Persisted var title: String
    @Persisted var posterImagePath: String
}

