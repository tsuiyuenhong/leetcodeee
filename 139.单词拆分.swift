/*
 * @lc app=leetcode.cn id=139 lang=swift
 *
 * [139] 单词拆分
 *
 * https://leetcode-cn.com/problems/word-break/description/
 *
 * algorithms
 * Medium (42.79%)
 * Likes:    198
 * Dislikes: 0
 * Total Accepted:    19K
 * Total Submissions: 44.6K
 * Testcase Example:  '"leetcode"\n["leet","code"]'
 *
 * 给定一个非空字符串 s 和一个包含非空单词列表的字典 wordDict，判定 s 是否可以被空格拆分为一个或多个在字典中出现的单词。
 * 
 * 说明：
 * 
 * 
 * 拆分时可以重复使用字典中的单词。
 * 你可以假设字典中没有重复的单词。
 * 
 * 
 * 示例 1：
 * 
 * 输入: s = "leetcode", wordDict = ["leet", "code"]
 * 输出: true
 * 解释: 返回 true 因为 "leetcode" 可以被拆分成 "leet code"。
 * 
 * 
 * 示例 2：
 * 
 * 输入: s = "applepenapple", wordDict = ["apple", "pen"]
 * 输出: true
 * 解释: 返回 true 因为 "applepenapple" 可以被拆分成 "apple pen apple"。
 * 注意你可以重复使用字典中的单词。
 * 
 * 
 * 示例 3：
 * 
 * 输入: s = "catsandog", wordDict = ["cats", "dog", "sand", "and", "cat"]
 * 输出: false
 * 
 * 
 */
class Solution {
    func wordBreak(_ s: String, _ wordDict: [String]) -> Bool {
        
        let set = Set(wordDict)

        var dp = Array(repeating: false, count: s.count + 1)

        dp[0] = true

        let characters = Array(s)

        for i in 1...characters.count {
            for j in 0..<i {
                if dp[j] && set.contains(String(characters[j..<i])) {
                    dp[i] = true
                }
            }
        }

        return dp.last!
    }
}

