// server.js - API - starts server, accepts HTTP requests , Query teh DB, returns JSON

require('dotenv').config();

const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = 3000;

// ✅ Enable CORS for Vite frontend
app.use(cors({
  origin: 'http://localhost:5173'
}));

// Middleware to parse JSON
app.use(express.json());

// PostgreSQL connection
const pool = new Pool({
  user: process.env.DB_USER,
  host: process.env.DB_HOST,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  port: process.env.DB_PORT,
});

// Test DB connection
pool.connect((err, client, release) => {
  if (err) {
    return console.error('Error acquiring client', err.stack);
  }
  console.log('Connected to PostgreSQL database!');
  release();
});

// Routes

// Get all players
app.get('/players', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM Player ORDER BY PlayerID');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Get all teams
app.get('/teams', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM Team ORDER BY TeamName');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Get all staff
app.get('/staff', async (req, res) => {
  try {
    const result = await pool.query('SELECT * FROM Staff ORDER BY StaffID');
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Get all player statistics
app.get('/playerstats', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM PlayerStatistics ORDER BY PlayerID, Year'
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Get all team statistics
app.get('/teamstats', async (req, res) => {
  try {
    const result = await pool.query(
      'SELECT * FROM TeamStatistics ORDER BY TeamName, Year'
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Get players by team
app.get('/players/:team', async (req, res) => {
  const team = req.params.team;
  try {
    const result = await pool.query(
      'SELECT * FROM Player WHERE TeamName = $1 ORDER BY PlayerID',
      [team]
    );
    res.json(result.rows);
  } catch (err) {
    console.error(err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Start server
app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});