//
//  TeleprompterViewController.swift
//  Teleprompter
//
//  Created by Chris Rehagen on 2/26/20.
//  Copyright © 2020 Chris Rehagen. All rights reserved.
//

import UIKit

class TeleprompterViewController: UIViewController, UITextViewDelegate {
        
    @IBOutlet weak var teleprompterTextView: UITextView!
    @IBOutlet weak var playButton: UIBarButtonItem!
    @IBOutlet weak var pauseButton: UIBarButtonItem!
    @IBOutlet weak var stopButton: UIBarButtonItem!
    @IBOutlet weak var speeedSlider: UISlider!
    
            
     var timer: Timer?
     var state = State.stopped
     var top: CGFloat = 0.0
     var bottom: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pauseButton.isEnabled = false
        stopButton.isEnabled = false
        teleprompterTextView.delegate = self as UITextViewDelegate
         
    }
    
    @IBAction func playButtonPressed(_ sender: Any) {
    
        playButton.isEnabled = false
        pauseButton.isEnabled = true
        stopButton.isEnabled = true

        if (state == .paused) {
            state = .playing
        } else {
            
            self.bottom = teleprompterTextView.contentSize.height
            self.top = -(teleprompterTextView.bounds.height/4)
            self.teleprompterTextView.setContentOffset(CGPoint(x: 0, y: self.top), animated: false)
            
            
            self.timer?.invalidate()
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                    if (self.state == .paused){
                        return
                }
                    let speed = CGFloat(self.speeedSlider!.value)
                    self.top += speed
                    self.teleprompterTextView.setContentOffset(CGPoint(x: 0, y: self.top), animated: true)
            })
        }
    }
    
    @IBAction func pauseButtonPressed(_ sender: Any) {
        state = .paused
        
        playButton.isEnabled = true
        pauseButton.isEnabled = false
    }
    
    @IBAction func stopButtonPressed(_ sender: Any) {
        timer?.invalidate()
        self.state = .stopped
        
        playButton.isEnabled = true
        stopButton.isEnabled = false
        pauseButton.isEnabled = false

    }
    
    @IBAction func rotateButtonPressed(_ sender: Any) {

        // ??
    }
    
    enum State {
        case stopped
        case playing
        case paused
    }
    
}
