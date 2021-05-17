### A Pluto.jl notebook ###
# v0.14.5

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 7afbb9b7-74cd-4561-be11-e075cdbf6f28
using DrWatson

# ╔═╡ b9b19005-71f1-415a-bea7-7d6ff204bc0e
begin
	@quickactivate
	
	using HypertextLiteral
	using DataFramesMeta
	using Statistics
	using StatsPlots
	using PlutoUI
	using Random
	using Plots
	
	import DarkMode
	
	plotly()
	#gr()
	
	char_name = "Lily the Flapper"
	
	char_sound_url = "https://upload.wikimedia.org/wikipedia/commons/transcoded/6/62/Meow.ogg/Meow.ogg.mp3"
	
	"""
	<marquee><h1> 💃 $char_name 🎉 </h1></marquee>
	""" |> HTML
end

# ╔═╡ ec714897-5a57-427f-ac49-8b91b9d6629e
html"<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>"

# ╔═╡ 6c756024-e411-4817-b549-a2f6899861d7
DarkMode.Toolbox()

# ╔═╡ e97634ac-15bf-42cc-91db-1fef9bf87a1c
@bind wdth NumberField(100:500, default=400)

# ╔═╡ d262fe7a-c9ad-47d6-876d-359eea15265f
DarkMode.enable()

# ╔═╡ 468e8689-bf1b-4ff5-8cbe-8295b99ff742
function updown(a, b; width=nothing)
	"""
	<table class="nohover" $(width === nothing ? "" : "width=$(wdth)px")>
	<tr>
		<td>$(html(a))</td>
	</tr>
	<tr>
		<td>$(html(b))</td>
	</tr>
	</table>
	""" |> HTML
end

# ╔═╡ dcbe16e1-9b4a-4f79-acae-75c3f536b91e
function leftright(a, b; width=600)
	"""
	<table width=$(width)px class="nohover">
	<tr>
		<td>$(html(a))</td>
		<td>$(html(b))</td>
	</tr>
	</table>
	""" |> HTML
end

# ╔═╡ 6b7206b9-d6c8-4823-ab2b-be185d42d28f
leftright(
	Resource("https://media.giphy.com/media/MMp0BcvDcBe5q/giphy-downsized.gif"),
	md"""
	#### Base Stats
	- Might $(@bind might_default NumberField(0:20, default=5))
	- Mental $(@bind mental_default NumberField(0:20, default=9))
	- Mystic $(@bind mystic_default NumberField(0:20, default=10))
	- Ethos $(@bind ethos_default NumberField(0:20, default=7))
	- Luck $(@bind luck_default NumberField(0:20, default=11))
	$(Resource(char_sound_url))
	"""
	)

# ╔═╡ b3796fff-78c5-4e93-96b0-b3e6b11a77df
leftright(
	md"""
	__Current Statistics__
	- Might $(@bind might_stat NumberField(0:20, default=might_default))
	- Mental $(@bind mental_stat NumberField(0:20, default=mental_default))
	- Mystic $(@bind mystic_stat NumberField(0:20, default=mystic_default))
	- Ethos $(@bind ethos_stat NumberField(0:20, default=ethos_default))
	- Luck $(@bind luck_stat NumberField(0:20, default=luck_default))
	""",
	md"""
	__Player Points__
	- Resource Points $(@bind rp_pts NumberField(0:20, default=9))
	- Hit Points $(@bind hit_pts NumberField(0:1:50, default=10)) 
	- Willpower Points $(@bind will_stat NumberField(0:1:20, default=9)) 
	__Player Percentages__
	- Sanity $(@bind san_stat Slider(0:1:100, default=33, show_value=true))%
	- Breaking Point $(@bind bp_pct Slider(0:1:100, default=26, show_value=true))%
	- Hypergeometry $(@bind hg_pct Slider(0:1:100, default=66, show_value=true))%
	"""
)

# ╔═╡ 9024881d-9a6f-426e-a1fb-14e6a75eac3b
begin
	stats = Dict(
		"Might" => might_stat, 			
		"Mental" => mental_stat, 		
		"Mystic" => mystic_stat, 		
		"Ethos" => ethos_stat, 			
		"Luck" => luck_stat, 			
		"RP" => rp_pts,
		"Hit Points" => hit_pts,
		"Willpower" => will_stat,
		"Sanity" => san_stat,
		"Breaking Point" => bp_pct,
		"Hypergeometry" => hg_pct,
	)

	stat_names = [
		"Might"
		"Mental"
		"Mystic"
		"Ethos"
		"Luck"
		"Willpower"
	]
	
	points_names = [
		"RP"
		"Hit Points"
		""
	]
	
	pcts_names = [
		"Sanity"
		"Breaking Point"
		"Hypergeometry"
	]
	
	stats_df = stats |> DataFrame
end;

# ╔═╡ a068ec88-594b-4641-94af-f19e7ee28800
groupedbar(select(stats_df, stat_names) |> Matrix, lables=stat_names, size=(800,300), position=:stack, title="$char_name's Stats")

# ╔═╡ a26acba4-eab2-4f97-9566-42eef43d8c92
groupedbar(select(stats_df, pcts_names) |> Matrix, lables=pcts_names, size=(800,300), position=:stack, title="$char_name Pcts")

# ╔═╡ Cell order:
# ╟─7afbb9b7-74cd-4561-be11-e075cdbf6f28
# ╟─b9b19005-71f1-415a-bea7-7d6ff204bc0e
# ╟─6b7206b9-d6c8-4823-ab2b-be185d42d28f
# ╟─b3796fff-78c5-4e93-96b0-b3e6b11a77df
# ╟─9024881d-9a6f-426e-a1fb-14e6a75eac3b
# ╟─a068ec88-594b-4641-94af-f19e7ee28800
# ╟─a26acba4-eab2-4f97-9566-42eef43d8c92
# ╟─ec714897-5a57-427f-ac49-8b91b9d6629e
# ╟─6c756024-e411-4817-b549-a2f6899861d7
# ╠═e97634ac-15bf-42cc-91db-1fef9bf87a1c
# ╠═d262fe7a-c9ad-47d6-876d-359eea15265f
# ╟─468e8689-bf1b-4ff5-8cbe-8295b99ff742
# ╟─dcbe16e1-9b4a-4f79-acae-75c3f536b91e
