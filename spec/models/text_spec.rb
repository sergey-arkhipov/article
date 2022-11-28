require 'rails_helper'


# rubocop:disable Metrics/BlockLength

RSpec.describe 'Testing model Text', type: :model do
  fixtures :articles, :texts
  let(:article) { articles(:one) }
  let(:text) { texts(:one) }

  context 'Working with Text' do
    it 'Create Version' do
      count = Text.count
      article.texts.create(text: 'BlaBlaBla')
      expect(Text.count - count).to(eq(1))
    end
    it 'Delete Version' do
      count = Text.count
      text.destroy
      expect(Text.count - count).to(eq(-1))
    end
    it 'Cannot create Version without Text' do
      text = article.texts.create(text: nil)
      expect(text).to_not be_valid
    end
    it 'Cannot create Version without Article' do
      text = Text.new(text: 'BlaBla')
      expect(text).to_not be_valid
    end
    it 'Article changed_on shoud be filled from current Version' do
      freeze_time do
        article.texts.create(text: 'BlaBla')
        expect(article.reload.changed_on).to(eq(DateTime.now))
      end
    end
  end
end
