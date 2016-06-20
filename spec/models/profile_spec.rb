require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "#full_name" do
    context "両方ある場合" do
      it "間にスペースが入ること" do
        profile = create(:profile, first_name: "First", last_name: "Last")
        expect(profile.full_name).to eq "First Last"
      end
    end

    context "名のみの場合" do
      it "スペースが入らないこと" do
        profile = create(:profile, first_name: "First")
        expect(profile.full_name).to eq "First"
      end
    end

    context "姓のみの場合" do
      it "スペースが入らないこと" do
        profile = create(:profile, last_name: "Last")
        expect(profile.full_name).to eq "Last"
      end
    end

    context "両方空の場合" do
      it "空になること" do
        profile = create(:profile)
        expect(profile.full_name.blank?).to be_truthy
      end
    end
  end
end
