# 🩺 **Healthcare Analytics — Patient Data Dashboard**

## 📋 **Objective**

Analyze 10,000 de-identified patient records (2023–2025) to uncover patterns in demographics, visit behavior, treatment outcomes, and lab diagnostics. The goal is to help healthcare facilities improve operational efficiency and patient outcomes through data-driven insights and strategic recommendations.

---

## 📊 **Dataset Used**

| Metric | Value |
|--------|-------|
| 👥 **Patients** | 10,000 |
| 🏥 **Visits** | 10,000 |
| 👨‍⚕️ **Doctors** | 1,000 |
| 🗺️ **U.S. States** | 5 |
| 📅 **Time Period** | 2023–2025 (3 Years) |

---

## 🛠️ **Tech Stack / Technologies Used**

| Technology | Purpose |
|-----------|---------|
| 📑 **Excel** | Data cleaning, preprocessing, and dashboard creation |
| 🗄️ **SQL** | Querying, aggregation, and data transformation |
| 📊 **Power BI** | Interactive dashboards and segmentation analysis |
| 📈 **Tableau** | Visual storytelling and trend analysis |

---

## 💡 **Key Skills Demonstrated**

- ✅ Data Cleaning & Preprocessing  
- ✅ Data Analysis & Visualization  
- ✅ Dashboard Development  
- ✅ Business Intelligence Reporting  
- ✅ Healthcare Data Interpretation  
- ✅ Statistical Analysis & Forecasting
- ✅ SQL Optimization & Query Design
- ✅ Executive Storytelling & Insights

---

## ❓ **The KPI Questions**

1. 💰 **What is the average treatment cost per patient?**
2. 📍 **Which states have the highest patient volume?**
3. 🚑 **What is the distribution of visit types** (Emergency, Routine, Follow-up)?
4. 💊 **Which chronic conditions are most prevalent?**
5. 🔬 **What percentage of lab results are abnormal or pending?**
6. ✅ **How does treatment success vary by type?**
7. 👥 **What is the patient-to-doctor ratio?**
8. 📈 **How have visits grown year-over-year?**

---

## 📊 **Dashboard Interaction**

### 🧠 **Patient Demographics Dashboard**
- Age distribution and gender breakdown
- Geographic analysis across 5 states
- Patient segmentation by risk profiles
- Insurance coverage patterns

### 🏥 **Visit & Treatment Dashboard**
- Visit types breakdown (Emergency, Routine, Follow-up)
- Treatment cost analysis and trends
- Average treatment cost per patient ($524.75)
- Visit volume by department and specialty

### 💊 **Chronic Conditions Dashboard**
- Prevalence of chronic conditions
- Hypertension (20.5%) vs Diabetes (20.3%)
- Comorbidity patterns
- Patient outcomes by condition type

### 🔬 **Lab Results Dashboard**
- Lab result distribution (Normal, Abnormal, Pending)
- 33.5% abnormal lab results flagging
- Diagnostic trends and patterns
- Critical value alerts and follow-ups

### 📈 **Key Insights & Recommendations Dashboard**
- YoY growth metrics (24% growth 2023→2024)
- Cost optimization opportunities
- Preventive care program recommendations
- Specialist hiring recommendations

---

## 🔍 **SQL Queries**

```sql
-- Total visits by year
SELECT YEAR(Visit_Date) AS Year, COUNT(*) AS Total_Visits
FROM Visits
GROUP BY YEAR(Visit_Date)
ORDER BY Year;

-- Average treatment cost by type
SELECT Treatment_Type, AVG(Cost) AS Avg_Cost
FROM Treatments
GROUP BY Treatment_Type
ORDER BY Avg_Cost DESC;

-- Top diagnoses by visit count
SELECT Diagnosis, COUNT(*) AS Visit_Count
FROM Visits
GROUP BY Diagnosis
ORDER BY Visit_Count DESC
LIMIT 10;

-- Lab result distribution
SELECT Lab_Result_Status, COUNT(*) AS Count, 
       ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM Lab_Results),2) AS Percentage
FROM Lab_Results
GROUP BY Lab_Result_Status;

-- Chronic condition prevalence
SELECT Chronic_Condition, COUNT(DISTINCT Patient_ID) AS Patient_Count,
       ROUND(COUNT(DISTINCT Patient_ID)*100.0/(SELECT COUNT(DISTINCT Patient_ID) FROM Patients),2) AS Prevalence_Percent
FROM Patient_Conditions
GROUP BY Chronic_Condition
ORDER BY Patient_Count DESC;

-- Patient-to-Doctor ratio by state
SELECT State, 
       COUNT(DISTINCT Patient_ID) AS Total_Patients,
       COUNT(DISTINCT Doctor_ID) AS Total_Doctors,
       ROUND(COUNT(DISTINCT Patient_ID)*1.0/COUNT(DISTINCT Doctor_ID), 2) AS Patient_Doctor_Ratio
FROM Visits
GROUP BY State;
```

