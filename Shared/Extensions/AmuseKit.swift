//
//  AmuseKit.swift
//  AmuseKitDemo
//
//  Created by Jota Uribe on 19/09/22.
//

import AmuseKit

extension AmuseKit.DataProvider {
    static let devToken = "YOUR_DEV_TOKEN_HERE"
    
    static func shared() -> AmuseKit.DataProvider {
        let configuration = AmuseKit.StorageConfiguration(serviceName: "com.jjotaum.akdemo",
                                                          developerTokenKey: "com.jjotaum.akdemo.dt",
                                                          userTokenKey: "com.jjotaum.akdemo.utk")
        let dataProvider = AmuseKit.DataProvider(configuration)
        dataProvider.setDeveloperToken(Self.devToken)
        return dataProvider
    }
}
