package com.naver.erp;


public class StockDTO {

	private int stk_cd;
	private String stk_nm;
	
	private int c_prc;
	private int o_prc;
	private int h_prc;
	private int l_prc;
	
	private int market;
	private String reg_date;
	
	private int rate;
	
	private int market_capital;
	private int stock_amount;
	
	private int net_change;

	private String deleteName;
	
	//recentPick관련
	private int recentPickStk_cd;
	private String recentPickStk_nm;
	private int recentPickNet_change;
	
	
	//mini 그래프 관련 -several_rate
	private double sales;
	private double business_profit;
	private double pre_tax_profit;
	private double net_profit;
	
	private double sales_rate;
	private double	business_profit_rate; 
	private double eitda_rate;
	private double net_profit_rate;
	private double debt_rate;
	
	//FINANCIAL_STATEMENTS 관련
	private double sales_cost;
	private double margin;
	private double sell_admin_cost;
	private double business_profit_official;//////////////////////////
	private double financial_return;
	private double financial_cost;
	private double other_revenues;
	private double other_exvenues;
	private double control_firms_profit;
	private double pre_tax_con_business_profit;
	private double corporate_tax;
	private double con_operating_profit;
	private double interrupted_operation_profit;
	private double net_income;
	private double control_income;
	private double non_control_income;
	
	
	
	
	
	
	
	
	
	public int getStk_cd() {
		return stk_cd;
	}
	public void setStk_cd(int stk_cd) {
		this.stk_cd = stk_cd;
	}
	public String getStk_nm() {
		return stk_nm;
	}
	public void setStk_nm(String stk_nm) {
		this.stk_nm = stk_nm;
	}
	public int getC_prc() {
		return c_prc;
	}
	public void setC_prc(int c_prc) {
		this.c_prc = c_prc;
	}
	public int getO_prc() {
		return o_prc;
	}
	public void setO_prc(int o_prc) {
		this.o_prc = o_prc;
	}
	public int getH_prc() {
		return h_prc;
	}
	public void setH_prc(int h_prc) {
		this.h_prc = h_prc;
	}
	public int getL_prc() {
		return l_prc;
	}
	public void setL_prc(int l_prc) {
		this.l_prc = l_prc;
	}
	public int getMarket() {
		return market;
	}
	public void setMarket(int market) {
		this.market = market;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public int getRate() {
		return rate;
	}
	public void setRate(int rate) {
		this.rate = rate;
	}
	public int getMarket_capital() {
		return market_capital;
	}
	public void setMarket_capital(int market_capital) {
		this.market_capital = market_capital;
	}
	public int getStock_amount() {
		return stock_amount;
	}
	public void setStock_amount(int stock_amount) {
		this.stock_amount = stock_amount;
	}
	public int getNet_change() {
		return net_change;
	}
	public void setNet_change(int net_change) {
		this.net_change = net_change;
	}
	public int getRecentPickStk_cd() {
		return recentPickStk_cd;
	}
	public void setRecentPickStk_cd(int recentPickStk_cd) {
		this.recentPickStk_cd = recentPickStk_cd;
	}
	public String getRecentPickStk_nm() {
		return recentPickStk_nm;
	}
	public void setRecentPickStk_nm(String recentPickStk_nm) {
		this.recentPickStk_nm = recentPickStk_nm;
	}
	public int getRecentPickNet_change() {
		return recentPickNet_change;
	}
	public void setRecentPickNet_change(int recentPickNet_change) {
		this.recentPickNet_change = recentPickNet_change;
	}
	public String getDeleteName() {
		return deleteName;
	}
	public void setDeleteName(String deleteName) {
		this.deleteName = deleteName;
	}
	
	
	
	

	
}
