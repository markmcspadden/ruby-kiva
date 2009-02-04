module Kiva
  class Loan
    
    def initialize(*args)
      attrs = {}
      
      # Get to the Hash
      attrs = args.first if args.first.is_a?(Hash)
      
      # Cycle through each pair
      # Creating reader if necessary
      # Setting value passed on args
      attrs.each_pair do |k,v|
        unless self.respond_to?(k.to_sym)
          self.class.class_eval do
            attr_reader k
          end
        end
        instance_variable_set("@#{k.to_s}", v)
      end
    end
    
    class << self
      # Search the Loans on Kiva
      # === Accepted Parameters
      # * :q - a string to query based on
      # * :status - the payment status: 'fundraising', 'funded', 'in_repayment', 'paid', 'defaulted'
      # * all the others should work but haven't been verified
      # === Returns
      # Hash
      # * paging - Hash with keys: total, page_size, pages, page
      # * loans - Array of Hashes with keys cooresponding to Kiva
      def search(params = {})
        params_string_array = []
        params.each_pair { |k,v| params_string_array << "#{k}=#{v}" }
        params_string = params_string_array.join("&")
        
        uri = URI.parse("http://api.kivaws.org/v1/loans/search.json?#{params_string}")
        
        response = Net::HTTP.get_response(uri)
        results = JSON.parse(response.body)
      end
      
      # Produce Kiva::Loan objects from the search 
      def search_results(params = {})
        loans = []
        search(params)["loans"].each do |loan|
          loans << Kiva::Loan.new(loan)
        end
        loans
      end
    end
    
  end
end