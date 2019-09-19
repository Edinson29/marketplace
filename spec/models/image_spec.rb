require 'rails_helper'

RSpec.describe Image, type: :model do
  it { should belong_to(:product) }

  it 'is valid' do
    subject.avatar.attach(io: File.open('public/apple-touch-icon.png'), filename: 'apple-touch-icon.png', content_type: 'image/png')
    expect(subject.avatar).to be_attached
  end
end
