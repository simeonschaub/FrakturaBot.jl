module Tofrak

macro unicodeconversion(name::Symbol, function_dict_name::Symbol, offset_upperc::Int, offset_numbers::Int=0,
						exceptions_upperc::Expr=:(Dict()), exceptions_lowerc::Expr=:(Dict()),
						offset_lowerc::Int=offset_upperc-6, enable_function_dict::Bool=true)

	name = string(name)
	fname = esc(Symbol("to$name"))

	if_upper = :(c + $offset_upperc)
	if !isempty(eval(exceptions_upperc))
		if_upper = quote
			try $exceptions_upperc[c]
			catch
				$if_upper
			end
		end
	end

	if_lower = :(c + $offset_lowerc)
	if !isempty(eval(exceptions_lowerc))
		if_lower = quote
			try $exceptions_lowerc[c]
			catch
				$if_lower
			end
		end
	end

	else_ = :c
	if offset_numbers ≠ 0
		else_ = quote
			'0'≤c≤'9' ? c+$offset_numbers : $else_
		end
	end
	
	add_to_dict = if enable_function_dict
		quote
			$(esc(function_dict_name))[$name] = $fname
		end
	end

	return quote
		function $fname(c::Char)
			if 'a'≤c≤'z'
				$if_lower
			elseif 'A'≤c≤'Z' 
				$if_upper
			else
				$else_
			end
		end

		function $fname(s::String)
			return map($fname, s)
		end

		$add_to_dict
	end
end

styles = Dict{String, Function}()

@unicodeconversion frak styles 120003 0 Dict('C'=>'ℭ', 'H'=>'ℌ', 'I'=>'ℑ', 'R'=>'ℜ', 'Z'=>'ℨ') 
@unicodeconversion bb styles 120055 120744 Dict('C'=>'ℂ', 'H'=>'ℍ', 'N'=>'ℕ', 'P'=>'ℙ', 'Q'=>'ℚ',
				      						   'R'=>'ℝ', 'Z'=>'ℤ')
@unicodeconversion scr styles 119899 0 Dict('B'=>'ℬ', 'E'=>'ℰ', 'F'=>'ℱ', 'H'=>'ℋ', 'I'=>'ℐ', 'L'=>'ℒ',
				      					   'M'=>'ℳ', 'R'=>'ℛ') Dict('e'=>'ℯ', 'g'=>'ℊ', 'o'=>'ℴ') 
@unicodeconversion bfrak styles 120107 120734
@unicodeconversion bscr styles 119951 120734
@unicodeconversion b styles 119743 120734
@unicodeconversion it styles 119795 0 Dict() Dict('h'=>'ℎ')
@unicodeconversion bi styles 119847 120734
@unicodeconversion sans styles 120159 120754
@unicodeconversion bsans styles 120211 120764
@unicodeconversion isans styles 120263 120754
@unicodeconversion bisans styles 120315 120764
@unicodeconversion mono styles 120367 120774

end
