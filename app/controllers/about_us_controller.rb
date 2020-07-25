class AboutUsController < ApplicationController
  def aboutus
    @committees = Committee.all
  end
end
