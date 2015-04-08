defmodule ChartRepoSpec do
	use ESpec

	before do
		chart = Charts.ChartRepo.create("chart_type", "chart_title", 1)
		{:ok, chart: chart}
	end

	describe "find_for_user" do
		let :chart, do: Charts.ChartRepo.for_user(%Charts.User{id: 1}, 1)

		it do: expect(__[:chart].title).to eq("chart_title")

	end
end