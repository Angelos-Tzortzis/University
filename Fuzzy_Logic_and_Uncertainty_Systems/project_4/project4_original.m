% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Τέταρτη Εργασία.
% Ημερομηνία παράδοσης: 08/01/2024 18:00.

close all
clear
clc

% Πεδία ορισμού x1 ε [0, 3], x2 ε [0, 200], y ε [0, 4].
x1 = linspace(0, 3, 301);
x2 = linspace(0, 200, 20001);
y = linspace(0, 4, 5);

% Βάση δύο ασαφών κανόνων με συνδετικό ALSO τον τελεστή max.
%      R1: IF x1 is A1 AND x2 is B2 THEN y is C1
% ALSO R2: IF x1 is A2 AND x2 is B1 THEN y is C2
a1 = tri_MF(x1, 0, 1, 2);      % μΑ1(x1) = tri_MF(x1; 0, 1, 2).
a2 = tri_MF(x1, 1, 1.8, 3);    % μΑ2(x1) = tri_MF(x1; 1, 1.8, 3).
b1 = tri_MF(x2, 0, 100, 200);  % μΒ1(x2) = tri_MF(x2; 0, 100, 200).
b2 = tri_MF(x2, 80, 160, 260); % μΒ2(x2) = tri_MF(x2; 80, 160, 260).

c1 = tri_MF(y, 0, 0, 4);       % μC1(y) = tri_MF(y; 0, 0, 4).
c2 = tri_MF(y, 0, 4, 4);       % μC2(y) = tri_MF(y; 0, 4, 4).

% Βήμα διακριτοποίησης 0.5.
y0_5 = 0:0.5:4;
c1_0_5 = tri_MF(y0_5, 0, 0, 4);
c2_0_5 = tri_MF(y0_5, 0, 4, 4);

% Βήμα διακριτοποίησης 1.0.
y1_0 = 0:1:4;
c1_1_0 = tri_MF(y1_0, 0, 0, 4);
c2_1_0 = tri_MF(y1_0, 0, 4, 4);

% Βήμα διακριτοποίησης 0.01.
y0_01 = 0:0.01:4;
c1_0_01 = tri_MF(y0_01, 0, 0, 4);
c2_0_01 = tri_MF(y0_01, 0, 4, 4);

% Βήμα διακριτοποίησης 0.0001.
y0_0001 = 0:0.0001:4;
c1_0_0001 = tri_MF(y0_0001, 0, 0, 4);
c2_0_0001 = tri_MF(y0_0001, 0, 4, 4);


x10 = 1.5; %x1,0
x20 = 120; %x2,0

% Ασαφοποιητής singleton.
% A' και B', ασαφή singletons.
% A' = 1 όταν x1 = x1,0, διαφορετικά A' = 0.
a_bar = zeros(size(x1));
a_bar(find(x1 == x10)) = 1;
% B' = 1 όταν x2 = x2,0, διαφορετικά B' = 0.
b_bar = zeros(size(x2));
b_bar(find(x2 == x20)) = 1;

% Υπολογισμός βαθμού εκπλήρωσης των κανόων.
% Χρησιμοποιούμε την έτοιμη συνάρτηση w_2_inputs που μας παράγει τo w για έναν κανόνα 2 εισόδων.
% Για τον 1ο κανόνα.
[w1, w1inputs] = w_2_inputs(a1, a_bar, b1, b_bar);
% Για τον 2ο κανόνα.
[w2, w2inputs] = w_2_inputs(a2, a_bar, b2, b_bar);

% Υπολογισμός των συναρτήσεων συμμετοχής C1' και C2'
% και του συνολικού συμπεράσματος C'.
c1_bar = min(w1, c1);
c2_bar = min(w2, c2);
c_bar = max(c1_bar, c2_bar);

% Βήμα διακριτοποίησης 0.5.
c1_bar_0_5 = min(w1, c1_0_5);
c2_bar_0_5 = min(w2, c2_0_5);
c_bar_0_5 = max(c1_bar_0_5, c2_bar_0_5);

% Βήμα διακριτοποίησης 1.0.
c1_bar_1_0 = min(w1, c1_1_0);
c2_bar_1_0 = min(w2, c2_1_0);
c_bar_1_0 = max(c1_bar_1_0, c2_bar_1_0);

% Βήμα διακριτοποίησης 0.01.
c1_bar_0_01 = min(w1, c1_0_01);
c2_bar_0_01 = min(w2, c2_0_01);
c_bar_0_01 = max(c1_bar_0_01, c2_bar_0_01);

% Βήμα διακριτοποίησης 0.0001.
c1_bar_0_0001 = min(w1, c1_0_0001);
c2_bar_0_0001 = min(w2, c2_0_0001);
c_bar_0_0001 = max(c1_bar_0_0001, c2_bar_0_0001);


% Απεικόνιση των συναρτήσεων.
% Βήμα διακριτοποίησης 0.5.
% A1, A2, B1, B2, A', B', C1, C2, C1', C2'.
figure(1)
plot_all_3(x1, a1, a_bar, x2, b1, b_bar, y0_5, c1_0_5, c1_bar_0_5, w1inputs,...
  ["|Βήμα διακριτοποίησης 0.5|", "A1: Blue, A': Orange, Input's firing strength: Black"],...
  "B1: Blue, B': Orange, Input's firing strength: Black",...
  "C1: Blue, C': Filled area ")
