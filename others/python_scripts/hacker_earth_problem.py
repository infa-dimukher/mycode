def solve (N, start, finish, Ticket_cost):
    sum_cost_straight = 0
    sum_cost_rev = 0
    if start > finish:
        for i in range(start,finish,-1):
            sum_cost_straight = sum_cost_straight + Ticket_cost[i-2]
        for i in range(finish-1,finish-N-1,-1):
            sum_cost_rev = sum_cost_rev + Ticket_cost[i]
        return min(sum_cost_straight,sum_cost_rev)
    elif start < finish:
        for i in range(start-1,finish-1):
            sum_cost_straight = sum_cost_straight + Ticket_cost[i]
        for i in range(start-2,finish-N-2,-1):
            sum_cost_rev = sum_cost_rev + Ticket_cost[i]
        return min(sum_cost_straight,sum_cost_rev)
    else:
        return 0

N = int(input())
start = int(input())
finish = int(input())
Ticket_cost = list(map(int, input().split()))

out_ = solve(N, start, finish, Ticket_cost)
print (out_)