//
//  ShareView.swift
//  Piccy
//
//  Created by Jannik Feuerhahn on 19.05.21.
//

import SwiftUI

struct ShareView: UIViewControllerRepresentable {
    
    var items: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = UIActivityViewController(activityItems: items, applicationActivities: applicationActivities)
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //
    }
}
