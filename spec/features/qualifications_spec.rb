feature 'Qualifications' do
  scenario do
    visit '/'
    qualifications.each do |q|
      expect(page.body).to include q
    end
  end

  def qualifications
    [
      '11+ Common Entrance',
      '13+ Common Entrance',
      'A Level',
      'ACT',
      'AP',
      'GCSE',
      'IGCSE',
      'SAT',
      'SAT Subject Tests',
      'Undergraduate'
    ]
  end
end
