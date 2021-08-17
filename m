Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58C63EE303
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Aug 2021 03:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237162AbhHQBbD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Aug 2021 21:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbhHQBam (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Aug 2021 21:30:42 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E441C0617AE;
        Mon, 16 Aug 2021 18:30:10 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id c24so38111962lfi.11;
        Mon, 16 Aug 2021 18:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1rOuTQcx9Elf9jGsA5Ck42tuk06UuZfodHaWyKuopa4=;
        b=nLg7hn8A5q/Vx/CDPzbsu0UZcMhezzX4poGP9+aJl2GMGcJhQYqkUnj5Qjl2cn36JS
         TRG8tU87zTvHq5zgQXHaUfSGmd+O/0lOIjEqYc1BrK9zX8G0pOagT0C0wooOsAF5RN7B
         yK/7WuO8b06VawvO6kBp681V6kBFyVQi0S6F6onYaebnZX8T/ICfdcFvXSYrhsgVKUYL
         K9LhVT6ka2mjmSQGZXodX88ijX4Dp4wQUWAkjBdKY6Y5GWYluTSb3kBlJweMyYfHhACG
         IxdIRBbwpMCTUUHhK75ttkWtdcgq0pw9a09WmdFz57TCTIW/Tn8SPuEy+khxI9rWUJ9M
         eM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1rOuTQcx9Elf9jGsA5Ck42tuk06UuZfodHaWyKuopa4=;
        b=ZiUD7XWwSonTbzv8n4BxRvUs68IDRzJX2mA3Z9bOA2TpPAMlUc012Nb+2+5i8Se0KL
         bLHjRRy6JeKCm0pVyU4Ix86ZV1dcSU3ETkTMANOQL54GRXHlTj70mM04jvk/W/gwNS5l
         F0kjXB4Xji7wztkoa31wfu2gf7NOqkymVRjO+uLtLXwr5TyGr0uFQuNzMqigKhUZjaf9
         QJBrGHs+MlLE4PQQqeUxB8N0KzdEY7brteSFpCEOITsDvBFdxAq2eB5WxddMWlDaXgf8
         nOwzHsW9vgSapP+/7Q0uLz9RonYG/1y++bFoSCDESLf5TUgKQlCGzQ4P9DJyoZqMaeSW
         BftQ==
X-Gm-Message-State: AOAM531ZUWVLKRpqgFXL9mg2EAeOwMKcXfZ/a4XXigVcbq00PiRlLY4c
        uBigrIxju48wGEASaed4bJc=
X-Google-Smtp-Source: ABdhPJwYUUWzqvmh2TbyZ8slt93fpku6uQ4CmSmfQ4fl39kgqkYGTl90+c9np45vo/m/xAMOfWGCEg==
X-Received: by 2002:ac2:43c4:: with SMTP id u4mr476965lfl.357.1629163808543;
        Mon, 16 Aug 2021 18:30:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-85-91.dynamic.spd-mgts.ru. [46.138.85.91])
        by smtp.gmail.com with ESMTPSA id g30sm46607lfj.298.2021.08.16.18.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Aug 2021 18:30:08 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-spi@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-mmc@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH v8 06/34] dt-bindings: clock: tegra-car: Document new tegra-clocks sub-node
Date:   Tue, 17 Aug 2021 04:27:26 +0300
Message-Id: <20210817012754.8710-7-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210817012754.8710-1-digetx@gmail.com>
References: <20210817012754.8710-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document tegra-clocks sub-node which describes Tegra SoC clocks that
require a higher voltage of the core power domain in order to operate
properly on a higher clock rates.  Each node contains a phandle to OPP
table and power domain.

The root PLLs and system clocks don't have any specific device dedicated
to them, clock controller is in charge of managing power for them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/clock/nvidia,tegra20-car.yaml    | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index 459d2a525393..7f5cd27e4ce0 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -42,6 +42,48 @@ properties:
   "#reset-cells":
     const: 1
 
+  tegra-clocks:
+    description: child nodes are the output clocks from the CAR
+    type: object
+
+    patternProperties:
+      "^[a-z]+[0-9]+$":
+        type: object
+        properties:
+          compatible:
+            allOf:
+              - items:
+                  - enum:
+                      - nvidia,tegra20-sclk
+                      - nvidia,tegra30-sclk
+                      - nvidia,tegra30-pllc
+                      - nvidia,tegra30-plle
+                      - nvidia,tegra30-pllm
+              - const: nvidia,tegra-clock
+
+          operating-points-v2:
+            $ref: /schemas/types.yaml#/definitions/phandle
+            description:
+              Phandle to OPP table that contains frequencies, voltages and
+              opp-supported-hw property, which is a bitfield indicating
+              SoC process or speedo ID mask.
+
+          clocks:
+            items:
+              - description: node's clock
+
+          power-domains:
+            maxItems: 1
+            description: phandle to the core SoC power domain
+
+        required:
+          - compatible
+          - operating-points-v2
+          - clocks
+          - power-domains
+
+        additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -59,6 +101,15 @@ examples:
         reg = <0x60006000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+
+        tegra-clocks {
+            sclk {
+                compatible = "nvidia,tegra20-sclk", "nvidia,tegra-clock";
+                operating-points-v2 = <&opp_table>;
+                clocks = <&tegra_car TEGRA20_CLK_SCLK>;
+                power-domains = <&domain>;
+            };
+        };
     };
 
     usb-controller@c5004000 {
-- 
2.32.0

