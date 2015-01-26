#include "activeframe.hpp"

#include <bb/cascades/SceneCover>
#include <bb/cascades/Container>
#include <bb/cascades/QmlDocument>

using namespace bb::cascades;

ActiveFrame::ActiveFrame(QObject *parent) : SceneCover(parent)
{
    QmlDocument *qml = QmlDocument::create("asset:///qml/ActiveFrame/ActiveFrame.qml").parent(parent);
    Container *mainContainer = qml->createRootObject<Container>();
    setContent(mainContainer);
}
