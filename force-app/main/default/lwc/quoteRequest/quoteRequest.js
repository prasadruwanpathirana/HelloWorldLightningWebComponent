import { LightningElement, track, api, wire } from 'lwc';
import Quote from './quote';
import getContactList from '@salesforce/apex/CompuLifeController.getContactList';
import getHealthList from '@salesforce/apex/CompuLifeController.getHealthList';
import getCategoryList from '@salesforce/apex/CompuLifeController.getCategoryList';
import { getRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const FIELDS = [
  'Contact.Name',
  'Contact.Title',
  'Contact.Phone',
  'Contact.Birthdate',
];

export default class ComboboxBasic extends LightningElement {
@api isLoaded = false;
@api isNotInitial = false;
@api recordId;

@wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    contact;

@wire(getContactList)
    contactsList;
@wire(getHealthList)
    healthList;
@wire(getCategoryList)
    categoryList;

@track yearValue = '2020';
@track dayValue = '15';
@track monthValue = 'January';
@track typeofInsuValue = '1';
@track healthClassValue = 'PP';
@track amountofInsuValue = '10000'; 
@track smokerValue = 'No';
@track genderValue = 'Male';
@track stateValue = 'MI';
@track quotes;



get stateoptions() {
  /* return [
             { label: 'Califonia', value: 'Califonia' },
             { label: 'Albama', value: 'Albama' },
             { label: 'Alesca', value: 'Alesca' },
           ];*/
      return this.contactsList.data;
}

get yearOptions() {
  return [
           { label: '1916', value: '1916' },
           { label: '1917', value: '1917' },
           { label: '1918', value: '1918' },
           { label: '1919', value: '1919' },
           { label: '1920', value: '1920' },
           { label: '1921', value: '1921' },
           { label: '1922', value: '1922' },
           { label: '1923', value: '1923' },
           { label: '1924', value: '1924' },
           { label: '1925', value: '1925' },
           { label: '1926', value: '1926' },
           { label: '1927', value: '1927' },
           { label: '1928', value: '1928' },
           { label: '1929', value: '1929' },
           { label: '1930', value: '1930' },
           { label: '1931', value: '1931' },
           { label: '1932', value: '1932' },
           { label: '1933', value: '1933' },
           { label: '1934', value: '1934' },
           { label: '1935', value: '1935' },
           { label: '1936', value: '1936' },
           { label: '1937', value: '1937' },
           { label: '1938', value: '1938' },
           { label: '1939', value: '1939' },
           { label: '1940', value: '1940' },
           { label: '1941', value: '1941' },
           { label: '1942', value: '1942' },
           { label: '1943', value: '1943' },
           { label: '1944', value: '1944' },
           { label: '1945', value: '1945' },
           { label: '1946', value: '1946' },
           { label: '1947', value: '1947' },
           { label: '1948', value: '1948' },
           { label: '1949', value: '1949' },
           { label: '1950', value: '1950' },
           { label: '1951', value: '1951' },
           { label: '1952', value: '1952' },
           { label: '1953', value: '1953' },
           { label: '1954', value: '1954' },
           { label: '1955', value: '1955' },
           { label: '1956', value: '1956' },
           { label: '1957', value: '1957' },
           { label: '1958', value: '1958' },
           { label: '1959', value: '1959' },
           { label: '1960', value: '1960' },
           { label: '1961', value: '1961' },
           { label: '1962', value: '1962' },
           { label: '1963', value: '1963' },
           { label: '1964', value: '1964' },
           { label: '1965', value: '1965' },
           { label: '1966', value: '1966' },
           { label: '1967', value: '1967' },
           { label: '1968', value: '1968' },
           { label: '1969', value: '1969' },
           { label: '1970', value: '1970' },
           { label: '1971', value: '1971' },
           { label: '1972', value: '1972' },
           { label: '1973', value: '1973' },
           { label: '1974', value: '1974' },
           { label: '1975', value: '1975' },
           { label: '1976', value: '1976' },
           { label: '1977', value: '1977' },
           { label: '1978', value: '1978' },
           { label: '1979', value: '1979' },
           { label: '1980', value: '1980' },
           { label: '1981', value: '1981' },
           { label: '1982', value: '1982' },
           { label: '1983', value: '1983' },
           { label: '1984', value: '1984' },
           { label: '1985', value: '1985' },
           { label: '1986', value: '1986' },
           { label: '1987', value: '1987' },
           { label: '1988', value: '1988' },
           { label: '1989', value: '1989' },
           { label: '1990', value: '1990' },
           { label: '1991', value: '1991' },
           { label: '1992', value: '1992' },
           { label: '1993', value: '1993' },
           { label: '1994', value: '1994' },
           { label: '1995', value: '1995' },
           { label: '1996', value: '1996' },
           { label: '1997', value: '1997' },
           { label: '1998', value: '1998' },
           { label: '1999', value: '1999' },
           { label: '2000', value: '2000' },
           { label: '2001', value: '2001' },
           { label: '2002', value: '2002' },
           { label: '2003', value: '2003' },
           { label: '2004', value: '2004' },
           { label: '2005', value: '2005' },
           { label: '2006', value: '2006' },
           { label: '2007', value: '2007' },
           { label: '2008', value: '2008' },
           { label: '2009', value: '2009' },
           { label: '2010', value: '2010' },
           { label: '2011', value: '2011' },
           { label: '2012', value: '2012' },
           { label: '2013', value: '2013' },
           { label: '2014', value: '2014' },
           { label: '2015', value: '2015' },
           { label: '2016', value: '2016' },
           { label: '2017', value: '2017' },
           { label: '2018', value: '2018' },
           { label: '2019', value: '2019' },
           { label: '2020', value: '2020' },
         ];
}

get dayOptions() {
  return [
           { label: '1', value: '1' },
           { label: '2', value: '2' },
           { label: '3', value: '3' },
           { label: '4', value: '4' },
           { label: '5', value: '5' },
           { label: '6', value: '6' },
           { label: '7', value: '7' },
           { label: '8', value: '8' },
           { label: '9', value: '9' },
           { label: '10', value: '10' },
           { label: '11', value: '11' },
           { label: '12', value: '12' },
           { label: '13', value: '13' },
           { label: '14', value: '14' },
           { label: '15', value: '15' },
           { label: '16', value: '16' },
           { label: '17', value: '17' },
           { label: '18', value: '18' },
           { label: '19', value: '19' },
           { label: '20', value: '20' },
           { label: '21', value: '21' },
           { label: '22', value: '22' },
           { label: '23', value: '23' },
           { label: '23', value: '24' },
           { label: '25', value: '25' },
           { label: '26', value: '26' },
           { label: '27', value: '27' },
           { label: '28', value: '28' },
           { label: '29', value: '29' },
           { label: '30', value: '30' },
           { label: '31', value: '31' },

         ];
}

get birthdate() {
  return this.contact.data.fields.Name.value;
}

 

get monthOptions() {
  return [
           { label: 'January', value: 'January' },
           { label: 'February', value: 'February' },
           { label: 'March', value: 'March' },
           { label: 'April', value: 'April' },
           { label: 'May', value: 'May' },
           { label: 'June', value: 'June' },
           { label: 'July', value: 'July' },
           { label: 'August', value: 'August' },
           { label: 'September', value: 'September' },
           { label: 'October', value: 'October' },
           { label: 'November', value: 'November' },
           { label: 'December', value: 'December' },
         ];
}

get healthClassOptions() {
 /*  return [
          { label: 'Preferred Plus', value: 'PreferredPlus' },
           { label: 'Preferred', value: 'Preferred' },
           { label: 'Regular Plus', value: 'RegularPlus' },
           { label: 'Regular', value: 'Regular' },
         ]; */

         return this.healthList.data;
}

get typeofInsuOptions() {
  /*return [
           { label: '1 Year Level Term', value: '1YearLevelTerm' },
           { label: '5 Year Level Term', value: '5YearLevelTerm' },
           { label: '10 Year Level Term', value: '10YearLevelTerm' },
           { label: '15 Year Level Term', value: '15YearLevelTerm' },
           { label: '20 Year Level Term', value: '20YearLevelTerm' },
           { label: '25 Year Level Term', value: '25YearLevelTerm' },
         ]; */
         return this.categoryList.data;
}

get amountofInsuOptions() {
  return [
    { label: '$10,000 ',value: '10000' },
    { label: '$25,000',value: '25000' },
    { label: '$50,000',value: '50000' },
    { label: '$75,000',value: '75000' },
    { label: '$100,000',value: '100000' },
    { label: '$125,000',value: '125000' },
    { label: '$150,000',value: '150000' },
    { label: '$175,000',value: '175000' },
    { label: '$200,000',value: '200000' },
    { label: '$225,000',value: '225000' },
    { label: '$250,000',value: '250000' },
    { label: '$300,000',value: '300000' },
    { label: '$350,000',value: '350000' },
    { label: '$400,000',value: '400000' },
    { label: '$450,000',value: '450000' },
    { label: '$500,000',value: '500000' },
    { label: '$550,000',value: '550000' },
    { label: '$600,000',value: '600000' },
    { label: '$650,000',value: '650000' },
    { label: '$700,000',value: '700000' },
    { label: '$750,000',value: '750000' },
    { label: '$800,000',value: '800000' },
    { label: '$900,000',value: '900000' },
    { label: '$1,000,000',value: '1000000' },
    { label: '$1,100,000',value: '1100000' },
    { label: '$1,250,000',value: '1250000' },
    { label: '$1,500,000',value: '1500000' },
    { label: '$1,750,000',value: '1750000' },
    { label: '$2,000,000',value: '2000000' },
    { label: '$2,500,000',value: '2500000' },
    { label: '$3,000,000',value: '3000000' },
    { label: '$4,000,000',value: '4000000' },
    { label: '$5,000,000',value: '5000000' },
    { label: '$6,000,000',value: '6000000' },
    { label: '$7,000,000',value: '7000000' },
    { label: '$8,000,000',value: '8000000' },
    { label: '$9,000,000',value: '9000000' },
    { label: '$1,000,000',value: '10000000' },
         ];
}

get genderOptions() {
  return [
           { label: 'Male', value: 'Male' },
           { label: 'Female', value: 'Female' },
         ];
}

get smokerOptions() {
  return [
           { label: 'No', value: 'No' },
           { label: 'Yes', value: 'Yes' },
         ];
}

handleClick(event) {
  debugger;
  this.isLoaded = true;
  let fileBody = JSON.stringify({
    'State': 'MI',
    'ZipCode': '',
    'BirthMonth': '8',
    'Birthday': '11',
    'BirthYear': '1980',
    'ActualAge': '39',
    'NearestAge': '40',
    'Sex': 'M',
    'Smoker': 'N',
    'Health': 'PP',
    'NewCategory': '5',
    'FaceAmount': '2000000',
    'ModeUsed': 'ALL'
  })
  var errObj = null;
  //6d0BED8e0
  var url1 = 'https://compulifeapi.com/api/CompanyList/';
  var url = 'https://compulifeapi.com/api/request/?COMPULIFEAUTHORIZATIONID=51b986Af5&REMOTE_IP=86.245.54.127'
		fetch(url,
		{
      method : "POST",
      body: fileBody,
			headers : {
	
      },
		}).then(function(response) {
      if(response.status != 200) {
        errObj = response;
      }
			return response.json();
		})
		.then((qlist) =>{
      debugger;
        if(errObj != null) {
        const event = new ShowToastEvent({
            title: 'Error',
            message: qlist.message,
            variant: 'error'
        });
        this.dispatchEvent(event);
        this.isLoaded = false;
        return;
        }
      
			let quotes_list = [];
			    for(let v of qlist.Compulife_ComparisonResults.Compulife_Results){
				    quotes_list.push(new Quote(v.Compulife_company, v.Compulife_ambest, v.Compulife_amb, v.Compulife_ambnumber,
              v.Compulife_compprodcode, v.Compulife_premiumAnnual, v.Compulife_premiumM, v.Compulife_guar,
              v.Compulife_product, v.Compulife_rgpfpp, v.Compulife_healthcat, v.Compulife_premiumQ, v.Compulife_premiumH));
          }
			
      this.quotes = quotes_list;
      this.isLoaded = false;
      this.isNotInitial = true;
			
		})
		.catch(e=>console.log(e));
}


  handleChange(event) {
    this.value1 = event.detail.value;
  }


  handleStateChange(event) {
    this.stateValue = event.detail.value;
  }

  handleHealthChange(event) {
    this.heathValue = event.detail.value;
 }


 
}