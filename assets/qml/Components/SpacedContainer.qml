import bb.cascades 1.3

Container {
    property double spacing;

    topPadding: spacing
    rightPadding: spacing
    bottomPadding: spacing
    leftPadding: spacing

    onCreationCompleted: {
        if (!spacing) {
            spacing = ui.du(2);
        }
    }
}
