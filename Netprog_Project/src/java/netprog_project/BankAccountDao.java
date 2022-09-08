/*
    Όνομα: Άγγελος Τζώρτζης
    Α.Μ.: ice18390094
 */
package netprog_project;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BankAccountDao {

    public static Connection getConnection() {
        Connection conn = null;

        try {
            // Δημιουγρούμε σύνδεση στην βάση μας ανάλογα με ποιά βάση χρησιμοποιόυμε
            // και τα στοιχεία της.
            Class.forName("org.mariadb.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mariadb://localhost:4306/bank", "Tzortzis", "1234");
        } catch (ClassNotFoundException | SQLException ex) {

        }
        return conn;
    }

    public static int addBankAccount(BankAccount bankAccount) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();

        try {
            // Με την χρήση PreparedStatement που είναι μία ασφαλής μέθοδος,
            // περνάμε στην βάση μας τα στοιχεία που εισάγαμε απο το HTML αρχείο
            // και δώσαμε τιμές στο αντικέιμενο μας
            PreparedStatement ps = conn.prepareStatement("INSERT INTO bank_accounts(firstName, lastName, phoneNumber, email, accountBalance, active) VALUES (?, ?, ?, ?, ?, ?)");
            ps.setString(1, bankAccount.getFirstName());
            ps.setString(2, bankAccount.getLastName());
            ps.setString(3, bankAccount.getPhoneNumber());
            ps.setString(4, bankAccount.getEmail());
            ps.setInt(5, bankAccount.getAccountBalance());
            // Θεωρούμε ότι ο λογαριασμός όταν δημιουργείται είναι ενεργός.
            ps.setBoolean(6, true);
            // Εκτελούμε την εντολή της SQL.
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        // Επιστρέφουμε το status (ορίζει αν πέτυχε η εντολή μας η όχι).
        return status;
    }

    public static int deposit(BankAccount bankAccount, int amount) {
        int status = 0;
        // Δημιουργία σύνδεσης ώστε να έχουμε πρόσβαση στην βάση μας.
        Connection conn = BankAccountDao.getConnection();
        // Προσθέτουμε στον λογαριασμό το ποσό που ορίσαμε με το id του λογαριασμού που ορίσαμε. 
        // εφόσον αυτός τηρεί της προυποθέσεις. (Είναι ενεργός και υπάρχει)
        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE bank_accounts SET accountBalance=accountBalance+? WHERE accountId=? AND active = true");
            ps.setInt(1, amount);
            ps.setInt(2, bankAccount.getAccountId());
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        return status;
    }

    public static int withdraw(BankAccount bankAccount, int amount) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();
        // Αφαιρούμε από τον λογαριασμό το ποσό που ορίσαμε με το id του λογαριασμού που ορίσαμε,
        // εφόσον αυτός τηρεί της προυποθέσεις. (Είναι ενεργός, υπάρχει, και έχει τα απαραίτητα χρήματα).

        try {
            PreparedStatement ps = conn.prepareStatement("UPDATE bank_accounts SET accountBalance=accountBalance-? WHERE accountId=? AND active = true");
            ps.setInt(1, amount);
            ps.setInt(2, bankAccount.getAccountId());
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        return status;
    }

    public static int transfer(BankAccount bankAccountSend, BankAccount bankAccountReceive, int amount) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();

        try {
            // Αρχικά αφαιρούμε το ποσό απο τον λογαριασμό που θέλουμε να στείλει τα χρήματα.
            PreparedStatement ps = conn.prepareStatement("UPDATE bank_accounts SET accountBalance=accountBalance-? WHERE accountId=? AND active = true");
            ps.setInt(1, amount);
            ps.setInt(2, bankAccountSend.getAccountId());
            status = ps.executeUpdate();
            // Εφόσον πετύχει αυτή η συναλλαγή το ποσό που αφαιρέθηκε απο τον λογαριασμό το προσθέτουμε στον άλλο.
            if (status != 0) {
                ps = conn.prepareStatement("UPDATE bank_accounts SET accountBalance=accountBalance+? WHERE accountId=? AND active = true");
                ps.setInt(1, amount);
                ps.setInt(2, bankAccountReceive.getAccountId());
                status = ps.executeUpdate();
            }
            conn.close();
        } catch (SQLException ex) {

        }
        // Εάν πετύχει αυτή η συναλλαγή θα μας επιστρέψει status = 1 η συνάρτηση.
        return status;
    }

    // Ενεργοποίηση λογαριασμόυ.
    public static int activate(BankAccount bankAccount) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();

        try {
            // Ενεργοποιούμε μόνο αν είναι απενεργοποιημένος.
            PreparedStatement ps = conn.prepareStatement("UPDATE bank_accounts SET active=true WHERE accountId=? AND active=false");
            ps.setInt(1, bankAccount.getAccountId());
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        return status;
    }

    // Απενεργοποίηση λογαριασμού.
    public static int deactivate(BankAccount bankAccount) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();

        try {
            // Απενεργοποιούμε μόνο άν είναι ενεργοποιημένος.
            PreparedStatement ps = conn.prepareStatement("UPDATE bank_accounts SET active=false WHERE accountId=? AND active=true");
            ps.setInt(1, bankAccount.getAccountId());
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        return status;
    }

    // Η παρακάτω συνάρτηση δέχεται ώς όρισμα έναν αριθμό λογαριασμού
    public static BankAccount getBankAccount(int accountId) {
        // Δημιουργία αντικειμένου ώστε να αποθηκεύσουμε τα στοιχεία μας.
        BankAccount bankAccount = new BankAccount();
        Connection conn = BankAccountDao.getConnection();

        try {
            // Εντολή SQL για την εμφάνιση όλων των στοιχείων της εγγραφής του αριθμού λογαριασμού.
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bank_accounts WHERE accountId=?");
            ps.setInt(1, accountId);
            ResultSet rs = ps.executeQuery();

            // Περνάμε όλα τα στοιχεία της εγγραφής στο αντικείμενο που δημιουργήσαμε πιο πάνω.
            if (rs.next()) {
                bankAccount.setAccountId(rs.getInt(1));
                bankAccount.setFirstName(rs.getString(2));
                bankAccount.setLastName(rs.getString(3));
                bankAccount.setPhoneNumber(rs.getString(4));
                bankAccount.setEmail(rs.getString(5));
                bankAccount.setAccountBalance(rs.getInt(6));
                bankAccount.setActive(rs.getBoolean(7));
            }
            conn.close();
        } catch (SQLException ex) {

        }
        return bankAccount;
    }

    // Eμφάνιση όλων των εγγραφών του πίνακα.
    public static List<BankAccount> getAllAccounts() {
        // Φτιάχνουμε αντικείμενο λίστα ώστε να αποθηκεύσουμε τον κάθε λογαριασμό.
        List<BankAccount> accountList = new ArrayList<>();
        Connection conn = BankAccountDao.getConnection();

        try {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM bank_accounts");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                // Φτιάχνουμε αντικείμο για να περάσουμε τα στοιχεία της εγγραφής σε ένα αντικείμενο.
                BankAccount bankAccount = new BankAccount();
                bankAccount.setAccountId(rs.getInt(1));
                bankAccount.setFirstName(rs.getString(2));
                bankAccount.setLastName(rs.getString(3));
                bankAccount.setPhoneNumber(rs.getString(4));
                bankAccount.setEmail(rs.getString(5));
                bankAccount.setAccountBalance(rs.getInt(6));
                bankAccount.setActive(rs.getBoolean(7));
                // Εφόσον περαστούν όλα τα στοιχεία αποθηκεύουμε το αντικείμενο στην λίστα.
                accountList.add(bankAccount);
            }
            conn.close();
        } catch (SQLException ex) {
        }
        return accountList;
    }

    public static int deleteAccount(int accountId) {
        int status = 0;
        Connection conn = BankAccountDao.getConnection();

        try {
            // Διαγραφή μίας εγγραφής της επιλογής μας.
            PreparedStatement ps = conn.prepareStatement("DELETE FROM bank_accounts WHERE accountId=?");
            ps.setInt(1, accountId);
            status = ps.executeUpdate();
            conn.close();
        } catch (SQLException ex) {

        }
        return status;
    }
}
