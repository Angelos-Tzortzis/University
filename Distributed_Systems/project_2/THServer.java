import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.*;

class THServer {

  public THServer() {
    try {
      THInterface th = new THImpl();
      Naming.rebind("//localhost/Theater", th);

    } catch (Exception e) {
      System.out.println("Trouble: " + e);
    }
  }

  public static void main(String[] args) {
    System.out.println("R.M.I. server started.");
    try {
      LocateRegistry.createRegistry(1099);
      System.out.println("Java RMI registry created.");
    } catch (RemoteException re) {
      System.out.println("RemoteException: " + re);
    }
    new THServer();
  }
}
