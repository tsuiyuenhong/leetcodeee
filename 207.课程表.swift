/*
 * @lc app=leetcode.cn id=207 lang=swift
 *
 * [207] 课程表
 *
 * https://leetcode-cn.com/problems/course-schedule/description/
 *
 * algorithms
 * Medium (48.69%)
 * Likes:    157
 * Dislikes: 0
 * Total Accepted:    12.4K
 * Total Submissions: 25.4K
 * Testcase Example:  '2\n[[1,0]]'
 *
 * 现在你总共有 n 门课需要选，记为 0 到 n-1。
 * 
 * 在选修某些课程之前需要一些先修课程。 例如，想要学习课程 0 ，你需要先完成课程 1 ，我们用一个匹配来表示他们: [0,1]
 * 
 * 给定课程总量以及它们的先决条件，判断是否可能完成所有课程的学习？
 * 
 * 示例 1:
 * 
 * 输入: 2, [[1,0]] 
 * 输出: true
 * 解释: 总共有 2 门课程。学习课程 1 之前，你需要完成课程 0。所以这是可能的。
 * 
 * 示例 2:
 * 
 * 输入: 2, [[1,0],[0,1]]
 * 输出: false
 * 解释: 总共有 2 门课程。学习课程 1 之前，你需要先完成​课程 0；并且学习课程 0 之前，你还应先完成课程 1。这是不可能的。
 * 
 * 说明:
 * 
 * 
 * 输入的先决条件是由边缘列表表示的图形，而不是邻接矩阵。详情请参见图的表示法。
 * 你可以假定输入的先决条件中没有重复的边。
 * 
 * 
 * 提示:
 * 
 * 
 * 这个问题相当于查找一个循环是否存在于有向图中。如果存在循环，则不存在拓扑排序，因此不可能选取所有课程进行学习。
 * 通过 DFS 进行拓扑排序 - 一个关于Coursera的精彩视频教程（21分钟），介绍拓扑排序的基本概念。
 * 
 * 拓扑排序也可以通过 BFS 完成。
 * 
 * 
 * 
 */

// @lc code=start
class Solution {
    func canFinish(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {
        
        return dfs(numCourses, prerequisites)

        var numCourses = numCourses

        // 维护邻接表
        var adjacency: [[Int]] = Array(repeating: [], count: numCourses)

        // 维护入度表
        var indegrees: [Int] = Array(repeating: 0, count: numCourses)

        for ele in prerequisites {
            let cur = ele[0]
            let pre = ele[1]
            
            indegrees[cur] += 1
            adjacency[pre].append(cur)
        }

        var queue: [Int] = []

        for i in 0..<indegrees.count where indegrees[i] == 0 {
            queue.append(i)
        }

        while !queue.isEmpty {
            let pre = queue.removeFirst()
            numCourses -= 1
            for cur in adjacency[pre] {
                indegrees[cur] -= 1
                if indegrees[cur] == 0 {
                    queue.append(cur)
                }
            }
        }

        return numCourses == 0
    }

    func dfs(_ numCourses: Int, _ prerequisites: [[Int]]) -> Bool {

        var adjacency: [[Int]] = Array(repeating: [], count: numCourses)
        var flags: [Int] = Array(repeating: 0, count: numCourses)

        for ele in prerequisites {
            let cur = ele[0]
            let pre = ele[1]

            adjacency[pre].append(cur)
        }

        func helper(_ i: Int) -> Bool {
            if flags[i] == -1 { return true }
            if flags[i] == 1 { return false }

            flags[i] = 1

            for cur in adjacency[i] {
                if !helper(cur) {
                    return false 
                }
            }

            flags[i] = -1

            return true
        }

        for i in 0..<numCourses {
            if !helper(i) {
                return false
            }
        }

        return true
    }
}
// @lc code=end

