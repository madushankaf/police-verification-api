import ballerina/http;
import police_api.repo;
import ballerinax/mysql;
import  police_api.logic;

configurable int servicePort = 9090;
configurable string host = "35.225.208.245";
configurable string userName = "root";
configurable string password = "root";
configurable int dbPort = 3306;
configurable string database = "policeVerificationDB";

mysql:Client dbClient = check new (host, userName, password, database, 3306);

repo:IRepository policeRecordRepo = new repo:MySqlCitizenRepository(dbClient);
logic:PolicRecordVerifier verifier = new (policeRecordRepo);

service http:Service /CitizenInfo on new http:Listener(servicePort) {

    resource function get nic/[string nic]() returns json {
        return {policeRecotdStatus: verifier.isAdressAvailable(nic) };
    }
}
