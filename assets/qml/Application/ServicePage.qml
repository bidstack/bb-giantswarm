import bb.cascades 1.3

import "../Elements"

Page {
    property variant service;
    titleBar: TitleBar {
        title: qsTr("Service")
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
                imageSource: "asset:///images/actions/custom/ic_service.png"
                verticalAlignment: VerticalAlignment.Center
                rightMargin: ui.du(3)
            }
            Container {
                Label {
                    text: service["name"]
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
                        text: service["status"]
                        textStyle.fontSize: FontSize.Small
                        textStyle.color: Color.create("#FF5C00")
                        leftMargin: ui.du(0)
                    }
                }
            }
        }
        Header {
            title: qsTr("Components")
        }
        ListView {
            dataModel: GroupDataModel {
                id: componentsDataModel
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
                            imageSource: "asset:///images/actions/custom/ic_component.png"
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
                componentsDataModel.insertList([
                    { name: "nginx", status: "up" },
                    { name: "rails", status: "up" }
                ]);
            }
            onTriggered: {
                navigation.push(Qt.createComponent(
                    "ComponentPage.qml"
                ).createObject(navigation, {
                    component: componentsDataModel.data(indexPath)
                }));
            }
        }
    }
}
