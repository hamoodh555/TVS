*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${baseurl}        http://45.63.86.127/
${browser}        chrome

*** Test Cases ***
Logo and copy rights verification
    Local browser launch
    #Jenkins browser launch
    Element Should Be Visible    xpath=.//a[@class='site-logo']
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Text Should Be    xpath=.//p[@class='copyrights-footer']    Copyright @ 2019 TVS Insurance. All Rights Reserved
    Execute JavaScript    window.scrollTo(document.body.scrollHeight, 0)

header menu verification
    ${menu_list}=    Get Element Count    xpath=.//ul[@class='we-mega-menu-ul nav nav-tabs']/li
    Should Be True    ${menu_list}>=4

header and footer verification
    Element Should Be Visible    xpath=.//header
    Sleep    4s
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Element Should Be Visible    xpath=.//footer

Car insur insurance
    Click Element    xpath=.//label[@for='edit-carreg-no']
    Input Text    id=edit-carreg-no    KA-07-8742
    Click Element    id=edit-submit

Find your cards
    Click Element    xpath=(.//ul[@class='popular-cars']/li[contains(.,'BMW')])[1]
    Select From List By Label    id=edit-select-your-type    118D SPORT LINE
    Select From List By Label    id=edit-select-your-fuel-type    DIESEL
    Select From List By Label    id=edit-select-your-variant    118D SPORT LINE 5 SEATER (1995 CC)

*** Keywords ***
Jenkins browser launch
    Set Selenium Speed    1s
    ${chrome_options} =    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    Call Method    ${chrome_options}    add_argument    headless
    Call Method    ${chrome_options}    add_argument    disable-gpu
    Call Method    ${chrome_options}    add_argument    no-sandbox
    Create WebDriver    Chrome    chrome_options=${chrome_options}
    Go To    ${baseurl}
    Maximize Browser Window
    Set Browser Implicit Wait    15s

Local browser launch
    Set Selenium Speed    1s
    Open Browser    ${baseurl}    ${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    15s
