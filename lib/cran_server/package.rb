require 'rubygems/package'

class CranServer
  class Package
    NAME_REGEXP = /[[:alpha:]-]+ [[:alpha:]-]+/
    AUTHORS_REGEXP = /(?<author>#{NAME_REGEXP})\s?(,|and|\z)/
    MAINTAINER_REGEXP = /(?<name>#{NAME_REGEXP}) <(?<email>.+?)>/

    attr_reader :description

    def initialize(package_file)
      package_file_io = StringIO.new(package_file)
      package_file_reader = Zlib::GzipReader.new(package_file_io)
      package_description = nil

      Gem::Package::TarReader.new(package_file_reader).each do |entry|
        if entry.full_name.end_with?('/DESCRIPTION')
          package_description = Dcf.parse(entry.read)[0]
          break
        end
      end

      raise 'Invalid package file. Description file not found.' if package_description.nil?

      self.description = package_description
    end

    private

    def parse_authors(authors)
      authors.scan(AUTHORS_REGEXP).flatten.map { |name| { name: name } }
    end

    def parse_maintainer(maintainer)
      # TODO: Support multiple maintainers
      info = maintainer.match(MAINTAINER_REGEXP)

      return [] if info.nil?

      [{ name: info[:name], email: info[:email] }]
    end

    def description=(info)
      @description = {
        name: info['Package'],
        title: info['Title'],
        version: info['Version'],
        authors: parse_authors( info['Author'] ),
        maintainers: parse_maintainer( info['Maintainer'] ),
        description: info['Description'],
        publication: info['Date/Publication']
      }
    end
  end
end
