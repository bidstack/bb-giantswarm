import bb.cascades 1.3

import "../Components"

Page {
    titleBar: TitleBar {
        title: qsTr("Instance")
        acceptAction: ActionItem {
            title: qsTr("Refresh")
        }
    }
    Container {
        Container {
            layout: StackLayout {
                orientation: LayoutOrientation.LeftToRight
            }
            topPadding: ui.du(5)
            rightPadding: ui.du(2)
            bottomPadding: ui.du(5)
            leftPadding: ui.du(5)
            ImageView {
                imageSource: "asset:///images/actions/custom/ic_instance.png"
                verticalAlignment: VerticalAlignment.Center
                rightMargin: ui.du(3)
            }
            Container {
                layoutProperties: StackLayoutProperties {
                    spaceQuota: 1
                }
                Label {
                    text: "c6ef55dc-d501-4669-b175-34b5c112ba79"
                    textStyle.fontSize: FontSize.Large
                    bottomMargin: ui.du(0)
                }
                Container {
                    layout: StackLayout {
                        orientation: LayoutOrientation.LeftToRight
                    }
                    Label {
                        text: qsTr("Status:")
                        textStyle.fontSize: FontSize.Small
                        textStyle.color: Color.Gray
                        rightMargin: ui.du(0)
                    }
                    Label {
                        text: "starting..."
                        textStyle.fontSize: FontSize.Small
                        textStyle.color: Color.create("#FF5C00")
                        leftMargin: ui.du(0)
                    }
                }
            }
        }
        Header {
            title: qsTr("Statistics")
        }
        Container {
            SpacedContainer {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    text: qsTr("Memory usage (MB)")
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "69.8"
                    textStyle.fontSize: FontSize.Large
                }
            }
            SpacedContainer {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    text: qsTr("Memory capacity (MB)")
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "7484.17"
                    textStyle.fontSize: FontSize.Large
                }
            }
            SpacedContainer {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    text: qsTr("Memory usage (%)")
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "0.93"
                    textStyle.fontSize: FontSize.Large
                }
            }
            SpacedContainer {
                layout: StackLayout {
                    orientation: LayoutOrientation.LeftToRight
                }
                Label {
                    layoutProperties: StackLayoutProperties {
                        spaceQuota: 1
                    }
                    text: qsTr("CPU usage (%)")
                    textStyle.fontSize: FontSize.Large
                }
                Label {
                    text: "0.01"
                    textStyle.fontSize: FontSize.Large
                }
            }
        }
    }
}
