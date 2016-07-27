module ApplicationHelper
  Speller = FFI::Aspell::Speller.new('en_US')

  def did_you_mean(typo)
    suggestions = Speller.suggestions(typo)
    suggestions.map!{ |term| [Post.search(term).meta["total"].to_i, term] }.max
  end

  def spell_check?(term, total_results)
    total_results.zero? || (!Speller.correct?(term) && total_results.zero?)
  end

  def make_suggestion(search_term, total_results)
    if spell_check?(search_term, total_results)
      did_you_mean(search_term)[1]
    end
  end

end
