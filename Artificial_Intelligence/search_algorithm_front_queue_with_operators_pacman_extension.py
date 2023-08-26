""" ----------------------------------------------------------------------------
******** Search Code for DFS  and other search methods
******** (expanding front only)
******** author:  AI lab
********
******** Κώδικας για DFS και άλλες μεθόδους αναζήτησης
******** (επέκταση μετώπου μόνο)
******** Συγγραφέας: Εργαστήριο ΤΝ
"""

import copy
import sys

# Για ποιο όμορφη εμφάνιση των αποτελεσμάτων μετώπου και της ουράς.
from pprint import pprint

sys.setrecursionlimit(10**6)

""" ----------------------------------------------------------------------------
**** Problem depending functions
**** ο κόσμος του προβλήματος (αν απαιτείται) και υπόλοιπες συναρτήσεις σχετικές με το πρόβλημα

#### to be  added ####
"""


""" Helper functions for checking operator's conditions """


# Ελέγχουμε κάθε "κελί" του πλέγματος, και αν υπάρχει το 'p' (ο pacman),
# και η τιμή των φρούτων είναι μεγαλύτερη του 0 τότε μπορεί να φαγωθεί φρούτο.
def can_eat(state):
    for i in range(len(state)):
        for j in range(len(state[i])):
            if state[i][j][0] == "p" and state[i][j][1] > 0:
                return 1


# Ελέγχουμε εάν μπορεί να μετακινηθεί ο pacman δεξιά. Δηλαδή εάν βρίσκεται στην
# τελευταία στήλη του πλέγματος δεν μπορεί να πάει δεξιά. Σε οποιαδήποτε άλλη
# περίπτωση μπορεί.
def can_move_right(state):
    for i in range(len(state)):
        if state[i][len(state[i]) - 1][0] == "p":
            return False
    return True


# Ελέγχουμε εάν μπορεί να μετακινηθεί ο pacman αριστερά. Δηλαδή εάν βρίσκεται
# στην πρώτη στήλη του πλέγματος δεν μπορεί να πάει αριστερά. Σε οποιαδήποτε
# άλλη περίπτωση μπορεί.
def can_move_left(state):
    for i in range(len(state)):
        if state[i][0][0] == "p":
            return False
    return True


# Ελέγχουμε εάν μπορεί να μετακινηθεί ο pacman προς τα πάνω. Δηλαδή εάν
# βρίσκεται στην πρώτη γραμμή του πλέγματος δεν μπορεί να πάει πάνω. Σε
# οποιαδήποτε άλλη περίπτωση μπορεί.
def can_move_up(state):
    for i in range(len(state[0])):
        if state[0][i][0] == "p":
            return False
    return True


# Ελέγχουμε εάν μπορεί να μετακινηθεί ο pacman προς τα κάτω. Δηλαδή εάν
# βρίσκεται στην τελευταία γραμμή του πλέγματος δεν μπορεί να πάει κάτω. Σε
# οποιαδήποτε άλλη περίπτωση μπορεί.
def can_move_down(state):
    for i in range(len(state[0])):
        if state[len(state) - 1][i][0] == "p":
            return False
    return True


""" Operator function: eat, move right, move left """


# Ελέγχουμε εάν ο pacman βρίσκεται σε κελί με αριθμό φρούτων μεγαλύτερο από 0,
# εάν είναι τότε μειώνεται ο αριθμός φρούτων
def eat(state):
    if can_eat(state):
        for i in range(len(state)):
            for j in range(len(state[i])):
                if state[i][j][0] == "p" and state[i][j][1] > 0:
                    state[i][j][1] -= 1
                    return state
    else:
        return None


# Ελέγχουμε εάν ο pacman βρίσκεται σε κελί που του επιτρέπει να μετακινηθεί
# δεξιά, εάν είναι τότε μετακινείται μία θέση δεξιά.
def move_right(state):
    if can_move_right(state):
        for i in range(len(state)):
            for j in range(len(state[i])):
                if state[i][j][0] == "p":
                    state[i][j][0] = " "
                    state[i][j + 1][0] = "p"
                    return state
    else:
        return None


