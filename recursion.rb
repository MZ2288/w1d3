require 'byebug'

def range(start, finish)
  # Break up ternary
  start > finish ? [] : range(start, finish - 1) << finish
end

def exponentiation(b, n)
  # Break up ternary
  n == 0 ? 1 : b * exponentiation(b, n - 1)
end

def exp(base, power)
  # debugger
  # Rewrite If/else
  case
  when power.zero?
    1
  when power == 1
    base
  when power.even?
    result = exp(base, power / 2)
    result * result
  else
    sub_result = exp(base, (power - 1) / 2)
    base * (sub_result * sub_result)
  end
end

class Array
  def deep_dup
    result = []
      self.each do |el|
        result << el unless el.is_a?(Array)
        result << el.deep_dup if el.is_a?(Array)
      end
    result
  end
end

def fibonacci(n)
  series = [0, 1]
  until series.size == n
    series << series[-1] + series[-2]
  end
  series
end

def fibs_rec(n)
  if n <= 2
    (0..n).to_a.take(n)
  else
    fibs = fibs_rec(n - 1)
    fibs << fibs[-1] + fibs[-2]
  end
end

# Re-do with only two args, array and target

def bsearch(array, target, imin = 0, imax = array.size - 1)
  return nil if !array.include?(target) || array.empty?
  # debugger
  middle = (imin + imax) / 2
  if array[middle] > target
    bsearch(array, target, imin, middle - 1)
  elsif array[middle] < target
    bsearch(array, target, middle + 1, imax)
  else
    return middle
  end
end

def make_change(amount, coins)
  return [] if amount <= 0
  raise "wtf" if coins.empty?
  this_change = nil
  best_change = nil
  coins.each_with_index do |coin, idx|
    next if coin > amount
    leftover_amount = amount - coin
    this_change = make_change(leftover_amount, coins[idx..-1])
    this_change.unshift(coin)
    if best_change.nil? || this_change.length < best_change.length
      best_change = this_change
    end
  end
  best_change
end

class Array
  def merge_sort
    return self if length <= 1
    middle = length / 2
    left = self[0..middle - 1].merge_sort
    right = self[middle..-1].merge_sort
    merge(left, right)
  end

  def merge(left, right)
    result = []
    until left.empty? || right.empty?
      if left.first < right.first
        result << left.shift
      else
        result << right.shift
      end
    end
    result + left + right
  end

  def subsets
    return [[]] if self.empty?
    previous_subs = self[0..-2].subsets
    new_subs = previous_subs.map { |subset| subset + [self[-1]] }
    previous_subs + new_subs
  end
end
