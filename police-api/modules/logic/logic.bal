import ballerina/log;
import police_api.repo;
import police_api.domain;

public class PolicRecordVerifier {
    private repo:IRepository policeRecordRepo;
    public function init(repo:IRepository policeRecordRepo) {
        self.policeRecordRepo = policeRecordRepo;

    }
    public function isAdressAvailable(string nic) returns boolean {

        domain:PoliceRecord|error policeRecord = self.policeRecordRepo.getPoliceRecord(nic);
        if policeRecord is error {
            log:printInfo(policeRecord.message());

            return false;
        }

        return policeRecord.areCriminalRecordsAvailable;

    }

}

