//
//  AnimatedZoomViewJob.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation

internal class AnimatedZoomViewJob: AnimatedJob
{
    internal var scaleX: CGFloat = 0.0
    internal var scaleY: CGFloat = 0.0
    internal var zoomOriginX: CGFloat = 0.0
    internal var zoomOriginY: CGFloat = 0.0
    internal var zoomCenterX: CGFloat = 0.0
    internal var zoomCenterY: CGFloat = 0.0
    
    internal init(
        viewPortHandler: ChartViewPortHandler,
        transformer: ChartTransformer,
        view: ChartViewBase,
        scaleX: CGFloat,
        scaleY: CGFloat,
        xOrigin: CGFloat,
        yOrigin: CGFloat,
        zoomCenterX: CGFloat,
        zoomCenterY: CGFloat,
        zoomOriginX: CGFloat,
        zoomOriginY: CGFloat,
        duration: NSTimeInterval,
        easing: ChartEasingFunctionBlock?)
    {
        super.init(viewPortHandler: viewPortHandler,
            xIndex: 0.0,
            yValue: 0.0,
            transformer: transformer,
            view: view,
            xOrigin: xOrigin,
            yOrigin: yOrigin,
            duration: duration,
            easing: easing)
        
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.zoomCenterX = zoomCenterX
        self.zoomCenterY = zoomCenterY
        self.zoomOriginX = zoomOriginX
        self.zoomOriginY = zoomOriginY
    }
    
    internal override func animationUpdate()
    {
        guard let
            viewPortHandler = viewPortHandler,
            transformer = transformer,
            view = view
            else { return }
        
        let scaleX = xOrigin + (xIndex - xOrigin) * phase
        let scaleY = yOrigin + (CGFloat(yValue) - yOrigin) * phase
        
        var pt = CGPoint(
            x: zoomOriginX + (zoomCenterX - zoomOriginX) * phase,
            y: zoomOriginY + (zoomCenterY - zoomCenterY) * phase
        );
        
        transformer.pointValueToPixel(&pt)
        viewPortHandler.centerViewPort(pt: pt, chart: view)
    
        viewPortHandler.zoomAndCenter(scaleX: scaleX, scaleY: scaleY, center: pt, chart: view)
    }
    
    internal override func animationEnd()
    {
        (view as? BarLineChartViewBase)?.calculateOffsets()
        view?.setNeedsDisplay()
    }
}
