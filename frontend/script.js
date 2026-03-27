let db;
let active = "";

// Detect API Base URL
const API_BASE = (window.location.protocol === 'file:') ? 'http://localhost:5500' : '';
const SQL_VERSION = '1.10.3';

async function init() {
    try {
        console.log("-> Starting Aura Persistence Engine...");
        
        // Wait for library to be available
        if (typeof initSqlJs !== 'function') {
            await new Promise(resolve => setTimeout(resolve, 500));
        }

        window.SQL = await initSqlJs({ 
            locateFile: f => `https://cdnjs.cloudflare.com/ajax/libs/sql.js/${SQL_VERSION}/${f}` 
        });
        
        await forceSync(true);
    } catch (e) {
        console.error("Engine Initialization Failure:", e);
        showErrorScreen("Library Loading Failure: " + e.message);
    }
}

async function forceSync(boot = false) {
    try {
        document.getElementById('stat').textContent = "SYNCING...";
        let schemaText = "";
        let isStatic = false;

        try {
            const res = await fetch(`${API_BASE}/api/get-schema`);
            if (res.ok) {
                const data = await res.json();
                if (data.success) schemaText = data.schema;
            }
        } catch (apiErr) {
            console.warn("Backend API unreachable, attempting static fallback...");
        }

        if (!schemaText) {
            // FALLBACK: Try fetching the static .sql file directly (for GitHub Pages/Static Hosting)
            const staticRes = await fetch('../database/clinical_trial_schema.sql');
            if (staticRes.ok) {
                schemaText = await staticRes.text();
                isStatic = true;
            } else {
                throw new Error("Could not load database schema (API or Static).");
            }
        }
        
        db = new window.SQL.Database();
        
        try {
            db.run(schemaText);
            console.log("-> Sync Successful: Local database hydrated.");
            
            // If static, check for any cached session data in localStorage
            if (isStatic && localStorage.getItem('aura_session_sql')) {
                const cachedSql = JSON.parse(localStorage.getItem('aura_session_sql'));
                cachedSql.forEach(cmd => db.run(cmd));
                console.log("-> Restored session data from localStorage.");
            }
        } catch (sqlError) {
            console.error("SQL Schema Error:", sqlError);
            alert("Master SQL Error: " + sqlError.message);
        }
        
        if (boot) {
            document.getElementById('code').value = schemaText;
        }
        
        document.getElementById('err').style.display = 'none';
        
        const statEl = document.getElementById('stat');
        if (isStatic) {
            statEl.textContent = "STATIC MODE (GH PAGES)";
            statEl.className = "status-pill warning";
            statEl.title = "Changes are saved to browser session only. Use 'Download SQL' to persist manually.";
        } else {
            statEl.textContent = "PERMANENCE ACTIVE";
            statEl.className = "status-pill online";
        }
        
        refreshSide();
        if (!boot) alert(isStatic ? "State reloaded (Static)." : "Successfully reloaded from backend and synchronized state!");
    } catch (e) {
        console.error("Sync Failure:", e);
        showErrorScreen("Database Unreachable. Make sure files are accessible or backend is running.");
    }
}

function showErrorScreen(msg = "") {
    const errDiv = document.getElementById('err');
    if (errDiv) {
        errDiv.style.display = 'flex';
    }
    document.getElementById('stat').textContent = "DISCONNECTED";
    document.getElementById('stat').className = "status-pill";
    if (msg) {
        console.log("Status Message:", msg);
    }
}

// 🚀 THE CORE: Persist changes back to the system
async function persist(sql) {
    try {
        const writeKeywords = ["INSERT", "UPDATE", "DELETE", "CREATE", "DROP", "ALTER"];
        const isWrite = writeKeywords.some(kw => sql.toUpperCase().includes(kw));

        if (isWrite) {
            // 1. Try Remote Persistence (Flask Backend)
            let persistedRemotely = false;
            try {
                const response = await fetch(`${API_BASE}/api/persist`, {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/json' },
                    body: JSON.stringify({ sql: sql })
                });
                const result = await response.json();
                if (result.success) persistedRemotely = true;
            } catch (e) {
                console.warn("Remote persistence unreachable.");
            }

            // 2. Always backup to localStorage (Safety/Static Mode)
            const sessionKey = 'aura_session_sql';
            const existing = JSON.parse(localStorage.getItem(sessionKey) || "[]");
            existing.push(sql);
            localStorage.setItem(sessionKey, JSON.stringify(existing));
            
            console.log(persistedRemotely ? "-> Persisted to File & LocalStorage" : "-> Persisted to LocalStorage (Static Mode)");
        }
    } catch (e) {
        console.warn("Persistence Sync Error.");
    }
}

