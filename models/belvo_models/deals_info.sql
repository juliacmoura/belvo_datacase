-- Databricks notebook source
with companies_deals_associations as (
select * from belvo_tables.tables.companies_deals_associations
),

contacts_deals_associations as (
select * from belvo_tables.tables.contacts_deals_associations
),

companies as (
select * from belvo_tables.tables.companies
),

contacts as (
select * from belvo_tables.tables.contacts
),

base as (
select 
contacts_deals_associations.contact_Id,
companies_deals_associations.company_Id,
companies_deals_associations.deal_Ids,
companies.name as company_name,
companies.country
from companies_deals_associations full join contacts_deals_associations using (deal_Ids)
left join companies on (companies_deals_associations.company_Id = companies.id)
) 

select 
base.contact_Id,
base.company_Id,
base.deal_Ids,
base.company_name,
contacts.name as contact_name,
contacts.job,
contacts.channel,
base.country
from base left join contacts on (base.contact_Id = contacts.id)
