import ballerina/sql;
import ballerinax/mysql;
import police_api.domain

public type IRepository object {
    public function getPoliceRecord(string nic) returns domain:PolicRecord|error;
};

public class MySqlCitizenRepository {
    *IRepository;
    mysql:Client mysqlClient;

    public function init(mysql:Client mysqlClient) {
        self.mysqlClient = mysqlClient;
    }

    public function getPoliceRecord(string nic) returns domain:PolicRecord|error {
        domain:PolicRecord|sql:Error policRecord = self.mysqlClient->queryRow(`SELECT * FROM PoliceRecords WHERE nic > ${nic};`);
        check self.mysqlClient.close();
        return policRecord;
    }

}

