#!/usr/bin/env bash
JAR="$HOME/.local/share/nvim/lsp_servers/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"
GRADLE_HOME=$HOME/gradle /opt/homebrew/opt/openjdk@11/bin/java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -javaagent:$HOME/Library/lombok/lombok.jar \
    -Xms1g \
    -Xmx2G \
    -jar $(echo "$JAR") \
    -configuration "$HOME/.local/share/nvim/lsp_servers/jdtls/config_mac" \
    -data "${1:-$HOME/workspace}" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMEDi
