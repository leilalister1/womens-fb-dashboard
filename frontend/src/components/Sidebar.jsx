export default function Sidebar() {
  return (
    <aside className="w-64 bg-slate-900 text-white p-4">
      <h2 className="text-xl font-bold mb-6">Dashboard</h2>

      <nav className="space-y-2">
        <button className="block w-full text-left hover:text-blue-400">
          Teams
        </button>
        <button className="block w-full text-left hover:text-blue-400">
          Players
        </button>
        <button className="block w-full text-left hover:text-blue-400">
          Stats
        </button>
      </nav>
    </aside>
  );
}
