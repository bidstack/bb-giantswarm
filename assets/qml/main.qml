import bb.cascades 1.4

import "Welcome"
import "Company"
import "Environment"
import "Application"
import "Account"

TabbedPane {
    tabs: [
        Tab {
            title: qsTr("Welcome")
            imageSource: "asset:///images/actions/official/ic_home.png"
            WelcomePage {}
        },
        Tab {
            title: qsTr("Companies")
            imageSource: "asset:///images/actions/custom/ic_company.png"
            CompaniesPage {}
        },
        Tab {
            title: qsTr("Environments")
            imageSource: "asset:///images/actions/custom/ic_environment.png"
            EnvironmentsPage {}
        },
        Tab {
            title: qsTr("Applications")
            imageSource: "asset:///images/actions/custom/ic_swarm.png"
            ApplicationsPage {}
        },
        Tab {
            title: qsTr("Account")
            imageSource: "asset:///images/actions/official/ic_edit_profile.png"
            AccountPage {}
        }
    ]
}