require File.expand_path(File.dirname(__FILE__) + '/neo')
require 'pry'

# Greed is a dice game where you roll up to five dice to accumulate
# points.  The following "score" function will be used to calculate the
# score of a single roll of the dice.
#
# A greed roll is scored as follows:
#
# * Everything else is worth 0 points.
#
#
# Examples:
#
# score([1,1,1,5,1]) => 1150 points
# score([2,3,4,6,2]) => 0 points
# score([3,4,5,3,3]) => 350 points
# score([1,5,1,2,4]) => 250 points
#
# More scoring examples are given in the tests below:
#
# Your goal is to write the score method.
class Test
  def initialize
    @result = 0
  end

  def score(dice)
    return @result if dice.empty?

    @test = dice.group_by(&:itself)
    handle_thousand
    handle_set
    handle_five
    handle_one
    @result
  end

  private

  def handle_thousand
    return unless @test[1]&.length.to_i > 2

    @result += 1000
    @test[1].slice!(0, 3)
  end

  def handle_set
    @test.each do |num, qunatity|
      next unless qunatity.length > 2

      @result += num * 100
      @test[num].slice!(0, 3)
    end
  end

  def handle_five
    return unless @test[5]&.any?

    @result += 50 * @test[5].length
  end

  def handle_one
    return unless @test[1]&.any?

    @result += 100 * @test[1].length
  end
end


class AboutScoringProject < Neo::Koan
  def test_score_of_an_empty_list_is_zero
    assert_equal 0, Test.new.score([])
  end

  def test_score_of_a_single_roll_of_5_is_50
    assert_equal 50, Test.new.score([5])
  end

  def test_score_of_a_single_roll_of_1_is_100
    assert_equal 100, Test.new.score([1])
  end

  def test_score_of_multiple_1s_and_5s_is_the_sum_of_individual_scores
    assert_equal 300, Test.new.score([1,5,5,1])
  end

  def test_score_of_single_2s_3s_4s_and_6s_are_zero
    assert_equal 0, Test.new.score([2,3,4,6])
  end

  def test_score_of_a_triple_1_is_1000
    assert_equal 1000, Test.new.score([1,1,1])
  end

  def test_score_of_other_triples_is_100x
    assert_equal 200, Test.new.score([2,2,2])
    assert_equal 300, Test.new.score([3,3,3])
    assert_equal 400, Test.new.score([4,4,4])
    assert_equal 500, Test.new.score([5,5,5])
    assert_equal 600, Test.new.score([6,6,6])
  end

  def test_score_of_mixed_is_sum
    assert_equal 250, Test.new.score([2,5,2,2,3])
    assert_equal 550, Test.new.score([5,5,5,5])
    assert_equal 1100, Test.new.score([1,1,1,1])
    assert_equal 1200, Test.new.score([1,1,1,1,1])
    assert_equal 1150, Test.new.score([1,1,1,5,1])
  end

end
