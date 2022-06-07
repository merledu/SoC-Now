from selenium import webdriver
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from icecream import ic

def parse_riscv_assembly(assembly):

    options = webdriver.ChromeOptions()
    options.add_argument("headless")

    driver = webdriver.Chrome("./chromedriver")

    driver.get("https://venus.kvakil.me/")

    # a = driver.find_element_by_id("asm-editor")
    # driver.execute_script("arguments[0].click();", a)
    # print(a.text)

    cm = driver.find_element_by_class_name("CodeMirror")
    codeline = cm.find_elements_by_class_name("CodeMirror-line")[0]
    codeline.click()
    textarea = cm.find_element_by_tag_name("textarea")
    textarea.send_keys(assembly)

    simulate_btn = driver.find_element_by_id("simulator-tab")
    simulate_btn.click()

    dump_btn = driver.find_element_by_id("simulator-dump")
    dump_btn.click()

    WebDriverWait(driver, 10).until(EC.alert_is_present())
    driver.switch_to.alert.accept()

    output = driver.find_element_by_id("console-output")
    return output.get_attribute('value')

