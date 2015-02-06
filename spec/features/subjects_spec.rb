feature 'Subjects' do
  scenario do
    visit '/'
    click_link '11+ Common Entrance'
    subjects.each do |s|
      expect(page.body).to include s
    end
  end

  def subjects
    %w[ English Maths Science ]
  end
end
