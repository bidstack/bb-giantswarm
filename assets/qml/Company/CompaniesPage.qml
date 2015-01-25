import bb.cascades 1.3
import bb.system 1.2

import "../Components"

NavigationPane {
    id: navigation
    Page {
        titleBar: TitleBar {
            title: qsTr("Companies")
            attachedObjects: [
                ActionItem {
                    id: cancelActionItem
                    title: qsTr("Cancel")
                },
                ActionItem {
                    id: doneActionItem
                    title: qsTr("Done")
                },
                ActionItem {
                    id: refreshActionItem
                    title: qsTr("Refresh")
                }
            ]
            onCreationCompleted: {
                if (false) {
                    acceptAction = doneActionItem
                    dismissAction = cancelActionItem
                } else {
                    acceptAction = refreshActionItem
                }
            }
        }
        actions: [
            ActionItem {
                title: qsTr("Add")
                ActionBar.placement: ActionBarPlacement.Signature
                imageSource: "asset:///images/actions/official/ic_add.png"
            }
        ]
        Container {
            ListView {
                dataModel: GroupDataModel {
                    id: companiesDataModel
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
                                imageSource: "asset:///images/actions/custom/ic_company.png"
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
                    companiesDataModel.insertList([
                        { name: "bidstack" },
                        { name: "giantswarm" }
                    ]);
                }
                onTriggered: {
                    var company = companiesDataModel.data(indexPath);
                }
            }
        }
    }
}