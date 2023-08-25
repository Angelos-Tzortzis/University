import java.net.MalformedURLException;
import java.rmi.Naming;
import java.rmi.NotBoundException;
import java.rmi.RemoteException;

public class THClient {

  public static void main(String[] args) {
    try {

      THInterface theater = (THInterface) Naming.lookup(args[1]);

      if (args.length == 2) {
        if (args[0].equals("list")) {
          System.out.println(theater.list());
        } else if (args[0].equals("guests")) {
          System.out.println(theater.guests());
        } else {
          System.out.println("Improper usage.");
        }
      } else if (args.length == 5) {
        if (args[0].equals("book")) {
          System.out.println(theater.book(args[2], Integer.parseInt(args[3]), args[4]));
        } else if (args[0].equals("cancel")) {
          System.out.println(theater.cancel(args[2], Integer.parseInt(args[3]), args[4]));
        } else {
          System.out.println("Improper usage.");
        }
      } else {
        System.out.println("Improper usage.");
      }
    } catch (MalformedURLException murle) {
      System.out.println("MalformedURLException:");
      System.out.println(murle);
    } catch (RemoteException re) {
      System.out.println("RemoteException:");
      System.out.println(re);
    } catch (NotBoundException nbe) {
      System.out.println("NotBoundException:");
      System.out.println(nbe);
    } catch (java.lang.ArithmeticException ae) {
      System.out.println("java.lang.ArithmeticException:");
      System.out.println(ae);
    } catch (Exception e) {
    }
  }
}
