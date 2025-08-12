# Simple addition app
# Adding comment
def addition(a, b):
    return a + b

def test_add():
    assert addition(1, 2) == 3
    assert addition(1, -1) == 0
    assert addition(1, 1) == 2