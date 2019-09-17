# should have subject defined that successfully returns paginated results

shared_context :should_have_pagination do |model_name|
  context 'should have pagination' do
    it 'should split results per page' do
      create_list(model_name, 2)
      params.merge!(per_page: 1)

      subject

      json = JSON.parse(response.body)
      expect(json.length).to eq 1
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
