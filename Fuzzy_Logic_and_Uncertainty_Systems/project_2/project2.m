% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Δεύτερη Εργασία.
% Ημερομηνία παράδοσης: 27/11/2023 18:00.

clc;
close all;
clear;


% 1.
% Ορίζουμε τα πεδία ορισμού για το x και y αντίστοιχα.
% Ux = [0, 50]
ux = linspace(0, 50, 101);
% Uy = [0, 100]
uy = linspace(0, 100, 101);


% 2.
% Δημιουργούμε τις συναρτήσεις tri_MF, trap_MF, gauss_MF, (μας δόθηκαν έτοιμες).
% Ορίζουμε τις παραμέτρους των συναρτήσεων.
x = ux;
a = 5;
b = 20;
c = 30;
d = 45;
m = 25;
sigma = 10;

% Εμφάνιση χρήσης συναρτήσεων συμμετοχής.
% Παράδειγμα χρήσης της tri_MF.
figure(1);
y = tri_MF(x, a, b, c);
plot(x, y);
title('tri-MF example (a = 5, b = 20, c = 30))');

% Παράδειγμα χρήσης της trap_MF.
figure(2);
y = trap_MF(x, a, b, c, d);
plot(x, y);
title('trap-MF example (a = 5, b = 20, c = 30, d = 45)');

% Παράδειγμα χρήσης της gauss_MF.
figure(3);
y = gauss_MF(x, m, sigma);
plot(x, y);
title('gauss-MF example (m = 25, sigma = 10)');


% 3.
% Ορίζουμε τις τιμές σx και σy (τυπική απόκλιση) για την κάθε συνάρτηση.
sigma_x = 8; % σx
sigma_y = 15; % σy


% 4.
% Ορίζουμε το κέντρο της γκαοσιανής κατανομής για κάθε συνάρτηση
% εφόσον θέλουμε <<το ζεύγος (x, y) είναι κοντά το σημείο (20, 60)>>.
mx = 20;
my = 60;

figure(4);
% Δημιουργησαμε την συνάρτηση twoD_MF η οποία υλοποιεί την
% δισδιάστατη συνάρτηση συμμετοχής .
twoD_MF(ux, uy, sigma_x, sigma_y, mx, my);
