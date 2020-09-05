class AboutUsController < ApplicationController
  def aboutus
    @committees = Committee.all
  end

  private
    def committee_user?
      super || current_user&.committee?
    end
end
