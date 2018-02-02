require 'rails_helper'

RSpec.describe Package, type: :model do
  let!(:payload) do
    {
      name: "A3",
      title: "Accurate, Adaptable, and Accessible Error Metrics for Predictive Models",
      version: "1.0.0",
      authors: [
       	{ name: "Scott Fortmann-Roe"},
       	{ name: "Apo Lonio"}
      ],
      maintainers: [
	{ name: "Scott Fortmann-Roe", email: "scottfr@berkeley.edu"}
      ],
      description: "Supplies tools for tabulating and analyzing the results of predictive models. The methods employed are applicable to virtually any predictive model and make comparisons between different methodologies straightforward.",
      publication: "2015-08-16 23:05:52"
    }
  end

  subject { Package.register(payload) }

  describe '.register' do
    it 'creates a new Package' do
      expect { subject }.to change { Package.count }.from(0).to(1)
    end

    it 'creates a new Version' do
      expect { subject }.to change { Version.count }.from(0).to(1)
    end

    it 'creates two new Person' do
      expect { subject }.to change { Person.count }.from(0).to(2)
    end

    it 'creates two new AuthorsPackage' do
      expect { subject }.to change { AuthorsPackage.count }.from(0).to(2)
    end

    it 'creates a new MaintainersPackage' do
      expect { subject }.to change { MaintainersPackage.count }.from(0).to(1)
    end
  end
end
