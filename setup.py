from setuptools import find_packages, setup

from python_fielder_models import __version__

install_requires = []

setup(
    name="python_fielder_models",
    version=__version__,
    description="Django serializer models for Fielder",
    url="git@github.com:asomas/fielder-models",
    author="Sarmad Gulzar",
    author_email="sarmad@asomas.ai",
    license="MIT",
    packages=find_packages(),
    install_requires=install_requires,
    zip_safe=False,
)
