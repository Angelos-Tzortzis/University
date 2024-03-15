from sklearn.datasets import load_iris
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
from sklearn import metrics

# 1.1
# Βήμα 1.
# Φόρτωση των δεδομένων του συνόλου δεδομένων Iris.
meas = load_iris().data

# Βήμα 2.
# Χρησιμοποιούνται οι 2 τελευταίες διαστάσεις του πίνακα.
X = meas[:, [2, 3]]
# Ορίζουμε τον αριθμό των συστάδων.
k = 3
# Εφαρμογή το αλγορίθμου k-means.
kmeans = KMeans(n_clusters=k).fit(X)
IDX = kmeans.labels_
C = kmeans.cluster_centers_

# Βήμα 3.
# Απεικόνιση των δεδομένων σε γραφήματα.
plt.figure(1)
# Παρουσιάζεται η κλάση που ανήκει η κάθε παρατήρηση.
plt.plot(IDX[:], 'o')
plt.show()

plt.plot(X[IDX == 0][:, 0], X[IDX == 0][:, 1],
         'limegreen', marker='o', linewidth=0, label='C1')
plt.plot(X[IDX == 1][:, 0], X[IDX == 1][:, 1],
         'yellow', marker='o', linewidth=0, label='C2')
plt.plot(X[IDX == 2][:, 0], X[IDX == 2][:, 1], '.c', marker='o', label='C3')
plt.scatter(C[:, 0], C[:, 1], marker='x', color='black',
            s=150, linewidth=3, label='Centroids', zorder=10)
plt.legend()
plt.show()

# SSE
sse = kmeans.inertia_
print("Sum of Squared Errors:", sse)

# Βρίσκουμε τις διάφορες τιμές του S.S.E. για αριθμό συστάδων από 4 έως 20
# και τις απεικονίζουμε σε γραφική παράσταση.
# Βρίσκουμε επίσης τη μέση τιμή του συντελεστή περιγράμματος για κάθε αριθμό
# συστάδων από 4 έως 20.
for i in range(4, 20 + 1):
    kmeans = KMeans(n_clusters=i).fit(X)
    sse = kmeans.inertia_
    plt.plot(i, sse, 'o', color='black')
    labels = kmeans.labels_
    silhouette_coefficient = metrics.silhouette_score(X, labels)
    print("Silhouette coefficient for", i, "clusters:", silhouette_coefficient)
plt.xlabel('Number of clusters')
plt.ylabel('SSE')
plt.show()
