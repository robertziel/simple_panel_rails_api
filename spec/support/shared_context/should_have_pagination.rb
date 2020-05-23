# should have subject defined that successfully returns paginated results

shared_context :should_have_pagination do |model_name, specific_attributes_raw|
  context 'should have pagination' do
    let(:model) { model_name.to_s.camelize.constantize }
    # for example: if records are returned only if belong to user then
    # let(:user) { create(:user) }
    # specific_attributes_raw = { user: :user }
    let(:specific_attributes) do
      return {} if specific_attributes_raw.nil?

      Hash[specific_attributes_raw.map { |key, value| [key, send(value)] }]
    end

    before do
      create_list(model_name, 3, specific_attributes)
      params.merge!(per_page: 2)
    end

    it 'should split results per page' do
      subject

      json = response_body_to_json
      expect(json[model_name.to_s.pluralize.to_sym].length).to eq 2
    end

    it 'should return count' do
      subject

      json = response_body_to_json
      expect(json[:count]).to eq model.where(specific_attributes).count
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
