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
                                    text: ListItemData.application_name
                                    textStyle.fontSize: FontSize.Large
                                    bottomMargin: 0
                                }
                                Label {
                                    text: ListItemData.company_name + "/" + ListItemData.environment_name
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
                        giantswarm.getAllApplications().map(function (application) {
                            return {
                                application_name: application["application"],
                                company_name: application["company"],
                                environment_name: application["environment"]
                            };
                        })
                    );
                }
                onTriggered: {
                    nav.push(Qt.createComponent(
                        "ApplicationPage.qml"
                    ).createObject(nav, applicationsDataModel.data(
                        indexPath
                    )));
                }
            }
        }
    }
}