import bb.cascades 1.3

Container {
    property double spacing;
    property double verticalSpacing;
    property double horizontalSpacing;

    topPadding: verticalSpacing
    rightPadding: horizontalSpacing
    bottomPadding: verticalSpacing
    leftPadding: horizontalSpacing

    onCreationCompleted: {
        if (!spacing) {
            spacing = ui.du(2)
        }

        if (!verticalSpacing) {
            verticalSpacing = spacing
        }

        if (!horizontalSpacing) {
            horizontalSpacing = spacing
        }
    }
}
