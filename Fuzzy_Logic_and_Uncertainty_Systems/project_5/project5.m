% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Πέμπτη Εργασία.
% Ημερομηνία παράδοσης: 15/01/2024 18:00.

close all
clear
clc

% Εδώ ορίζουμε τον αριθμό των κανόνων και τω εισόδων και εξόδων του ασαφούς
% συστήματος.
rule_number = 7;
output_sets = 5;

% Μπορούμε να αλλάξουμε τις τιμές του συντελεστή επικάλυψης για την
% υλοποίηση του ερωτήματος 2.
overlapping_coefficient = 0.5;
% overlapping_coefficient = 0.3;
% overlapping_coefficient = 0.4;
% overlapping_coefficient = 0.6;

% 1.
% 1.1.
x = 0:1:360; % x ε X = [0, 360] (σε μοίρες).
y = linspace(-0.4, 1, 361); % y ε Y = [-0.4, 1].
z = (1/2)*sin(2*pi*x/360) + (1/2)*sin(2*pi*(x + 30)/360).^2;

% Ομοιόμορφη κατανομή του χώρου εισόδου.
figure(1)
axis([min(x) max(x) 0 1.05])
title('Διαμερισμός του x')
hold on
[alpha, beta , gamma] = tri_MF_partition(min(x), max(x), rule_number, overlapping_coefficient);
for k = 1:rule_number
  mf_x(k, :) = tri_MF(x, alpha(k), beta(k), gamma(k));
  plot(x, mf_x(k, :))
end
hold off

% Ομοιόμορφη κατανομή του χώρου εξόδου.
figure(2)
axis([min(y) max(y) 0 1.05])
title('Διαμερισμός του y')
hold on
[alpha, beta , gamma] = tri_MF_partition(min(y), max(y), output_sets, overlapping_coefficient);
for k = 1:output_sets
  mf_y(k, :) = tri_MF(y, alpha(k), beta(k), gamma(k));
  plot(y, mf_y(k, :))
end
hold off

% Βάση κανόνων, αντιστοίχιση των ασαφών συνόλων στα σύνολα των κανόνων. 
in(1, :) = mf_x(1, :);
in(2, :) = mf_x(2, :);
in(3, :) = mf_x(3, :);
in(4, :) = mf_x(4, :);
in(5, :) = mf_x(5, :);
in(6, :) = mf_x(6, :);
in(7, :) = mf_x(7, :);

out(1, :) = mf_y(3, :);
out(2, :) = mf_y(5, :);
out(3, :) = mf_y(4, :);
out(4, :) = mf_y(3, :);
out(5, :) = mf_y(2, :);
out(6, :) = mf_y(1, :);
out(7, :) = mf_y(2, :);

% 1.2.
for j = 1:length(x)
  for i = 1:rule_number
    bbar(i, :) = min(in(i, j), out(i, :));
  end
    
  % Συνολική έξοδος της βάσης κανόνων.
  total = bbar(1, :);

  for i = 2:rule_number
    total = max(total, bbar(i, :));
  end
  % Αποσαφοποιητής COA.
  output(j) = sum(y.*total)/sum(total);
end

% Σχεδιασμός των γραφικών παραστάσεων.
figure(3);
plot(x, z, 'b', x, output, 'r--')
title(sprintf('Μπλε: 1/2*sin(2*pi*x/360) + 1/2*sin(2*pi*(x + 30)/360)^2\nΚόκκινο: Έξοδος του ασαφούς συστήματος\nOverlapping Coefficient: %.1f', overlapping_coefficient))

% 2.

% 3.
% Ορίζουμε τις νέες παραμέτρους για την δικιά μας βάση κανόνων.
% Οι τιμές x, y, z δεν αλλάζουν.
rule_number = 18;
output_sets = 8;
overlapping_coefficient = 0.5;

figure(4)
axis([min(x) max(x) 0 1.05])
title('Διαμερισμός του x')
hold on
[alpha, beta , gamma] = tri_MF_partition(min(x), max(x), rule_number, overlapping_coefficient);
for k = 1:rule_number
  mf_x(k, :) = tri_MF(x, alpha(k), beta(k), gamma(k));
  plot(x, mf_x(k, :))
end
hold off

figure(5)
axis([min(y) max(y) 0 1.05])
title('Διαμερισμός του y')
hold on
[alpha, beta , gamma] = tri_MF_partition(min(y), max(y), output_sets, overlapping_coefficient);
for k = 1:output_sets
  mf_y(k, :) = tri_MF(y, alpha(k), beta(k), gamma(k));
  plot(y, mf_y(k, :))
end
hold off

in(1, :) = mf_x(1, :); in(2, :) = mf_x(2, :); in(3, :) = mf_x(3, :);
in(4, :) = mf_x(4, :); in(5, :) = mf_x(5, :); in(6, :) = mf_x(6, :);
in(7, :) = mf_x(7, :); in(8, :) = mf_x(8, :); in(9, :) = mf_x(9, :);
in(10, :) = mf_x(10, :); in(11, :) = mf_x(11, :); in(12, :) = mf_x(12, :);
in(13, :) = mf_x(13, :); in(14, :) = mf_x(14, :); in(15, :) = mf_x(15, :);
in(16, :) = mf_x(16, :); in(17, :) = mf_x(17, :); in(18, :) = mf_x(18, :);

out(1, :) = mf_y(4, :); out(2, :) = mf_y(5, :); out(3, :) = mf_y(6, :);
out(4, :) = mf_y(8, :); out(5, :) = mf_y(8, :); out(6, :) = mf_y(7, :);
out(7, :) = mf_y(6, :); out(8, :) = mf_y(5, :); out(9, :) = mf_y(4, :);
out(10, :) = mf_y(4, :); out(11, :) = mf_y(4, :); out(12, :) = mf_y(3, :);
out(13, :) = mf_y(3, :); out(14, :) = mf_y(2, :); out(15, :) = mf_y(2, :);
out(16, :) = mf_y(1, :); out(17, :) = mf_y(2, :); out(18, :) = mf_y(3, :);

for j = 1:length(x)
  for i = 1:rule_number
    bbar(i, :) = min(in(i, j), out(i, :));
  end

  total = bbar(1, :);

  for i = 2:rule_number
    total = max(total, bbar(i, :));
  end

  output(j) = sum(y.*total)/sum(total);
end

figure(6);
plot(x, z, 'b', x, output, 'r--')
title(sprintf('Μπλε: 1/2*sin(2*pi*x/360) + 1/2*sin(2*pi*(x + 30)/360)^2\nΚόκκινο: Έξοδος του ασαφούς συστήματος\nOverlapping Coefficient: %.1f', overlapping_coefficient))
