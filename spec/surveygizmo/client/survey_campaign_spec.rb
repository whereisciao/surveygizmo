require 'helper'

describe Surveygizmo::API do
  let(:client) { Surveygizmo::Client.new }

  describe "#survey_campaigns" do
    before do
     stub_get("/v2/survey/1018301/surveycampaign").
       to_return(:body => fixture("survey_campaigns.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      client.survey_campaigns(1018301)
      a_get("/v2/survey/1018301/surveycampaign").
        should have_been_made
    end

    describe "filters" do
      # Accept Filters
      context "one filter" do 
        before do
         stub_get("/v2/survey/1018301/surveycampaign").
           with(:query => {
              "filter[field][0]"=>"status",
              "filter[operator][0]"=>"=",
              "filter[value][0]"=>"Active"
            }).
           to_return(:body => fixture("survey_campaigns.json"), :headers => {:content_type => "application/json; charset=utf-8"})
        end

        it "requests the correct resource" do
          client.survey_campaigns(1018301, :filter => {
            "field" => "status",
            "operator" => "=",
            "value" => "Active"
          })
          a_get("/v2/survey/1018301/surveycampaign").
           with(:query => {
              "filter[field][0]"=>"status",
              "filter[operator][0]"=>"=",
              "filter[value][0]"=>"Active"
            }).
            should have_been_made
        end
      end
    end
  end

  describe "#survey_campaign" do
    before do
     stub_get("/v2/survey/1018301/surveycampaign/673550").
       to_return(:body => fixture("survey_campaign.json"), :headers => {:content_type => "application/json; charset=utf-8"})
    end
    it "requests the correct resource" do
      client.survey_campaign(1018301, 673550)
      a_get("/v2/survey/1018301/surveycampaign/673550").
        should have_been_made
    end
  end
end
