import React from "react";
import TeamList from "./components/TeamList";
import PlayerList from "./components/PlayerList";

function App() {
  return (
    <div className="min-h-screen bg-gray-900 p-8 text-white">
      <h1 className="text-3xl font-bold mb-6">Women’s Football Dashboard</h1>
      <TeamList />
      <PlayerList />
    </div>
  );
}

export default App;