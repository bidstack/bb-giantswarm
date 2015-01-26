import bb.cascades 1.3

import "../Elements"

Page {
    property variant application;
    titleBar: TitleBar {
        title: qsTr("Application")
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
                imageSource: "asset:///images/actions/custom/ic_swarm.png"
                verticalAlignment: VerticalAlignment.Center
                rightMargin: ui.du(3)
            }
            Container {
                Label {
                    text: application["name"]
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
                        text: application["status"]
                        textStyle.fontSize: FontSize.Small
                        textStyle.color: Color.create("#FF5C00")
                        leftMargin: ui.du(0)
                    }
                }
            }
        }
        Header {
            title: qsTr("Services")
        }
        ListView {
            dataModel: GroupDataModel {
                id: servicesDataModel
                sortingKeys: [ "name" ]
                sortedAscending: true
                grouping: ItemGrouping.None
            }
            listItemComponents: ListItemComponent {
                type: "item"
                Container {
                    SingleLineListContainer {
                        layout: StackLayout {
                            orientation: LayoutOrientation.LeftToRight
                        }
                        ImageView {
                            imageSource: "asset:///images/actions/custom/ic_service.png"
                            verticalAlignment: VerticalAlignment.Center
                        }
                        Label {
                            layoutProperties: StackLayoutProperties {
                                spaceQuota: 1
                            }
                            text: ListItemData.name
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
                servicesDataModel.insertList([
                    { name: "website", status: "starting" },
                    { name: "api", status: "failed" }
                ]);
            }
            onTriggered: {
                navigation.push(Qt.createComponent(
                    "ServicePage.qml"
                ).createObject(navigation, {
                    service: servicesDataModel.data(indexPath)
                }));
            }
        }
    }
}
