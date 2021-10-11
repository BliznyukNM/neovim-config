#!/usr/bin/env bash
JAR="$HOME/.config/nvim/backends/jdt-language-server/plugins/org.eclipse.equinox.launcher_*.jar"
LAUNCH_ARGS= \
    # -javaagent:$HOME/Library/lombok/lombok.jar
GRADLE_HOME=$HOME/gradle /opt/homebrew/opt/openjdk@11/bin/java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    $LAUNCH_ARGS \
    -Xms1g \
    -Xmx2G \
    -jar $(echo "$JAR") \
    -configuration "$HOME/.config/nvim/backends/jdt-language-server/config_mac" \
    -data "${1:-$HOME/workspace}" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMEDi
