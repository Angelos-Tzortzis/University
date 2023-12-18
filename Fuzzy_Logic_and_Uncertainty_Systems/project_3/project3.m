% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Τρίτη Εργασία.
% Ημερομηνία παράδοσης: 11/12/2023 18:00.

close all
clear
clc

% 1.
% IF x is A THEN y is B.
ux = linspace(0, 20, 2001); % xεUx = [0, 20].
uy = linspace(0, 20, 2001); % yεUy = [0, 20].

a = tri_MF(ux, 8, 12, 17); % A
b = tri_MF(uy, 9, 11, 15); % B
a_bar = trap_MF(ux, 3, 5, 7, 13); % A'

% 2.
figure(1)
plot(ux, a) % Α
hold on
plot(ux, a_bar) % Α'
title("A, A'")
hold off

figure(2)
plot(uy, b) % Β
title('B')

% 3.
% GMP
w = max(min(a, a_bar)); % w = 0.5
b_bar = min(w, b); % B'
hold on
area(uy, b_bar) % Β'
title("B, B' (GMP, Mamdani)")
hold off

% 4.
% (α).
a_bar = tri_MF(ux, 8, 12, 17); % A = A'

figure(3)
plot(ux, a) % Α
hold on
plot(ux, a_bar) % Α'
title("A, A'")
hold off

figure(4)
plot(uy, b) % Β
title('B')

