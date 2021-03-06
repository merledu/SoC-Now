"""
Django settings for thesocnow project.

Generated by 'django-admin startproject' using Django 3.2.

For more information on this file, see
https://docs.djangoproject.com/en/3.2/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/3.2/ref/settings/
"""

from pathlib import Path
import os

# Build paths inside the project like this: BASE_DIR / 'subdir'.
BASE_DIR = Path(__file__).resolve().parent.parent


# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/3.2/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'django-insecure-om#dytpo(iq=h(#_-+)rcv0559w!k(mw882044x1w0b@8%h3(e'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = []


# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'pages',
    'soc',
    'django_mysql',
    'components',
    'verification'

]

MIDDLEWARE = [
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'thesocnow.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, "templates")],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'thesocnow.wsgi.application'


# Database
# https://docs.djangoproject.com/en/3.2/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}


# Password validation
# https://docs.djangoproject.com/en/3.2/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/3.2/topics/i18n/

LANGUAGE_CODE = 'en-us'

TIME_ZONE = 'UTC'

USE_I18N = True

USE_L10N = True

USE_TZ = True


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/3.2/howto/static-files/

STATIC_URL = '/static/'

# Default primary key field type
# https://docs.djangoproject.com/en/3.2/ref/settings/#default-auto-field

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'
STATICFILES_DIRS = [os.path.join(BASE_DIR, 'static')]


GENERATOR_DIR="SoC-Now-Generator"


DRIVERS = {
    "soc"       :       "GeneratorDriver",
    "fpga"      :       "SoCNowDriver",
    "corewbi"   :       "nucleusrv.components.CoreWBI",
    "corewbim"  :       "nucleusrv.components.CoreWBIM",
    "corewbic"  :       "nucleusrv.components.CoreWBIC",
    "corewbif"  :       "nucleusrv.components.CoreWBIF",
    "corewbimf" :       "nucleusrv.components.CoreWBIMF",
    "corewbimc" :       "nucleusrv.components.CoreWBIMC",
    "corewbifc" :       "nucleusrv.components.CoreWBIFC",
    "corewbimfc":       "nucleusrv.components.CoreWBIMFC",
    "coretli"   :       "nucleusrv.components.CoreTLI",
    "coretlim"  :       "nucleusrv.components.CoreTLIM",
    "coretlif"  :       "nucleusrv.components.CoreTLIF",
    "coretlic"  :       "nucleusrv.components.CoreTLIC",
    "coretlimf" :       "nucleusrv.components.CoreTLIMF",
    "coretlimc" :       "nucleusrv.components.CoreTLIMC",
    "coretlifc" :       "nucleusrv.components.CoreTLIFC",
    "coretlimfc":       "nucleusrv.components.CoreTLIMFC",
    "gpiowb"    :       "jigsaw.GPIOHarnessDriver",
    "spiwb"     :       "jigsaw.SpiDriverWB",
    "spifwb"    :       "jigsaw.SpiFlashDriverWB",
    "i2cwb"     :       "jigsaw.I2CHarnessDriver",
    "uartwb"    :       "jigsaw.UARTHarnessDriver",
    "timerwb"   :       "jigsaw.TimerDriverWB",
    "gpiotl"    :       "jigsaw.GPIOHarnessDriverTL",
    "spitl"     :       "jigsaw.SpiDriverTL",
    "spiftl"   :       "jigsaw.SpiFlashDriverTL",
    "i2ctl"     :       "jigsaw.I2CHarnessDriverTL",
    "timertl"   :       "jigsaw.TimerDriverTL",
    "uarttl"    :       "jigsaw.UARTHarnessDriverTL",
    "wb"        :       "caravan.bus.wishbone.WishboneDriver",
    "tl"        :       "caravan.bus.tilelink.TilelinkDriver",
    "tlc"       :       "TilelinkCachedDriver",
}


RTL_FILES = {
    "soc"       :       "Generator.v",
    "fpga"      :       "SoCNow.v",
    "corewbi"   :       "Core.v",
    "corewbim"  :       "Core.v",
    "corewbic"  :       "Core.v",
    "corewbif"  :       "Core.v",
    "corewbimf" :       "Core.v",
    "corewbimc" :       "Core.v",
    "corewbifc" :       "Core.v",
    "corewbimfc":       "Core.v",
    "coretli"   :       "Core.v",
    "coretlim"  :       "Core.v",
    "coretlif"  :       "Core.v",
    "coretlic"  :       "Core.v",
    "coretlimf" :       "Core.v",
    "coretlimc" :       "Core.v",
    "coretlifc" :       "Core.v",
    "coretlimfc":       "Core.v",
    "gpiowb"    :       "gpioHarness.v",
    "spiwb"     :       "SpiHarness.v",
    "spifwb"   :       "SpiFlashHarness.v",
    "uartwb"    :       "uartHarness.v",
    "i2cwb"     :       "i2cHarness.v",
    "timerwb"   :       "TimerHarness.v",
    "gpiotl"    :       "gpioHarness_TL.v",
    "spitl"     :       "SpiHarnessTL.v",
    "spiftl"   :       "SpiFlashHarnessTL.v",
    "uarttl"    :       "uartHarness_TL.v",
    "i2ctl"     :       "i2cHarness_TL.v",
    "timertl"   :       "TimerHarnessTL.v",
    "wb"        :       "Harness.v",
    "tl"        :       "TilelinkHarness.v",
    "tlc"       :       "TilelinkCachedHarness.v",
}

XDC_ENCODS = {
    "default": "## Clock signal \nset_property PACKAGE_PIN E3 [get_ports {clock}] \nset_property IOSTANDARD LVCMOS33 [get_ports {clock}]",
    "clk":"# Clock constraints \ncreate_clock -period x [get_ports {clock}]",
    
}

ARTY_COMPS_i = {
    "BTN0":"set_property -dict { PACKAGE_PIN D9    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "BTN1":"set_property -dict { PACKAGE_PIN C9    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "BTN2":"set_property -dict { PACKAGE_PIN B9    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "BTN3":"set_property -dict { PACKAGE_PIN B8    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "SW0" :"set_property -dict { PACKAGE_PIN A8    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "SW1" :"set_property -dict { PACKAGE_PIN C11   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "SW2" :"set_property -dict { PACKAGE_PIN C10   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "SW3" :"set_property -dict { PACKAGE_PIN A10   IOSTANDARD LVCMOS33 } [get_ports { x }];",
}
ARTY_COMPS_o = {
    "LD0_b":"set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD0_g":"set_property -dict { PACKAGE_PIN F6    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD0_r":"set_property -dict { PACKAGE_PIN G6    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD1_b":"set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD1_g":"set_property -dict { PACKAGE_PIN J4    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD1_r":"set_property -dict { PACKAGE_PIN G3    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD2_b":"set_property -dict { PACKAGE_PIN H4    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD2_g":"set_property -dict { PACKAGE_PIN J2    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD2_r":"set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD3_b":"set_property -dict { PACKAGE_PIN K2    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD3_g":"set_property -dict { PACKAGE_PIN H6    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD3_r":"set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD4" : "set_property -dict { PACKAGE_PIN H5    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD5" : "set_property -dict { PACKAGE_PIN J5    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD6" : "set_property -dict { PACKAGE_PIN T9    IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "LD7" : "set_property -dict { PACKAGE_PIN T10   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[1]":"set_property -dict { PACKAGE_PIN G13   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[2]":"set_property -dict { PACKAGE_PIN B11   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[3]":"set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[4]":"set_property -dict { PACKAGE_PIN D12   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[5]":"set_property -dict { PACKAGE_PIN D13   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[6]":"set_property -dict { PACKAGE_PIN B18   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[7]":"set_property -dict { PACKAGE_PIN A18   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JA[8]":"set_property -dict { PACKAGE_PIN K16   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_p[1]":"set_property -dict { PACKAGE_PIN E15   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_n[1]":"set_property -dict { PACKAGE_PIN E16   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_p[2]":"set_property -dict { PACKAGE_PIN D15   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_n[2]":"set_property -dict { PACKAGE_PIN C15   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_p[3]":"set_property -dict { PACKAGE_PIN J17   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_n[3]":"set_property -dict { PACKAGE_PIN J18   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_p[4]":"set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JB_n[4]":"set_property -dict { PACKAGE_PIN J15   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_p[1]":"set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_n[1]":"set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_p[2]":"set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_n[2]":"set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_p[3]":"set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_n[3]":"set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_p[4]":"set_property -dict { PACKAGE_PIN T13   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JC_n[4]":"set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[1]":"set_property -dict { PACKAGE_PIN D4   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[2]":"set_property -dict { PACKAGE_PIN D3   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[3]":"set_property -dict { PACKAGE_PIN F4   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[4]":"set_property -dict { PACKAGE_PIN F3   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[5]":"set_property -dict { PACKAGE_PIN E2   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[6]":"set_property -dict { PACKAGE_PIN D2   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[7]":"set_property -dict { PACKAGE_PIN H2   IOSTANDARD LVCMOS33 } [get_ports { x }];",
    "JD[8]":"set_property -dict { PACKAGE_PIN G2   IOSTANDARD LVCMOS33 } [get_ports { x }];",
}


BUSES = {
    "wb":"Wishbone",
    "tl-ul":"Tilelink Uncached Lightweight",
    "tl-c":"Tilelink Cached",
}