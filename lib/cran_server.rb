require 'dcf'
require 'open-uri'

class CranServer
  DEFAULT_LOCATION = 'https://cran.r-project.org/src/contrib'.freeze

  attr_reader :location, :package_list

  def initialize(location = DEFAULT_LOCATION)
    @location = location
  end

  def package_list
    #
    # Too Slow
    # @packages ||= Dcf.parse(fetch_package_list)
    #

    @packages_list ||=
      fetch_package_list.split("\n\n").map do |package|
	Dcf.parse(package)[0]
      end
  end

  def fetch_package_file(name, version)
    package_file_location = "#{location}/#{name}_#{version}.tar.gz"

    begin
      open(package_file_location).read
    rescue OpenURI::HTTPError => e
      raise e unless e.message.match(/404 Not Found/)
    end
  end

  private

  def fetch_package_list
    open("#{location}/PACKAGES").read
  end
end
