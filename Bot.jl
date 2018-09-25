#!/bin/env julia
using Telegrambot
using UUIDs

include("Tofrak.jl")

botApi="bot<your_api_key>"

txtCmds = Dict{String,Function}( name => ( s -> s == " " ?
										  "You have to pass text to the command like: `/$name Hello World`" :
										  tostyle(s) )
								for (name, tostyle) in Tofrak.styles )

txtCmds["start"] = _ -> """Hi!
This Bot converts Text to various different unicode scripts.
Available Commands are:
 - /frak - 𝔉𝔯𝔞𝔨𝔱𝔲𝔯
 - /bb - 𝔻𝕠𝕦𝕓𝕝𝕖𝕤𝕥𝕣𝕦𝕔𝕜
 - /scr 𝒮𝒸𝓇𝒾𝓅𝓉
 - /mono - 𝙼𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎
 - /sans - 𝖲𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿
 - /b - 𝐁𝐨𝐥𝐝
 - /it - 𝐼𝑡𝑎𝑙𝑖𝑐
 - /bi - 𝑩𝒐𝒍𝒅 𝒊𝒕𝒂𝒍𝒊𝒄
 - /bfrak - 𝕭𝖔𝖑𝖉 𝕱𝖗𝖆𝖐𝖙𝖚𝖗
 - /bscr - 𝓑𝓸𝓵𝓭 𝓢𝓬𝓻𝓲𝓹𝓽
 - /bsans - 𝗕𝗼𝗹𝗱 𝗦𝗮𝗻𝘀
 - /isans - 𝘐𝘵𝘢𝘭𝘪𝘤 𝘚𝘢𝘯𝘴
 - /bisans - 𝘽𝙤𝙡𝙙 𝙞𝙩𝙖𝙡𝙞𝙘 𝙎𝙖𝙣𝙨"""

txtCmds["help"] = _ -> """Available Commands:
 - /frak - 𝔉𝔯𝔞𝔨𝔱𝔲𝔯
 - /bb - 𝔻𝕠𝕦𝕓𝕝𝕖𝕤𝕥𝕣𝕦𝕔𝕜
 - /scr 𝒮𝒸𝓇𝒾𝓅𝓉
 - /mono - 𝙼𝚘𝚗𝚘𝚜𝚙𝚊𝚌𝚎
 - /sans - 𝖲𝖺𝗇𝗌-𝗌𝖾𝗋𝗂𝖿
 - /b - 𝐁𝐨𝐥𝐝
 - /it - 𝐼𝑡𝑎𝑙𝑖𝑐
 - /bi - 𝑩𝒐𝒍𝒅 𝒊𝒕𝒂𝒍𝒊𝒄
 - /bfrak - 𝕭𝖔𝖑𝖉 𝕱𝖗𝖆𝖐𝖙𝖚𝖗
 - /bscr - 𝓑𝓸𝓵𝓭 𝓢𝓬𝓻𝓲𝓹𝓽
 - /bsans - 𝗕𝗼𝗹𝗱 𝗦𝗮𝗻𝘀
 - /isans - 𝘐𝘵𝘢𝘭𝘪𝘤 𝘚𝘢𝘯𝘴
 - /bisans - 𝘽𝙤𝙡𝙙 𝙞𝙩𝙖𝙡𝙞𝙘 𝙎𝙖𝙣𝙨"""

function inlineQueryHandle(s)
	return InlineQueryResultArticle[
			InlineQueryResultArticle(string(UUIDs.uuid4()),
               name, tostyle(s)) 
			for (name, tostyle) in Tofrak.styles ]
end

t = @async startBot(botApi; textHandle = txtCmds, inlineQueryHandle=inlineQueryHandle)

println("Ready...")

while true sleep(.1) end
