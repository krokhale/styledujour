require 'nokogiri'
require 'opengraph'
require 'net/http'
require 'open-uri'

module Parse
  module Page

    def parse_page(url, local_file = false)
      parsed_url = URI.parse(url)
      url = "http://#{url}" unless url =~ %r(^https?://) or local_file == true
      results = {}
      #try open graph first
      page = OpenGraph.fetch(url)
      
      if page.type? || page.image?
        results[:title] = page.title
        results[:description] = page.description || page.nokogiri_parsed_document.css("meta[name='description']").first['content']
        results[:images] = nil
        results[:images_sized] = nil
        results[:image] = page.image
        results[:site_name] = page.site_name
      else
        #add RDF/microdata here
        
        #most basic scraping. 
   
  
        @images_sized = []
        @skip_images = []
        @title_filters = []
        parsed_page = page.nokogiri_parsed_document
        
        results[:title] = self.parse_title(parsed_page)
        results[:description] = self.parse_description(parsed_page)
        results[:images] = self.parse_images(parsed_page, parsed_url)
        results[:images_sized] = @images_sized.sort {|a,b| a[:size] <=> b[:size]}.reverse
        results[:image] = results[:image_sized].first
      end
      results
    end

    def self.parse_title(doc)
      title = (doc/"head/title").inner_html
      title = @title_filters.inject(title) {|str,key| str.gsub(%r{#{key}}, '') }
      title.sub(/^[|\s]+/,'').sub(/[|\s]+$/,'').gsub(/&nbsp;/,' ')
    end

    def self.parse_description(doc)
      desc = (doc/"head/meta[@name='description']")
      desc = (doc/"head/meta[@http-equiv='Description']") unless desc.present?
      desc = (doc/"head/meta[@http-equiv='description']") unless desc.present?
      return false unless desc.present?
      desc.first.attributes['content'].try(:value)
    end

    def self.parse_images(doc, url)
      images = (doc/"img")
      valid_images = []
      images.each do |image|
        next unless image.attributes['src'].present?
        image_url = self.concat_url(url, image.attributes['src'].value)
        valid_images << image_url if self.is_valid_image? image_url
      end

      valid_images
    end

    def self.is_valid_image?(image_url)
      min_image_size = 3500
      return false if @skip_images.include? image_url
      begin
        url = URI.parse(image_url)
      rescue URI::InvalidURIError
        return false
      end
      response = nil

      http = Net::HTTP.new(url.host, url.port)
      if url.scheme == 'https'
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      begin
        response = http.request_head(url.path)
      rescue Exception
        return false
      end
      
      return false unless response 

      if !response['content-length'].present?
        response = http.get(url.path)
      end
      
      size = response['content-length'].to_i
      if size >= min_image_size and not image_url =~ /\.gif(\??.*)?$/
        @images_sized << {:size => size, :url => image_url}
        return true
      else
        return false
      end
    end

    def self.concat_url(parsed_url, path)
      return path if path =~ %r(^https?://)
      base_url = "#{parsed_url.scheme}://#{parsed_url.host}"
      base_url += parsed_url.path unless path =~ %r(^/)
      base_url += path
    end

  module_function :parse_page

  end
end

module Parse
  module Ecommerce
    class Page
      @doc
      
      def parse_page(url, local_file = false)
        parsed_url = URI.parse(url)
        url = "http://#{url}" unless url =~ %r(^https?://) or local_file == true
        results = {}
        #try open graph first
        page = OpenGraph.fetch(url)
        @doc = page.nokogiri_parsed_document
        
        if page.type? || page.image?
          results[:title] = page.title
          results[:description] = page.description || page.nokogiri_parsed_document.css("meta[name='description']").first['content']
          results[:images] = nil
          results[:images_sized] = nil
          results[:image] = page.image
          results[:site_name] = page.site_name
          results[:prices] = parse_prices
        else
          #add RDF/microdata here
          
          #most basic scraping. 
    
          @images_sized = []
          @skip_images = []
          @title_filters = []
          
          results[:title] = parse_title
          results[:description] = parse_description
          results[:images] = parse_images(parsed_url)
          results[:images_sized] = @images_sized.sort {|a,b| a[:size] <=> b[:size]}.reverse
          results[:prices] = parse_prices
        end
        results
        
      end
      
      def get_doc
        @doc
      end
      private
      def parse_title
        title = (@doc/"head/title").inner_html
        title = @title_filters.inject(title) {|str,key| str.gsub(%r{#{key}}, '') }
        title.sub(/^[|\s]+/,'').sub(/[|\s]+$/,'').gsub(/&nbsp;/,' ')
      end
  
      def parse_description
        desc = (@doc/"head/meta[@name='description']")
        desc = (@doc/"head/meta[@http-equiv='Description']") unless desc.present?
        desc = (@doc/"head/meta[@http-equiv='description']") unless desc.present?
        return false unless desc.present?
        desc.first.attributes['content'].try(:value)
      end
  
      def parse_images(url)
        images = (@doc/"img")
        valid_images = []
        images.each do |image|
          next unless image.attributes['src'].present?
          next if image.attributes['width'].present? && image.attributes['width'].value.to_i < 50
          image_url = concat_url(url, image.attributes['src'].value)
          next unless not image_url =~ /\.gif(\??.*)?$/
          valid_images << image_url if is_valid_image? image_url
        end
  
        valid_images
      end
  
      def is_valid_image?(image_url)
        min_image_size = 3500
        return false if @skip_images.include? image_url
        begin
          url = URI.parse(image_url)
        rescue URI::InvalidURIError
          return false
        end
        response = nil
  
        http = Net::HTTP.new(url.host, url.port)
        if url.scheme == 'https'
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
        end
  
        begin
          response = http.request_head(url.path)
        rescue Exception
          return false
        end
        
        return false unless response 
  
        if !response['content-length'].present?
          response = http.get(url.path)
        end
        
        size = response['content-length'].to_i
        if size >= min_image_size and not image_url =~ /\.gif(\??.*)?$/
          @images_sized << {:size => size, :url => image_url}
          return true
        else
          return false
        end
      end
  
      def concat_url(parsed_url, path)
        return path if path =~ %r(^https?://)
        base_url = "#{parsed_url.scheme}://#{parsed_url.host}"
        base_url += parsed_url.path unless path =~ %r(^/)
        base_url += path
      end
      
      def parse_prices
       ((@doc/"div").text.scan(/\$\d{0,3}.{0,1}\d+\.{0,1}\d{1,2}/)).uniq
      end
    end
  end

end