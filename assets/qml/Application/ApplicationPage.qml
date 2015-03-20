import bb.cascades 1.4

import "../Elements"

Page {
    property string application_name;
    property string company_name;
    property string environment_name;
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
                    text: application_name
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
                        id: statusLabel
                        status: "unknown"
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
                var application = giantswarm.getApplicationStatus(
                    company_name,
                    environment_name,
                    application_name
                );

                statusLabel.status = application["status"];
                servicesDataModel.insertList(application["services"]);
            }
            onTriggered: {
                nav.push(Qt.createComponent(
                    "ServicePage.qml"
                ).createObject(nav, {
                    service: servicesDataModel.data(indexPath)
                }));
            }
        }
    }
}
