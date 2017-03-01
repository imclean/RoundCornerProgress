//
//  RoundCornerProgressView.swift
//  PhucNguyen
//
//  Created by Phuc Nguyen on 8/18/16.
//  Copyright © 2016 Phuc Nguyen. All rights reserved.
//

import UIKit

@IBDesignable
public class RoundCornerProgressView: UIView {
    
    // MARK: Public properties
    public var animationLength:Double = 0.5
    public let progressLabel = UILabel(frame: .zero)
    // MARK: Private properties
    public var requestPayment:Bool = true
    
    private let trackView = UIView(frame: .zero)
    private let progressView = UIView(frame: .zero)
    
    public let userView = UIImageView(frame: .zero)
    public let paidTick = UIImageView(frame: .zero)
    public let requestImage = UIImageView(frame: .zero)
    public let requestText = UILabel(frame: .zero)
    public var totalAmount:Double = 0.0
    
    // MARK: Inspectable properties
    
    @IBInspectable public var shouldDisplayProgressLabel: Bool = true {
        didSet {
            progressLabel.isHidden = !shouldDisplayProgressLabel
        }
    }
    
    @IBInspectable public var labelColor: UIColor = UIColor.black {
        didSet {
            progressLabel.textColor = labelColor
        }
    }
    
    @IBInspectable public var imageBorder: UIColor = UIColor.black {
        didSet {
            userView.layer.borderColor = imageBorder.cgColor
        }
    }
    
    @IBInspectable public var labelFont: UIFont = UIFont.systemFont(ofSize: 10) {
        didSet {
            progressLabel.font = labelFont
        }
    }
    
    @IBInspectable public var trackRoundCorners: UIRectCorner = [.topRight, .bottomRight, .topLeft, .bottomLeft] {
        didSet {
            trackView.roundCorner(roundingCorners: trackRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
            
        }
    }
    
    @IBInspectable public var progressRoundCorners: UIRectCorner = [] {
        didSet {
            progressView.roundCorner(roundingCorners: progressRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        }
    }
    
    @IBInspectable public var trackTintColor: UIColor = UIColor.lightGray {
        didSet {
            trackView.backgroundColor = trackTintColor
        }
    }
    
    @IBInspectable public var progressTintColor: UIColor = UIColor.red {
        didSet {
            progressView.backgroundColor = progressTintColor
        }
    }
    
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet {
            self.progress = max(0, min(1, self.progress))
            if progress > 0.4 {
                progressLabel.isHidden = false
                requestImage.isHidden = true
                requestText.isHidden = true
                if progress == 1.0 {
                    paidTick.isHidden = false
                }
            } else {
                paidTick.isHidden = true
                progressLabel.isHidden = true
                requestImage.isHidden = false
                requestText.isHidden = false
            }
            UIView.animate(withDuration: animationLength, delay: 0.0, options: .curveEaseInOut, animations: { 
                self.progressView.frame = CGRect(origin: self.progressView.frame.origin, size: CGSize(width: self.frame.width * self.progress, height: self.frame.height))
                self.progressView.roundCorner(roundingCorners: self.progressRoundCorners, cornerRadius: CGSize(width: self.frame.size.height / 2, height: self.frame.size.height / 2))
                if self.progress < 0.12 {
                    self.userView.frame = CGRect(origin: self.progressView.frame.origin, size: CGSize(width: self.progressView.frame.size.height, height: self.progressView.frame.size.height))
                } else if self.progress > 0.88 {
                    self.userView.frame = CGRect(origin: CGPoint(x:self.frame.width  - self.progressView.frame.size.height,y:0), size: CGSize(width: self.progressView.frame.size.height, height: self.progressView.frame.size.height))
                } else {
                    self.userView.frame = CGRect(origin: CGPoint(x:self.frame.width * self.progress - (self.progressView.frame.size.height / 2),y:0), size: CGSize(width: self.progressView.frame.size.height, height: self.progressView.frame.size.height))
                }
            }) { (complete) in
                
            }
        }
    }
    
    @IBInspectable public var userImage: UIImage? = nil {
        didSet {
            userView.image = userImage
            userView.clipsToBounds = true
            userView.contentMode = .scaleAspectFill
        }
    }
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        setupSubviews()
    }
    
    // MARK: - Setup views
    
    private func setupSubviews() {
        setupTrackView()
        setupProgressView()
        setupProgressLabel()
        setupUserImageView()
    }
    
    private func setupUserImageView() {
        if userView.superview == nil {
            userView.frame = CGRect(origin: .zero, size:  CGSize(width: frame.height, height: frame.height))
            addSubview(userView)
            paidTick.frame = CGRect(x: 16, y: (self.frame.size.height / 2) - 12, width: 24, height: 24)
            
            paidTick.contentMode = .scaleAspectFit
            paidTick.clipsToBounds = true
            addSubview(paidTick)
            
            requestImage.frame = CGRect(x: self.frame.size.width - 40, y: (self.frame.size.height / 2) - 12, width: 24, height: 24)
            
            requestImage.contentMode = .scaleAspectFit
            requestImage.clipsToBounds = true
            addSubview(requestImage)
        }
        paidTick.isHidden = self.progress != 1.0
        requestImage.isHidden = !requestPayment
        userView.layer.cornerRadius = frame.height / 2
        userView.layer.borderColor = imageBorder.cgColor
        userView.layer.borderWidth = 2
        userView.clipsToBounds = true
    }
    
    private func setupTrackView() {
        trackView.frame = CGRect(origin: .zero, size: CGSize(width: frame.width - 2, height: frame.height))
        trackView.roundCorner(roundingCorners: trackRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        trackView.backgroundColor = trackTintColor
        trackView.clipsToBounds = true
        addSubview(trackView)
    }
    
    private func setupProgressView() {
        progressView.frame = CGRect(origin: .zero, size: CGSize(width: frame.width * progress, height: frame.height))
        progressView.roundCorner(roundingCorners: progressRoundCorners, cornerRadius: CGSize(width: frame.size.height / 2, height: frame.size.height / 2))
        progressView.backgroundColor = progressTintColor
        trackView.addSubview(progressView)
    }
    
    private func setupProgressLabel() {
        progressLabel.frame = CGRect(x: 48, y: (self.frame.size.height / 2) - 9, width: 150, height: 18)
        progressLabel.textAlignment = .left
        progressLabel.textColor = labelColor
        progressLabel.isHidden = self.progress < 0.3
        addSubview(progressLabel)
        bringSubview(toFront: progressLabel)
        
        requestText.frame = CGRect(x: (self.frame.size.width / 2), y: (self.frame.size.height / 2) - 9, width: (self.frame.size.width / 2) - 50, height: 18)
        requestText.textAlignment = .right
        requestText.isHidden = !shouldDisplayProgressLabel
        addSubview(requestText)
        bringSubview(toFront: requestText)
    }
}
