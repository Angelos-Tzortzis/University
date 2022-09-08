/*
    Όνομα: Άγγελος Τζώρτζης
    Α.Μ.: ice18390094
 */
package netprog_project;

import java.util.List;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.Consumes;
import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;

@Path("/bankAccountService")
public class BankAccountServiceImpl {
    // Την μέθοδο POST την χρησιμοποιούμε για την αποστολή δεδομένων.
    // Την μέθοδο GET την χρησιμοποιούμε για την παραλαβή δεδομένων.
    // Η μέθοδς Consumes καθορίζει το είδος εισόδου που θα δεχθεί η μέθοδος μας.
    // Η μέθοδος Produces καθορίζει το είδος αρχείο που θα παράγει η μέθοδος μας.

    // Ρυθμίζουμε το Path, της παραμέτρους, τις μέθοδους και για το κάθε endpoint
    @POST
    @Path("/bankAccounts")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String createBankAccount(
            @FormParam("firstName") String firstName,
            @FormParam("lastName") String lastName,
            @FormParam("phoneNumber") String phoneNumber,
            @FormParam("email") String email,
            @FormParam("accountBalance") int accountBalance,
            @Context HttpServletResponse servletResponse
    ) {
        // Φτιάχνουμε ένα νέο αντικέιμενο BankAccount και με τους setters περνάμε σε αυτό
        // τις τιμές που έχουμε εισάγει απο HTML αρχείο μας.
        BankAccount bankAccount = new BankAccount();
        bankAccount.setFirstName(firstName);
        bankAccount.setLastName(lastName);
        bankAccount.setPhoneNumber(phoneNumber);
        bankAccount.setEmail(email);
        bankAccount.setAccountBalance(accountBalance);
        // Καλούμε την συνάρτηση για την δημιουργία ενός νέου λογαριασμού.
        int result = BankAccountDao.addBankAccount(bankAccount);
        // Εάν πέτυχε η συνάρτηση, επιστρέφει πίσω την τιμή 1 και τυπώνουμε
        // στο browser μήνυμα επιτυχίας, αλλιώς επιστρέφει 0 και τυπώνει μήνυμα αποτυχίας.
        if (result == 1) {
            return "<h3>Account created successfully.<h3>";
        }
        return "<h3>Unable to create account.<h3>";
    }

    // Στην deposit και withdraw δεχόμαστε σαν ορίσματα τον αριθμό λογαριασμού
    // και το ποσό που θα αναληφθεί/κατατεθεί.
    @POST
    @Path("/deposit")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String deposit(
            @FormParam("accountId") int accountId,
            @FormParam("amount") int amount,
            @Context HttpServletResponse servletResponse
    ) {

        BankAccount bankAccount = new BankAccount();
        bankAccount.setAccountId(accountId);
        int result = BankAccountDao.deposit(bankAccount, amount);
        if (result == 1) {
            return "<h3>Successful Deposit.<h3>";
        }
        return "<h3>Deposit Error (Account possibly deactivated/doesn't exit).<h3>";
    }

    @POST
    @Path("/withdraw")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String withdraw(
            @FormParam("accountId") int accountId,
            @FormParam("amount") int amount,
            @Context HttpServletResponse servletResponse
    ) {
        BankAccount bankAccount = new BankAccount();
        bankAccount.setAccountId(accountId);
        int result = BankAccountDao.withdraw(bankAccount, amount);
        if (result == 1) {
            return "<h3>Successful Withdrawal.<h3>";
        }
        return "<h3>Unsuccessful Withdrawal (Insufficient Balance or account possibly deactivated/doesn't exit)<h3>";
    }

    // Εδώ σαν όρισμα έχουμε τους δύο λογαριασμούς που θέλουμε να γίνει η συνναλαγή και το ποσό που θα ανταλλάξουν.
    @POST
    @Path("/transfer")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String transfer(
            @FormParam("accountIdSend") int accountIdSend,
            @FormParam("accountIdReceive") int accountIdReceive,
            @FormParam("amount") int amount,
            @Context HttpServletResponse servletResponse
    ) {
        BankAccount bankAccountSend = new BankAccount();
        BankAccount bankAccountReceive = new BankAccount();
        bankAccountSend.setAccountId(accountIdSend);
        bankAccountReceive.setAccountId(accountIdReceive);
        int result = BankAccountDao.transfer(bankAccountSend, bankAccountReceive, amount);
        if (result == 1) {
            return "<h3>Successful Transfer.<h3>";
        }
        return "<h3>Unsuccesful Transfer (Insufficient Balance or one of the accounts possibly deactivated/doesn't exit).<h3>";
    }

    // Η activate και deactivate δέχονται όρισμα το id του λογαριασμού.
    @POST
    @Path("/activate")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String activate(
            @FormParam("accountId") int accountId,
            @Context HttpServletResponse servletResponse
    ) {
        BankAccount bankAccount = new BankAccount();
        bankAccount.setAccountId(accountId);
        int result = BankAccountDao.activate(bankAccount);
        if (result == 1) {
            return "<h3>Account activated.<h3>";
        }
        return "<h3>Unable to activate account (account possibly already activated or doesn't exit).<h3>";
    }

    @POST
    @Path("/deactivate")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String deactivate(
            @FormParam("accountId") int accountId,
            @Context HttpServletResponse servletResponse
    ) {
        BankAccount bankAccount = new BankAccount();
        bankAccount.setAccountId(accountId);
        int result = BankAccountDao.deactivate(bankAccount);
        if (result == 1) {
            return "<h3>Account deactivated.<h3>";
        }
        return "<h3>Unable to deactivate account (account possibly already deactivated or doesn't exit).<h3>";
    }

    // Εμφανίζουμε τα στοιχεία της εγγραφής της επιλογής μας σε μορφή XML.
    @GET
    @Path("/bankaccountxml/{accountId}")
    @Produces(MediaType.APPLICATION_XML)
    public BankAccount getBankAccountXml(@PathParam("accountId") int accountId) {
        return BankAccountDao.getBankAccount(accountId);
    }

    // Εμφανίζουμε τα στοιχεία της εγγραφής της επιλογής μας σε μορφή JSON.
    @GET
    @Path("/bankaccountjson/{accountId}")
    @Produces(MediaType.APPLICATION_JSON)
    public BankAccount getBankAccountJson(@PathParam("accountId") int accountId) {
        return BankAccountDao.getBankAccount(accountId);
    }

    // Εμφανίζουμε όλα τα στοιχεία του πίνακα σε μορφή XML.
    @GET
    @Path("/allaccountsxml")
    @Produces(MediaType.APPLICATION_XML)
    public List<BankAccount> getAllAccountsXml() {
        return BankAccountDao.getAllAccounts();
    }

    // Εμφανίζουμε όλα τα στοιχεία του πίνακα σε μορφή JSON.
    @GET
    @Path("/allaccountsjson")
    @Produces(MediaType.APPLICATION_JSON)
    public List<BankAccount> getAllAccountsJson() {
        return BankAccountDao.getAllAccounts();
    }

    // Διαγραφή εγγραφής.
    @POST
    @Path("/delete")
    @Produces(MediaType.TEXT_HTML)
    @Consumes(MediaType.APPLICATION_FORM_URLENCODED)
    public String delete(@FormParam("accountId") int accountId, @Context HttpServletResponse servletResponse) {

        int result = BankAccountDao.deleteAccount(accountId);
        if (result == 1) {
            return "<h3>Account deleted.<h3>";
        }
        return "<h3>Unable to delete account.<h3>";
    }
}
