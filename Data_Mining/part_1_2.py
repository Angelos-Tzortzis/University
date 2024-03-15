import scipy.io
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# 1.2
# Βήμα 1.
# Φόρτωση των δεδομένων του συνόλου δεδομένων xV από το αρχείο
# 'xV.mat'.
mat_file = scipy.io.loadmat('xV.mat')
xV = np.array(mat_file['xV'])

# Βήμα 2.
# Χρησιμοποιούνται τα 2 πρώτα χαρακτηριστικά του πίνακα.
# X = xV[:, [0, 1]] # Bήμα 2.
# X = xV[:, [296, 305]] # Bήμα 3.
X = xV[:, [-2, -1]] # Bήμα 4.
# X = xV[:, [205, 175]] # Bήμα 5.
# Ορίζουμε τον αριθμό των συστάδων.
k = 3
# Εφαρμογή το αλγορίθμου k-means.
kmeans = KMeans(n_clusters=k).fit(X)
IDX = kmeans.labels_
C = kmeans.cluster_centers_

# Απεικόνιση των δεδομένων σε γραφήματα.
plt.plot(X[IDX == 0][:, 0], X[IDX == 0][:, 1],
         'limegreen', marker='o', linewidth=0, label='C1')
plt.plot(X[IDX == 1][:, 0], X[IDX == 1][:, 1],
         'yellow', marker='o', linewidth=0, label='C2')
plt.plot(X[IDX == 2][:, 0], X[IDX == 2][:, 1], '.c', marker='o', label='C3')
plt.scatter(C[:, 0], C[:, 1], marker='x', color='black',  # type: ignore
            s=150, linewidth=3, label='Centroids', zorder=10)
plt.legend()
plt.show()

# SSE
sse = kmeans.inertia_
print("Sum of Squared Errors:", sse)
