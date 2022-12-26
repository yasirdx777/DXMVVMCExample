//
//  ImageTableViewCell.swift
//  DXTemplate
//
//  Created by Yasir Romaya on 8/13/22.
//

import Foundation
import UIKit

class ImageTableViewCell: UITableViewCell, CellIdentifier {
    
    private lazy var mainImageView: AsyncImageView = {
        @UsesAutoLayout
        var imageView = AsyncImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func createView(){
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        
        contentView.addSubview(mainImageView)
        
        
        NSLayoutConstraint.activate(mainImageView.constraintsForAnchoringTo(boundsOf: contentView))
        
        NSLayoutConstraint.activate([mainImageView.heightAnchor.constraint(equalToConstant: 300)])
        
    }
    

    override func prepareForReuse() {
        mainImageView.image = nil
        mainImageView.cancelImageLoad()
    }
    
    func configure(imageUrl: String) {
        mainImageView.loadImage(at: URL(string: imageUrl)!)
    }
}