---

## ⚙️ **Process**

### 🔧 **Data Cleaning & Preprocessing**
- Cleaned missing and inconsistent data using Excel Power Query and SQL CAST functions
- Removed duplicates using DISTINCT and window functions
- Capped outliers using IQR (Interquartile Range) method
- Standardized date formats and numeric precision

### 📝 **Feature Engineering**
Created derived columns for segmentation:
- Age_Group (18-30, 31-45, 46-60, 60+)
- Visit_Year (2023, 2024, 2025)
- Cost_Band (Low, Medium, High, Premium)
- Condition_Severity (Mild, Moderate, Severe)

### 📊 **Dashboard Development**
- Built dashboards in Power BI, Tableau, and Excel for comparative insights
- Implemented interactive filters and slicers
- Created KPI cards and trend visualizations
- Designed drill-down capabilities for detailed analysis

### 🎯 **Validation & Testing**
- Cross-validated metrics across all three platforms
- Performed quality assurance checks
- Ensured HIPAA compliance for de-identified data

---

## 🎯 **Key Insights**

| Insight | Finding | Impact |
|---------|---------|--------|
| 📈 YoY Growth | Visits grew 24% from 2023 to 2024 | Strong facility demand & capacity planning needed |
| 💊 Top Conditions | Hypertension (20.5%) & Diabetes (20.3%) | Preventive care programs recommended |
| 🔬 Lab Abnormalities | 33.5% abnormal results indicate proactive diagnostics needed | Automated lab flagging system required |
| 💰 Treatment Costs | Average $524.75 across all modalities | Pricing parity but opportunity for cost optimization |
| 👥 Specialist Mix | Balanced primary care to specialist ratio | Targeted hiring in Neurology recommended |
| 📍 Geographic Distribution | Patient volume varies by state (5-state analysis) | Resource allocation optimization opportunity |
| 🚑 Visit Types | Clear distribution across Emergency, Routine, Follow-up | Capacity and staffing alignment needed |

---

## 🏆 **Conclusion**

Preventive care programs and automated lab flagging can significantly improve patient outcomes. The balanced specialist mix supports strong primary care delivery, but targeted hiring in Neurology is recommended.

Data-driven insights enable:

✅ Better resource allocation  
✅ Improved patient satisfaction  
✅ Reduced operational costs  
✅ Enhanced clinical outcomes  
✅ Proactive disease management

---

## 📁 **Directory Structure**

```
healthcare-analysis/
├── README.md
├── data/
│   ├── raw/
│   │   ├── patient_records.csv (10,000 patients)
│   │   ├── visits_data.csv (10,000 visits)
│   │   ├── doctors_data.csv (1,000 doctors)
│   │   ├── lab_results.csv
│   │   └── treatment_data.csv
│   └── processed/
│       ├── cleaned_patient_data.csv
│       ├── aggregated_metrics.csv
│       └── dashboard_source.csv
├── dashboards/
│   ├── excel/
│   │   ├── Patient_Demographics.xlsx
│   │   ├── Visit_Treatment_Analysis.xlsx
│   │   └── Chronic_Conditions_Lab_Results.xlsx
│   ├── powerbi/
│   │   ├── Patient_Demographics_Dashboard.pbix
│   │   ├── Visit_Treatment_Dashboard.pbix
│   │   ├── Chronic_Conditions_Dashboard.pbix
│   │   ├── Lab_Results_Dashboard.pbix
│   │   └── Key_Insights_Dashboard.pbix
│   └── tableau/
│       ├── Patient_Demographics_Story.twb
│       ├── Visit_Treatment_Analysis.twb
│       ├── Chronic_Conditions_Tableau.twb
│       ├── Lab_Results_Dashboard.twb
│       └── State_AgeGroup_Insights.twb
├── sql_queries/
│   ├── data_extraction.sql
│   ├── kpi_queries.sql
│   ├── aggregation_queries.sql
│   └── validation_queries.sql
├── scripts/
│   ├── data_cleaning.py
│   ├── analysis.py
│   ├── data_validation.py
│   └── etl_pipeline.py
├── reports/
│   ├── Executive_Summary.pdf
│   ├── Monthly_Analysis_2025.pdf
│   └── YoY_Comparison_Report.pdf
└── documentation/
    ├── data_dictionary.md
    ├── methodology.md
    ├── dashboard_guide.md
    └── technical_specifications.md
```

