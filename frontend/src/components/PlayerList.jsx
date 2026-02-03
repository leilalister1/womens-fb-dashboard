//fetches and displays a list of players from the backend API
import { useEffect, useState } from "react"; // UseState- stores data that can change and re-renders when updated
// UseEffect- performs side effects like data fetching after render
import axios from "axios"; //makes HTTP requests to backend API

export default function PlayerList() { //everytime a state changes, react calls this function to re-render the component
  const [players, setPlayers] = useState([]);
  const [error, setError] = useState(null);

  useEffect(() => { //run this code after component mounts
    axios.get("http://localhost:3000/players") 
      .then(res => {
        console.log("PLAYERS FROM API:", res.data); 
        setPlayers(res.data);
      })
      .catch(err => {
        console.error(err);
        setError("Failed to load players");
      });
  }, []);

  if (error) return <p className="text-red-500">{error}</p>;

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-3">Players</h2>

      {players.length === 0 ? (
        <p>No players loaded</p>
      ) : (
        <ul className="space-y-2">
          {players.map(player => (
            <li
              key={player.playerid}
              className="border rounded p-2"
            >
              <strong>
                {player.firstname} {player.lastname}
              </strong>
              <div className="text-sm text-gray-500">
                Team: {player.teamname}
              </div>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

