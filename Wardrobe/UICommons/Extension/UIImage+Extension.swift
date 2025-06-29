//
//  UIImage+Extension.swift
//  Wardrobe
//
//  Created by Anton on 29/06/2025.
//

import UIKit

extension UIImage {

    func resizedAndCompressed(
        maxDimension: CGFloat = 300,
        compressionQuality: CGFloat = 0.2
    ) -> (
        resized: UIImage,
        data: Data
    )? {
        let aspectRatio: CGFloat = size.width / size.height

        let newSize: CGSize = {
            return if size.width > size.height {
                .init(
                    width: maxDimension,
                    height: maxDimension / aspectRatio
                )
            } else {
                .init(
                    width: maxDimension * aspectRatio,
                    height: maxDimension
                )
            }
        }()

        let format: UIGraphicsImageRendererFormat = .init()
        format.opaque = true
        format.scale = 1
        format.preferredRange = .standard // Avoid HDR

        let renderer: UIGraphicsImageRenderer = .init(
            size: newSize,
            format: format
        )
        let resizedImage: UIImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: newSize))
        }

        guard let data: Data = resizedImage.jpegData(compressionQuality: compressionQuality) else {
            return nil
        }

        return (resized: resizedImage, data: data)
    }
}
