require 'rails_helper'

describe CranServer::Package do
  let!(:expected_description) do
    {
      name: "A3",
      title: "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
      version: "1.0.0",
      authors: [ { name: "Scott Fortmann-Roe"} ],
      maintainers: [
	{ name: "Scott Fortmann-Roe", email: "scottfr@berkeley.edu"}
      ],
      description: "Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
      publication: "2015-08-16 23:05:52"
    }
  end

  describe ".new", vcr: { cassette_name: 'package file' } do
    it 'returns a new CranServer::Package instance with properly parsed attributes' do
      package_file = CranServer.new.fetch_package_file('A3', '1.0.0')

      expect( CranServer::Package.new(package_file).description ).to eq(expected_description)
    end
  end
end