# Ελέγχουμε εάν ο pacman βρίσκεται σε κελί που του επιτρέπει να μετακινηθεί
# αριστερά, εάν είναι τότε μετακινείται μία θέση αριστερά.
def move_left(state):
    if can_move_left(state):
        for i in range(len(state)):
            for j in range(len(state[i])):
                if state[i][j][0] == "p":
                    state[i][j][0] = " "
                    state[i][j - 1][0] = "p"
                    return state
    else:
        return None


# Ελέγχουμε εάν ο pacman βρίσκεται σε κελί που του επιτρέπει να μετακινηθεί
# πάνω, εάν είναι τότε μετακινείται μία θέση πάνω.
def move_up(state):
    if can_move_up(state):
        for i in range(len(state)):
            for j in range(len(state[i])):
                if state[i][j][0] == "p":
                    state[i][j][0] = " "
                    state[i - 1][j][0] = "p"
                    return state
    else:
        return None


# Ελέγχουμε εάν ο pacman βρίσκεται σε κελί που του επιτρέπει να μετακινηθεί
# κάτω, εάν είναι τότε μετακινείται μία θέση κάτω.
def move_down(state):
    if can_move_down(state):
        for i in range(len(state)):
            for j in range(len(state[i])):
                if state[i][j][0] == "p":
                    state[i][j][0] = " "
                    state[i + 1][j][0] = "p"
                    return state
    else:
        return None


""" Function that checks if current state is a goal state """


# Εδώ αντί να θέλουμε να έχουμε μία συγκεκριμένη τελική κατάσταση, μας αρκεί
# απλά να έχουμε κατάσταση που δεν υπάρχουν φρούτα στο πλέγμα ώς τελική. Οπότε
# ελέγχουμε όλο το πλέγμα για φρούτα και άν σε όλα τα κελιά είναι 0 τότε έχουμε
# τελική κατάσταση.
def is_goal_state(state):
    for i in range(len(state)):
        for j in range(len(state[i])):
            if state[i][j][1] > 0:
                return 0
    return 1


""" Function that finds the children of current state """


# Συνάρτηση ώστε να βρούμε τις καταστάσεις παιδιών απο κάθε κατάσταση γονέα.
def find_children(state):
    children = []

    # Δημιουργούμε κατάσταση για κάθε πιθανό σενάριο κίνησης του pacman.
    right_state = copy.deepcopy(state)
    child_right = move_right(right_state)
    left_state = copy.deepcopy(state)
    child_left = move_left(left_state)
    up_state = copy.deepcopy(state)
    child_up = move_up(up_state)
    down_state = copy.deepcopy(state)
    child_down = move_down(down_state)
    eat_state = copy.deepcopy(state)
    child_eat = eat(eat_state)

    # Εάν είναι έγκυρες αυτές οι καταστάσεις τις προσθέτουμε στη λίστα των
    # καταστάσεων παιδιών.
    if child_eat is not None:
        children.append(child_eat)
    if child_up is not None:
        children.append(child_up)
    if child_down is not None:
        children.append(child_down)
    if child_left is not None:
        children.append(child_left)
    if child_right is not None:
        children.append(child_right)

    return children


def make_front(state):
    return [state]


""" ----------------------------------------------------------------------------
**** FRONT
**** Διαχείριση Μετώπου
"""

""" ----------------------------------------------------------------------------
** initialization of front
** Αρχικοποίηση Μετώπου
"""


def make_front(state):
    return [state]


""" ----------------------------------------------------------------------------
**** expanding front
**** επέκταση μετώπου
"""


