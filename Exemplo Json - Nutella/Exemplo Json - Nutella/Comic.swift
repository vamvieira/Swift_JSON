//
//  Comic.swift
//  Exemplo Json - Nutella
//
//  Created by Usuário Convidado on 19/09/23.
//

import Foundation

struct Comic:Decodable {
    var num:Int
    var day:String
    var month:String
    var year:String
    var title:String
    var img:String
}
