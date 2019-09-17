# should have subject defined that successfully returns paginated results

shared_context :should_have_pagination do |model_name|
  context 'should have pagination' do
    before do
      create_list(model_name, 3)
      params.merge!(per_page: 2)
    end

    it 'should split results per page' do
      subject

      json = JSON.parse(response.body)
      expect(json[model_name.to_s.pluralize].length).to eq 2
    end

    it 'should return count' do
      subject

      json = JSON.parse(response.body)
      expect(json['count']).to eq model_name.to_s.capitalize.constantize.count
    end

    it 'should include pagination params in documentation' do
      subject
      doc_params = response.request.env['grape.routing_args'][:route_info].params
      expect(doc_params['page']).not_to be_nil
      expect(doc_params['per_page']).not_to be_nil
      expect(doc_params['offset']).not_to be_nil
    end
  end
end
