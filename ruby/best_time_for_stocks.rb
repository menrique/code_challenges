# 1. Say you have an array prices for which the ith element is the price of a given stock on day i. Design an algorithm
# to find the maximum profit. You may complete as many transactions as you like (i.e., buy one and sell one share of the
# stock multiple times).
#
# Note:
# You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).
#
# Example 1:
# Input: [7,1,5,3,6,4]
# Output: 7
# Explanation: buy on day 2 (price = 1) and sell on day 3 (price = 5), profit = 5-1 = 4.
# Then buy on day 4 (price = 3) and sell on day 5 (price = 6), profit = 6-3 = 3.
#
# Example 2:
# Input: [1,2,3,4,5]
# Output: 4
# Explanation: buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
# Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
# engaging multiple transactions at the same time. You must sell before buying_priceing again.
#
# Example 3:
# Input: [7,6,4,3,1]
# Output: 0
# Explanation: In this case, no transaction is done, i.e. max profit = 0.
#
# Constraints:
# 1 <= prices.length <= 3 * 10 ^ 4
# 0 <= prices[i] <= 10 ^ 4

def max_profit(prices)
  buy_at = 0
  profit = 0
  length = prices.length

  while buy_at < length
    buy = prices[buy_at]
    sell = nil
    sell_at = buy_at + 1
    deal = false

    while sell_at < length && !deal
      sell = prices[sell_at]
      future_deal = prices[sell_at + 1]
      deal = future_deal.nil? || future_deal < sell ? sell > buy : false
      sell_at += 1
    end

    if deal
      profit += sell - buy
      buy_at = sell_at
    else
      buy_at += 1
    end
  end

  profit
end

prices = [7, 1, 5, 3, 6, 4]
max_profit(prices)
# => 7

prices = [1, 2, 3, 4, 5]
max_profit(prices)
# => 4

prices = [7, 6, 4, 3, 1]
max_profit(prices)
# => 0


def max_profit_2(prices)
  sell_at = 0
  profit = 0
  prices.each.with_index do |buy, buy_at|
    next if sell_at > buy_at
    sell_at = buy_at + 1
    opportunities = prices[sell_at..prices.length]

    sell, at = opportunities.find.with_index.with_object([]) do |(price, index), result|
      future_deal = opportunities[index + 1]
      deal = future_deal.nil? || future_deal < price ? price > buy : false
      deal && result.push(price, index)
    end

    unless sell.nil?
      sell_at += at + 1
      profit += sell - buy
    end
  end

  profit
end

prices = [7, 1, 5, 3, 6, 4]
max_profit_2(prices)
# => 7

prices = [1, 2, 3, 4, 5]
max_profit_2(prices)
# => 4

prices = [7, 6, 4, 3, 1]
max_profit_2(prices)
# => 0

require 'benchmark'
prices = [7, 1, 5, 3, 6, 4]
Benchmark.bmbm(12) do |bm|
  bm.report("Loops:") do
    max_profit(prices)
  end

  bm.report("Enumerators:") do
    max_profit_2(prices)
  end
end;nil
#                    user     system      total        real
# Loops:         0.000006   0.000001   0.000007 (  0.000006)
# Enumerators:   0.000018   0.000001   0.000019 (  0.000018)