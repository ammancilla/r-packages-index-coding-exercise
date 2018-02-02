require 'rails_helper'

describe CranServer do
  let!(:server) { CranServer.new }

  describe "#package_list", vcr: { cassette_name: 'package list' } do
    it 'returns all the packages listed in the server' do
      expect(server.package_list.first).to be_a(Hash)
      expect( server.package_list[0]['Package'] ).to eq('A3')
      expect( server.package_list[0]['Version'] ).to eq('1.0.0')
      expect(server.package_list.count).to be(12101)
    end
  end

  describe "#fetch_package_file", vcr: { cassette_name: 'package file' } do
    it 'returns the proper package file for a given package and version' do
      # TODO: Should assert the content of the file.
      expect( server.fetch_package_file('A3', '1.0.0') ).not_to be(nil)
    end
  end
end
