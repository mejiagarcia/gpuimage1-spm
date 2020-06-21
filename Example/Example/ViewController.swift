//
//  ViewController.swift
//  Example
//
//  Created by Maria Paula Gomez Prieto on 6/21/20.
//  Copyright © 2020 Kooler. All rights reserved.
//

import UIKit
import GPUImage

class ViewController: UIViewController {
    // MARK: - UI References
     @IBOutlet private weak var videoView: GPUImageView!
    
    var movieWritter: GPUImageMovieWriter?
    private var videoCamera: GPUImageVideoCamera?
    var customFilter: YUGPUImageHighPassSkinSmoothingFilter?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    // MARK: - Private Methods
    private func setupView() {
        Permissions.checkPermissions(in: self) { [weak self] in
            self?.setCamera()
            self?.setFilter()
        }
    }
    
    private func setCamera() {
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSession.Preset.vga640x480.rawValue, cameraPosition: .back)
        videoCamera?.horizontallyMirrorFrontFacingCamera = false
        videoCamera?.horizontallyMirrorRearFacingCamera = false
        videoCamera?.outputImageOrientation = .portrait
    }
    
    private func setFilter() {
        customFilter = YUGPUImageHighPassSkinSmoothingFilter()
        customFilter?.amount = 1
        videoCamera?.addTarget(customFilter)
        customFilter?.addTarget(videoView)
        videoCamera?.startCapture()
    }
}

