"""
    Time complexity: O( N * M )
    Space complexity: O( N * M )

    Where 'N' and 'M' are the lengths of the strings 'A' and
    'B' respectively.

    The idea is the same as memoization. We are going to use the recurrence relation used in memoization. 


 

The steps are as follows:-

function getMinCost(string& a, string& b):

Initialize a 3d matrix ‘DP’ of size ‘N’ x ‘M’ x 2 with -1.
Set 'DP[1][0][0]' and 'DP[0][1][1]' to 1.
Run a loop from 'i' = 0...'N':
Run a loop from 'j' = 0...'M'
If 'i' < 'N':
If 'i' > 0 then update the value of 'DP[ i+1 ] [ j ][ 0 ]' to the minimum of 'DP[ i+1 ][ j ][ 0 ]' and ('DP[ i ][ j ][ 0 ]' + (‘A[ i-1 ]’ != ‘A[ i ]’)).
If 'j' > 0 then update the value of 'DP[ i+1 ][ j ][ 0 ]' to the minimum of 'DP[ i+1 ][ j ][ 0 ]' and ('DP[ i ][ j ][ 1 ]' + ('B[ j-1 ]' != 'A[ i ]' )).
if 'j' < 'M':
If 'i' > 0 then update the value of 'DP[ i ][ j+1 ][ 1 ]' to the minimum of 'DP[ i ][ j+1 ][ 1 ]' and ('DP[ i ][ j ][ 0 ]' + ('A[ i-1 ]' != 'B[ j ]')).
If 'j' > 0 then update the value of 'DP[ i ][ j+1 ][ 1 ]' to the minimum of 'DP[ i ][ j+1 ][ 1 ]' and ('DP[ i ][ j ][ 1 ]' + ('B[ j-1 ]'!= 'B[ j ]' ))
Return the minimum of 'DP[n][m][0]' and 'DP[n][m][1]'.
Time Complexity
O( N * M ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively. 

 

We are running two nested loops to get the value for each ‘DP’ state.

Hence the time complexity is O( N * M ).

Space Complexity
O( N * M ), Where ‘N’ and ‘M’ are the lengths of the strings ‘A’ and ‘B’ respectively.

 

We are using a 3d matrix of size ‘N’ x ‘M’ x 2.

Hence space complexity is O( N * M ).
"""


def getMinCost(a: str, b: str) -> int:

    n = len(a)
    m = len(b)

    # Initialize a 3d matrix ‘DP’ of size ‘N’ x ‘M’ x 2 with 10000.
    dp = [[[10000 for _ in range(2)] for _ in range(m + 1)] for _ in range(n + 1)]

    # Set 'DP[1][0][0]' and 'DP[0][1][1]' to 1.
    dp[1][0][0] = dp[0][1][1] = 1

    # Run a loop from 'i' = 0...'N':
    for i in range(n + 1):
        # Run a loop from 'j' = 0...'M':
        for j in range(m + 1):
            # If 'i' < 'N':
            if i < n:
                # If 'i' > 0 then update the value of 'DP[ i+1 ][ j ][ 0 ]' to the
                # minimum of 'DP[ i+1 ][ j ][ 0 ]' and ('DP[ i ][ j ][ 0 ]' +
                # ('A[i-1]' != 'A[i]')).
                if i > 0:
                    dp[i + 1][j][0] = min(dp[i + 1][j][0], 
                                        dp[i][j][0] + (a[i - 1] != a[i]))

                # If 'j' > 0 then update the value of 'DP[ i+1 ][ j ][ 0 ]' to the
                # minimum of 'DP[ i+1 ][ j ][ 0 ]' and ('DP[ i ][ j ][ 1 ]' +
                # ('B[ j-1 ]' != 'A[ i ]' )).
                if j > 0:
                    dp[i + 1][j][0] = min(dp[i + 1][j][0], 
                                        dp[i][j][1] + (b[j - 1] != a[i]))

            # if 'j' < 'M':
            if j < m:
                # If 'i' > 0 then update the value of 'DP[ i ][ j+1 ][ 1 ]' to the
                # minimum of 'DP[ i ][ j+1 ][ 1 ]' and ('DP[ i ][ j ][ 0 ]' +
                # ('A[ i-1 ]' != 'B[ j ]')).
                if i > 0:
                    dp[i][j + 1][1] = min(dp[i][j + 1][1], 
                                        dp[i][j][0] + (a[i - 1] != b[j]))

                # If 'j' > 0 then update the value of 'DP[ i ][ j+1 ][ 1 ]' to the
                # minimum of 'DP[ i ][ j+1 ][ 1 ]' and ('DP[ i ][ j ][ 1 ]' +
                # ('B[ j-1 ]'!= 'B[ j ]' )).
                if j > 0:
                    dp[i][j + 1][1] = min(dp[i][j + 1][1], 
                                        dp[i][j][1] + (b[j - 1] != b[j]))

    # Return the minimum of 'DP[n][m][0]' and 'DP[n][m][1]'.
    return min(dp[n][m][0], dp[n][m][1])