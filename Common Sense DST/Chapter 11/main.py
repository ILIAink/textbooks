def reverse_string(s):
    if len(s) == 1:
        return s[0]

    # Last element of array, call array excluding the last character
    return s[-1] + reverse_string(s[:-1])


def reverse(s):
    if len(s) == 1:
        return s[0]

    return reverse(s[1 : len(s)]) + s[0]


def count_x(s):
    if len(s) == 0:
        return 0

    if s[0] == "x":
        return 1 + count_x(s[1 : len(s)])
    else:
        return count_x(s[1 : len(s)])


if __name__ == "__main__":
    print(count_x("absscxxsdxdx"))
