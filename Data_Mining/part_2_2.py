from sklearn.datasets import load_iris
from sklearn.cluster import DBSCAN
import matplotlib.pyplot as plt
from scipy.stats import zscore
import numpy as np

# 2.2
# Βήμα 1.
# Φόρτωση των δεδομένων iris και χρήση των διαστάσεων 2 και 3.
meas = load_iris().data
X = meas[:, [2, 3]]

# Βήμα 2.
# Εκτέλεση του αλγορίθμου DBSCAN με τις παραμέτρους ε=0.1 και MinPts=5.
dbscan = DBSCAN(eps=0.1, min_samples=5).fit(X)
IDX = dbscan.labels_

# Βήμα 3.
# Παρουσίαση σε γράφημα διασποράς τις δύο διαστάσεις του πίνακα X.
plt.figure(1)
plt.scatter(X[:, 0], X[:, 1])
plt.show()

# Βήμα 4.
# Παρουσίαση σε γράφημα τις συστάδες που προέκυψαν από τον αλγόριθμο DBSCAN.
plt.figure(2)
plt.scatter(X[:, 0], X[:, 1], c=IDX)
plt.show()

# Βήμα 5.
# Επαναλαμβάνουμε μετα την κανονικοποίηση των δεδομένων με την μέθοδο zscore.
xV1 = zscore(X[:,0])
xV2 = zscore(X[:,1])
Xnew = np.transpose(np.array([xV1,xV2]))
dbscan = DBSCAN(eps=0.1, min_samples=5).fit(Xnew)
IDX = dbscan.labels_
plt.figure(3)
plt.scatter(Xnew[:,0],Xnew[:,1], c=IDX)
plt.show()