figure(2)
plot_all_3(x1, a2, a_bar, x2, b2, b_bar, y0_5, c2_0_5, c2_bar_0_5, w2inputs,...
  ["|Βήμα διακριτοποίησης 0.5|", "A2: Blue, A': Orange, Input's firing strength: Black"],...
  "B2: Blue, B': Orange, Input's firing strength: Black",...
  "C2: Blue, C': Filled area ")

% Έξοδος C'.
figure(3)
plot(y, c_bar)
hold on
plot(y0_5, c_bar_0_5, 'ro')
axis([min(y)-0.1 max(y)+0.1 0 1])
grid on
title("C' με βήμα διακριτοποίησης 0.5.")


% Βήμα διακριτοποίησης 1.0.
% A1, A2, B1, B2, A', B', C1, C2, C1', C2'.
figure(4)
plot_all_3(x1, a1, a_bar, x2, b1, b_bar, y1_0, c1_1_0, c1_bar_1_0, w1inputs,...
  ["|Βήμα διακριτοποίησης 1.0|", "A1: Blue, A': Orange, Input's firing strength: Black"],...
  "B1: Blue, B': Orange, Input's firing strength: Black",...
  "C1: Blue, C': Filled area ")
figure(5)
plot_all_3(x1, a2, a_bar, x2, b2, b_bar, y1_0, c2_1_0, c2_bar_1_0, w2inputs,...
  ["|Βήμα διακριτοποίησης 1.0|", "A2: Blue, A': Orange, Input's firing strength: Black"],...
  "B2: Blue, B': Orange, Input's firing strength: Black",...
  "C2: Blue, C': Filled area ")

% Έξοδος C'.
figure(6)
plot(y, c_bar)
hold on
plot(y1_0, c_bar_1_0, 'ro')
axis([min(y)-0.1 max(y)+0.1 0 1])
grid on
title("C' με βήμα διακριτοποίησης 1.0.")


% Βήμα διακριτοποίησης 0.01.
% A1, A2, B1, B2, A', B', C1, C2, C1', C2'.
figure(7)
plot_all_3(x1, a1, a_bar, x2, b1, b_bar, y0_01, c1_0_01, c1_bar_0_01, w1inputs,...
  ["|Βήμα διακριτοποίησης 0.01|", "A1: Blue, A': Orange, Input's firing strength: Black"],...
  "B1: Blue, B': Orange, Input's firing strength: Black",...
  "C1: Blue, C': Filled area ")
figure(8)
plot_all_3(x1, a2, a_bar, x2, b2, b_bar, y0_01, c2_0_01, c2_bar_0_01, w2inputs,...
  ["|Βήμα διακριτοποίησης 0.01|", "A2: Blue, A': Orange, Input's firing strength: Black"],...
  "B2: Blue, B': Orange, Input's firing strength: Black",...
  "C2: Blue, C': Filled area ")

% Έξοδος C'.
figure(9)
plot(y, c_bar)
hold on
plot(y0_01, c_bar_0_01, 'ro')
axis([min(y)-0.1 max(y)+0.1 0 1])
grid on
title("C' με βήμα διακριτοποίησης 0.01.")


% Βήμα διακριτοποίησης 0.0001.
% A1, A2, B1, B2, A', B', C1, C2, C1', C2'.
figure(10)
plot_all_3(x1, a1, a_bar, x2, b1, b_bar, y0_0001, c1_0_0001, c1_bar_0_0001, w1inputs,...
  ["|Βήμα διακριτοποίησης 0.0001|", "A1: Blue, A': Orange, Input's firing strength: Black"],...
  "B1: Blue, B': Orange, Input's firing strength: Black",...
  "C1: Blue, C': Filled area ")
figure(11)
plot_all_3(x1, a2, a_bar, x2, b2, b_bar, y0_0001, c2_0_0001, c2_bar_0_0001, w2inputs,...
  ["|Βήμα διακριτοποίησης 0.0001|", "A2: Blue, A': Orange, Input's firing strength: Black"],...
  "B2: Blue, B': Orange, Input's firing strength: Black",...
  "C2: Blue, C': Filled area ")

% Έξοδος C'.
figure(12)
plot(y, c_bar)
hold on
plot(y0_0001, c_bar_0_0001, 'ro')
axis([min(y)-0.1 max(y)+0.1 0 1])
grid on
title("C' με βήμα διακριτοποίησης 0.0001.")


% Υπολογισμός της τελικής σαφής εξόδου y* του συστήματος.
% Βήμα διακριτοποίησης 0.5.
output_y_0_5 = sum(y0_5.*c_bar_0_5)/sum(c_bar_0_5)
% Βήμα διακριτοποίησης 1.0.
output_y_1_0 = sum(y1_0.*c_bar_1_0)/sum(c_bar_1_0)
% Βήμα διακριτοποίησης 0.01.
output_y_0_01 = sum(y0_01.*c_bar_0_01)/sum(c_bar_0_01)
% Βήμα διακριτοποίησης 0.0001.
output_y_0_0001 = sum(y0_0001.*c_bar_0_0001)/sum(c_bar_0_0001)
