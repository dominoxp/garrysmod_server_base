FROM cm2network/steamcmd:root

ENV GMODDIR="/server/gmod" \
	CSS="/server/cstrike"

RUN apt-get update && apt-get install -y bzip2 lib32gcc1 libtinfo5 lib32stdc++6 ca-certificates python3-minimal

RUN mkdir -p ${GMODDIR} && chown steam:steam ${GMODDIR} -R && \
	mkdir -p ${CSS} && chown steam:steam ${CSS} -R

RUN su steam -c "${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${GMODDIR} +app_update 4020 validate +force_install_dir ${CSS} +app_update 232330 validate +quit"

VOLUME ["${GMODDIR}/garrysmod/addons", "${GMODDIR}/garrysmod/data", "${GMODDIR}/garrysmod/cache"]

RUN chown steam:steam ${GMODDIR}
