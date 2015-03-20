import bb.cascades 1.4

import "../Elements"

Page {
    property variant component;
    titleBar: TitleBar {
        title: qsTr("Component")
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
                imageSource: "asset:///images/actions/custom/ic_component.png"
                verticalAlignment: VerticalAlignment.Center
                rightMargin: ui.du(3)
            }
            Container {
                Label {
                    text: component["name"]
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
                    StatusLabel {
                        status: component["status"]
                        leftMargin: ui.du(0)
                    }
                }
            }
        }
        Header {
            title: qsTr("Instances")
        }
        ListView {
            dataModel: GroupDataModel {
                id: instancesDataModel
                sortingKeys: [ "name" ]
                sortedAscending: true
                grouping: ItemGrouping.None
            }
            listItemComponents: ListItemComponent {
                type: "item"
                Container {
                    TwoLineListContainer {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        ImageView {
                            imageSource: "asset:///images/actions/custom/ic_instance.png"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }
                            text: ListItemData.id
                            textStyle.fontSize: FontSize.Large
                            verticalAlignment: VerticalAlignment.Center
                        }
                        ImageView {
                            imageSource: "asset:///images/actions/custom/ic_next.png"
                            verticalAlignment: VerticalAlignment.Center
                        }
                    }
                    Divider {}
                }
            }
            onCreationCompleted: {
                instancesDataModel.insertList(component["instances"]);
            }
            onTriggered: {
                nav.push(Qt.createComponent(
                    "InstancePage.qml"
                ).createObject(nav, {
                    instance: instancesDataModel.data(indexPath)
                }));
            }
        }
    }
}
