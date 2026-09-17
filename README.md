# Eniac-Magist Partnership Analysis

> **Should Eniac partner with Magist to enter the Brazilian market?**
>
> SQL and Tableau analysis evaluating Magist's product portfolio,
> pricing, and delivery performance to support Eniac's expansion decision.

---

## 📊 Project Overview

Eniac is a Spain-founded e-commerce company specialising in Apple products
and premium accessories.

To enter the Brazilian market, Eniac is considering a 3-year partnership
with Magist, a Brazilian SaaS company providing order management and
logistics services.

This project analyses Magist's database using SQL and Tableau to evaluate
product compatibility, pricing, and operational performance.

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Data exploration and analysis |
| SQL | Queries, joins, and business metrics |
| Tableau Public | Interactive dashboards |
| PowerPoint | Executive presentation |

---

## 🗄️ Database

| Information | Value |
|---|---|
| Country | Brazil |
| Period | September 2016 – August 2018 |
| Duration | 25 months |
| Currency | Euros (€) |

### Technology Categories

Computers, electronics, telephony, audio, tablets, consoles,
and other technology-related categories.

---

# 📈 Key Findings

## 1. Eniac vs Magist Tech

**Comparison Period: April 2017 – March 2018**

| Metric | Eniac | Magist Tech |
|---|---:|---:|
| Total Revenue | €14M | €1.24M |
| Avg Monthly Revenue | €1.17M | €103K |
| Avg Order Value | €710 | €123.95 |
| Avg Item Price | €540 | €109.70 |

### Key Insights

- Magist Tech's average monthly revenue was approximately 9% of Eniac's.
- Eniac's average item price was approximately 4.9x higher.
- Eniac's average order value was approximately 5.7x higher.

---

## 2. Technology Share of Magist

| Metric | Value |
|---|---:|
| Tech share of orders | ~15% |
| Tech share of revenue | ~14% |
| Tech sellers as % of all sellers | ~15.7% |
| Tech products priced ≥ €500 | ~3% |

Magist operates across a broad range of categories, while technology
represents a relatively small share of its business.

---

## 🚚 Operational Performance

The Tableau dashboard analyses:

- On-time delivery rate.
- Delivery performance.
- Customer review scores.
- Review score distribution.

These metrics help evaluate whether Magist can support Eniac's
customer experience expectations.

---

# 💡 Recommendation

### Do Not Proceed with the Partnership

Based on the analysed product, pricing, and marketplace data:

- Technology represents only ~15% of Magist's orders.
- Magist Tech's average item price is €109.70.
- Only ~3% of Magist Tech products are priced at €500 or more.
- Magist's marketplace characteristics may not closely align with
  Eniac's premium technology-focused positioning.

**Eniac should explore alternative Brazilian market-entry channels
better aligned with its premium product portfolio.**

---

## 📊 Tableau Dashboards

### Magist Overview
Order trends, category distribution, and technology share.

### Magist Marketplace
Eniac vs Magist Tech pricing comparison.

### Operational Performance
Delivery performance and customer review analysis.

🔗 [View Tableau Dashboards](https://tinyurl.com/eniacXmagist)

---

## 🧠 Skills Demonstrated

**SQL:** Database exploration, joins, aggregation, and business metrics.

**Tableau:** KPI development, visualisation, and dashboard creation.

**Business Analysis:** Product portfolio evaluation, pricing analysis,
and data-driven recommendations.

---

## 📁 Project Structure

```text
eniac-magist-partnership-analysis/
│
├── README.md
├── sql/
│   ├── magist_datacheck.sql
│   ├── magist_Delivery.sql
│   ├── magist_products.sql
│   └── magist_Sellers.sql
│
├── presentation/
│   └── Presentation.pptx
│
└── tableau/
