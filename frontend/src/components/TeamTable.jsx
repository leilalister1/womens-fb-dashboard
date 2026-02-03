export default function TeamTable({ teams }) {
  return (
    <div className="bg-white p-4 rounded shadow">
      <h3 className="font-bold mb-3">Teams</h3>
      <table className="w-full">
        <tbody>
          {teams.map(team => (
            <tr key={team.TeamName} className="border-t">
              <td className="py-2">{team.TeamName}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

