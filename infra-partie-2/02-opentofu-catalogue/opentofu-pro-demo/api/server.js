const express = require("express");
const { Pool } = require("pg");
const Redis = require("redis");

const app = express();
const port = 3000;

const pool = new Pool({
    host: "postgres",
    database: process.env.POSTGRES_DB,
    user: process.env.POSTGRES_USER,
    password: process.env.POSTGRES_PASSWORD,
    port: 5432
});

const redisClient = Redis.createClient({
    socket: { host: "redis", port: 6379 }
});

redisClient.connect().catch(console.error);

app.get("/health", async (req, res) => {
    try {
        await pool.query("SELECT 1");
        await redisClient.ping();
        res.json({ status: "ok", postgres: true, redis: true });
    } catch (err) {
        res.status(500).json({ status: "error", error: err.message });
    }
});

app.get("/products", async (req, res) => {
    res.json([{ id: 1, name: "Produit démo" }]);
});

app.listen(port, () => {
    console.log(`API running on port ${port}`);
});
