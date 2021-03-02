from setuptools import setup, find_packages

install_requires = [
    "black==20.8b1",
    "djangorestframework>=3.11.0",
    "wheel==0.36.2",
]

setup(
    name="python_fielder_models",
    version="0.0.4",
    description="Django serializer models for Fielder",
    url="git@github.com:asomas/fielder-models",
    author="Sarmad Gulzar",
    author_email="sarmad@asomas.ai",
    license="MIT",
    packages=find_packages(),
    install_requires=install_requires,
    zip_safe=False,
)