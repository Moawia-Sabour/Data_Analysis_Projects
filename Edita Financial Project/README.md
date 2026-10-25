# 🍰 Edita Food Industries: Financial Performance Dashboard

> A 6-page Power BI dashboard that answers one question: **is Edita (EGX: EFID) growing profitably, and is that growth sustainable?** Built on 20 quarters of income statement, balance sheet, and cash flow data.

---

## 📌 Table of Contents
- [Business Question](#-business-question)
- [Data](#-data)
- [Dashboard Pages](#-dashboard-pages)
- [Key Findings](#-key-findings)
- [Risks and Recommendations](#-risks-and-recommendations)
- [Design](#-design)
- [Project Structure](#-project-structure)
- [How to Use](#-how-to-use)
- [Skills Demonstrated](#-skills-demonstrated)
- [Author](#-author)

---

## 🎯 Business Question

> **Is Edita growing profitably, and what could slow it down?**

Raw financial statements show hundreds of numbers but do not say whether growth is profitable, safely funded, or turning into cash. This project turns them into six pages, each answering one business question.

## 🗃️ Data

| Item | Detail |
|---|---|
| 🏢 Company | Edita Food Industries (EGX: EFID) |
| 🌐 Source | [Stock Analysis](https://stockanalysis.com) |
| 📅 Period | 20 quarters, Sep 2021 to Jun 2026 |
| 📑 Statements | Income statement, balance sheet, cash flow statement |
| 💰 Unit | EGP million |
| 🐍 Collection | Python ETL (requests, pandas, Regex), the same pipeline used in the EGX Financial Performance project |

The data is stored in **one long table** with 5 columns, so a new quarter only adds rows:

| Column | Example |
|---|---|
| `Financial Term` | Revenue |
| `End Of Quarter` | 2026-06-30 |
| `Amount` | 6480 |
| `Company` | EFID |
| `Statement Type` | income-statement |

📄 **File:** `EFID_Edita_financials.xlsx` has two sheets: `EFID_Long` (ready for Power BI) and `Statements_Wide` (all statements by quarter).

> ⚠️ Some year-end quarters are not reported by the source. Charts that need them skip those quarters.

---

## 🖥️ Dashboard Pages

| # | Page | Question it answers |
|---|---|---|
| 1️⃣ | **Overview** | How is the company performing financially? |
| 2️⃣ | **Profit & Loss** | Is the company growing profitably? |
| 3️⃣ | **Balance Sheet** | What does it own, and how is it funded? |
| 4️⃣ | **Liquidity & Leverage** | Can it meet its obligations? |
| 5️⃣ | **Working Capital** | How efficiently does it use operating assets? |
| 6️⃣ | **Risks & Takeaways** | What problem did the analysis find, and what should the company do? |

Every page has the same structure: a headline that states the finding, four KPI cards, one main chart with two supporting charts, and a **So what** strip. A single **Year slicer** in the header filters the whole report.

### 📊 Key measures (TTM Jun 2026)

| KPI | Value |
|---|---|
| 💰 Revenue | **EGP 23.92B** (+37.4% vs prior TTM) |
| 📈 Operating margin | **17.7%** (gross 34.7%, net 14.2%) |
| 🏆 Return on equity | **~54%** |
| 💵 Net income | **EGP 3.39B** |
| 🧾 EBITDA | **EGP 4.76B** |
| ⚖️ Net debt / EBITDA | **0.09x** |

---

## 💡 Key Findings

- ✅ **Growth is profitable.** Revenue grew 37% while the operating margin held near 17.7%.
- 🏭 **Costs grow in line with sales.** COGS takes 65% of revenue and OPEX 17%; OPEX moved only from 17.5% to 17.6% in 8 quarters.
- 🏗️ **A capital-heavy business.** PP&E and inventory hold 56% of assets; liabilities are 62% of assets (1.60x equity).
- 💧 **Liquidity is adequate.** Current ratio 1.55x, quick ratio 0.91x, interest covered 6.3x.
- ⏳ **Cash is tied up for about 34 days** (inventory 65 days, receivables 5, payables 37).

## ⚠️ Risks and Recommendations

| 🚩 Problem found | 📉 Evidence |
|---|---|
| **Profit is not turning into cash** | Q2 2026 operating cash flow was **EGP -124M** against net income of **EGP 796M**; TTM cash flow is 81% of net income |
| **Short-term debt is rising** | EGP 0.70B to **1.97B** in a year; total debt EGP 5.67B, but cash and short-term investments of **EGP 5.23B** cover it |
| **Inventory is building up** | EGP 2.02B to **2.77B** in a year (**+37%**), 17% of assets |

**Recommendations**

1. 🏦 Control debt: refinance short-term debt into longer terms.
2. 📦 Cut inventory days with tighter stock planning by product line.
3. 💵 Protect cash: match dividends and capex to operating cash flow.
4. 🧮 Keep margin: watch gross margin as input costs move.

> 💬 Net of cash, debt is low (0.09x EBITDA), so the risk is refinancing and liquidity timing, not solvency.

---

## 🎨 Design

- **Palette:** black, gray, orange, and red (with lighter and darker shades). One meaning per color: orange for focus, red for risks, gray for secondary series.
- **Storytelling:** each page opens with its finding as the headline, then shows the evidence.
- **Theme file:** `EGX_Financials_theme.json` applies the colors in Power BI (`View ➜ Themes ➜ Browse for themes`).

---

## 📁 Project Structure

```
Edita_Financial_Performance/
├── 📄 README.md
├── 🗃️ data/
│   └── EFID_Edita_financials.xlsx
├── 📊 dashboard/
│   ├── Edita_Dashboard.pbix
│   └── EGX_Financials_theme.json
├── 🖼️ images/
│   ├── page1_Overview.png
│   ├── page2_Profit_Loss.png
│   ├── page3_Balance_Sheet.png
│   ├── page4_Liquidity_Leverage.png
│   ├── page5_Working_Capital.png
│   └── page6_Risks_Takeaways.png
└── 📑 docs/
    └── Edita_Financial_Performance.pptx
```

## ▶️ How to Use

1. Open the Power BI file in `dashboard/`.
2. Apply the theme: `View ➜ Themes ➜ Browse for themes ➜ EGX_Financials_theme.json`.
3. Point the data source to `data/EFID_Edita_financials.xlsx` (sheet `EFID_Long`).
4. Click **Refresh** 🔄.

---

## 🧰 Skills Demonstrated

| Area | Skills |
|---|---|
| 📊 **Power BI** | Data modeling, DAX measures, dashboard design, themes, slicers |
| 💼 **Financial analysis** | Growth, margins, ROE, liquidity, leverage, working capital, cash flow |
| 🐍 **Python / ETL** | Web scraping, Regex, pandas, wide-to-long reshaping |
| 🧠 **Business thinking** | Question-first analysis, risk identification, recommendations |
| 🎨 **Data storytelling** | Headline findings, consistent layout, color system |

---

## 👤 Author

**Moawia Mohamed**: Entry-Level Data Analyst

🔗 [LinkedIn](https://www.linkedin.com/in/moawia-mohamed-a08625325) · 💻 [GitHub](https://github.com/Moawia-Sabour)
