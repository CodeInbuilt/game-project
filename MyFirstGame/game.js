// Get canvas
const canvas = document.getElementById("gameCanvas");
const ctx = canvas.getContext("2d");

// Canvas size (if not set in HTML)
canvas.width = 800;
canvas.height = 500;

// ================== PLAYER ==================
const player = {
    x: 375,
    y: 440,
    width: 50,
    height: 50,
    speed: 6
};

// ================== GAME VARIABLES ==================
let keys = {};
let enemies = [];
let score = 0;
let gameOver = false;

// ================== CONTROLS ==================
document.addEventListener("keydown", (e) => {
    keys[e.key] = true;
});

document.addEventListener("keyup", (e) => {
    keys[e.key] = false;
});

// ================== CREATE ENEMY ==================
function createEnemy() {
    const size = 40;
    const x = Math.random() * (canvas.width - size);

    enemies.push({
        x: x,
        y: -size,
        width: size,
        height: size,
        speed: 2 + Math.random() * 3
    });
}

// ================== COLLISION CHECK ==================
function isColliding(a, b) {
    return (
        a.x < b.x + b.width &&
        a.x + a.width > b.x &&
        a.y < b.y + b.height &&
        a.y + a.height > b.y
    );
}

// ================== UPDATE ==================
function update() {

    if (gameOver) return;

    // Player movement
    if (keys["ArrowLeft"] && player.x > 0)
        player.x -= player.speed;

    if (keys["ArrowRight"] && player.x + player.width < canvas.width)
        player.x += player.speed;

    // Move enemies
    enemies.forEach((enemy, index) => {
        enemy.y += enemy.speed;

        // Check collision
        if (isColliding(player, enemy)) {
            gameOver = true;
        }

        // Remove enemy if off screen
        if (enemy.y > canvas.height) {
            enemies.splice(index, 1);
            score++;
        }
    });
}

// ================== DRAW ==================
function draw() {

    ctx.clearRect(0, 0, canvas.width, canvas.height);

    // Player
    ctx.fillStyle = "cyan";
    ctx.fillRect(player.x, player.y, player.width, player.height);

    // Enemies
    ctx.fillStyle = "red";
    enemies.forEach(enemy => {
        ctx.fillRect(enemy.x, enemy.y, enemy.width, enemy.height);
    });

    // Score
    ctx.fillStyle = "white";
    ctx.font = "20px Arial";
    ctx.fillText("Score: " + score, 10, 25);

    // Game Over
    if (gameOver) {
        ctx.fillStyle = "yellow";
        ctx.font = "40px Arial";
        ctx.fillText("GAME OVER", 280, 250);
        ctx.font = "20px Arial";
        ctx.fillText("Refresh to Restart", 300, 290);
    }
}

// ================== GAME LOOP ==================
function gameLoop() {
    update();
    draw();
    requestAnimationFrame(gameLoop);
}

// Spawn enemies every 1 second
setInterval(createEnemy, 1000);

// Start game
gameLoop();
