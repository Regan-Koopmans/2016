class Game:
    def __init__(self):
        self.agents = [];
    def addAgent(self, ActiveAgent):
        self.agents.append(ActiveAgent);
    def printAgents(self):
        str = ""
        for agent in self.agents:
            str += agent + " ";
        print(str);


class ActiveAgent:
    def __init__(self, name):
        self.name = name
    def __str__(self):
        return self.name


g = Game();
x = ActiveAgent("x");
y = ActiveAgent("y");
g.addAgent(x);
g.addAgent(y);
g.printAgents();
