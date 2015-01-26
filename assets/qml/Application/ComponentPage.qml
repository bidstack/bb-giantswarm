import bb.cascades 1.3

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
                    Label {
                        text: component["name"]
                        textStyle.fontSize: FontSize.Small
                        textStyle.color: Color.create("#FF5C00")
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
                instancesDataModel.insertList([
                    { name: "c6ef55dc-d501-4669-b175-34b5c112ba79", status: "up" },
                    { name: "37df40f4-fd6d-4b60-a662-d7d61ec0741c", status: "starting" },
                    { name: "7a1f51cf-33b7-4a5b-b101-c943dcc8b48a", status: "failed" }
                ]);
            }
            onTriggered: {
                navigation.push(Qt.createComponent(
                    "InstancePage.qml"
                ).createObject(navigation, {
                    instance: instancesDataModel.data(indexPath)
                }));
            }
        }
    }
}