---

## 📊 **Dashboard Overview**

### ✅ **Excel Dashboards**
- Patient demographics, cost segmentation, and visit trends
- Summary cards with key metrics
- Pivot tables and slicers for interactive exploration
- Print-ready formats for executive reporting

### ✅ **Power BI Dashboards**
- Treatment outcomes and chronic conditions analysis
- Lab result distribution and abnormality tracking
- Interactive filtering and cross-dashboard navigation
- Mobile-responsive design for on-the-go access
- Real-time data refresh capabilities

### ✅ **Tableau Dashboards**
- Interactive visualization of state-wise insights
- Age-group and demographic deep dives
- Geographic mapping and heat maps
- Trend analysis and forecasting visualizations
- Story-driven data narrative

---

## 🔐 **Data Security & Compliance**

### 🏥 **HIPAA Compliance**
- ✅ **De-Identification**: All patient records have been de-identified per HIPAA Safe Harbor method
  - Removed direct identifiers (Name, SSN, Medical Record Number)
  - Removed dates (except year) that could identify patients
  - Aggregated small cell counts to prevent re-identification
- ✅ **Privacy Rule**: Data handling complies with HIPAA Privacy Rule requirements
- ✅ **Security Rule**: Technical, physical, and administrative safeguards implemented
- ✅ **Audit Controls**: All access to patient data is logged and monitored

### 🔒 **Data Encryption**
- ✅ **Encryption in Transit**: All data transfers use TLS 1.2+ protocol
- ✅ **Encryption at Rest**: Database encryption enabled on SQL Server/MySQL
- ✅ **File-Level Security**: Sensitive files encrypted using AES-256
- ✅ **Backup Encryption**: All backup copies encrypted and stored securely

### 👤 **Access Control (RBAC)**
- ✅ **Role-Based Access**: Different permission levels for different user types
  - Administrators: Full access to all dashboards and data
  - Department Heads: Access to department-specific data only
  - Analysts: Read-only access to processed data
  - Executives: Access to summary-level insights and KPIs
- ✅ **Multi-Factor Authentication (MFA)**: Required for cloud platforms (Power BI, Tableau)
- ✅ **Password Policies**: Strong password requirements (12+ chars, complexity)
- ✅ **Session Management**: Automatic timeout after 30 minutes of inactivity

### 📋 **Audit Logging & Monitoring**
- ✅ **Access Logs**: All user logins and data access tracked with timestamps
- ✅ **Change Tracking**: Database changes logged with user identification
- ✅ **Compliance Reports**: Monthly audit reports generated and reviewed
- ✅ **Alert System**: Unusual access patterns trigger security alerts
- ✅ **Data Retention**: Logs retained for minimum 7 years per regulations

### 🛡️ **Data Governance**
- ✅ **Data Classification**: Patient data classified as "Highly Sensitive"
- ✅ **Data Retention Policy**:
  - Active data retained for 6 years
  - Archived data retained for 10 years
  - Secure destruction after retention period
- ✅ **Breach Response**: Documented incident response plan in place
- ✅ **Data Quality Standards**: Regular validation and integrity checks
- ✅ **Business Associate Agreements (BAA)**: Executed with all third-party vendors

### 🌐 **Platform-Specific Security**

**Excel Security**
- Password-protected workbooks with encryption
- Restricted editing permissions
- Macro security settings configured
- File stored on encrypted network drives

**Power BI Security**
- Azure Active Directory (AAD) integration for SSO
- Row-Level Security (RLS) for data filtering
- Compliance with ISO 27001, SOC 2, and HIPAA
- Regular security updates and patches
- Data residency in HIPAA-compliant datacenters

**Tableau Security**
- SSO integration with organizational directory
- Workbook-level and row-level permissions
- Audit trail for all dashboard access
- TLS encryption for data transport
- Compliance with healthcare industry standards

---

## ✔️ **Compliance Standards Met**

- 🏥 **HIPAA** (Health Insurance Portability and Accountability Act)
- 🔐 **HITRUST CSF** (Common Security Framework)
- 📋 **SOC 2 Type II** Compliance
- 🌍 **GDPR** (for international patient data)
- ⚖️ **State Privacy Laws** (CCPA, CPRA compliance where applicable)
- 🏢 **CMS Requirements** (for Medicare/Medicaid submissions)

---

## 📊 **Data Validation & Quality Assurance**

- ✅ Quarterly security audits by third-party firms
- ✅ Annual penetration testing
- ✅ Regular vulnerability scanning
- ✅ Data validation checksums to detect unauthorized changes
- ✅ Disaster recovery and business continuity plans tested semi-annually
