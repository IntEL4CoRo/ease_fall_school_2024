FROM intel4coro/jupyter-ros2:humble-py3.10

# --- Download URDF resources --- #
WORKDIR ${HOME}
RUN git clone --depth=1 https://github.com/Multiverse-Framework/Multiverse-Assets.git
RUN git clone --depth=1 https://github.com/Multiverse-Framework/Multiverse-World.git

USER ${NB_USER}
# --- Copy repo content --- #
COPY --chown=${NB_USER}:users . ${HOME}/work

WORKDIR ${HOME}/work
# --- Install python dependencies --- #
RUN pip install -r requirements.txt

# --- Create symbolic links --- #
RUN ln -s ${HOME}/Multiverse-Assets ${HOME}/work/day1/Assets
RUN ln -s ${HOME}/Multiverse-World/iai_apartment ${HOME}/work/day1/iai_apartment
RUN ln -s ${HOME}/Multiverse-World/iai_apartment/urdf/apartment.xacro ${HOME}/work/day1/iai_apartment.xacro

# --- Entrypoint --- #
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "start-notebook.sh" ]
