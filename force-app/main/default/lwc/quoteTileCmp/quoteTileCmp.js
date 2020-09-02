import { LightningElement, api } from 'lwc';

export default class QuoteTile extends LightningElement {
    
    @api compcode;
    @api name;
    @api url;
}