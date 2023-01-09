import ballerina/sql;
import ballerinax/mysql;
import police_api.domain;

public type IRepository object {
    public function getPoliceRecord(string nic) returns domain:PoliceRecord|error;
};

public class MySqlCitizenRepository {
    *IRepository;
    mysql:Client mysqlClient;

    public function init(mysql:Client mysqlClient) {
        self.mysqlClient = mysqlClient;
    }

    public function getPoliceRecord(string nic) returns domain:PoliceRecord|error {
        domain:PoliceRecord|sql:Error policRecord = self.mysqlClient->queryRow(`SELECT * FROM PoliceRecords WHERE nic > ${nic};`);
        return policRecord;
    }
}

