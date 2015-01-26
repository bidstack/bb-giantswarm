#ifndef ACTIVEFRAME_HPP
#define ACTIVEFRAME_HPP

#include <QObject>
#include <bb/cascades/SceneCover>

using namespace ::bb::cascades;

class ActiveFrame: public SceneCover {
    Q_OBJECT

public:
    ActiveFrame(QObject *parent = 0);
};

#endif
