require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Article, type: :model do
  context 'Working with Article' do
    it 'Create Article' do
      count = Article.count
      Article.create(author: 'Test author', title: 'Example Title')
      expect(Article.count - count).to(eq(1))
    end
    it 'Delete Article' do
      article = Article.create(author: 'Test author', title: 'Example Title')
      count = Article.count
      article.destroy
      expect(Article.count - count).to(eq(-1))
    end
    it 'Cannot create Article without author' do
      article = Article.create(author: nil, title: 'Example Title')
      expect(article).to_not be_valid
    end
    it 'Cannot create Article without title' do
      article = Article.create(author: 'Test author', title: nil)
      expect(article).to_not be_valid
    end
    it 'Article changed_on shoud be filled with current time' do
      freeze_time do
        article = Article.create(author: 'Test author', title: 'Example Title')
        expect(article.changed_on).to(eq(DateTime.now))
      end
    end
    it 'Destroy article\'s dependents' do
      article = Article.create(author: 'Test author', title: 'Example Title')
      text = article.texts.create(text: 'BlaBlaBla')
      text1 = article.texts.create(text: 'BlaBlaBla1')
      expect(article.texts.count).to(eq(2))
      expect(article.texts).to be_present
      article.destroy
      expect { article.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { text.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect { text1.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
    it 'Expect articles changed_on attribute set when new version created ' do
      article = Article.create(author: 'Test author', title: 'Example Title')
      article_time = article.changed_on
      sleep(2)
      text = article.texts.new(text: 'BlaBlaBla')
      text.save
      expect(article.reload.changed_on).not_to eq(article_time)
    end
  end
end
