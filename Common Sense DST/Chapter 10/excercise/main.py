arr = [
    1,
    2,
    3,
    7,
    [8, [4, 5, 6], [9, 10, 11, [12, 13, 14]]],
    [15, 16, 17, 18, 19, [20, 21, 22, [23, 24, 25, [26, 27, 29]], 30, 31], 32],
    33,
]


def print_items(arr):
    for item in arr:
        if isinstance(item, list):
            print_items(item)
        else:
            print(item)


if __name__ == "__main__":
    print_items(arr)
