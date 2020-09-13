import { LightningElement, api } from 'lwc';

export default class QuoteResponse extends LightningElement {
    
    @api Compulife_company;
    @api Compulife_ambest;
    @api Compulife_amb;
    @api Compulife_ambnumber; 
    @api Compulife_compprodcode; 
    @api Compulife_premiumAnnual; 
    @api Compulife_premiumM; 
    @api Compulife_guar; 
    @api Compulife_product; 
    @api Compulife_rgpfpp; 
    @api Compulife_healthcat; 
    @api Compulife_premiumQ; 
    @api Compulife_premiumH;
    @api Company_logo;
    @api id;
}