*** Settings ***
Documentation       Contém keywords de UI genéricas e o setup do ambiente de teste.

Library             Browser
Resource            ../api/auth_keywords.resource
Resource            ../api/movies_keywords.resource
Resource            ../api/sessions_keywords.resource
Variables           ../../variables/local_env.py
Variables           ../../variables/test_data.py

*** Keywords ***