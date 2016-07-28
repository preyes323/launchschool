class Game
  attr_reader :frames

  def initialize
    @frames = []
    @current_frame = []
    @last_frame = false
  end

  def roll(pins)
    pin_error_checks pins

    if @last_frame
      @frames.last << pins
      last_frame_error_checks @frames.last
    else
      @current_frame << pins
      frame_error_checks @current_frame

      if frame_end? @current_frame
        @frames << @current_frame
        @current_frame = []
      end
    end

    @last_frame = true if last_frame?(frames) && !@last_frame
  end

  def score
    scoring_error_checks

    frame_scores = frames.each_with_index.map do |frame, idx|
      if open? frame
        frame.reduce(:+)
      elsif spare? frame, idx
        idx == 9 ? frame.reduce(:+) : 10 + frames[idx + 1].first
      elsif strike? frame, idx
        idx == 9 ? frame.reduce(:+) : strike_score(frames.slice(idx, 3))
      end
    end

    frame_scores.reduce(:+)
  end

  private

  def open?(frame)
    frame.reduce(:+) < 10
  end

  def spare?(frame, idx)
    return frame.take(2).reduce(:+) if idx == 9
    frame.reduce(:+) == 10 && frame.length == 2
  end

  def strike?(frame, idx = 0)
    return frame.first == 10 if idx == 9
    frame.reduce(:+) == 10 && frame.length == 1
  end

  def strike_score(frames)
    frames.first.concat(frames[1..-1].flatten.take(2)).reduce(:+)
  end

  def frame_end?(frame)
    frame.length == 2 || frame.reduce(:+) == 10
  end

  def last_frame?(frames)
    frames.length == 10
  end

  def pin_error_checks(pins)
    raise RuntimeError, 'Pins must have a value from 0 10' if pins < 0 || pins > 10
  end

  def frame_error_checks(frame)
    raise RuntimeError, 'Pin count exceeds pins on the lane' if frame.reduce(:+) > 10
  end

  def last_frame_error_checks(frame)
    if frame[1..-1].reduce(:+) > 10 && frame[1] != 10
      raise RuntimeError, 'Pin count exceeds pins on the lane'
    end

    if frame.length > 0 && frame.first == 0
      raise RuntimeError, 'Should not be able to roll after game is over'
    end
  end

  def scoring_error_checks
    raise RuntimeError, 'Score cannot be taken until the end of the game' unless @last_frame

    if strike?(frames.last) && frames.last.length == 1
      raise RuntimeError, 'Game is not yet over, cannot score!'
    end
  end
end
