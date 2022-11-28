require 'rails_helper'
require 'elastic_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe 'Working with Elasticsearch', type: :model do
  context 'Working with Elasticsearch' do
    it 'Destroy Article index' do
      ElascticHelper.create_elastic_index
      expect(Article.__elasticsearch__.delete_index!).to eq({ 'acknowledged' => true })
    end

    it 'Create Article index' do
      ElascticHelper.drop_elastic_index
      expect(Article.__elasticsearch__.create_index!).to eq({ 'acknowledged' => true, 'shards_acknowledged' => true,
                                                              'index' => 'articles' })
    end

    it 'Create articles fill elasticsearch' do
      FactoryBot.create_list(:article, 50)
      count_db = Article.all.count
      count_elastic = Article.__elasticsearch__.all.count
      expect(count_db).to be(50)
      expect(count_elastic).to be(50)
    end

    it 'Expect elasticsearch return default records size' do
      FactoryBot.create_list(:article, 20)
      count_elastic = Article.search('*').count
      expect(count_elastic).to be(10)
    end
    it 'Expect elasticsearch perform search' do
      FactoryBot.create_list(:article, 10, :with_text)
      # binding.pry
      count_elastic = Article.search('9').count
      expect(count_elastic).to be(1)
    end
  end
end
