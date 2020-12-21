FROM cm2network/steamcmd:root

ENV GMODDIR="/server/gmod" \
	CSS="/server/cstrike"

RUN apt-get update && apt-get install -y bzip2 lib32gcc1 libtinfo5 lib32stdc++6 ca-certificates python3-minimal

RUN mkdir -p "${GMODDIR}" "${CSS}" "${GMODDIR}/garrysmod/addons" "${GMODDIR}/garrysmod/data" "${GMODDIR}/garrysmod/cache" && \
	chown steam:steam ${GMODDIR} -R && chown steam:steam ${CSS} -R

RUN su steam -c "${STEAMCMDDIR}/steamcmd.sh +login anonymous +force_install_dir ${GMODDIR} +app_update -beta x86-64 4020 validate +force_install_dir ${CSS} +app_update 232330 validate +quit"

VOLUME ["${GMODDIR}/garrysmod/addons", "${GMODDIR}/garrysmod/data", "${GMODDIR}/garrysmod/cache"]

RUN chown steam:steam ${GMODDIR}
