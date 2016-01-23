require 'rails_helper'

feature "zarządzanie recenzjami" do
  
  context "po zalogowaniu" do
    include_context "admin login"
    
    context "Z recenzentem, autorem i tekstem w bazie danych" do

    before do
      person1 = Person.create!(name: "Marek", surname: "Jeziorski", email: "m@o2.pl", discipline: "informatyka", sex: "mężczyzna")
			person2 = Person.create!(name: "Dominika", surname: "Skoczeń", email: "d@o2.pl", discipline: "informatyka", sex: "kobieta")
      person3 = Person.create!(name: "Piotr", surname: "Szysz", email: "p@o2.pl", discipline: "matematyka", sex: "mężczyzna")
      person4 = Person.create!(name: "Anna", surname: "Salceson", email: "a@o2.pl", discipline: "polonistyka", sex: "kobieta")
      country1 = Country.create!(name: "Polska")
      institution1 = Institution.create!(name: "Uniwersytet Jagielloński", country: country1)
      institution2 = Institution.create!(name: "Politechnika Wrocławska", country: country1)
      department1 = Department.create!(name: "Wydział Matematyki", institution: institution1)
      department2 = Department.create!(name: "Wydział Matematyki", institution: institution1)
      department3 = Department.create!(name: "Wydział Polonistyki", institution: institution2)
			affiliation1 = Affiliation.create!(person: person1, department: department1, year_from: "2013", year_to: "2016")
			affiliation2 = Affiliation.create!(person: person2, department: department2, year_from: "2010", year_to: "2016")
      affiliation3 = Affiliation.create!(person: person4, department: department3, year_from: "2011", year_to: "2016")
			submission1 = Submission.create!(polish_title: "Wielki Bęben", person: person3, status: "nadesłany", language: "polski", received: "02-01-2016")
			article_revision = ArticleRevision.create!(submission: submission1, version: "1", pages: "3", pictures: "0")
      Authorship.create!(person: person2, submission: submission1, corresponding: "true", position: "0")
      
    end
   
    scenario "Dodawanie recenzji przez stronę Zgłoszone Artykuły z dwoma osobami o różnej afiliacji" do
      visit '/submissions'
      
      click_link("Wielki Bęben")
      click_button 'Dodaj recenzenta'
      within("#new_review") do
          select "Salceson, Anna,", from: "Recenzent"
          select "wysłane zapytanie", from: "Status"
          fill_in "Zapytanie wysłano", with: "02-01-2016"
          fill_in "Deadline", with: "05-03-2016"
          fill_in "Bla bla bla", with: "Uwagi"
        end
        click_button 'Dodaj'
        expect(page).not_to have_css(".has-error")
    end
  end
  end
end
