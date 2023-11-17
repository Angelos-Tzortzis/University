% Ονοματεπώνυμο: Άγγελος Τζώρτζης.
% Αριθμός Μητρώου: ice18390094.
% Μάθημα: Συστήματα Ασαφους Λογικής & Αβεβαιότητας.
% Πρώτη Εργασία.
% Ημερομηνία παράδοσης: 17/11/2023 18:00.

close all;
clear;
clc;
format long;

% 1.
% U: Ηλικία.
x = 0:100;


% % 2.
% Δημιουργία ζευγών singleton με βάση τηv εκφώνηση της άσκησης.
% A = {(χ, μΑ(χ))|χ ε U}, μΑ(χ) = 1/(1 + (χ/15)^2).
mf(1, :) = 1./(1 + (x/15).^2);
% B = {(χ, μΒ(χ))|χ ε U}, μΒ(χ) = exp(-(χ - 45)^2/(2*15^2)).
mf(2, :) = exp(-(x - 45).^2/(2*15^2));
% C = {(χ, μC(χ))|χ ε U}, μC(χ) = 1/(1 + ((χ - 100)/20)^2).
mf(3, :) = 1./(1 + ((x - 100)/20).^2);


% % 3.
% Χρήση της συνάρτησης alpha_cuts (που μας δόθηκε)
% για την υλοποίηση των ζητούμενων της άσκησης.
% 3.1.
alpha_cuts(3, 0.005, x, mf, 1);
% 3.2.
alpha_cuts(3, 0.95, x, mf, 2);
% 3.3.
% 3.3.1.
alpha_cuts(3, 0.3, x, mf, 3);
% 3.3.2.
alpha_cuts(3, 0.7, x, mf, 4);


% 4.
% Σχεδίαση των γραφικών παραστάσεων των ζευγών singleton με τις
% κατάλληλες ετικέτες γιά την ορθή μελέτη τους.
figure(5);
plot(x, mf(1, :), 'r');
hold on;
plot(x, mf(2, :), 'g');
hold on;
plot(x, mf(3, :), 'b');
hold on;
title('Red: Low, Green: Medium, Blue: High');
axis([min(x) max(x) 0 1.1]);


% 5.
% 5.1.
figure(6);
% Με χρήση της min(), ανάμεσα σε 2 γραφικές παραστάσεις παίρνουμε
% πάντα την μίκρότερη τιμή σε κάθε σημείο του άξονα χ. Οπότε θα πάρουμε
% σε κάθε σημείο τις τιμές που ανήκουν κάι στις 2 γραφικές
% παραστάσεις άρα θα έχουμε την τομή τους.
intersection_A_B = min(mf(1, :), mf(2, :));
plot(x, intersection_A_B);
title('Intersection of A and B');
axis([min(x) max(x) 0 max(intersection_A_B)]);

figure(7);
intersection_C_B = min(mf(3, :), mf(2, :));
plot(x, intersection_C_B);
title('Intersection of C and B');
axis([min(x) max(x) 0 max(intersection_C_B)]);

% 5.2.
figure(8);
% Με χρήση της max(), ανάμεσα σε 2 γραφικές παραστάσεις παίρνουμε
% πάντα την μεγαλύτερη τιμή σε κάθε σημείο του άξονα χ. Οπότε θα πάρουμε
% σε κάθε σημείο τις τιμές που ανήκουν έστω σε μία απο τις 2 γραφικές
% παραστάσεις άρα θα έχουμε την ένωση τους.
union_A_B = max(mf(1, :), mf(2, :));
plot(x, union_A_B);
title('Union of A and B');
axis([min(x) max(x) 0 max(union_A_B)]);

figure(9);
union_B_C = max(mf(2, :), mf(3, :));
plot(x, union_B_C);
title('Union of B and C');
axis([min(x) max(x) 0 max(union_B_C)]);

% 5.3.
figure(10);
% Γνωρίζουμε ότι το συμπλήρωμα βγαίνει απο τον τύπο: Β' = 1 - Β
% οπότε αφαιρώντας απο το ένα κάθε σημείο της γραφικής παράστασης
% προκύπτει το συμπλήρωμα.
complement_B = 1 - mf(2, :);
plot(x, complement_B);
title('Complement of B');
axis([min(x) max(x) 0 max(complement_B)]);


% 6.
% 6.1.
for i = 1:3
  fprintf('The cardinality of fuzzy set no.%d is %g.\n', i, sum(mf(i, :)));
end
fprintf('\nThe cardinality of the intersection of A and B is: %g.\n', sum(intersection_A_B));
fprintf('The cardinality of the intersection of C and B is: %g.\n', sum(intersection_C_B));
fprintf('The cardinality of the union of A and B is: %g.\n', sum(union_A_B));
fprintf('The cardinality of the union of B and C is: %g.\n', sum(union_B_C));
% Βλέπουμε οτι τα μεγέθη των τομών είναι αρκετα μικρότερα απο αυτα των συνόλων
% το οποίο λογικό καθώς π.χ.: Το Α εκφράζει <<νέος>> και το Β εκφράζει <<μεσήλικας>>,
% και η ένωση τους κάποιος που εκφράζεται ώς <<νέος και μεσήλικας>> οπότε είναι ανάμενόμενο
% αμα σκεφτούμε ότι πήραμε και το μικρότερος μέγεθος και κάθε σημείο των 2 γραφικών παραστάσεων.
% Το ίδιο ισχύει για την τομή C και B γία <<ηλικιωμένος>> και <<μεσήλικας>> αντίστοιχα.

% 6.2.
% Υπολογίσουμε τα μέτρα γειτονείας με την συνάρτηση subsethood_measure() που μας δόθηκε.
% S(A, B)
subsethood = subsethood_measure(mf(1, :), mf(2, :));
fprintf('\nThe subsethood measure of fuzzy sets A and B is: %g.\n', subsethood);
% S(C, A)
subsethood = subsethood_measure(mf(3, :), mf(1, :));
% S(A, C)
fprintf('The subsethood measure of fuzzy sets C and A is: %g.\n', subsethood);
subsethood = subsethood_measure(mf(1, :), mf(3, :));
% Σημειώνουμε ότι S(A, C) != S(C, A) και φαίνεται απο τα αποτελέσματα.
fprintf('The subsethood measure of fuzzy sets A and C is: %g.\n', subsethood);
% S(C, B)
subsethood = subsethood_measure(mf(3, :), mf(2, :));
fprintf('The subsethood measure of fuzzy sets C and B is: %g.\n', subsethood);

% 6.3.
% Υπολογίσουμε τα μέτρα ομοιότητας με την συνάρτηση similarity_measure() που μας δόθηκε.
% E(A, B)
similarity = similarity_measure(mf(1, :), mf(2, :));
fprintf('\nThe similarity measure of fuzzy sets A and B is: %g.\n', similarity);
% E(A, C)
similarity = similarity_measure(mf(1, :), mf(3, :));
fprintf('The similarity measure of fuzzy sets A and C is: %g.\n', similarity);
% E(B, C)
similarity = similarity_measure(mf(2, :), mf(3, :));
fprintf('The similarity measure of fuzzy sets B and C is: %g.\n', similarity);
