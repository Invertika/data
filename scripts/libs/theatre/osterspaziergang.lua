plotOsterspaziergang = {}

plotOsterspaziergang:step=0

--NPCs
plotOsterspaziergang.Julia=0

-- Konstuktor
function plotOsterspaziergang:new()
	local res = {}
	setmetatable(res, self)
	self.__index = self
	
	return res
end

function plotOsterspaziergang.npc_talk(npc, ch)
  mana.chatmessage(ch, "Schauspieler reden nicht mit dem Publikum.")
end

function plotOsterspaziergang:nextPlotStep()
  if self.step==0 then
    self.Julia=create_npc("Julia", 45, 46 * TILESIZE + 16, 17 * TILESIZE + 16, plotOsterspaziergang.npc_talk, nil) --- Julia
    mana.being_say(self.Julia, "Vom Eise befreit sind Strom und Bäche")
  elseif self.step==1 then
    mana.being_say(self.Julia, "Durch des Frühlings holden, belebenden Blick,")
  elseif self.step==2 then
    mana.being_say(self.Julia, "Im Tale grünet Hoffnungsglück;")
  end
  
  self.step=self.step+1
end