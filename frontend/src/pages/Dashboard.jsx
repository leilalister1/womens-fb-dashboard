import { useEffect, useState } from "react";
import axios from "axios";

import Sidebar from "../components/Sidebar";
import StatsCard from "../components/StatsCard";
import TeamTable from "../components/TeamTable";
import PlayerList from "../components/PlayerList";

export default function Dashboard() {
  const [teams, setTeams] = useState([]);
  const [players, setPlayers] = useState([]);

  // Fetch data once when dashboard loads
  useEffect(() => {
    const fetchData = async () => {
      try {
        const teamsRes = await axios.get("http://localhost:3000/teams");
        const playersRes = await axios.get("http://localhost:3000/players");

        setTeams(teamsRes.data);
        setPlayers(playersRes.data);
      } catch (err) {
        console.error("API error:", err);
      }
    };

    fetchData();
  }, []);

  return (
    <div className="flex min-h-screen bg-gray-100">
      
      {/* Sidebar */}
      <Sidebar />

      {/* Main content */}
      <main className="flex-1 p-6">
        <h1 className="text-3xl font-bold mb-6">
          Women’s Football Dashboard
        </h1>

        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mb-8">
          <StatsCard title="Total Teams" value={teams.length} />
          <StatsCard title="Total Players" value={players.length} />
          <StatsCard title="Season" value="2024" />
        </div>

        {/* Data sections */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <TeamTable teams={teams} />
          <PlayerList players={players} />
        </div>
      </main>
    </div>
  );
}
