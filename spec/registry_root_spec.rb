RSpec.describe PaneronRegistry::RegistryRoot do
  it "detects invalid registry path on initialization" do
    expect do
      PaneronRegistry::RegistryRoot.new("spec/fixtures/doesnotexist")
    end.to raise_error PaneronRegistry::Error
  end

  it "allows valid registry path on initialization" do
    root = PaneronRegistry::RegistryRoot.new("spec/fixtures/test-registry")
    expect(root).to be_instance_of PaneronRegistry::RegistryRoot
  end

  describe "with a valid registry root repository" do
    let(:root) do
      PaneronRegistry::RegistryRoot.new("spec/fixtures/test-registry")
    end

    it "gets registry root metadata" do
      expect(root.get_root_metadata).to eql(
        {
          "datasets" => { "reg-1" => true },
          "title" => "registry",
        },
      )
    end

    it "lists out registries" do
      expect(root.list_registries).to contain_exactly(
        "reg-1",
        "reg-2",
        "reg-3",
      )
    end

    it "gets registry metadata" do
      expect(root.get_registry("reg-1")).to be_instance_of(
        PaneronRegistry::Registry,
      )
    end
  end
end
