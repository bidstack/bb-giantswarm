import bb.cascades 1.3

Page {
    Container {
        layout: DockLayout {}
        Container {
            verticalAlignment: VerticalAlignment.Center
            horizontalAlignment: HorizontalAlignment.Center
            ImageView {
                imageSource: "asset:///images/giantswarm.png"
                scalingMethod: ScalingMethod.AspectFit
                horizontalAlignment: HorizontalAlignment.Center
                bottomMargin: ui.du(0)
            }
            Label {
                text: "giantswarm.io"
                textStyle.fontSize: FontSize.Large
                bottomMargin: ui.du(0)
                topMargin: ui.du(0)
                horizontalAlignment: HorizontalAlignment.Center
            }
            Label {
                text: "0.10.2-beta"
                textStyle.fontSize: FontSize.XSmall
                textStyle.color: Color.Red
                topMargin: ui.du(0)
                horizontalAlignment: HorizontalAlignment.Center
            }
        }
    }
}