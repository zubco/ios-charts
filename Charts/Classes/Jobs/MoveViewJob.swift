//
//  MoveViewJob.swift
//  Charts
//
//  Copyright 2015 Daniel Cohen Gindi & Philipp Jahoda
//  A port of MPAndroidChart for iOS
//  Licensed under Apache License 2.0
//
//  https://github.com/danielgindi/ios-charts
//

import Foundation

// This defines a viewport modification job, used for delaying or animating viewport changes
internal class MoveViewJob: Job
{
    internal override init(
        viewPortHandler: ChartViewPortHandler,
        xIndex: CGFloat,
        yValue: Double,
        transformer: ChartTransformer,
        view: ChartViewBase)
    {
        super.init(
            viewPortHandler: viewPortHandler,
            xIndex: xIndex,
            yValue: yValue,
            transformer: transformer,
            view: view)
    }
    
    internal override func doJob()
    {
        guard let
            viewPortHandler = viewPortHandler,
            transformer = transformer,
            view = view
            else { return }
        
        var pt = CGPoint(
            x: xIndex,
            y: CGFloat(yValue)
        );
        
        transformer.pointValueToPixel(&pt)
        viewPortHandler.centerViewPort(pt: pt, chart: view)
    }
}