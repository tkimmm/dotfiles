local colors <const> = {
	black_1 = 0xff181819,
	-- white = 0xfff8f8f2,
	-- red = 0xf1cc3e44,
	green = 0xff8aff81,
	-- blue = 0xff5199ba,
	-- yellow = 0xffffff81,
	-- orange = 0xfff4c07b,
	-- magenta = 0xd3fc7ebd,
	-- purple = 0xff796fa9,
	-- other_purple = 0xff302c45,
	-- cyan = 0xff7bf2de,
	-- grey = 0xff7f8490,
	-- dirty_white = 0xc8cad3f5,
	-- dark_grey = 0xff2b2736,
	black = 0xff181819,
	white = 0xffe2e2e3,
	red = 0xffed8796,
	-- blue = 0xff1e1e2e,
	blue = 0xff8aadf4,
	yellow = 0xffeed49f,
	orange = 0xfff5a97f,
	magenta = 0xffc6a0f6,
	purple = 0xffc29df1,
	grey = 0xff7f8490,
	other_purple = 0xff302c45,
	cyan = 0xff7bf2de,
	dark_grey = 0xff2b2736,
	dirty_white = 0xc8cad3f5,
	lightblack = 0x8a262323,
	try = 0xff100f19,
	try2 = 0xff1b1e28,
	try3 = 0xff262531,
	try_border = 0xff58618e,
	try4 = 0xff1e1e1e,
	transparent = 0x00000000,
	ala_back = 0xff1e1e2e,
	bar = {
		-- transparent = 0x00000000,
		bg = 0xf1151320,
		border = 0xff2c2e34,
	},
	popup = {
		bg = 0xf1151320,
		border = 0xff2c2e34,
	},
	slider = {
		bg = 0xf1151320,
		border = 0xff2c2e34,
	},

	bg1 = 0xff181819,
	bg2 = 0xff8aadf4,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}

-- Catpucinno
-- return {
-- 	black = 0xff181819,
-- 	white = 0xffe2e2e3,
-- 	red = 0xffed8796,
-- 	green = 0xffa6da95,
-- 	blue = 0xff8aadf4,
-- 	yellow = 0xffeed49f,
-- 	orange = 0xfff5a97f,
-- 	magenta = 0xffc6a0f6,
-- 	purple = 0xffc29df1,
-- 	grey = 0xff7f8490,
-- 	dirty_white = 0xc8cad3f5,
-- 	lightblack = 0x8a262323,
-- 	transparent = 0x00000000,
-- 	try = 0xff100f19,
-- 	try2 = 0xff1b1e28,
-- 	try3 = 0xff262531,
-- 	try_border = 0xff58618e,
-- 	try4 = 0xff1e1e1e,
--
-- 	bar = {
-- 		bg = 0xf10a0913,
-- 		border = 0xff2c2e34,
-- 	},
-- 	popup = {
-- 		bg = 0xc02c2e34,
-- 		border = 0xffc29df1
-- 	},
-- 	bg1 = 0xd31e1d29,
-- 	bg2 = 0xff131122, --0x88211f21
--
-- 	with_alpha = function(color, alpha)
-- 		if alpha > 1.0 or alpha < 0.0 then return color end
-- 		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
-- 	end,
-- }
return colors
