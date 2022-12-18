//
//  ProductModel.swift
//  VapingApp
//
//  Created by iOSayed on 16/12/2022.
//


import Foundation

    // MARK: - ProductElement
    struct ProductModel: Codable {
        let id: Int
        let productDescription: String
        let image: Image
        let price: Int
    }

    // MARK: - Image
    struct Image: Codable {
        let width, height: Int
        let url: String
    }
