# Predicting ROI on Market Attribution Using Market Mix Modelling (MMM)

This repository contains the implementation and findings of a project focused on predicting Return on Investment (ROI) for marketing campaigns using **Market Mix Modelling (MMM)**. The project leverages advanced machine learning techniques, particularly using the **Robyn library**, to analyze and optimize marketing efforts across multiple platforms such as Meta, Google, and TikTok.

## Overview

Marketing attribution is a critical process for evaluating the effectiveness of various marketing touchpoints. This project employs **MMM** to provide actionable insights into advertising efficiency, enabling businesses to make informed decisions about budget allocation and strategy optimization.

### Key Highlights
- Developed a predictive model to estimate ROI for marketing campaigns.
- Incorporated seasonality, holidays, and external factors into the analysis.
- Used Pareto optimization to evaluate marketing efficiency across channels.
- Focused on platforms like Meta (Facebook, Instagram), Google (Search, Shopping, Display), and TikTok.

## Features
1. **Data Analysis and Preprocessing**: 
   - Extensive exploratory data analysis (EDA) to understand trends and correlations.
   - Handled and cleaned multi-channel data over a five-year period (2019-2024).

2. **Robyn Library Integration**:
   - Automated model building and hyperparameter tuning using Robyn.
   - Consideration of adstock and saturation effects for accurate modeling.

3. **Performance Metrics**:
   - Achieved an Adjusted R² of 86% and NRMSE of 7.3%.
   - Insights into immediate and carryover advertising effects.

4. **Key Insights**:
   - Meta Facebook contributed over 50% to ROI, with high returns from Google Shopping.
   - Seasonality and holidays play significant roles in ROI fluctuations.

## Tools and Technologies
- **Programming Languages**: Python
- **Libraries and Frameworks**: Robyn, pandas, NumPy, Prophet, Matplotlib
- **Machine Learning Techniques**: Regression modeling, optimization algorithms
- **Visualization**: Correlation heatmaps, ROI decomposition, Pareto front analysis

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/MufidShaikh/Predicting-ROI-On-Market-Attribution-Using-Market-Mix-Modelling-MMM.git
