import bb.cascades 1.3

import "../Components"

NavigationPane {
    id: navigation
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
                        SpacedContainer {
                            verticalSpacing: ui.du(1)
                            horizontalSpacing: ui.du(2)
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
                                    textStyle.fontSize: FontSize.XSmall
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
                    applicationsDataModel.insertList([
                    { name: "bidstack-api", environment: "bidstack/staging" },
                            { name: "giantswarm-weather", environment: "giantswarm/production" }
                            ]);
                }
                onTriggered: {
                    var application = applicationsDataModel.data(indexPath);
                }
            }
        }
    }
}