RSpec.describe PaneronRegistry::Registry do
  let(:registry) do
    PaneronRegistry::Registry.new("spec/fixtures/test-registry", "reg-1")
  end

  describe "item classes" do
    it "lists out item classes" do
      expect(registry.item_class_names).to contain_exactly(
        "item-class-1",
        "item-class-2",
        "item-class-3",
      )
    end

    it "retrieves item classes" do
      registry.item_class.each do |item_class|
        expect(item_class).to be_instance_of(PaneronRegistry::ItemClass)
      end
    end

    it "lists out item UUIDs" do
      expect(registry.item_uuids.length).to be(9)
    end
  end

  it "gets registry metadata" do
    expect(registry.get_metadata_yaml).to eql(
      {
        "contentSummary" => "<p> This is a test registry. </p>",
        "name" => "Test Registry 1",
        "operatingLanguage" => {
          "country" => "N/A",
          "languageCode" => "eng",
          "name" => "English",
        },
        "organizations" => {
          "00000000-000a-000b-000c-000000000000" => {
            "logoURL" => "",
            "name" => "Stake Holdings, Inc.",
          },
        },
        "stakeholders" => [
          {
            "contacts" => [
              {
                "label" => "email",
                "value" => "stakeholder1@example.com",
              },
            ],
            "gitServerUsername" => "stakeholder1",
            "name" => "Stake Holder 1",
            "roles" => ["submitter",
                        "manager",
                        "control-body-reviewer",
                        "control-body",
                        "owner"],
          },
          {
            "affiliations" => {
              "00000000-000a-000b-000c-000000000000" => {
                "role" => "member",
              },
            },
            "contacts" => [{
              "label" => "email",
              "value" => "stakeholder2@example.com",
            }],
            "gitServerUsername" => "stakeholder2",
            "name" => "Stake Holder 2",
            "roles" => ["owner", "manager"],
          },
        ],
        "version" => {
          "id" => "1.1",
          "timestamp" => Time.parse("2024-01-01 07:00:00.000000000 +0000"),
        },
      },
    )
  end
end
