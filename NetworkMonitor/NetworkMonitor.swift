//
//  NetworkMonitor.swift
//  VapingApp
//
//  Created by iOSayed on 17/12/2022.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor : NWPathMonitor
    public private(set) var isConnected:Bool = false
    public private(set) var connectionType:ConnectionType = .unowned
    
    enum ConnectionType{
        case wifi
        case celluler
        case ethernet
        case unowned
    }
    private init() {
        monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.connectionType(path)
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func connectionType(_ path:NWPath) {
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .celluler

        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet

        }else {
            connectionType = .unowned
        }
    }
    
}
