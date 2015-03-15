import bb.cascades 1.4

Container {
    background: Color.Black
    
    layout: DockLayout {}
    
    Container {
        verticalAlignment: VerticalAlignment.Center
        horizontalAlignment: HorizontalAlignment.Center
        
        ImageView {
            imageSource: "asset:///images/giantswarm.png"
            scalingMethod: ScalingMethod.AspectFit
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            bottomMargin: 0
        }
        
        Label {
            text: "giantswarm.io"
            textStyle.fontSize: FontSize.Small
            horizontalAlignment: HorizontalAlignment.Center
            topMargin: 0
        }
    }
}