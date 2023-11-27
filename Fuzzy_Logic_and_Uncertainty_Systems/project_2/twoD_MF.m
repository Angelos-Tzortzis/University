% Συνάρτηση twoD_MF(x, y, sigma_x, sigma_y, mx, my)
% που υλοποιεί την δισδιάστατη συνάρτηση συμμετοχής.
% και την εμφανίζει στην οθόνη.

function mf_xy = twoD_MF(x, y, sigma_x, sigma_y, mx, my)
% Ορίζουμε τις γκαουσιανές συναρτήσεις μ(x) και μ(y) αντίστοιχα.
gauss_x = gauss_MF(x, mx, sigma_x);
gauss_y = gauss_MF(y, my, sigma_y);

% Χρήση της συναρτησης meshgrid για την δημιουργία των ζεύγων (μ(x), μ(y)).
[mf_gauss_x, mf_gauss_y] = meshgrid(gauss_x, gauss_y);
mf_xy = mf_gauss_x.*mf_gauss_y; % μΑ(x, y).
% Μπορεί επίσης να εφαρμόσουμε τον τελεστή min καθώς είναι ανάλογος με την AND
% και εφόσον θέλουμε να βρούμε την συνάρτηση σμμετοχής
% για <<x κοντά στο mx>> ΚΑΙ <<y κοντά στο my>>.
% mf_xy = min(mf_gauss_x, mf_gauss_y); % min(μ(x), μ(y)), για κάθε (x, y).

% Απεικόνιση της συνάρτησης συμμετοχής.
mesh(x, y, mf_xy); % surf, surfl.
title('two dimensional gaussian membership function with PRODUCT connective (μΑ(x,y))');
% title('two dimensional gaussian membership function with MIN connective (μΑ(x,y))');
xlabel('x');
ylabel('y');
end
