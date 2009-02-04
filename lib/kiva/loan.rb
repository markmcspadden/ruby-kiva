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
      # === Returns
      # Hash
      # * paging - total, page_size, pages, page
      # * loans
      def search(params = {})
        params_string_array = []
        params.each_pair { |k,v| params_string_array << "#{k}=#{v}" }
        params_string = params_string_array.join("&")
        
        uri = URI.parse("http://api.kivaws.org/v1/loans/search.json?#{params_string}")
        
        response = Net::HTTP.get_response(uri)
        results = JSON.parse(response.body)
      end
      
      # The loans portion of the search 
      def search_results(params = {})
        search(params)["loans"]
      end
    end
    
  end
end