function downloadDB() {
    if (!db) return;
    try {
        // Option A: Export the SQL commands used in this session
        const sessionKey = 'aura_session_sql';
        const sessionSql = JSON.parse(localStorage.getItem(sessionKey) || "[]");
        
        // Option B: Better yet, get current schema and combine
        fetch(`${API_BASE}/api/get-schema`)
            .then(res => res.json())
            .then(data => {
                const fullSql = data.schema + "\n\n-- AUTO-GENERATED UPDATES\n" + sessionSql.join(";\n") + ";";
                const blob = new Blob([fullSql], { type: 'text/sql' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'clinical_trial_schema_updated.sql';
                a.click();
            })
            .catch(() => {
                // If backend fetch fails, just export the session SQL
                const blob = new Blob([sessionSql.join(";\n") + ";"], { type: 'text/sql' });
                const url = URL.createObjectURL(blob);
                const a = document.createElement('a');
                a.href = url;
                a.download = 'updates_only.sql';
                a.click();
                alert("Only session updates exported (Schema file was unreachable).");
            });
    } catch (e) {
        alert("Export failed: " + e.message);
    }
}

function refreshSide() {
    if (!db) return;
    const list = document.getElementById('sideList');
    try {
        const res = db.exec("SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
        const tables = res.length > 0 ? res[0].values.flat() : [];
        
        list.innerHTML = tables.map(t => `
            <div class="nav-item" id="nav-${t}" onclick="openTable('${t}')">
                <i class="fas fa-table"></i> ${t}
            </div>
        `).join('');
        
        if (active && tables.includes(active)) {
            openTable(active);
        } else if (tables.length > 0 && !active) {
            openTable(tables[0]);
        }
    } catch (e) {
        console.error("Sidebar Refresh Error:", e);
    }
}

function openTable(t) {
    if (!db) return;
    active = t;
    setMode('exp');
    
    document.querySelectorAll('.nav-item').forEach(el => el.classList.remove('active'));
    const nav = document.getElementById(`nav-${t}`);
    if (nav) nav.classList.add('active');
    
    document.getElementById('curTitle').textContent = t.replace('_', ' ');
    document.getElementById('curTools').innerHTML = `<button class="btn-plus" onclick="addRec('${t}')">+ NEW RECORD</button>`;
    
    renderTable();
}

function renderTable() {
    if (!db || !active) return;
    try {
        const res = db.exec(`SELECT * FROM ${active}`);
        const head = document.getElementById('gridHead');
        const body = document.getElementById('gridBody');
        
        const metaRes = db.exec(`PRAGMA table_info(${active})`);
        if (metaRes.length === 0) return;
        
        const meta = metaRes[0].values;
        const cols = meta.map(v => v[1]);
        const pk = meta.find(v => v[5] === 1)?.[1] || cols[0];
        const pkIdx = cols.indexOf(pk);

        head.innerHTML = `<tr>${cols.map(c => `<th>${c}</th>`).join('')}<th>ACTIONS</th></tr>`;
        
        if (res.length === 0) {
            body.innerHTML = `<tr><td colspan="${cols.length + 1}" style="text-align:center; padding:100px; opacity:0.3;">Empty Set.</td></tr>`;
            return;
        }
        
        body.innerHTML = res[0].values.map(r => `
            <tr>
                ${r.map(v => `<td>${v !== null ? v : '<span style="opacity:0.2">NULL</span>'}</td>`).join('')}
                <td>
                    <button class="btn-del" onclick="delRec('${active}', '${pk}', '${r[pkIdx]}')">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </td>
            </tr>
        `).join('');
    } catch (e) {
        console.error("Render Error:", e);
    }
}

async function addRec(t) {
    if (!db) return;
    const meta = db.exec(`PRAGMA table_info(${t})`)[0].values;
    const cols = meta.map(v => v[1]);
    const insertCols = [];
    const insertVals = [];
    
    for (let c of cols) {
        const v = prompt(`Enter value for ${c} (leave blank for auto-generate/NULL):`);
        if (v === null) return; // User cancelled prompt
        
        if (v.trim() !== "") {
            insertCols.push(c);
            insertVals.push(`'${v.replace(/'/g, "''")}'`);
        }
    }
    
    if (insertCols.length === 0) {
        alert("Cannot insert an empty record.");
        return;
    }

    const sql = `INSERT INTO ${t} (${insertCols.join(', ')}) VALUES (${insertVals.join(', ')})`;
    try {
        db.run(sql);
        renderTable();
        await persist(sql);
        alert("Record added successfully!");
    } catch (e) {
        alert("Insert Error: " + e.message);
    }
}

async function delRec(t, pk, id) {
    if (!db) return;
    if (confirm(`Confirm deletion of record where ${pk} = '${id}'?`)) {
        const sql = `DELETE FROM ${t} WHERE ${pk} = '${id}'`;
        try {
            db.run(sql);
            renderTable();
            await persist(sql);
        } catch (e) {
            alert("Delete Error: " + e.message);
        }
    }
}

async function runStudio() {
    if (!db) {
        alert("SQL Engine not connected.");
        return;
    }
    const sqlInput = document.getElementById('code').value;
    if (!sqlInput.trim()) return;
    
    const resBox = document.getElementById('resBox');
    try {
        const res = db.exec(sqlInput);
        
        const upperSql = sqlInput.toUpperCase();
        if (upperSql.includes("CREATE") || upperSql.includes("DROP") || upperSql.includes("ALTER")) {
            refreshSide();
        }
        
        if (res.length > 0) {
            resBox.style.display = 'block';
            document.getElementById('resHead').innerHTML = `<tr>${res[0].columns.map(c => `<th>${c}</th>`).join('')}</tr>`;
            document.getElementById('resBody').innerHTML = res[0].values.map(r => `
                <tr>${r.map(v => `<td>${v !== null ? v : '--'}</td>`).join('')}</tr>
            `).join('');
        } else {
            resBox.style.display = 'none';
            alert("Execution Successful.");
            if (active) renderTable();
        }
        
        await persist(sqlInput);
    } catch (e) {
        alert("SQL Failure: " + e.message);
    }
}

function setMode(m) {
    document.getElementById('secExp').style.display = m === 'exp' ? 'block' : 'none';
    document.getElementById('secStd').style.display = m === 'std' ? 'block' : 'none';
    document.getElementById('tExp').classList.toggle('active', m === 'exp');
    document.getElementById('tStd').classList.toggle('active', m === 'std');
}

window.forceSync = forceSync;
window.setMode = setMode;
window.openTable = openTable;
window.addRec = addRec;
window.delRec = delRec;
window.runStudio = runStudio;

document.onreadystatechange = () => {
    if (document.readyState === "complete") init();
};