w = max(min(a, a_bar)); % w = 1 (Λογικό αφού A = A').
b_bar = min(w, b);
hold on
area(uy, b_bar) % Β'
% B και Β' ταυτίζονται.
title("B, B' (GMP, Mamdani)")
hold off

% (β).
a_bar = trap_MF(ux, 2, 4, 6, 8);

figure(5)
plot(ux, a) % Α
hold on
plot(ux, a_bar) % Α'
title("A, A'")
hold off

figure(6)
plot(uy, b) % Β

w = max(min(a, a_bar)); % w = 0 (Αφού δεν υπάρχει επικάλυψη Α με Α').
b_bar = min(w, b);
hold on
area(uy, b_bar) % Β'
title("B, B' (GMP, Mamdani)")
hold off

% 5.
% R1: IF x is A1 (Slow) AND y is B1 (Very Small) THEN z is C1 (Very Large)
% R2: IF x is A2 (Fast) AND y is B2 (Small) THEN z is C2 (Small)
ux = linspace(0, 100, 10001); % xεUx = [0, 100].
uy = linspace(0, 30, 3001); % yεUy = [0, 30].
uz = linspace(0, 3, 3001); % zεUz = [0, 3].

% 5.1.
% Διαμερισμός των χώρων x, y, z.
a1 = tri_MF(ux, 0, 0, 33.33);
a2 = tri_MF(ux, 0, 33.33, 66.67);
a3 = tri_MF(ux, 33.33, 66.67, 100);
a4 = tri_MF(ux, 66.67, 100, 100);

b1 = tri_MF(uy, 0, 0, 20);
b2 = tri_MF(uy, 10, 30, 30);

c1 = tri_MF(uz, 0, 0, 2);
c2 = tri_MF(uz, 1, 3, 3);

% 5.2.
figure(7)
plot(ux, a1) % 1ος διαμερισμός του x.
hold on
plot(ux, a2) % 2ος διαμερισμός του x.
plot(ux, a3) % 3ος διαμερισμός του x.
plot(ux, a4) % 4ος διαμερισμός του x.
title("A1, A2, A3, A4")
hold off

figure(8)
plot(uy, b1) % 1ος διαμερισμός του y.
hold on
plot(uy, b2) % 2ος διαμερισμός του y.
title("B1, B2")
hold off

figure(9)
plot(uz, c1) % 1ος διαμερισμός του z.
hold on
plot(uz, c2) % 2ος διαμερισμός του z.
title("C1, C2")
hold off

% 5.3.
% Υποθέτουμε ότι το b1 είναι το σύνολο Small για το y καθώς αυτό
% περιέχει τις μικρότερες τιμές και το c2 για το Large του z καθώς
% αυτό περιέχει τις μεγαλύτερες τιμές.
% Ο λεκτικός μετασχηματιστής Very υλοποιείται με την ύψωση του συνόλου στο τετράγωνο.
very_small_y = b1.^2; % B1 Very Small
very_large_z = c2.^2; % C1 Very Large

% 6.
a_bar = tri_MF(ux, 10, 30, 50); % Α'
b_bar = tri_MF(uy, 5, 10, 15); % Β'

% GMP
% 6.1.
% Mamdani
% (α).
% R1
w1 = max(min(max(a1, a2), a_bar)); % Yποθέτουμε ώς Α1 (Slow) τους πρώτους 2 διαμερισμούς ασαφών συνόλων του χώρου x.
w2 = max(min(very_small_y, b_bar));
w_r1 = min(w1, w2); % w1 του 1ου κανόνα.
% R2
w1 = max(min(max(a3, a4), a_bar)); % Yποθέτουμε ώς Α2 (Fast) τους τελευταίους 2 διαμερισμούς ασαφών συνόλων του χώρου x.
w2 = max(min(b1, b_bar));
w_r2 = min(w1, w2); % w2 του 2ου κανόνα.

% Βγάλαμε ότι:
% A1 (Slow) = a1, a2 καθώς καλύπτουν τις μικρότερες τιμές στο x.
% A2 (Fast) = a3, a4 καθώς καλύπτουν τις μεγαλύτερες τιμές στο x.
% B2 (Small) = b1 καθώς καλύπτει τις μικρότερες τιμές στο y.
% B1 (Very Small) = very_small_y = b1.^2 προκύπτει από την εφάρμογή του
% λεκτικού μετασχηματιστή Very στο B2 (Small).
% C2 (Small) = c1 καθώς καλύπτει τις μικρότερες τιμές στο z.
% C1 (Very Large) = very_large_z = c2.^2 εφόσον c1 καλύπτει το Small τότε c2 καλύπτει το large
% και με εφαρμογή του λεκτικού σχηματιστή Very παίρνουμε Very Large.

% (β).
c1_bar = min(very_large_z, w_r1); % Από τον κανόνα R1: C1'
c2_bar = min(c1, w_r2); % Από τον κανόνα R2: C2'

% (γ).
c_bar = max(c1_bar, c2_bar); % Από τον κανόνα R1 και R2: C'

% (δ).
figure(10)
plot(uz, very_large_z) % C1 (Very Large)
hold on
area(uz, c1_bar) % C1'
title("C1 (Very Large), C1': Mamdani")
hold off

figure(11)
plot(uz, c1) % C2 (Small)
hold on
area(uz, c2_bar) % C2'
title("C2 (Small), C2': Mamdani")
hold off

figure(12)
plot(uz, max(c1, very_large_z)); % C1 v C2
hold on
area(uz, c_bar) % C'
title("C1 v C2, C': Mamdani")

% 6.2.
% Larsen
% (α).
w1 = max(min(max(a1, a2), a_bar)); % Yποθέτουμε ώς Slow τους πρώτους 2 διαμερισμούς ασαφών συνόλων του χώρου x.
w2 = max(min(very_small_y, b_bar));
w_r1 = min(w1, w2);

w1 = max(min(max(a3, a4), a_bar)); % Yποθέτουμε ώς Fast τους τελευταίους 2 διαμερισμούς ασαφών συνόλων του χώρου x.
w2 = max(min(b2, b_bar));
w_r2 = min(w1, w2);

% (β).
c1_bar = w_r1 * very_large_z; % Από τον κανόνα R1: C1'
c2_bar = w_r2 * c1; % Από τον κανόνα R2: C2'

% (γ).
c_bar = max(c1_bar, c2_bar); % Από τον κανόνα R1 και R2: C'

% (δ).
figure(13)
plot(uz, very_large_z) % C1 (Very Large)
hold on
area(uz, c1_bar) % C1'
title("C1 (Very Large), C1': Larsen")
hold off

figure(14)
plot(uz, c1) % C2 (Small)
hold on
area(uz, c2_bar) % C2'
title("C2 (Small), C2': Larsen")
hold off

figure(15)
plot(uz, max(c1, very_large_z));
hold on
area(uz, c_bar) % C'
title("C1 v C2, C': Larsen")
