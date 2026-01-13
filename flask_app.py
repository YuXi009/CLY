from flask import Flask, redirect, render_template, request, url_for
from dotenv import load_dotenv
import os
import git
import hmac
import hashlib
from db import db_read, db_write
from auth import login_manager, authenticate, register_user
from flask_login import login_user, logout_user, login_required, current_user
import logging

logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s [%(levelname)s] %(name)s: %(message)s",
)

# Load .env variables
load_dotenv()
W_SECRET = os.getenv("W_SECRET")

# Init flask app
app = Flask(__name__)
app.config["DEBUG"] = True
app.secret_key = "supersecret"

# Init auth
login_manager.init_app(app)
login_manager.login_view = "login"

# DON'T CHANGE
def is_valid_signature(x_hub_signature, data, private_key):
    hash_algorithm, github_signature = x_hub_signature.split('=', 1)
    algorithm = hashlib.__dict__.get(hash_algorithm)
    encoded_key = bytes(private_key, 'latin-1')
    mac = hmac.new(encoded_key, msg=data, digestmod=algorithm)
    return hmac.compare_digest(mac.hexdigest(), github_signature)

# DON'T CHANGE
@app.post('/update_server')
def webhook():
    x_hub_signature = request.headers.get('X-Hub-Signature')
    if is_valid_signature(x_hub_signature, request.data, W_SECRET):
        repo = git.Repo('./mysite')
        origin = repo.remotes.origin
        origin.pull()
        return 'Updated PythonAnywhere successfully', 200
    return 'Unathorized', 401

# Auth routes
@app.get("/users")
@login_required
def users():
    users = db_read("SELECT * FROM users", ())
    return render_template ("users.html", title = "Benutzername", users = users)

@app.route("/login", methods=["GET", "POST"])
def login():
    error = None

    if request.method == "POST":
        user = authenticate(
            request.form["username"],
            request.form["password"]
        )

        if user:
            login_user(user)
            next_page = request.args.get("next")
            return redirect(next_page or url_for("patient"))

        error = "Benutzername oder Passwort ist falsch."

    return render_template(
        "auth.html",
        title="In dein Konto einloggen",
        action=url_for("login"),
        button_label="Einloggen",
        error=error,
        footer_text="Noch kein Konto?",
        footer_link_url=url_for("register"),
        footer_link_label="Registrieren"
    )


@app.route("/register", methods=["GET", "POST"])
def register():
    error = None

    if request.method == "POST":
        username = request.form["username"]
        password = request.form["password"]

        ok = register_user(username, password)
        if ok:
            return redirect(url_for("login"))

        error = "Benutzername existiert bereits."

    return render_template(
        "auth.html",
        title="Neues Konto erstellen",
        action=url_for("register"),
        button_label="Registrieren",
        error=error,
        footer_text="Du hast bereits ein Konto?",
        footer_link_url=url_for("login"),
        footer_link_label="Einloggen"
    )

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for("patient"))



# App routes
'''@app.route("/", methods=["GET", "POST"])
@login_required
def index():
     # GET
   if request.method == "GET":
        todos = db_read("SELECT id, content, due FROM todos WHERE user_id=%s ORDER BY due", (current_user.id,))
        return render_template("main_page.html", todos=todos)

    # POST
    content = request.form["contents"]
    due = request.form["due_at"]
    db_write("INSERT INTO todos (user_id, content, due) VALUES (%s, %s, %s)", (current_user.id, content, due, ))
    return redirect(url_for("index"))


@app.post("/complete")
@login_required
def complete():
    todo_id = request.form.get("id")
    db_write("DELETE FROM todos WHERE user_id=%s AND id=%s", (current_user.id, todo_id,))
    return redirect(url_for("index"))

if __name__ == "__main__":
    app.run()
'''

# Patientenliste
@app.get("/")
@login_required
def patient():
    patients = db_read ("SELECT * FROM Patient WHERE Aktivitaetsstatus = 1 ", ())
    return render_template("patient.html", title="Patientenlist", patients = patients)


#UseCase 1 Patient erfassen
@app.route("/add_patient", methods=["GET", "POST"])
@login_required
def add_patient():
    if request.method == "POST":
        Name = request.form["Name"]
        Geburtsdatum = request.form["Geburtsdatum"]
        Geschlecht = request.form["Geschlecht"]
        Gewicht = request.form["Gewicht"]
        Versicherungsnummer = request.form["Versicherungsnummer"]

        db_write(
            "INSERT INTO Patient (Name, Geburtsdatum, Geschlecht, Gewicht, Aktivitaetsstatus, Versicherungsnummer) "
            "VALUES (%s, %s, %s, %s, 1, %s)",
            (Name, Geburtsdatum, Geschlecht, Gewicht, Versicherungsnummer)
        )

        return redirect(url_for("patient"))

    return render_template("add_patient.html")


# Use Case 4 Patientenübersicht anzeigen
@app.get("/patient/<int:patienten_id>")
@login_required
def patientenuebersicht(patienten_id):
    patient = db_read(
        "SELECT * FROM Patient WHERE patienten_id = %s",
        (patienten_id,),
        single=True
    )

    if not patient:
        return "Patient nicht gefunden", 404

    return render_template(
        "patientenuebersicht.html",
        title="Patientenübersicht",
        patient=patient
    )


