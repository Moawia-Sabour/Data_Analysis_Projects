# 📊 EGX Financial Performance Dashboard

> An end-to-end financial analysis project for companies listed on the **Egyptian Exchange (EGX)**: a **Python ETL pipeline** that scrapes quarterly financial statements, and a **6-page Power BI dashboard** built on top of it.
---

## 📌 Table of Contents
- [Business Question](#-business-question)
- [The Problem](#-the-problem)
- [The Solution](#-the-solution)
- [How the ETL Works](#-how-the-etl-works)
- [The Data](#-the-data)
- [The Dashboard](#-the-dashboard)
- [Design System](#-design-system)
- [Key Insights](#-key-insights)
- [Project Structure](#-project-structure)
- [How to Run](#-how-to-run)
- [Skills Demonstrated](#-skills-demonstrated)
- [Author](#-author)

---

## 🎯 Business Question

> **How are EGX-listed companies performing financially, and how do they compare with their peers?**

The dashboard answers this through six business questions: growth, profitability, funding, liquidity, efficiency, and peer comparison.

## ⚠️ The Problem

The original Power BI report loaded EGX financial statements **directly from the web with Power Query**. Every loaded table re-opened the website in a headless browser, which caused:

- 🐢 **84 page loads** on every refresh (for just 2 companies)
- ⏱️ **Refresh timeouts**, so the report could not be updated reliably
- 🚫 A setup that could not scale to more companies

## ✅ The Solution

I moved all the web work out of Power BI and into a **Python notebook**:

1. 🌐 Python downloads each page **once**
2. 🧹 It cleans and reshapes the tables
3. 💾 It saves **one Excel file** (`financials.xlsx`)
4. 📊 Power BI reads **only that file**

### 🚀 Result

| Metric | Before (Power Query) | After (Python ETL) |
|---|---|---|
| Page loads per refresh | 84 | **6** |
| Reduction | | **93% fewer** |
| Power BI refresh time | Timeouts | **Under 5 seconds** |
| Companies covered | 2 | **196** |

---

## 🔄 How the ETL Works

```
🌐 stockanalysis.com  ➜  🐍 Python notebook  ➜  📄 financials.xlsx  ➜  📊 Power BI
   3 pages per company      download + unpivot      one long table       report & visuals
```

| Step | What happens |
|---|---|
| **1. Install** | `requests`, `pandas`, `lxml`, `openpyxl` |
| **2. Settings** | List of company tickers, the 3 statement pages, and how many tables to keep from each |
| **3. Download & unpivot** | Loops over companies and pages, reads the HTML tables with `pd.read_html`, keeps the first *n* tables |
| **4. Clean & save** | Fixes headers, unpivots with `melt`, extracts dates with **Regex**, converts text to numbers, drops blanks, writes Excel |

### 🔍 Key techniques

- **Three nested loops:** companies → statement pages → tables on each page
- **Browser-like headers** (`User-Agent`, `Accept-Language`) so the site does not block the script
- **`time.sleep(2)`** between requests to avoid being rejected
- **Two header rows fixed** with `get_level_values(-1)`, keeping the quarter-end date row
- **Wide ➜ long with `pd.melt()`:** a new quarter adds *rows*, not columns, so Power BI never breaks
- **Regex date extraction** (`\w{3} \d{1,2}, \d{4}`) then `pd.to_datetime`
- **`pd.to_numeric(errors="coerce")`** turns commas and symbols into clean numbers; non-numeric values (like `-` or growth %) become blank and are dropped

---

## 🗃️ The Data

The final table is **one long table** with 5 columns:

| Column | Example |
|---|---|
| `Financial Term` | Revenue |
| `End Of Quarter` | 2026-06-30 |
| `Amount` | 88017 |
| `Company` | SWDY |
| `Statement Type` | income-statement |

📈 **Dataset size**

- **196** EGX-listed companies
- **215,925** rows
- **187** distinct financial terms
- Up to **20 quarters** per company (mainly 2021 to Q2 2026)
- 3 statement types: income statement, balance sheet, cash flow statement

> 💡 A long format means a new quarter or a new company only adds rows. Nothing in the Power BI model needs to change.

---

## 🖥️ The Dashboard

A **6-page interactive Power BI report**. Each page answers **one business question**. The page title is the page name, and the subtitle is the question.

| # | Page | The question it answers |
|---|---|---|
| 1️⃣ | **Overview** | How is the company performing financially? |
| 2️⃣ | **Profit & Loss** | Is the company growing profitably? |
| 3️⃣ | **Balance Sheet** | What does it own, and how is it funded? |
| 4️⃣ | **Liquidity & Leverage** | Can it meet its obligations? |
| 5️⃣ | **Working Capital** | How efficiently does it use operating assets? |
| 6️⃣ | **Compare Companies** | How does it stack up against peers? |

### 📑 What each page shows

**1️⃣ Overview**: KPI cards (Revenue, EBITDA, Net Income, FCF, Net Debt / EBITDA, ROE), growth chart, margins, profit vs cash, and net debt.

**2️⃣ Profit & Loss**: income statement matrix, revenue-to-net-income waterfall, cost structure (COGS %, OPEX %, net margin %), and revenue split.

**3️⃣ Balance Sheet**: funding (debt vs equity), what the company owns, what it owes, plus D/E and D/A.

**4️⃣ Liquidity & Leverage**: current, quick, and cash ratios, debt vs equity, interest coverage (below 3x is a warning), and Net Debt / EBITDA.

**5️⃣ Working Capital**: DSO, DIO, DPO and the cash conversion cycle, working capital items, and turnover ratios.

**6️⃣ Compare Companies**: company picker, ratio table, ROE vs Debt/Equity scatter, and revenue growth ranking.

### 📐 Consistent page layout

1. **Navigation:** dark sidebar on the left, same place on every page
2. **Filters:** Company, Year, Yearly/Quarterly, Clear (synced across pages)
3. **KPI row:** 4 to 6 cards with the value, one line of context, and a small trend line
4. **Charts:** each chart title is the question it answers

**Reading rules that avoid misreadings**

- ❓ Titles are questions ("Is profit turning into cash?" instead of "OCF vs NI")
- 📅 Partial years say so (**2026 H1**, so nobody reads a drop)
- 🔢 One unit: EGP billions, ratios as `x`, margins as `%`

---

## 🎨 Design System

**One meaning per color, on every page.**

| Color | Hex | Used for |
|---|---|---|
| 🟦 Deep teal | `#1D4A55` | Revenue, assets, subtotals, selected state |
| 🟩 Teal | `#3A9A9A` | EBITDA, equity, second series |
| 🟧 Amber | `#D9772B` | Costs, net income, liabilities |
| 🟪 Purple | `#7A5AA6` | Operating expenses (OPEX) |
| 🟥 Brick red | `#B6452C` | Debt and warnings (always with words) |
| ✅ Green | `#2E7D5B` | Positive change (always with words) |
| ⬜ Gray | `#AEBBC0` | Prior year, other, thresholds |
| ⬛ Sidebar | `#12303A` | Navigation background |

The theme is saved as a **Power BI theme file** so the same colors apply everywhere.

---

## 💡 Key Insights

Example: **Juhayna (JUFO)**

| KPI | Value |
|---|---|
| 💰 H1 revenue | **EGP 17.68B** (**+24.8% YoY**) |
| 📈 EBITDA margin | **15%** |
| 🏆 ROE | **31.6%** |
| 🔁 Cash conversion cycle | **85.4 days** |

---

## 📁 Project Structure

```
EGX_Financial_Performance/
├── 📄 README.md
├── 🐍 etl/
│   └── scraping notebook (.ipynb)
├── 🗃️ data/
│   └── financials.xlsx
├── 📊 dashboard/
│   ├── Power BI report (.pbix)
│   ├── EGX_Financials_theme.json
│   └── Measures.dax
├── 📑 docs/
│   ├── Financial_Dashboard_Design_Brief.pptx
│   └── stockanalysis_code_explained.pptx
└── 🖼️ images/
    └── dashboard page screenshots
```

---

## ▶️ How to Run

1. **Install the libraries** (once)
   ```bash
   pip install requests pandas lxml openpyxl
   ```
2. **Edit the settings cell** in the notebook: add the tickers you want to `companies`, written exactly as in the site URL (e.g., `"SWDY"`, `"TMGH"`)
3. **Run all cells** to download the statements and create `financials.xlsx`
4. **Open the Power BI report** and apply the theme (`View ➜ Themes`)
5. **Point the data source** to `financials.xlsx`, then click **Refresh** 🔄

> ⚠️ If the notebook returns `ValueError: No tables found`, the site blocked the request. Use the browser-like headers in the settings cell, and run locally (some sites block cloud notebook IPs such as Google Colab).

To update the data later: run the notebook again, then refresh Power BI.

---

## 🧰 Skills Demonstrated

| Area | Skills |
|---|---|
| 🐍 **Python** | Web scraping, pandas, `melt`, Regex, data cleaning |
| 🔧 **ETL** | Pipeline design, reshaping wide to long, automation |
| 📊 **Power BI** | DAX measures, data modeling, dashboard design, themes |
| 💼 **Finance** | KPI development, ratio analysis (liquidity, leverage, profitability, efficiency) |
| 🎨 **Design** | Design brief, consistent layout, color system, data storytelling |
| ⚡ **Performance** | Cut refresh load by 93% and refresh time to under 5 seconds |

---

## 👤 Author

**Moawia Mohamed**: Data Analyst

🔗 [LinkedIn](https://www.linkedin.com/in/moawiamohamed) · 💻 [GitHub](https://github.com/Moawia-Sabour)
