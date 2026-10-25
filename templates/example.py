import sys
import math
import heapq
import bisect
from collections import deque, Counter, defaultdict
from itertools import permutations, combinations, product, accumulate
from functools import lru_cache

sys.setrecursionlimit(200000)


def rl():
    return sys.stdin.readline().rstrip("\r\n")


def rl_int():
    return int(rl())


def rl_list(s: str = None):
    return rl().split(s)


def rl_list_int(s: str = None):
    return list(map(int, rl_list(s)))


def rdl_list_int():
    return list(map(int, sys.stdin.read().split()))


def pr(*args, sep=" ", end="\n"):
    sys.stdout.write(sep.join(map(str, args)) + end)


def pr_list(arr, sep=" "):
    sys.stdout.write(sep.join(map(str, arr)) + "\n")


def solve():
    pass


def main():
    solve()


if __name__ == "__main__":
    main()
