% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Τέταρτη Εργασία.
% Ημερομηνία παράδοσης: 08/01/2024 18:00.

% Σημειώσεις:
% Έγινε τροποποίηση στην έτοιμη συνάρτηση plot_all_3, ώστε να δέχεται σαν
% ορίσματα τους τίτλους των γραφικών συναρτήσεων που σχεδιάζει.
% Οι θεωρητικές επιλύσεις βρίσκονται στο παραδοτέο σε μορφή φωτογραφίας.

close all
clear
clc

% Πεδία ορισμού x1 ε [0, 3], x2 ε [0, 200], y ε [0, 4].
x1 = linspace(0, 3, 301);
x2 = linspace(0, 200, 20001);
y = 0:4;
y_step = [0.5, 1.0, 0.01, 0.0001]; % Τα βήματα διακριτοποίησης του y.
% Βάση δύο ασαφών κανόνων με συνδετικό ALSO τον τελεστή max.
%      R1: IF x1 is A1 AND x2 is B2 THEN y is C1
% ALSO R2: IF x1 is A2 AND x2 is B1 THEN y is C2
a1 = tri_MF(x1, 0, 1, 2);      % μΑ1(x1) = tri_MF(x1; 0, 1, 2).
a2 = tri_MF(x1, 1, 1.8, 3);    % μΑ2(x1) = tri_MF(x1; 1, 1.8, 3).
b1 = tri_MF(x2, 0, 100, 200);  % μΒ1(x2) = tri_MF(x2; 0, 100, 200).
b2 = tri_MF(x2, 80, 160, 260); % μΒ2(x2) = tri_MF(x2; 80, 160, 260).
c1 = tri_MF(y, 0, 0, 4);       % μC1(y) = tri_MF(y; 0, 0, 4).
c2 = tri_MF(y, 0, 4, 4);       % μC2(y) = tri_MF(y; 0, 4, 4).

% Μετρήσεις των είσοδων του συστήματος.
x10 = 1.5; % x1,0
x20 = 120; % x2,0

% Ασαφοποιητής singleton.
% A' και B', ασαφή singletons.
% A' = 1 όταν x1 = x1,0, διαφορετικά A' = 0.
a_bar = zeros(size(x1));
a_bar(find(x1 == x10)) = 1;
% B' = 1 όταν x2 = x2,0, διαφορετικά B' = 0.
b_bar = zeros(size(x2));
b_bar(find(x2 == x20)) = 1;

% Υπολογισμός βαθμού εκπλήρωσης των κανόων.
% Χρησιμοποιούμε την έτοιμη συνάρτηση w_2_inputs που μας παράγει τo w για
% έναν κανόνα 2 εισόδων.
% Για τον 1ο κανόνα.
[w1, w1inputs] = w_2_inputs(a1, a_bar, b1, b_bar)
% Για τον 2ο κανόνα.
[w2, w2inputs] = w_2_inputs(a2, a_bar, b2, b_bar)

% Υπολογισμός των συναρτήσεων συμμετοχής C1' και C2'
% και του συνολικού συμπεράσματος C'.
% Θα υπολογιστεί και στην συνέχεια για κάθε βήμα διακριτοποίησης που
% ζητείται.
c1_bar = min(w1, c1);
c2_bar = min(w2, c2);
c_bar = max(c1_bar, c2_bar);

% Μεταβλητή που απαριθμεί τον αριθμό των εικόνων.
figure_number = 0;

% Βρόχος που εκτελείται ώστε να βρεθούν τα ζητούμενα
% για κάθε βήμα διακριτοποίησης.
for i = 1:length(y_step) % 0.5, 1.0, 0.01, 0.0001.
  % Σε κάθε έπανάληψη υπολογίζουμε ξανά τις τιμές
  % y, c1, c2,c1_bar, c2_bar, c_bar για την νέα διακριτοποίηση.
  y_i = 0:y_step(i):4;
  c1_i = tri_MF(y_i, 0, 0, 4);
  c2_i = tri_MF(y_i, 0, 4, 4);
  c1_bar_i = min(w1, c1_i);
  c2_bar_i = min(w2, c2_i);
  c_bar_i = max(c1_bar_i, c2_bar_i);

  % Απεικόνιση των συναρτήσεων.
  % A1, A', B1, B', C1, C1'.
  figure_number = figure_number + 1;
  figure(figure_number)
  plot_all_3(x1, a1, a_bar, x2, b1, b_bar, y_i, c1_i, c1_bar_i, w1inputs,...
    [sprintf("|Βήμα διακριτοποίησης %g|", y_step(i)), "A1: Blue, A': Orange, Input's firing strength: Black"],...
    "B1: Blue, B': Orange, Input's firing strength: Black",...
    "C1: Blue, C1': Filled area ")
  % A2, A', B2, B', C2, C2'.
  figure_number = figure_number + 1;
  figure(figure_number)
  plot_all_3(x1, a2, a_bar, x2, b2, b_bar, y_i, c2_i, c2_bar_i, w2inputs,...
    [sprintf("|Βήμα διακριτοποίησης %g|", y_step(i)), "A2: Blue, A': Orange, Input's firing strength: Black"],...
    "B2: Blue, B': Orange, Input's firing strength: Black",...
    "C2: Blue, C2': Filled area ")
  % C'.
  figure_number = figure_number + 1;
  figure(figure_number)
  plot(y, c_bar)
  hold on
  plot(y_i, c_bar_i, 'ro')
  axis([min(y)-0.1 max(y)+0.1 0 1])
  grid on
  title(sprintf("C' με βήμα διακριτοποίησης %g", y_step(i)))
  
  % Υπολογισμός της τελικής σαφής εξόδου y* του συστήματος
  % (ασαφοποιητής COA).
  output_y_i = sum(y_i .* c_bar_i) / sum(c_bar_i)
end

% Καθώς για κάθε από τα ζητούμενα βήματα διακριτοποίησης, οι γραφικές
% αναπαραστήσεις των συναρτήσεων και η τιμή της σαφής εξόδου y* του
% συστήματος δεν αλλάζουν, θα προτιμούσαμε να χρησιμοποιήσουμε το
% μεγαλύτερο βήμα διακριτοποίησης καθώς θα παράξει αποτέλεσμα με μεγαλύτερη
% ταχύτητα καί θα καταναλώσει λιγότερη μνήμη.
