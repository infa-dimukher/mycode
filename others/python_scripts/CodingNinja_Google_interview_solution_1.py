"""
    Time complexity: O( 2^( N + M ) )
    Space complexity: O( N + M )

    Where 'N' and 'M' are the lengths of the strings 'A' and
    'B' respectively.

    In this approach, We can recursively merge the strings. Since we need to merge the strings in such a way that their relative order is maintained, we can have two pointers ‘AIDX’ and ‘BIDX’ pointing to the first characters of strings ‘A’ and ‘B’ respectively. At any point, we have two options, either we merge the character at ‘A[ AIDX ]’ or we merge the character at ‘B[ BIDX ]’.

 

 We can recursively try both ways one by one and check which one yields the minimum cost. To check the number of consecutive characters that are not equal we can make a variable that denotes the last character was taken from which string and then we can access the character and check if the current merging character is equal to the previous character or not.


 

The steps are as follows:-

// Recursive function to find minimum cost

function getMinCostUtil(string& a, string& b, int aidx, int bidx, int lastCh):

If indices of string 'A' and 'B' is equal to 'N' and 'M' respectively then return 0.
Initialize a variable 'PREV' with 0, it denotes the ASCII value of the last character.
If the value of 'lastCh' is 0 then update the value of 'PREV' with the ASCII value of the character at 'AIDX' - 1 from 'A'.
Else update the value of 'PREV' with the ASCII value of the character at 'BIDX' - 1 from 'B'.
If 'BIDX' is equal to 'M' then recursively call 'getMinCostUtil' with the cost of appending 'A[AIDX]' into the string 'C'.
If 'AIDX' is equal to 'N' then recursively call 'getMinCostUtil' with the cost of appending 'B[BIDX]' into the string 'C'.
Else recursively call the 'getMinCostUtil' function by first appending  'A[AIDX]' into the string 'C' then restore the string and call the function again by appending 'B[BIDX]' then return the minimum value returned by them.

 

function getMinCost(string& a, string& b):

Call 'getMinCostUtil' first by appending the first character of string  'A' then restore the string and call the function again by appending the first character of 'B', store the minimum of them into the variable  'ANS'
Return the value of the variable 'ANS'.
Time Complexity
O( 2^( N + M ) ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively.

 

For any ‘i’th character in ‘C’, we have two choices of either merging the character of ‘A’ or the character of ‘B’. We are exploring both the ways recursively, so the recursive tree grows as 1, 2, 4, … 2^( N + M) because the length of the string should be ( ‘N’ + ‘M’ ).

Hence the time complexity is O( 2^( N + M )  ).

Space Complexity
O( N + M ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively.

 

The height of the recursive tree can be at most ( ‘N’ + ‘M’ ).

Hence space complexity is O( N + M ).
"""

# Recursive function to find minimum cost
def getMinCostUtil(a: str, b: str, aidx: int, bidx: int, lastCh: int) -> int:
    n, m = len(a), len(b)

    # If indices of string 'A' and 'B' is equal to 'N' and 'M' respectively
    # then return 0.
    if aidx == n and bidx == m:
        return 0

    # Initialize a variable 'PREV' with 0, it denotes the value of the last
    # character
    prev = 0

    # If the value of 'lastCh' is 0 then update the value
    # of 'PREV' with the ascii value of the character at 'AIDX' - 1 from 'A'.
    if lastCh == 0:
        prev = a[aidx - 1]

    else:
        # Else update the value of 'PREV' with the ascii value
        # of the character at 'BIDX' - 1 from 'B'.
        prev = b[bidx - 1]

    # Else if 'BIDX' is equal to 'M' then recursively call 'getMinCostUtil'
    # with the cost of appending 'A[AIDX]' into the string 'C'.
    if bidx == m:
        return (a[aidx] != prev) + getMinCostUtil(a, b, aidx + 1, bidx, 0)

    # If 'AIDX' is equal to 'N' then recursively call 'getMinCostUtil' with the
    # cost of appending 'B[BIDX]' into the string 'C'.
    if aidx == n:
        return (b[bidx] != prev) + getMinCostUtil(a, b, aidx, bidx + 1, 1)
    cost1 = a[aidx] != prev
    cost2 = b[bidx] != prev

    # Else recurively call 'getMinCostUtil' function with first appending
    # 'A[AIDX]' into the string 'C' then restore the string and call the
    # function again with appending 'B[BIDX]' return the minimum value returned
    # by them.
    return min(cost1 + getMinCostUtil(a, b, aidx + 1, bidx, 0),
        cost2 + getMinCostUtil(a, b, aidx, bidx + 1, 1))


def getMinCost(a: str, b: str) -> int:
    # Call 'getMinCostUtil' first with appending the first character of string
    # 'A' then restore the string and call the function again with appending
    # the first character of 'B', store the minimum of them into the variable
    # 'ANS'
    ans = 1 + min(getMinCostUtil(a, b, 1, 0, 0), getMinCostUtil(a, b, 0, 1, 1))

    # Return the value of the variable 'ANS'.
    return ans