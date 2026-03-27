import os
import webbrowser
from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS

# 🎯 AURA CONNECT: Persistence & Runtime Sync
app = Flask(__name__, static_folder='../frontend', static_url_path='')
CORS(app)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
SCHEMA_PATH = os.path.join(BASE_DIR, '../database/clinical_trial_schema.sql')

# 1. API: Load data from file
@app.route('/api/get-schema', methods=['GET'])
def get_schema():
    try:
        target = os.path.normpath(SCHEMA_PATH)
        if not os.path.exists(target):
            return jsonify({'success': False, 'error': 'DQL file not found'}), 404
        with open(target, 'r') as f:
            return jsonify({'success': True, 'schema': f.read()})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

# 2. API: Persist changes back to the SQL file
@app.route('/api/persist', methods=['POST'])
def persist():
    try:
        data = request.get_json()
        sql_command = data.get('sql')
        
        if not sql_command:
            return jsonify({'success': False, 'error': 'No SQL provided'}), 400
            
        target = os.path.normpath(SCHEMA_PATH)
        
        # Append the new operation to the master file
        with open(target, 'a') as f:
            f.write(f"\n-- Auto-Persisted at Runtime\n{sql_command};\n")
            
        print(f"-> Clinical Persistence: Logged action to {target}")
        return jsonify({'success': True})
    except Exception as e:
        return jsonify({'success': False, 'error': str(e)}), 500

@app.route('/')
def home():
    return send_from_directory(app.static_folder, 'index.html')

if __name__ == '__main__':
    print("\n>>> AURA PERSISTENCE SERVER STARTING...")
    print("---------------------------------------")
    print("URL: http://localhost:5500")
    print("STORAGE: " + os.path.abspath(SCHEMA_PATH))
    print("---------------------------------------\n")
    
    webbrowser.open('http://localhost:5500')
    app.run(debug=True, port=5500)
