import os
from readthedocs.core.settings import Settings
from .base import CommunityBaseSettings


class CommunityProdSettings(CommunityBaseSettings):

    """Settings for production"""

    DEBUG = False
    SECRET_KEY = os.environ.get('SECRET_KEY', 'Cw3H4gUYbB+kJH6f+_[ROn#Abp)bJ>>*wk?/uJXDgNm4_cIC_f')
    SERVER = os.environ.get('SERVER',  'readthedocs.com')

    DONT_HIT_DB = False

    SLUMBER_USERNAME = 'admin'
    SLUMBER_PASSWORD = 'azerty1234'
    SLUMBER_API_HOST = 'http://{0}'.format(SERVER)

    PRODUCTION_DOMAIN = SERVER
    PUBLIC_DOMAIN = None
    USE_SUBDOMAIN = False
    PUBLIC_API_URL = 'https://{0}'.format(PRODUCTION_DOMAIN)

    @property
    def DATABASES(self):  # noqa
        return {
            'default': {
                'ENGINE': 'django.db.backends.postgresql_psycopg2', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
                'NAME': 'readthedoc', # Or path to database file if using sqlite3.
                # The following settings are not used with sqlite3:
                'USER': 'rtd',
                'PASSWORD': 'rtd',
                'HOST': 'localhost',  # Empty for localhost through domain sockets or '127.0.0.1' for localhost through TCP.
                'PORT': '5432',  # Set to empty string for default.
            }
        }

    SESSION_COOKIE_DOMAIN = SERVER

    BROKER_URL = 'redis://localhost:6379/0'
    CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'
    CELERY_ALWAYS_EAGER = False
    CELERY_CREATE_DIRS = 1

    NGINX_X_ACCEL_REDIRECT = True

    TIME_ZONE = 'Europe/Paris'
    ALLOW_PRIVATE_REPOS = True

    MANAGERS = ADMINS = ()

    ACCOUNT_EMAIL_VERIFICATION = "none"


CommunityProdSettings.load_settings(__name__)
