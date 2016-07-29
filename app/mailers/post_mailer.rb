class PostMailer < ApplicationMailer

  def notify_answer(answer)
    @answer= answer
    mail to: answer.question.author.email,
    subject: "#{answer.author.name} just answered your question #{answer.question.title}"
  end

end
