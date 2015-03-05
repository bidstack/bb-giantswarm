#include <QDebug>
#include <QSqlQuery>
#include <QSqlError>

#include "environmentrepository.hpp"

using namespace Giantswarm::Repositories;

EnvironmentRepository::EnvironmentRepository(QSqlDatabase& database, QObject *parent) : GiantswarmRepository(database, parent) {

}

bool EnvironmentRepository::add(QString companyName, QString environmentName) {
    const QString sql =
      "INSERT INTO environments (company_name, name) "
        "VALUES (:company_name, :environment_name)";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.bindValue(":company_name", companyName);
    stmt.bindValue(":environment_name", environmentName);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        qWarning() << "Failed to add environment:" << err.text();
        return false;
    }

    return true;
}

bool EnvironmentRepository::has(QString companyName, QString environmentName) {
    return all(companyName).contains(environmentName);
}

bool EnvironmentRepository::remove(QString companyName, QString environmentName) {
    const QString sql =
      "DELETE FROM environments WHERE "
        "company_name = :company_name AND "
        "name = :environment_name";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.bindValue(":company_name", companyName);
    stmt.bindValue(":environment_name", environmentName);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        qWarning() << "Failed to remove environment:" << err.text();
        return false;
    }

    return true;
}

bool EnvironmentRepository::clear(QString companyName) {
    const QString sql =
      "DELETE FROM environments WHERE "
        "company_name = :company_name";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.bindValue(":company_name", companyName);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        qWarning() << "Failed to clear environments:" << err.text();
        return false;
    }

    return true;
}

bool EnvironmentRepository::clear() {
    const QString sql = "DELETE FROM environments";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        qWarning() << "Failed to clear environments:" << err.text();
        return false;
    }

    return true;
}

QVariantList EnvironmentRepository::all(QString companyName) {
    const QString sql =
      "SELECT name FROM environments WHERE "
        "company_name = :company_name "
        "ORDER BY name ASC";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.bindValue(":company_name", companyName);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        return QVariantList();
    }

    QVariantList environments;
    while (stmt.next()) {
        environments.append(stmt.value(0).toString());
    }

    return environments;
}

QVariantList EnvironmentRepository::all() {
    const QString sql =
      "SELECT name FROM environments "
        "ORDER BY name ASC";

    QSqlQuery stmt(database());
    stmt.prepare(sql);
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        return QVariantList();
    }

    QVariantList environments;
    while (stmt.next()) {
        environments.append(stmt.value(0).toString());
    }

    return environments;
}

void EnvironmentRepository::init() {
    const QString sql =
        "CREATE TABLE IT NOT EXISTS environments ("
            "id INTEGER PRIMARY KEY, "
            "name CHAR(100) NOT NULL, "
            "company_name CHAR(100) NOT NULL"
        ")";

    QSqlQuery stmt(sql, database());
    stmt.exec();

    QSqlError err = stmt.lastError();
    if (err.isValid()) {
        qWarning() << "Failed to create environments table:" << err.text();
    }
}
