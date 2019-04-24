//
//  MaterialShowcaseInstructionView.swift
//  MaterialShowcase
//
//  Created by Andrei Tulai on 2017-11-16.
//  Copyright © 2017 Aromajoin. All rights reserved.
//

import Foundation
import UIKit

public protocol MaterialShowcaseInstructionViewDelegate: class {
    func didTapActionButton(button: UIButton)
}

public class MaterialShowcaseInstructionView: UIView {
  
  internal static let PRIMARY_TEXT_SIZE: CGFloat = 20
  internal static let SECONDARY_TEXT_SIZE: CGFloat = 15
  internal static let PRIMARY_TEXT_COLOR = UIColor.white
  internal static let SECONDARY_TEXT_COLOR = UIColor.white.withAlphaComponent(0.87)
  internal static let PRIMARY_DEFAULT_TEXT = "Awesome action"
  internal static let SECONDARY_DEFAULT_TEXT = "Tap here to do some awesome thing"

  public weak var delegate: MaterialShowcaseInstructionViewDelegate?

  public var badgeLabel: UILabel!
  public var primaryLabel: UILabel!
  public var secondaryLabel: UILabel!
  public var actionButton: UIButton!

  let primaryTextTopSpace: CGFloat = 16
  let secondaryTextTopSpace: CGFloat = 8
  let actionButtonTopSpace: CGFloat = 24

  // Text
  public var badgeText: String?
  public var badgeBackgroundColor: UIColor?
  public var badgeFont: UIFont?
  public var primaryText: String!
  public var secondaryText: String!
  public var actionButtonText: String?
  public var primaryTextColor: UIColor!
  public var secondaryTextColor: UIColor!
  public var actionButtonTextColor: UIColor?
  public var primaryTextSize: CGFloat!
  public var secondaryTextSize: CGFloat!
  public var primaryTextFont: UIFont?
  public var secondaryTextFont: UIFont?
  public var primaryTextAlignment: NSTextAlignment!
  public var secondaryTextAlignment: NSTextAlignment!
  public var actionButtonBorderColor: UIColor?
  public var actionButtonBorderWidth: CGFloat?
  public var actionButtonBorderCornerRadius: CGFloat?
  public var actionButtonFont: UIFont?

  public init() {
    // Create frame
    let frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 0)
    super.init(frame: frame)
    
    configure()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  /// Initializes default view properties
  fileprivate func configure() {
    setDefaultProperties()
  }
  
  fileprivate func setDefaultProperties() {
    // Text
    primaryText = MaterialShowcaseInstructionView.PRIMARY_DEFAULT_TEXT
    secondaryText = MaterialShowcaseInstructionView.SECONDARY_DEFAULT_TEXT
    primaryTextColor = MaterialShowcaseInstructionView.PRIMARY_TEXT_COLOR
    secondaryTextColor = MaterialShowcaseInstructionView.SECONDARY_TEXT_COLOR
    primaryTextSize = MaterialShowcaseInstructionView.PRIMARY_TEXT_SIZE
    secondaryTextSize = MaterialShowcaseInstructionView.SECONDARY_TEXT_SIZE
  }

    /// Configures and adds primary label view
    private func addBadgeLabel() {
        if badgeLabel != nil {
            badgeLabel.removeFromSuperview()
        }

        badgeLabel = UILabel()

        guard let text = badgeText else { return }

        badgeLabel.text = text
        badgeLabel.textColor = .white
        badgeLabel.backgroundColor = badgeBackgroundColor
        badgeLabel.textAlignment = .center
        badgeLabel.font = badgeFont ?? UIFont.systemFont(ofSize: 10)

        badgeLabel.sizeToFit()

        badgeLabel.frame = CGRect(x: 0, y: 0, width: badgeLabel.frame.size.width + 12 , height: badgeLabel.frame.size.height + 6)
        badgeLabel.layer.cornerRadius = 2.5
        badgeLabel.clipsToBounds = true

        addSubview(badgeLabel)
    }

