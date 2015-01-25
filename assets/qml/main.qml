import bb.cascades 1.3

TabbedPane {
    tabs: [
        Tab {
            title: qsTr("Welcome")
            Page {}
        },
        Tab {
            title: qsTr("Companies")
            Page {}
        },
        Tab {
            title: qsTr("Environments")
            Page {}
        },
        Tab {
            title: qsTr("Applications")
            Page {}
        },
        Tab {
            title: qsTr("Account")
            Page {}
        }
    ]
}