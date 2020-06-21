//
//  Permissions.swift
//  Example
//
//  Created by Maria Paula Gomez Prieto on 6/21/20.
//  Copyright © 2020 Kooler. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

enum PermissionsStatus {
    case granted
    case undetermined
    case denied
}
struct Permissions {
    
    static func checkPermissions(in viewController: UIViewController, onConfirm: @escaping () -> Void) {
        
        if checkMicrophonePermission() == .granted, checkCameraPermission() == .granted {
            onConfirm()
            return
        }
        
        if checkMicrophonePermission() == .undetermined {
            askMicrophonePermission(in: viewController, onConfirm: onConfirm)
            return
        }
        
        if checkCameraPermission() == .undetermined {
            askCameraPermission(in: viewController, onConfirm: onConfirm)
            return
        }
        
    }
    
    static func checkMicrophonePermission() -> PermissionsStatus {
        switch AVAudioSession.sharedInstance().recordPermission {
        case .denied:
            return .denied
        case .granted:
            return .granted
        case .undetermined:
            return .undetermined
        @unknown default:
            return .denied
        }
    }
    
    static func checkCameraPermission() -> PermissionsStatus {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            return .undetermined
        case .restricted:
            return .denied
        case .denied:
            return .denied
        case .authorized:
            return .granted
        @unknown default:
            return .denied
        }
    }
    
    static func askMicrophonePermission(in viewController: UIViewController, onConfirm: @escaping () -> Void) {
        
        if AVAudioSession.sharedInstance().recordPermission == .undetermined {
            AVAudioSession.sharedInstance().requestRecordPermission({ _ in
                DispatchQueue.main.async {
                    checkPermissions(in: viewController, onConfirm: onConfirm)
                }
            })
        }
    }
    
    static func askCameraPermission(in viewController: UIViewController, onConfirm: @escaping () -> Void) {
     
        if AVCaptureDevice.authorizationStatus(for: .video) == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { _ in
                DispatchQueue.main.async {
                    checkPermissions(in: viewController, onConfirm: onConfirm)
                }
            })
        }
    }
    
    static func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
    
}
