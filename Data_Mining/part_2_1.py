import scipy.io
import numpy as np
from sklearn.cluster import DBSCAN
import matplotlib.pyplot as plt

# 2.1.
# Βήμα 1.
# Φόρτωση των δεδομένων mydata.mat.
mat_file = scipy.io.loadmat('mydata.mat')
X = np.array(mat_file['X'])

# Βήμα 2.
# Εκτέλεση της DBSCAN στις 2 πρώτες διαστάσεις του πίνακα με παραμέτρους
# ε = 0.5 και ΜinPts = 15.
dbscan = DBSCAN(eps=0.5, min_samples=15).fit(X)
IDX = dbscan.labels_

# Bήμα 3.
# Παρουσιάζουμε σε γράφημα διασποράς τις τιμές των 2 διαστάσεων του πίνακα.
plt.figure(1)
plt.scatter(X[:, 0], X[:, 1])
plt.show()

# Βήμα 4.
# Παρουσίαση σε δεύτερο γράφημα τις συστάδες που χώρισε η
# DBSCAN και τον θόρυβο.
plt.figure(2)
plt.scatter(X[:, 0], X[:, 1], c=IDX)
plt.show()
