"""
This module provides a set of functions for baking lasagna.
"""

EXPECTED_BAKE_TIME = 40
TIME_PER_LAYER = 2

def bake_time_remaining(time):
    """ Calculate the bake time remaining.
    Args:
        time (int): The time already spent baking.
    """
    return EXPECTED_BAKE_TIME - time

def preparation_time_in_minutes(layers):
    """ Calculate the preparation time.
    Args:
        layers (int): The number of layers in the lasagna.
    """
    return TIME_PER_LAYER * layers

def elapsed_time_in_minutes(layers, time_spent):
    """ Calculate the total elapsed time.
    Args:
        layers (int): The number of layers in the lasagna.
        time_spent (int): The time already spent baking.
    """
    return time_spent + preparation_time_in_minutes(layers)
