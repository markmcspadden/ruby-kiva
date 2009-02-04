require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

module LoanSpecHelper
  def search_results_raw
    {"paging"=>{"total"=>32566, "page_size"=>20, "pages"=>1629, "page"=>1}, 
    "loans"=>[{"borrower_count"=>1, 
                "status"=>"paid", 
                "name"=>"Waliholla Ali", 
                "posted_date"=>"2008-12-30T17:30:20Z", 
                "activity"=>"Farming", 
                "paid_amount"=>1050, 
                "id"=>81893, 
                "description"=>{"languages"=>["en"]}, 
                "partner_id"=>34, 
                "use"=>"To increase his agricultural business.", 
                "loan_amount"=>1050, 
                "funded_amount"=>1050, 
                "image"=>{"template_id"=>1, "id"=>248766}, 
                "location"=>{"country"=>"Afghanistan", "geo"=>{"type"=>"point", "level"=>"town", "pairs"=>"34.42 70.45"}, 
                "town"=>"Jalalabad"}, 
                "sector"=>"Agriculture"}]}
  end
end

describe Kiva::Loan do
  include LoanSpecHelper

  describe "attributes" do
    before(:each) do
      @loan = Kiva::Loan.new(:status => "paid", :loan_amount => 1050)
    end
    
    it "should get the status attribute set during initialization" do
      @loan.status.should == "paid"
    end
    
    it "should get the loan ammount" do
      @loan.loan_amount.should == 1050
    end
    
    it "should NOT set the loan ammount after initialization (Kiva data is currently read only)" do
      lambda{@loan.loan_amount = 1150}.should raise_error(NoMethodError)
    end
  end # attributes
  
  describe "search" do    
    before(:each) do
      @response = mock("response", :body => "{}")
    end
    
    it "should make the search request" do
      Net::HTTP.should_receive(:get_response).with(URI.parse("http://api.kivaws.org/v1/loans/search.json?q=farm")).and_return(@response)
      Kiva::Loan.search(:q => "farm")      
    end
    
    it "should parse the JSON response" do
      Net::HTTP.stub!(:get_response).and_return(@response)
      
      JSON.should_receive(:parse).with(@response.body)
      Kiva::Loan.search(:q => "farm")
    end
    
    it "should search loans based on status (fundraising,funded,in_repayment,paid,defaulted)" do
      Net::HTTP.should_receive(:get_response).with(URI.parse("http://api.kivaws.org/v1/loans/search.json?status=paid")).and_return(@response)
      Kiva::Loan.search(:status => "paid")
    end
    
    it "should escape any characters that would cause problems in search" do
      pending "not yet implemented"
    end
    
    it "should handle non 200 OK responses" do
      pending "not yet implemented"
    end
  end # search
  
  describe "search results" do
    before(:each) do
      Kiva::Loan.should_receive(:search).with(:q => "farm").and_return(search_results_raw)
      
      @results = Kiva::Loan.search_results(:q => "farm")
    end
    it "should ignore the paging details" do      
      @results.should_not include(search_results_raw["paging"])
    end
    it "should get loans that are of type Kiva::Loan" do
      @results.first.class.to_s.should == "Kiva::Loan"
    end
    it "should handle a raw search result with a loans entry" do
      pending "not yet implemented"
    end
  end # search results
  
end # Kiva::Loan