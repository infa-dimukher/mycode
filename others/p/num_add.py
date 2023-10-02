class Solution:
    
    def __init__(self) -> None:
        
    
    def twoSum(self, nums: List[int], target: int) -> List[int]:
        nums = self.nums
        target = self.target
        sum = 0
        sum_list = []
        for i in range(len(nums)):
            for j in range(i+1,len(nums)):
                sum = nums[i] + nums[j]
                if sum == target:
                    sum_list.append(i)
                    sum_list.append(j)
                    return sum_list
                    break
            if sum == target:
                break
            else:
                continue

nums_str = input().split(',')
nums = [int(n) for n in nums_str]
target = int(input())
get_solution = Solution.twoSum(nums,target)
print(get_solution)