import ballerina/log;
import police_api.repo;
import police_api.domain;

public class AdressVerifier {
    private repo:IRepository addressRepo;
    public function init(repo:IRepository addressRepo) {
        self.addressRepo = addressRepo;

    }
    public function isAdressAvailable(string no, string text) returns boolean {

        domain:Adress|error address = self.addressRepo.getAdress(no, text);
        if address is error {
            log:printInfo(address.message());

            return false;
        }

        return address.no == no;

    }

}