# Επέκταση μετώπου με διάφορες περιπτώσεις ανάλογα με τον αλγόριθμο αναζήτησης
# που θέλουμε να χρησιμοποιήσουμε.
def expand_front(front, method):
    if method == "DFS":
        if front:
            print("Front:")
            for i in range(len(front)):
                pprint(front[i])
                print()
            print()
            node = front.pop(0)
            for child in find_children(node):
                # DFS εισάγει νέα κατάσταση στην αρχή της λίστας.
                front.insert(0, child)
    elif method == "BFS":
        if front:
            print("Front:")
            for i in range(len(front)):
                pprint(front[i])
                print()
            print()
            node = front.pop(0)
            for child in find_children(node):
                # BFS εισάγει νέα κατάσταση στο τέλος της λίστας.
                front.append(child)

    return front


""" ----------------------------------------------------------------------------
**** QUEUE
**** Διαχείριση ουράς
"""

""" ----------------------------------------------------------------------------
** initialization of queue
** Αρχικοποίηση ουράς
"""


def make_queue(state):
    return [[state]]


""" ----------------------------------------------------------------------------
**** expanding queue
**** επέκταση ουράς
"""


# Επέκταση ουράς με διάφορες περιπτώσεις ανάλογα με τον αλγόριθμο αναζήτησης
# που θέλουμε να χρησιμοποιήσουμε.
def extend_queue(queue, method):
    if method == "DFS":
        print("Queue:")
        for i in range(len(queue)):
            pprint(queue[i])
            print()
        print()
        node = queue.pop(0)
        queue_copy = copy.deepcopy(queue)
        children = find_children(node[-1])
        for child in children:
            path = copy.deepcopy(node)
            path.append(child)
            # DFS εισάγει νέα κατάσταση στην αρχή της λίστας.
            queue_copy.insert(0, path)
        return queue_copy
    elif method == "BFS":
        print("Queue:")
        for i in range(len(queue)):
            pprint(queue[i])
            print()
        print()
        node = queue.pop(0)
        queue_copy = copy.deepcopy(queue)
        children = find_children(node[-1])
        for child in children:
            path = copy.deepcopy(node)
            path.append(child)
            # BFS εισάγει νέα κατάσταση στο τέλος της λίστας.
            queue_copy.append(path)
        return queue_copy


""" ----------------------------------------------------------------------------
**** Basic recursive function to create search tree (recursive tree expansion)
**** Βασική αναδρομική συνάρτηση για δημιουργία δέντρου αναζήτησης (αναδρομική επέκταση δέντρου)
"""


# Συνάρτηση που δημιουργεί το δέντρο αναζήτησης, ώστε να βρεθεί η λύση στο
# πρόβλημα.
def find_solution(front, queue, closed, method):
    if not front:
        print("No solution")
    elif front[0] in closed:
        new_front = copy.deepcopy(front)
        new_front.pop(0)
        new_queue = copy.deepcopy(queue)
        new_queue.pop(0)
        find_solution(new_front, new_queue, closed, method)
    elif is_goal_state(front[0]):
        print("Goal found")
        # pprint(front[0])
        for i in range(len(queue)):
            pprint(queue[i])
            print()
        print()
    else:
        closed.append(front[0])
        front_copy = copy.deepcopy(front)
        front_children = expand_front(front_copy, method)
        queue_copy = copy.deepcopy(queue)
        queue_children = extend_queue(queue_copy, method)
        closed_copy = copy.deepcopy(closed)
        find_solution(front_children, queue_children, closed_copy, method)


"""" ----------------------------------------------------------------------------
** Executing the code
** κλήση εκτέλεσης κώδικα
"""


def main():
    initial_state = [
        [["p", 3], [" ", 1], [" ", 0]],
        [[" ", 2], [" ", 3], [" ", 2]],
        [[" ", 1], [" ", 2], [" ", 1]],
    ]

    method = "DFS"  # Επιλογή και για 'BFS'
    """ ----------------------------------------------------------------------------
    **** starting search
    **** έναρξη αναζήτησης
    """

    print("____BEGIN__SEARCHING____")
    find_solution(
        make_front(initial_state),
        make_queue(initial_state),
        [],
        method
    )


if __name__ == "__main__":
    main()
