plotOsterspaziergang = {}

-- Konstuktor
function plotOsterspaziergang:new()
	local res = {}
	setmetatable(res, self)
	self.__index = self
	return res
end

function plotOsterspaziergang:nextPlotStep()

end