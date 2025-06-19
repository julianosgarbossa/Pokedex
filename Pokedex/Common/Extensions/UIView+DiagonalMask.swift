//
//  UIView+DiagonalMask.swift
//  Pokedex
//
//  Created by Juliano Sgarbossa on 19/06/25.
//

import UIKit

extension UIView {
    /// Aplica uma máscara diagonal na view atual.
    /// cutoffMultiplier: Valor entre 0.0 e 1.0 que determina onde o corte da diagonal será aplicado.
    /// Exemplo: 1.0 corta na base direita completa, 0.5 corta exatamente na metade, 0.75 é mais inclinado.
    func applyDiagonalMask(cutoffMultiplier: CGFloat = 0.75) {
        self.layoutIfNeeded()
        
        let width = self.bounds.width
        let height = self.bounds.height
        
        let cutoffX = width * cutoffMultiplier
        
        let path = UIBezierPath()
        path.move(to: .zero)                             /// canto superior esquerdo
        path.addLine(to: CGPoint(x: width, y: 0))        /// canto superior direito
        path.addLine(to: CGPoint(x: cutoffX, y: height)) /// ponto inclinado inferior direito
        path.addLine(to: CGPoint(x: 0, y: height))       /// canto inferior esquerdo
        path.close()
        
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        self.layer.mask = shape
    }
}
