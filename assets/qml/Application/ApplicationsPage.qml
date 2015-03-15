import bb.cascades 1.4

import "../Elements"

NavigationPane {
    id: nav
    Page {
        titleBar: TitleBar {
            title: qsTr("Applications")
            acceptAction: ActionItem {
                title: qsTr("Refresh")
            }
        }
        Container {
            ListView {
                dataModel: GroupDataModel {
                    id: applicationsDataModel
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
                                imageSource: "asset:///images/actions/custom/ic_swarm.png"
                                verticalAlignment: VerticalAlignment.Center
                            }
                            Container {
                                layoutProperties: StackLayoutProperties {
                                    spaceQuota: 1
                                }
                                verticalAlignment: VerticalAlignment.Center
                                Label {
                                    text: ListItemData.name
                                    textStyle.fontSize: FontSize.Large
                                    bottomMargin: 0
                                }
                                Label {
                                    text: ListItemData.environment
                                    verticalAlignment: VerticalAlignment.Center
                                    textStyle.fontSize: FontSize.Small
                                    textStyle.color: Color.Gray
                                    topMargin: ui.du(0)
                                }
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
                    applicationsDataModel.insertList(
                        giantswarm.getApplications().map(function (application) {
                            return {
                                name: application["application"],
                                environment: application["environment"],
                                status: "unknown" // TODO
                            };
                        })
                    );
                }
                onTriggered: {
                    navigation.push(Qt.createComponent(
                        "ApplicationPage.qml"
                    ).createObject(nav, {
                        application: applicationsDataModel.data(indexPath)
                    }));
                }
            }
        }
    }
}