/*
 * @lc app=leetcode.cn id=36 lang=swift
 *
 * [36] 有效的数独
 *
 * https://leetcode-cn.com/problems/valid-sudoku/description/
 *
 * algorithms
 * Medium (55.56%)
 * Likes:    182
 * Dislikes: 0
 * Total Accepted:    34.9K
 * Total Submissions: 62.8K
 * Testcase Example:  '[["5","3",".",".","7",".",".",".","."],["6",".",".","1","9","5",".",".","."],[".","9","8",".",".",".",".","6","."],["8",".",".",".","6",".",".",".","3"],["4",".",".","8",".","3",".",".","1"],["7",".",".",".","2",".",".",".","6"],[".","6",".",".",".",".","2","8","."],[".",".",".","4","1","9",".",".","5"],[".",".",".",".","8",".",".","7","9"]]'
 *
 * 判断一个 9x9 的数独是否有效。只需要根据以下规则，验证已经填入的数字是否有效即可。
 * 
 * 
 * 数字 1-9 在每一行只能出现一次。
 * 数字 1-9 在每一列只能出现一次。
 * 数字 1-9 在每一个以粗实线分隔的 3x3 宫内只能出现一次。
 * 
 * 
 * 
 * 
 * 上图是一个部分填充的有效的数独。
 * 
 * 数独部分空格内已填入了数字，空白格用 '.' 表示。
 * 
 * 示例 1:
 * 
 * 输入:
 * [
 * ⁠ ["5","3",".",".","7",".",".",".","."],
 * ⁠ ["6",".",".","1","9","5",".",".","."],
 * ⁠ [".","9","8",".",".",".",".","6","."],
 * ⁠ ["8",".",".",".","6",".",".",".","3"],
 * ⁠ ["4",".",".","8",".","3",".",".","1"],
 * ⁠ ["7",".",".",".","2",".",".",".","6"],
 * ⁠ [".","6",".",".",".",".","2","8","."],
 * ⁠ [".",".",".","4","1","9",".",".","5"],
 * ⁠ [".",".",".",".","8",".",".","7","9"]
 * ]
 * 输出: true
 * 
 * 
 * 示例 2:
 * 
 * 输入:
 * [
 * ["8","3",".",".","7",".",".",".","."],
 * ["6",".",".","1","9","5",".",".","."],
 * [".","9","8",".",".",".",".","6","."],
 * ["8",".",".",".","6",".",".",".","3"],
 * ["4",".",".","8",".","3",".",".","1"],
 * ["7",".",".",".","2",".",".",".","6"],
 * [".","6",".",".",".",".","2","8","."],
 * [".",".",".","4","1","9",".",".","5"],
 * [".",".",".",".","8",".",".","7","9"]
 * ]
 * 输出: false
 * 解释: 除了第一行的第一个数字从 5 改为 8 以外，空格内其他数字均与 示例1 相同。
 * ⁠    但由于位于左上角的 3x3 宫内有两个 8 存在, 因此这个数独是无效的。
 * 
 * 说明:
 * 
 * 
 * 一个有效的数独（部分已被填充）不一定是可解的。
 * 只需要根据以上规则，验证已经填入的数字是否有效即可。
 * 给定数独序列只包含数字 1-9 和字符 '.' 。
 * 给定数独永远是 9x9 形式的。
 * 
 * 
 */
class Solution {
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        
        // 将九宫格分为9个区域
        // i < 3, j < 3 -> 0
        // ...
        // i > 6, j > 6 -> 8

        let m = board.count

        var rowRecorder: [[Character: Int]] = Array(repeating: [:], count: 9)
        var columnRecorder: [[Character: Int]] = Array(repeating: [:], count: 9)
        var areaRecorder: [[Character: Int]] = Array(repeating: [:], count: 9)

        for i in 0..<m {
            for j in 0..<m {

                let character = board[i][j]

                guard character != "." else { continue }
                
                let k = i / 3 * 3 + j / 3 // count current character belong to which area

                if rowRecorder[j][character] != nil || columnRecorder[i][character] != nil || areaRecorder[k][character] != nil {
                    return false
                }

                rowRecorder[j][character] = j
                columnRecorder[i][character] = i
                areaRecorder[k][character] = k

            }
        }

        return true
    }

    // 第一次的做法
    private func _isValidSudoku(_ board: [[Character]]) -> Bool {
        var hashMap = Set<Character>()

        let m = board.count
        
        // 监测每行
        for i in 0..<m {
            for j in 0..<m {
                let val = board[i][j]
                if hashMap.contains(val) && val != "." {
                    return false
                }
                hashMap.insert(val)
            }
            hashMap.removeAll()
        }

        // 监测每列
        for j in 0..<m {
            for i in 0..<m {
                let val = board[i][j]
                if hashMap.contains(val) && val != "." {
                    return false
                }
                hashMap.insert(val)
            }
            hashMap.removeAll()
        }

        // 监测 3x3
        for i in 0..<3 {
            for j in 0..<3 {
                
                for si in 0..<3 {
                    for sj in 0..<3 {
                        let val = board[3*i+si][3*j+sj]
                        if hashMap.contains(val) && val != "." {
                            return false
                        }
                        hashMap.insert(val)
                    }
                }

                hashMap.removeAll()
            }
        }

        return true
    }
}

