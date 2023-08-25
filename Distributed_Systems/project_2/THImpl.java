import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class THImpl extends java.rmi.server.UnicastRemoteObject implements THInterface {

  public String PA[] = new String[100];
  public String PB[] = new String[200];
  public String PG[] = new String[400];
  public String KE[] = new String[225];
  public String PTH[] = new String[75];

  public int emptySeatsPA = 100;
  public int emptySeatsPB = 200;
  public int emptySeatsPG = 400;
  public int emptySeatsKE = 225;
  public int emptySeatsPTH = 75;

  ArrayList<String> guestNames = new ArrayList<String>();
  ArrayList<int[]> guestSeats = new ArrayList<int[]>();

  public Map<String, Integer> PAWaitingList = new HashMap<String, Integer>();
  public Map<String, Integer> PBWaitingList = new HashMap<String, Integer>();
  public Map<String, Integer> PGWaitingList = new HashMap<String, Integer>();
  public Map<String, Integer> KEWaitingList = new HashMap<String, Integer>();
  public Map<String, Integer> PTHWaitingList = new HashMap<String, Integer>();

  public int getEmptySeatsPA() {
    return emptySeatsPA;
  }

  public THImpl() throws java.rmi.RemoteException {
    super();
    // "" means there is a free seat.
    // Αρχικοποίηση των κενών θέσεων.
    for (int i = 0; i < 100; i++) {
      PA[i] = "";
    }

    for (int i = 0; i < 200; i++) {
      PB[i] = "";
    }

    for (int i = 0; i < 400; i++) {
      PG[i] = "";
    }

    for (int i = 0; i < 225; i++) {
      KE[i] = "";
    }

    for (int i = 0; i < 75; i++) {
      PTH[i] = "";
    }
  }

  public String list() throws java.rmi.RemoteException {

    for (int i = 0; i < 100; i++) {
      if (!(PA[i].equals(""))) {
        emptySeatsPA--;
      }
    }

    for (int i = 0; i < 200; i++) {
      if (!(PB[i].equals(""))) {
        emptySeatsPB--;
      }
    }

    for (int i = 0; i < 400; i++) {
      if (!(PG[i].equals(""))) {
        emptySeatsPG--;
      }
    }

    for (int i = 0; i < 225; i++) {
      if (!(KE[i].equals(""))) {
        emptySeatsKE--;
      }
    }

    for (int i = 0; i < 75; i++) {
      if (!(PTH[i].equals(""))) {
        emptySeatsPTH--;
      }
    }

    return (emptySeatsPA + " θέσεις Πλατεία - Ζώνη Α (κωδικός: ΠΑ) - τιμή :45 Ευρώ." + "\n"
        + emptySeatsPB + " θέσεις Πλατεία - Ζώνη Β (κωδικός: ΠΒ) - τιμή :35 Ευρώ." + "\n"
        + emptySeatsPG + " θέσεις Πλατεία - Ζώνη Γ (κωδικός: ΠΓ) - τιμή :25 Ευρώ." + "\n"
        + emptySeatsKE + " θέσεις Κεντρικός Εξώστης (κωδικός: ΚΕ) - τιμή :30 Ευρώ." + "\n"
        + emptySeatsPTH + " θέσεις Πλαϊνά Θεωρεία (κωδικός: ΠΘ) - τιμή :20 Ευρώ.");
  }

  public String book(String type, int number, String name) throws java.rmi.RemoteException {
    int cost = 0;
    String output = "";
    int temp = number;

    if (type.equals("PA")) {

      if (number > emptySeatsPA) {
        PAWaitingList.put(name, number);
        output += "Δεν υπάρχουν αρκετές θέσεις ΠΑ. Προστέθηκε στην λίστα αναμονής.";
        return output;
      }

      for (int i = 0; i < 100; i++) {
        if (temp == 0) {
          break;
        }
        if (PA[i].equals("")) {
          PA[i] = name;
          cost += 45;
          temp--;
          emptySeatsPA--;
        }
      }
      return ("Κρατηθηκαν " + (number - temp) + " θέσεις ΠΑ. Συνολικό κόστος: " + cost + " ευρώ.");

    } else if (type.equals("PB")) {
      if (number > emptySeatsPB) {
        PBWaitingList.put(name, number);
        return "Δεν υπάρχουν αρκετές θέσεις ΠB. Προστέθηκε στην λίστα αναμονής.";
      }


      for (int i = 0; i < 200; i++) {

        if (temp == 0) {
          break;
        }

        if (PB[i].equals("")) {
          PB[i] = name;
          cost += 35;
          temp--;
        }


      }
      return "Κρατηθηκαν " + (number - temp) + " θέσεις ΠΒ. Συνολικό κόστος: " + cost + " ευρώ.";
    } else if (type.equals("PG")) {
      if (number > emptySeatsPG) {
        PGWaitingList.put(name, number);
        return "Δεν υπάρχουν αρκετές θέσεις ΠΓ. Προστέθηκε στην λίστα αναμονής.";
      }
      for (int i = 0; i < 400; i++) {
        if (temp == 0) {
          break;
        }

        if (PG[i].equals("")) {
          PG[i] = name;
          cost += 25;
          temp--;
        }
      }
      return "Κρατηθηκαν " + (number - temp) + " θέσεις ΠΓ. Συνολικό κόστος: " + cost + " ευρώ.";
    } else if (type.equals("KE")) {
      if (number > emptySeatsKE) {
        KEWaitingList.put(name, number);
        return "Δεν υπάρχουν αρκετές θέσεις KE. Προστέθηκε στην λίστα αναμονής.";
      }

      for (int i = 0; i < 225; i++) {
        if (temp == 0) {
          break;
        }

        if (KE[i].equals("")) {
          KE[i] = name;
          cost += 30;
          temp--;
        }
      }
      return "Κρατηθηκαν " + (number - temp) + " θέσεις ΚΕ. Συνολικό κόστος: " + cost + " ευρώ.";
    } else if (type.equals("PTH")) {

      if (number > emptySeatsPTH) {
        PTHWaitingList.put(name, number);
        return "Δεν υπάρχουν αρκετές θέσεις ΠΘ. Προστέθηκε στην λίστα αναμονής.";
      }
      for (int i = 0; i < 75; i++) {
        if (temp == 0) {
          break;
        }

        if (PTH[i].equals("")) {
          PTH[i] = name;
          cost += 20;
          temp--;
        }
      }
      return "Κρατηθηκαν " + (number - temp) + " θέσεις ΠΘ. Συνολικό κόστος: " + cost + " ευρώ.";
    } else {
      return "Δεν υπάρχει η ζώνη που ζητήσατε.";
    }
  }

  public String guests() throws java.rmi.RemoteException {

    for (int i = 0; i < 100; i++) {
      if (PA[i].equals("")) {
        continue;
      } else if (guestNames.contains(PA[i])) {
        guestSeats.get(guestNames.indexOf(PA[i]))[0]++;
      } else {
        int[] temp = {0, 0, 0, 0, 0};
        guestNames.add(PA[i]);
        guestSeats.add(temp);
        guestSeats.get(guestNames.indexOf(PA[i]))[0]++;
      }
    }

    for (int i = 0; i < 200; i++) {
      if (PB[i].equals("")) {
        continue;
      } else if (guestNames.contains(PB[i])) {
        guestSeats.get(guestNames.indexOf(PB[i]))[1]++;
      } else {
        int[] temp = {0, 0, 0, 0, 0};
        guestNames.add(PB[i]);
        guestSeats.add(temp);
        guestSeats.get(guestNames.indexOf(PB[i]))[1]++;
      }
    }

    for (int i = 0; i < 400; i++) {
      if (PG[i].equals("")) {
        continue;
      } else if (guestNames.contains(PG[i])) {
        guestSeats.get(guestNames.indexOf(PG[i]))[2]++;
      } else {
        int[] temp = {0, 0, 0, 0, 0};
        guestNames.add(PG[i]);
        guestSeats.add(temp);
        guestSeats.get(guestNames.indexOf(PG[i]))[2]++;
      }
    }

    for (int i = 0; i < 225; i++) {
      if (KE[i].equals("")) {
        continue;
      } else if (guestNames.contains(KE[i])) {
        guestSeats.get(guestNames.indexOf(KE[i]))[3]++;
      } else {
        int[] temp = {0, 0, 0, 0, 0};
        guestNames.add(KE[i]);
        guestSeats.add(temp);
        guestSeats.get(guestNames.indexOf(KE[i]))[3]++;
      }
    }

    for (int i = 0; i < 75; i++) {
      if (PTH[i].equals("")) {
        continue;
      } else if (guestNames.contains(PTH[i])) {
        guestSeats.get(guestNames.indexOf(PTH[i]))[4]++;
      } else {
        int[] temp = {0, 0, 0, 0, 0};
        guestNames.add(PTH[i]);
        guestSeats.add(temp);
        guestSeats.get(guestNames.indexOf(PTH[i]))[4]++;
      }
    }

    String output = "";
    for (int i = 0; i < guestNames.size(); i++) {
      output += guestNames.get(i) + ": " + guestSeats.get(i)[0] + " θέσεις ΠΑ, "
          + guestSeats.get(i)[1] + " θέσεις ΠΒ, " + guestSeats.get(i)[2] + " θέσεις ΠΓ, "
          + guestSeats.get(i)[3] + " θέσεις ΚΕ, " + guestSeats.get(i)[4] + " θέσεις ΠΘ.\n";
    }

    return output;
  }

  public String cancel(String type, int number, String name) throws java.rmi.RemoteException {
    int temp = number;
    int remaining = 0;

    if (name.equals("")) {
      return "Παρακαλώ εισάγετε ένα όνομα.";
    }

    if (type.equals("PA")) {
      for (int i = 0; i < 100; i++) {

        if (PA[i].equals(name)) {
          if (temp == 0) {
            remaining++;
          } else {
            PA[i] = "";
            emptySeatsPA++;
            temp--;
          }
        }
      }

      return name + ": Ακυρώθηκαν " + (number - temp) + " θέσεις ΠΑ." + "\nΜένουν " + remaining
          + " θέσεις ΠΑ.";
    } else if (type.equals("PB")) {
      for (int i = 0; i < 200; i++) {
        if (PB[i].equals(name)) {
          if (temp == 0) {
            remaining++;
          } else {
            PB[i] = "";
            emptySeatsPB++;
            temp--;
          }
        }
      }

      return name + ": Ακυρώθηκαν " + (number - temp) + " θέσεις ΠΒ." + "\nΜένουν " + remaining
          + " θέσεις ΠΒ.";
    } else if (type.equals("PG")) {
      for (int i = 0; i < 400; i++) {
        if (PG[i].equals(name)) {
          if (temp == 0) {
            remaining++;
          } else {
            PG[i] = "";
            emptySeatsPG++;
            temp--;
          }
        }
      }

      return name + ": Ακυρώθηκαν " + (number - temp) + " θέσεις ΠΓ." + "\nΜένουν " + remaining
          + " θέσεις ΠΓ.";
    } else if (type.equals("KE")) {
      for (int i = 0; i < 225; i++) {
        if (KE[i].equals(name)) {
          if (temp == 0) {
            remaining++;
          } else {
            KE[i] = "";
            emptySeatsKE++;
            temp--;
          }
        }
      }

      return name + ": Ακυρώθηκαν " + (number - temp) + " θέσεις ΚΕ." + "\nΜένουν " + remaining
          + " θέσεις ΚΕ.";
    } else if (type.equals("PTH")) {
      for (int i = 0; i < 75; i++) {
        if (PTH[i].equals(name)) {
          if (temp == 0) {
            remaining++;
          } else {
            PTH[i] = "";
            emptySeatsPTH++;
            temp--;
          }
        }
      }

      return name + ": Ακυρώθηκαν " + (number - temp) + " θέσεις ΠΘ." + "\nΜένουν " + remaining
          + " θέσεις ΠΘ.";
    } else {
      return "Παρακαλώ εισάγετε έναν έγκυρο τύπο θέσης.";
    }
  }
}
