FROM intel4coro/jupyter-ros2:humble-py3.10

# --- Download URDF resources --- #
WORKDIR ${HOME}
RUN git clone --depth=1 https://github.com/Multiverse-Framework/Multiverse-Assets.git
RUN git clone --depth=1 https://github.com/Multiverse-Framework/Multiverse-World.git

# --- Install python dependencies --- #
# Put it before the COPY repo command to avoid install dependencies every time the repo changes
USER ${NB_USER}
COPY requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# --- Copy repo content --- #
COPY --chown=${NB_USER}:users . ${HOME}/ease_fall_school_2024
WORKDIR ${HOME}/ease_fall_school_2024

# --- Create symbolic links --- #
RUN ln -s ${HOME}/Multiverse-Assets ${HOME}/ease_fall_school_2024/day1/Assets
RUN ln -s ${HOME}/Multiverse-World/iai_apartment ${HOME}/ease_fall_school_2024/day1/iai_apartment
RUN ln -s ${HOME}/Multiverse-World/iai_apartment/urdf/apartment.xacro ${HOME}/ease_fall_school_2024/day1/iai_apartment.xacro

# --- Entrypoint --- #
ENTRYPOINT ["/entrypoint.sh"]
CMD [ "start-notebook.sh" ]
