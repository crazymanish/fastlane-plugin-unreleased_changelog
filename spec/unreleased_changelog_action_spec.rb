describe Fastlane::Actions::UnreleasedChangelogAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The unreleased_changelog plugin is working!")

      Fastlane::Actions::UnreleasedChangelogAction.run(nil)
    end
  end
end
