# MediCare-Chain — Project Information

> A Blockchain-based Decentralized Healthcare Management System built with Django, Solidity, and Ethereum (Ganache).

---

## 1. Source Code

### Project Structure

```
MediCare-Chain/
│
├── MediCare-Chain/                  # Main Django project root
│   ├── healthcare/                  # Django project configuration
│   │   ├── settings.py              # Project settings (DB, installed apps, etc.)
│   │   ├── urls.py                  # Root URL configuration
│   │   └── wsgi.py                  # WSGI entry point
│   │
│   ├── main_app/                    # Core Django application
│   │   ├── admin.py                 # Django admin registration
│   │   ├── apps.py                  # App configuration
│   │   ├── models.py                # Database models (Patient, Doctor, etc.)
│   │   ├── views.py                 # Business logic & Web3 blockchain interactions
│   │   ├── urls.py                  # App-level URL routing
│   │   ├── tests.py                 # Unit tests
│   │   ├── migrations/              # Django database migrations
│   │   ├── static/                  # CSS, JS, images
│   │   └── templates/               # HTML templates (dashboard, login, forms, etc.)
│   │       ├── main_app/
│   │       │   ├── addPatients.html
│   │       │   ├── addDoctor.html
│   │       │   ├── donation.html
│   │       │   ├── sign.html
│   │       │   └── dashboard_base.html
│   │       └── registration/
│   │           └── login.html
│   │
│   ├── contract/                    # Ethereum Smart Contract (Truffle project)
│   │   ├── contracts/
│   │   │   └── HealthCare.sol       # Main Solidity smart contract
│   │   ├── migrations/              # Truffle deployment scripts
│   │   ├── build/                   # Compiled contract artifacts (ABI, bytecode)
│   │   ├── truffle-config.js        # Truffle network configuration
│   │   └── HealthCareABI            # Contract ABI (used by Web3.py in Django)
│   │
│   ├── db.sqlite3                   # SQLite database (patient/doctor records)
│   ├── manage.py                    # Django management entry point
│   ├── run.bat                      # One-click startup script (Ganache + Django)
│   └── start_django.bat             # Django-only startup script
│
├── README.md                        # Project overview and description
└── LICENSE                          # MIT License
```

### Key Source Files

| File | Purpose |
|------|---------|
| `main_app/models.py` | Defines `Patient`, `Doctor`, and related database models |
| `main_app/views.py` | All views including Web3.py calls to the Ethereum blockchain |
| `main_app/urls.py` | Maps URL paths to views |
| `contract/contracts/HealthCare.sol` | Solidity smart contract handling funds, donations, and transfers |
| `contract/truffle-config.js` | Truffle config pointing to Ganache on `localhost:8545` |
| `healthcare/settings.py` | Django settings including database and installed apps config |

---

## 2. Software / Tools Used

### Backend
| Tool | Version | Purpose |
|------|---------|---------|
| **Python** | 3.x | Core backend language |
| **Django** | 4.x | Web framework (MVC architecture) |
| **Web3.py** | 6.x | Python library to interact with Ethereum blockchain |
| **SQLite** | Built-in | Persistent local database for patient/doctor records |

### Blockchain
| Tool | Version | Purpose |
|------|---------|---------|
| **Ganache** | Latest (npx) | Local Ethereum blockchain simulator with data persistence |
| **Truffle** | Latest (npx) | Smart contract compilation and deployment framework |
| **Solidity** | ^0.8.x | Smart contract programming language |
| **MetaMask** | Browser Extension | Ethereum wallet for donor interactions |

### Frontend
| Tool | Purpose |
|------|---------|
| **HTML5 / CSS3** | Page structure and styling |
| **JavaScript** | Client-side interactions and Web3.js calls |
| **Bootstrap** | Responsive UI components |
| **Chart.js** | Analytics dashboard visualizations |

### Development Environment
| Tool | Purpose |
|------|---------|
| **Node.js / npm** | Required to run Truffle and Ganache via `npx` |
| **Visual Studio Code** | Code editor |
| **Git** | Version control |

---

## 3. Instructions to Execute (README)

### Prerequisites

Make sure the following are installed on your system before running the project:

- [ ] **Python 3.x** — [Download](https://www.python.org/downloads/)
- [ ] **Node.js (v16+)** — [Download](https://nodejs.org/)
- [ ] **Git** — [Download](https://git-scm.com/)
- [ ] **MetaMask** browser extension — [Install](https://metamask.io/)

---

### Step 1 — Clone the Repository

```bash
git clone https://github.com/<your-username>/MediCare-Chain.git
cd MediCare-Chain
```

---

### Step 2 — Install Python Dependencies

Navigate to the Django project folder and install required Python packages:

```bash
cd MediCare-Chain
pip install django web3
```

> If a `requirements.txt` is present, run:
> ```bash
> pip install -r requirements.txt
> ```

---

### Step 3 — Install Node.js Dependencies (for Truffle & Ganache)

```bash
cd contract
npm install
```

> Truffle and Ganache will be available via `npx` after this step.

---

### Step 4 — Run the Application

#### Option A: One-Click Startup (Recommended)

Double-click **`run.bat`** from the `MediCare-Chain/MediCare-Chain/` folder.

This script will automatically:
1. Kill any process on port `8545`
2. Start **Ganache** on `localhost:8545` with persistent blockchain data
3. Deploy the **HealthCare.sol** smart contract (first run only)
4. Update `views.py` and HTML templates with the new contract address
5. Start the **Django** development server on `http://127.0.0.1:8000/`
6. Open the application in your default browser

#### Option B: Manual Startup

**Terminal 1 — Start Ganache:**
```bash
npx ganache --port 8545 --deterministic --db "./ganache-db"
```

**Terminal 2 — Deploy Smart Contract (first run only):**
```bash
cd contract
npx truffle migrate --network development
```

**Terminal 3 — Start Django Server:**
```bash
cd MediCare-Chain
python manage.py migrate
python manage.py runserver
```

Then open your browser at: **[http://127.0.0.1:8000/](http://127.0.0.1:8000/)**

---

### Step 5 — Login to the Application

Use the Django admin credentials or create a superuser:

```bash
python manage.py createsuperuser
```

Follow the prompts to set a username and password, then log in at the app's login page.

---

### Step 6 — Configure MetaMask (For Donor Transactions)

1. Open MetaMask in your browser
2. Add a new network with these settings:
   - **Network Name:** Ganache Local
   - **RPC URL:** `http://127.0.0.1:8545`
   - **Chain ID:** `1337`
   - **Currency Symbol:** ETH
3. Import a Ganache test account using its private key (shown in the Ganache terminal)

---

### Resetting All Data (If Needed)

To start fresh with a clean blockchain and database:

1. Delete the `ganache-db/` folder
2. Delete `db.sqlite3`
3. Re-run `run.bat`

> ⚠️ **Warning:** This will permanently erase all patient/doctor records and blockchain transactions.

---

### Common Issues & Fixes

| Issue | Fix |
|-------|-----|
| Port 8545 already in use | Run `run.bat` — it auto-kills the port |
| Contract address mismatch | Delete `ganache-db/` and re-run `run.bat` to redeploy |
| Django migration errors | Run `python manage.py migrate` manually |
| MetaMask not connecting | Ensure Ganache is running and MetaMask RPC URL is `http://127.0.0.1:8545` |
| `web3` import error | Run `pip install web3` |

---

*MediCare-Chain — Decentralized Healthcare on the Ethereum Blockchain*
