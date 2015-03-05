#ifndef GIANTSWARM_ENVIRONMENTREPOSITORY_HPP
#define GIANTSWARM_ENVIRONMENTREPOSITORY_HPP

#include <QObject>

#include "../giantswarmrepository.hpp"

namespace Giantswarm {

    namespace Repositories {

        class EnvironmentRepository : public GiantswarmRepository {
            Q_OBJECT

        public:
            EnvironmentRepository(QSqlDatabase& database, QObject *parent = 0);

        public:
            bool add(QString companyName, QString environmentName);
            bool has(QString companyName, QString environmentName);
            bool remove(QString companyName, QString environmentName);
            bool clear(QString companyName);
            bool clear();
            QVariantList all(QString companyName);
            QVariantList all();

        protected:
            void init();
        };

    };

};

#endif