  /// Configures and adds primary label view
  private func addPrimaryLabel() {
    if primaryLabel != nil {
        primaryLabel.removeFromSuperview()
    }
    
    primaryLabel = UILabel()
    
    if let font = primaryTextFont {
      primaryLabel.font = font
    } else {
      primaryLabel.font = UIFont.boldSystemFont(ofSize: primaryTextSize)
    }
    primaryLabel.textColor = primaryTextColor
    primaryLabel.textAlignment = self.primaryTextAlignment ?? .left
    primaryLabel.numberOfLines = 0
    primaryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    primaryLabel.text = primaryText
    primaryLabel.frame = CGRect(x: 0, y: badgeLabel.frame.height + primaryTextTopSpace, width: getWidth(), height: 0)
    primaryLabel.sizeToFitHeight()
    addSubview(primaryLabel)
  }

  /// Configures and adds secondary label view
  private func addSecondaryLabel() {
    if secondaryLabel != nil {
        secondaryLabel.removeFromSuperview()
    }
    
    secondaryLabel = UILabel()
    if let font = secondaryTextFont {
      secondaryLabel.font = font
    } else {
      secondaryLabel.font = UIFont.systemFont(ofSize: secondaryTextSize)
    }
    secondaryLabel.textColor = secondaryTextColor
    secondaryLabel.textAlignment = self.secondaryTextAlignment ?? .left
    secondaryLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
    secondaryLabel.text = secondaryText
    secondaryLabel.numberOfLines = 0
    
    secondaryLabel.frame = CGRect(x: 0, y: badgeLabel.frame.height + primaryTextTopSpace + primaryLabel.frame.height + secondaryTextTopSpace,  width: getWidth(), height: 0)

    secondaryLabel.sizeToFitHeight()
    addSubview(secondaryLabel)
  }

    /// Configures and adds action button
    private func addActionButton() {
        if actionButton != nil {
            actionButton.removeFromSuperview()
        }

        guard let title = actionButtonText else { return }

        actionButton = UIButton()
        actionButton.setTitle(title, for: .normal)
        actionButton.setTitleColor(actionButtonTextColor, for: .normal)
        actionButton.titleLabel?.font = actionButtonFont

        actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        actionButton.isUserInteractionEnabled = true

        actionButton.layer.borderColor = actionButtonBorderColor?.cgColor
        actionButton.layer.borderWidth = actionButtonBorderWidth ?? 0

        actionButton.layer.cornerRadius = actionButtonBorderCornerRadius ?? 0

        actionButton.frame = CGRect(x: 0, y: badgeLabel.frame.height + primaryTextTopSpace + primaryLabel.frame.height + secondaryTextTopSpace + secondaryLabel.frame.height + actionButtonTopSpace, width: getWidth(), height: 0)

        actionButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)

        actionButton.sizeToFit()
        addSubview(actionButton)

        frame = CGRect(x: frame.minX,
                       y: frame.minY,
                       width: frame.width,
                       height: badgeLabel.frame.height + primaryLabel.frame.height + secondaryLabel.frame.height + actionButton.frame.height + actionButtonTopSpace + secondaryTextTopSpace + primaryTextTopSpace)
    }

    @objc func didTapActionButton(button: UIButton) {
        self.delegate?.didTapActionButton(button: button)
    }
  
  //Calculate width per device
  private func getWidth() -> CGFloat{
    //superview was left side
    if (self.superview?.frame.origin.x)! < CGFloat(0) {
        return frame.width - (frame.minX/2)
    } else if ((self.superview?.frame.origin.x)! + (self.superview?.frame.size.width)! >
        UIScreen.main.bounds.width) { //superview was right side
        return (frame.width - frame.minX)/2
    }
    return (frame.width - frame.minX)
  }
    
  /// Overrides this to add subviews. They will be drawn when calling show()
  public override func layoutSubviews() {
    super.layoutSubviews()

    addBadgeLabel()
    addPrimaryLabel()
    addSecondaryLabel()
    addActionButton()

    subviews.forEach({$0.isUserInteractionEnabled = $0 == actionButton})
  }
}
