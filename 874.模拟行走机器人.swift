/*
 * @lc app=leetcode.cn id=874 lang=swift
 *
 * [874] 模拟行走机器人
 *
 * https://leetcode-cn.com/problems/walking-robot-simulation/description/
 *
 * algorithms
 * Easy (30.06%)
 * Likes:    53
 * Dislikes: 0
 * Total Accepted:    3.7K
 * Total Submissions: 12.3K
 * Testcase Example:  '[4,-1,3]\n[]'
 *
 * 机器人在一个无限大小的网格上行走，从点 (0, 0) 处开始出发，面向北方。该机器人可以接收以下三种类型的命令：
 * 
 * 
 * -2：向左转 90 度
 * -1：向右转 90 度
 * 1 <= x <= 9：向前移动 x 个单位长度
 * 
 * 
 * 在网格上有一些格子被视为障碍物。
 * 
 * 第 i 个障碍物位于网格点  (obstacles[i][0], obstacles[i][1])
 * 
 * 如果机器人试图走到障碍物上方，那么它将停留在障碍物的前一个网格方块上，但仍然可以继续该路线的其余部分。
 * 
 * 返回从原点到机器人的最大欧式距离的平方。
 * 
 * 
 * 
 * 示例 1：
 * 
 * 输入: commands = [4,-1,3], obstacles = []
 * 输出: 25
 * 解释: 机器人将会到达 (3, 4)
 * 
 * 
 * 示例 2：
 * 
 * 输入: commands = [4,-1,4,-2,4], obstacles = [[2,4]]
 * 输出: 65
 * 解释: 机器人在左转走到 (1, 8) 之前将被困在 (1, 4) 处
 * 
 * 
 * 
 * 
 * 提示：
 * 
 * 
 * 0 <= commands.length <= 10000
 * 0 <= obstacles.length <= 10000
 * -30000 <= obstacle[i][0] <= 30000
 * -30000 <= obstacle[i][1] <= 30000
 * 答案保证小于 2 ^ 31
 * 
 * 
 */

// @lc code=start
class Solution {
    func robotSim(_ commands: [Int], _ obstacles: [[Int]]) -> Int {
        
        var dx = [0, 1, 0, -1]
        var dy = [1, 0, -1, 0]

        var sets = Set<[Int]>()

        for ele in obstacles {
            sets.insert(ele)
        }

        var direction = 0
        var x = 0
        var y = 0
        var res = 0

        for ele in commands {
            if ele == -2 {
                direction = (direction + 3) % 4
            } else if ele == -1 {
                direction = (direction + 1) % 4
            } else {
                for i in 0..<ele {
                    let nx = x + dx[direction]
                    let ny = y + dy[direction]

                    if !sets.contains([nx, ny]) {
                        x = nx
                        y = ny

                        res = max(res, x*x+y*y)
                    }
                }
            }
        }

        return res
    }
}
// @lc code=end

