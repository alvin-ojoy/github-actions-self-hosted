# Simple addition app

def addition(a, b):
    return a + b

def test_add():
    assert addition(1, 2) == 3
    assert addition(1, -1) == 0