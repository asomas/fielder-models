from setuptools import find_packages, setup

install_requires = [
    "black==20.8b1",
    "djangorestframework>=3.11.0",
    "lxml==4.6.4",
    "wheel==0.36.2",
]

setup(
    name="python_fielder_models",
    version="0.0.206",
    description="Django serializer models for Fielder",
    url="git@github.com:asomas/fielder-models",
    author="Sarmad Gulzar",
    author_email="sarmad@asomas.ai",
    license="MIT",
    packages=find_packages(),
    install_requires=install_requires,
    zip_safe=False,
)
