"""
    Time complexity: O( N * M )
    Space complexity: O( N * M )

    Where 'N' and 'M' are the lengths of the strings 'A' and
    'B' respectively.

    The backtracking approach discussed before can be optimized using memoization. Let a state ‘S’ be defined by  (‘AIDX’, ‘BIDX’, ‘lastCh’), if we observe carefully we are calculating the minimum value for some states (‘AIDX’, ‘BIDX’, ‘lastCh’) many times. We can store the minimum value for each state ‘S’ in a matrix and when we visit it again we will not calculate it but return the value already stored,


 

Let us define a matrix ‘DP’ of size ‘N’ x ‘M’ x 2. 2 is used as an identifier to detect the last character was taken from which string. ‘DP[ i ][ j ][ k ]’ stores the minimum value calculated for the state ( ‘i’, ‘j’, ‘k’ ).  


 

The steps are as follows:-

// Recursive function to find minimum cost

function getMinCostUtil(string& a, string& b, int aidx, int bidx, int lastCh, [ [ [ int ] ] ] dp):

If indices of string 'A' and 'B' is equal to 'N' and 'M' respectively then return 0.
If ‘DP[ AIDX ][ BIDX ][ lastCh ]’ is not equal to -1 then return the value of ‘DP[ AIDX ][ BIDX ][ lastCh ]’.
Initialize a variable 'PREV' with 0, it denotes the ASCII value of the last character.
If the value of 'lastCh' is 0 then update the value of 'PREV' with the ASCII value of the character at 'AIDX' - 1 from 'A'.
Else update the value of 'PREV' with the ASCII value of the character at 'BIDX' - 1 from 'B'.
If 'BIDX' is equal to 'M' then recursively call 'getMinCostUtil' with the cost of appending 'A[AIDX]' into the string 'C' and store the value returned in ‘DP[ AIDX ][ BIDX ][ lastCh ]’.
If 'AIDX' is equal to 'N' then recursively call 'getMinCostUtil' with the cost of appending 'B[BIDX]' into the string 'C' and store the value returned in ‘DP[ AIDX ][ BIDX ][ lastCh ]’.
Else recursively call the 'getMinCostUtil' function by first appending  'A[ AIDX ]' into the string 'C' then restore the string and call the function again by appending 'B[BIDX]' then store the minimum value returned by them in  ‘DP[ AIDX ][ BIDX ][ lastCh ]’ and return it.

 

function getMinCost(string& a, string& b):

Initialize a 3d matrix ‘DP’ of size ‘N’ x ‘M’ x 2 with -1.
Call 'getMinCostUtil' first by appending the first character of string  'A' then restore the string and call the function again by appending the first character of 'B', store the minimum of them into the variable  'ANS'
Return the value of the variable 'ANS'.
Time Complexity
O( N * M ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively. 



 

Each state of ‘DP” ( ‘i’, ‘j’, ‘k’ ) is visited only once now and the value of ‘i’ can be from (1 to ‘N’) and ‘j’ can vary from ( 1 to ‘M’ ) and ‘k’ can vary from (1 to 2 ). So the time complexity is O( 2 x ‘N’ x ‘M’ ). 2 can be ignored here.


 

Hence the time complexity is O( N * M ).

Space Complexity
O( N * M ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively.

 

We are using a 3d matrix of size ‘N’ x ‘M’ x 2 and then the space taken for recursive stack will be at most ( ‘N’ + ‘M’).

Hence space complexity is O( N * M ).
"""


def getMinCostUtil(a: str, b: str, aidx: int, bidx: int, lastCh: int, dp: [[[int]]]) -> int:
    n = len(a)
    m = len(b)

    # If indices of string 'A' and 'B' is equal to 'N' and 'M' respectively
    # then return 0.
    if aidx == n and bidx == m:
        return 0

    # If ‘DP[ AIDX ][ BIDX ][ lastCh ]’ is not equal to -1
    # then return the value of ‘DP[ AIDX ][ BIDX ][ lastCh ]’.
    if dp[aidx][bidx][lastCh] != -1:
        return dp[aidx][bidx][lastCh]

    # Initialize a variable 'PREV' with 0, it denotes the
    # ascii value of the last character.
    prev = 0

    # If the value of 'lastCh' is 0 then update the value of
    # 'PREV' with the ascii value of the character at 'AIDX' - 1 from 'A'
    if lastCh == 0:
        prev = a[aidx - 1]
    else:
        # Else update the value of 'PREV' with the ascii value
        # of the character at 'BIDX' - 1 from 'B'.
        prev = b[bidx - 1]

    # If 'BIDX' is equal to 'M' then recursively call
    # 'getMinCostUtil' with the cost of appending 'A[AIDX]' into
    # the string 'C' and store the value returned in ‘DP[ AIDX ][ BIDX ][
    # lastCh ]’.
    if bidx == m:
        findMinCostUtil = getMinCostUtil(a, b, aidx + 1, bidx, 0, dp)
        dp[aidx][bidx][lastCh] = ((a[aidx]) != prev) + findMinCostUtil
        
        return dp[aidx][bidx][lastCh]

    # If 'AIDX' is equal to 'N' then recursively call 'getMinCostUtil'
    # with the cost of appending 'B[BIDX]' into the string
    # 'C' and store the value returned in ‘DP[ AIDX ][ BIDX ][ lastCh ]’.
    if aidx == n:
        findMinCostUtil = getMinCostUtil(a, b, aidx, bidx + 1, 1, dp)
        dp[aidx][bidx][lastCh] = ((b[bidx]) != prev) + findMinCostUtil
        return dp[aidx][bidx][lastCh]

    cost1 = a[aidx] != prev
    cost2 = b[bidx] != prev

    # Else recursively call the 'getMinCostUtil' function
    # by first appending  'A[ AIDX ]' into the string 'C' then
    # restore the string and call the function again by appending
    # 'B[BIDX]' then store the minimum value returned by
    # them in  ‘DP[ AIDX ][ BIDX ][ lastCh ]’ and return it.
    dp[aidx][bidx][lastCh] = min(cost1 + getMinCostUtil(a, b, aidx + 1, bidx, 0, dp),
                            cost2 + getMinCostUtil(a, b, aidx, bidx + 1, 1, dp))
    return dp[aidx][bidx][lastCh]


def getMinCost(a: str, b: str) -> int:
    n = len(a)
    m = len(b)

    # Initialize a 3d matrix ‘DP’ of size ‘N’ x ‘M’ x 2 with -1.
    dp = [[[-1 for k in range(2)] for j in range(m + 1)] for i in range(n + 1)]

    # Call 'getMinCostUtil' first by appending the first
    # character of string  'A' then restore the string and
    # call the function again by appending the first character
    # of 'B', store the minimum of them into the variable 'ANS.
    ans = 1 + min(getMinCostUtil(a, b, 1, 0, 0, dp), getMinCostUtil(a, b, 0, 1, 1, dp))

    # Return the value of the variable 'ANS'
    return ans