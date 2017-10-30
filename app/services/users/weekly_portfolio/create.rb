module Users
  module WeeklyPortfolio
    class Create
      include Interactor::Organizer

      organize Statistics::CreateWeeklyPortfolio, Users::WeeklyPortfolio::SendEmail
    end
  end
end
