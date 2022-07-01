//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Антон Головатый on 26.06.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let title: String
    let subtitle: String?
    let collection: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(title: model.trackName,
                             subtitle: model.artistName,
                             collection: model.collectionName)
    }
}
