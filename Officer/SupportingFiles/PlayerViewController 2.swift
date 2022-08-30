//
//  PlayerViewController.swift
//  Officer
//
//  Created by Furkan Eruçar on 29.08.2022.
//

import UIKit
import AVKit

//private func configureVideoPlayer() {
//
//        videoPlayer = AVPlayer(url: URL(fileURLWithPath: path))
//        playerController.player = videoPlayer
//        playerController.view.frame.size.height = videoView.frame.size.height
//        playerController.view.frame.size.width = videoView.frame.size.width
//        playerController.videoGravity = .resizeAspectFill
//        videoView.addSubview(playerController.view)
//        videoView.addSubview(playPauseButton)
        

class PlayerViewController: AVPlayerViewController {
    
    var videoPlayer: AVPlayer?
    let tapButton = UIButton()
    
    init(videoPlayer: AVPlayer) {
        super.init(nibName: nil, bundle: nil)
        self.videoPlayer = videoPlayer
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        videoGravity = .resizeAspectFill
        self.player = videoPlayer
        
        configureObserver()
        configurePlayPauseAction()
    }
    
    private func configureObserver() {
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem,
                                               queue: OperationQueue.main) { [weak self] _ in
            if (self?.player?.currentItem) != nil {
                self?.player?.seek(to: .zero)
                self?.player?.pause()
            }
        }
    }
    
    private func configurePlayPauseAction() {
        view.addSubview(tapButton)
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(playPause))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func playPause() {
        switch videoPlayer?.timeControlStatus {
        case .playing:
            videoPlayer?.play()
        case .paused:
            videoPlayer?.pause()
        default:
            break
        }
    }
 
}
