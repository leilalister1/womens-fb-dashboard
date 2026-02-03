import { useEffect, useState } from 'react'
import axios from 'axios'

function TeamList() {
  const [teams, setTeams] = useState([])

  useEffect(() => {
    axios.get('http://localhost:3000/teams')
      .then(res => setTeams(res.data))
      .catch(err => console.error(err))
  }, [])

  return (
    <div className="p-4">
      <h2 className="text-xl font-semibold mb-2">Teams</h2>

      <ul className="space-y-1">
        {teams.map(team => (
          <li
            key={team.teamid || team.TeamID || team.TeamName}
            className="p-2 bg-gray-100 rounded"
          >
            {team.teamname || team.TeamName}
          </li>
        ))}
      </ul>
    </div>
  )
}

export default TeamList
