require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe "#full_name" do
    subject { profile.full_name }

    context "姓名両方ある場合" do
      let(:profile) { create(:profile, first_name: "First", last_name: "Last") }
      it "間にスペースか入ること" do
        is_expected.to eq "First Last"
      end
    end

    context "名のみの場合" do
      let(:profile) { create(:profile, first_name: "First", last_name: "") }
      it "スペースが入らないこと" do
        is_expected.to eq "First"
      end
    end

    context "姓のみの場合" do
      let(:profile) { create(:profile, first_name: "", last_name: "Last") }
      it "スペースが入らないこと" do
        is_expected.to eq "Last"
      end
    end

    context "両方空の場合" do
      let(:profile) { create(:profile, first_name: "", last_name: "") }
      it "空になること" do
        expect(profile.full_name.blank?).to be_truthy
      end
    end
  end
end
