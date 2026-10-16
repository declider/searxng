.. SPDX-License-Identifier: AGPL-3.0-or-later

Windows-native fork
===================

This fork runs SearXNG **natively on Windows** — no Docker, no WSL. Upstream
targets Linux/Unix and points Windows users at a container or WSL. The only
source change required was making the Unix-only ``pwd`` import in
``searx/valkeydb.py`` optional.

Install
-------

.. code-block:: powershell

   uv venv .venv --python 3.12
   uv pip install --python .venv\Scripts\python.exe setuptools wheel pyyaml msgspec typing-extensions pybind11
   uv pip install --python .venv\Scripts\python.exe --no-build-isolation -e .
   uv pip install --python .venv\Scripts\python.exe tzdata

   copy settings.windows.yml settings.yml
   .venv\Scripts\python.exe -c "import secrets;print(secrets.token_hex(32))"
   rem paste the output into server.secret_key in settings.yml

Run
---

.. code-block:: powershell

   run.cmd

The instance serves on http://127.0.0.1:8888 with JSON search enabled, ready
for local agents::

   crw search "your query" --search-backend-url http://127.0.0.1:8888

See ``WINDOWS.md`` for the complete list of changes against upstream.
Everything below is the unmodified upstream README.

----

.. _metasearch engine: https://en.wikipedia.org/wiki/Metasearch_engine
.. _Installation guide: https://docs.searxng.org/admin/installation.html
.. _Configuration guide: https://docs.searxng.org/admin/settings/index.html
.. _CONTRIBUTING: https://github.com/searxng/searxng/blob/master/CONTRIBUTING.rst
.. _LICENSE: https://github.com/searxng/searxng/blob/master/LICENSE

.. figure:: https://raw.githubusercontent.com/searxng/searxng/master/client/simple/src/brand/searxng.svg
   :target: https://searxng.org
   :alt: SearXNG
   :width: 512px


SearXNG is a `metasearch engine`_. Users are neither tracked nor profiled.

.. image:: https://img.shields.io/badge/organization-3050ff?style=flat-square&logo=searxng&logoColor=fff&cacheSeconds=86400
   :target: https://github.com/searxng
   :alt: Organization

.. image:: https://img.shields.io/badge/documentation-3050ff?style=flat-square&logo=readthedocs&logoColor=fff&cacheSeconds=86400
   :target: https://docs.searxng.org
   :alt: Documentation

.. image:: https://img.shields.io/github/license/searxng/searxng?style=flat-square&label=license&color=3050ff&cacheSeconds=86400
   :target: https://github.com/searxng/searxng/blob/master/LICENSE
   :alt: License

.. image:: https://img.shields.io/github/commit-activity/y/searxng/searxng/master?style=flat-square&label=commits&color=3050ff&cacheSeconds=3600
   :target: https://github.com/searxng/searxng/commits/master/
   :alt: Commits

.. image:: https://img.shields.io/weblate/progress/searxng?server=https%3A%2F%2Ftranslate.codeberg.org&style=flat-square&label=translated&color=3050ff&cacheSeconds=86400
   :target: https://translate.codeberg.org/projects/searxng/
   :alt: Translated

Setup
=====

To install SearXNG, see `Installation guide`_.

To fine-tune SearXNG, see `Configuration guide`_.

Further information on *how-to* can be found `here <https://docs.searxng.org/admin/index.html>`_.

Connect
=======

If you have questions or want to connect with others in the community:

- `#searxng:matrix.org <https://matrix.to/#/#searxng:matrix.org>`_

Contributing
============

See CONTRIBUTING_ for more details.

License
=======

This project is licensed under the GNU Affero General Public License (AGPL-3.0).
See LICENSE_ for more details.
