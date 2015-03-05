#include "giantswarmrepository.hpp"

using namespace Giantswarm;

GiantswarmRepository::GiantswarmRepository(QSqlDatabase& database, QObject *parent) : QObject(parent) {
    m_database = database;
}

QSqlDatabase& GiantswarmRepository::database() {
    return m_database;
}