# Allergien
@app.route("/patient/<int:patienten_id>/allergien", methods=["GET", "POST"])
@login_required
def allergien(patienten_id):
    patient = db_read(
        "SELECT patienten_id, Name FROM Patient WHERE patienten_id = %s",
        (patienten_id,),
        single=True
    )

    if not patient:
        return "Patient nicht gefunden", 404

    if request.method == "POST":
        selected_ids = request.form.getlist("allergie_id")

        db_write(
            "DELETE FROM Patient_Allergie WHERE patienten_id = %s",
            (patienten_id,)
        )

        for aid in selected_ids:
            db_write(
                "INSERT INTO Patient_Allergie (patienten_id, allergie_id) VALUES (%s, %s)",
                (patienten_id, int(aid))
            )

        return redirect(url_for("patientenuebersicht", patienten_id=patienten_id))

    allergies = db_read(
        "SELECT allergie_id, Name FROM Allergie ORDER BY Name",
        ()
    )

    rows = db_read(
        "SELECT allergie_id FROM Patient_Allergie WHERE patienten_id = %s",
        (patienten_id,)
    )

    selected_set = {r["allergie_id"] for r in rows}

    return render_template(
        "allergien.html",
        title="Allergien bearbeiten",
        patient=patient,
        allergies=allergies,
        selected_set=selected_set
    )


# Ernährungspräferenzen
@app.route("/patient/<int:patienten_id>/ernaehrungspraeferenzen", methods=["GET", "POST"])
@login_required
def ernaehrungspraeferenzen(patienten_id):
    # Patient holen
    patient = db_read(
        "SELECT patienten_id, Name FROM Patient WHERE patienten_id = %s",
        (patienten_id,),
        single=True
    )
    if not patient:
        return "Patient nicht gefunden", 404

    # POST: Speichern
    if request.method == "POST":
        selected_ids = request.form.getlist("praeferenz_id")

        db_write(
            "DELETE FROM Patient_Ernaehrungspraeferenz WHERE patienten_id = %s",
            (patienten_id,)
        )

        for pid in selected_ids:
            db_write(
                "INSERT INTO Patient_Ernaehrungspraeferenz (patienten_id, praeferenz_id) VALUES (%s, %s)",
                (patienten_id, int(pid))
            )

        return redirect(url_for("patientenuebersicht", patienten_id=patienten_id))

    # GET: Alle Präferenzen laden
    preferences = db_read(
        "SELECT praeferenz_id, Name FROM Ernaehrungspraeferenz ORDER BY Name",
        ()
    )

    # GET: Bereits ausgewählte Präferenzen laden
    rows = db_read(
        "SELECT praeferenz_id FROM Patient_Ernaehrungspraeferenz WHERE patienten_id = %s",
        (patienten_id,)
    )
    selected_set = {r["praeferenz_id"] for r in rows}

    return render_template(
        "ernaehrungspraeferenzen.html",
        title="Ernährungspräferenzen bearbeiten",
        patient=patient,
        preferences=preferences,
        selected_set=selected_set
    )



# Medikamente
@app.route("/patient/<int:patienten_id>/medikamente", methods=["GET", "POST"])
@login_required
def medikamente(patienten_id):
    # Patient holen
    patient = db_read(
        "SELECT patienten_id, Name FROM Patient WHERE patienten_id = %s",
        (patienten_id,),
        single=True
    )
    if not patient:
        return "Patient nicht gefunden", 404

    # POST: Speichern
    if request.method == "POST":
        selected_ids = request.form.getlist("medikament_id")

        db_write(
            "DELETE FROM Patient_Medikament WHERE patienten_id = %s",
            (patienten_id,)
        )

        for mid in selected_ids:
            db_write(
                "INSERT INTO Patient_Medikament (patienten_id, medikament_id) VALUES (%s, %s)",
                (patienten_id, int(mid))
            )

        return redirect(url_for("patientenuebersicht", patienten_id=patienten_id))

    # GET: Alle Medikamente laden
    meds = db_read(
        "SELECT medikament_id, Name FROM Medikament ORDER BY Name",
        ()
    )

    # GET: Bereits ausgewählte Medikamente laden
    rows = db_read(
        "SELECT medikament_id FROM Patient_Medikament WHERE patienten_id = %s",
        (patienten_id,)
    )
    selected_set = {r["medikament_id"] for r in rows}

    return render_template(
        "medikamente.html",
        title="Medikamente bearbeiten",
        patient=patient,
        meds=meds,
        selected_set=selected_set
    )



# Gerichte
@app.get("/patient/<int:patienten_id>/gerichte")
@login_required
def gerichte(patienten_id):
    return render_template(
        "gerichte.html",
        patienten_id=patienten_id,
        title="Gerichte"
    )


# Ernährungsplan
@app.get("/patient/<int:patienten_id>/ernaehrungsplan")
@login_required
def ernaehrungsplan(patienten_id):
    return render_template(
        "ernaehrungsplan.html",
        patienten_id=patienten_id,
        title="Ernährungsplan"
    )
