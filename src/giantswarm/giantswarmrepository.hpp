#ifndef GIANTSWARM_REPOSITORY_HPP
#define GIANTSWARM_REPOSITORY_HPP

#include <QObject>
#include <QSqlDatabase>

namespace Giantswarm {

    class GiantswarmRepository : public QObject {
        Q_OBJECT

    public:
        GiantswarmRepository(QSqlDatabase& database, QObject *parent = 0);

    protected:
        QSqlDatabase& database();
        virtual void init() =0;

    private:
        QSqlDatabase m_database;
    };

};

#endif
