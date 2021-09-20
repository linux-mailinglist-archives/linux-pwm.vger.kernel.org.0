Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1E0412C93
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351860AbhIUCpp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbhIUCDH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:03:07 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27185C140925;
        Mon, 20 Sep 2021 11:12:32 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y28so69656451lfb.0;
        Mon, 20 Sep 2021 11:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ibGug1ieM1Zc7MJuknBrkttvd7qxV12foe1b+4QmuwU=;
        b=N8bTLhdJS1tRK7kb66jGnWWxeCVnZ4U8UTSOkhenHnkz1Iha1ZB5v14ejpbC9OBUiH
         ROpnRKZMlvXdsVURiFwYtcm8pvzuXJw7+7RHtDKnhVkUllD+PWGvairMHA9cJDfsrMpA
         PFWrp4yOCNs7fuN+a7VX4VNKbq89+pObh++yImfwQfLcTf1RSTA+L9pk7aKlA+NkI3+i
         Ji2viYOzyiJd3XpYNvJnd27AHMmnalLrZ5mPXvLnisCG0jtVe80z3DYyM+rUHJjio2bH
         MwqIUfkEn2iqspAEn6YEtTdT0fU8xUXo7BqMSt5jDux8PYo66Fmx81oAOVubS2L5oUUQ
         V+Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ibGug1ieM1Zc7MJuknBrkttvd7qxV12foe1b+4QmuwU=;
        b=nsAOswhfJCgkcw5UElhILFaJ4JKsAvVxZv2HsyC7Ff/DF0QJe7pt5jGm1RcgdNy2Li
         TC3qNB+lIzFsSuOpM5/Mufou9QJs2Q8yZykyVbNdCcMlFIXJZfMNpOc98OYlmfbNbyXY
         fWwG21PHvdKX2lh6rBNI0ek/3h7GodykeD6NuaiHOFrnn1UonK8XWX86NfAsrIIW9gtJ
         tRkQ/XM90dzcs0lnX2CRgrFF3fY17DtKsiDMm23AjYTjZhGHjcS7Tf3oV60yQzskyggQ
         /TAYcnwtPf8+ayNY07to+jNZyTH7i5cIAWyWPo97+3U8qbjR7BRtFh+/XZUt2VzlCS4P
         gLTQ==
X-Gm-Message-State: AOAM5307MlEMHA+nxmYV6pMX9haOS6XtbA/FgBSrs1axLG7vr/jq5pjx
        mfXqx9OZxfjFkVLC24JFtnw=
X-Google-Smtp-Source: ABdhPJyKWl6Wfk3O8oXy6VPIO6lO7gwklUZsdWFaSfWuAUj82tSDiJc9RSQMcgq5kpiI9r85gdbb5Q==
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr7852728lfv.655.1632161547306;
        Mon, 20 Sep 2021 11:12:27 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:27 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Subject: [PATCH v12 22/35] media: dt: bindings: tegra-vde: Convert to schema
Date:   Mon, 20 Sep 2021 21:11:32 +0300
Message-Id: <20210920181145.19543-23-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Convert NVIDIA Tegra video decoder binding to schema.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/media/nvidia,tegra-vde.txt       |  64 -----------
 .../bindings/media/nvidia,tegra-vde.yaml      | 107 ++++++++++++++++++
 2 files changed, 107 insertions(+), 64 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
 create mode 100644 Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml

diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
deleted file mode 100644
index 602169b8aa19..000000000000
--- a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.txt
+++ /dev/null
@@ -1,64 +0,0 @@
-NVIDIA Tegra Video Decoder Engine
-
-Required properties:
-- compatible : Must contain one of the following values:
-   - "nvidia,tegra20-vde"
-   - "nvidia,tegra30-vde"
-   - "nvidia,tegra114-vde"
-   - "nvidia,tegra124-vde"
-   - "nvidia,tegra132-vde"
-- reg : Must contain an entry for each entry in reg-names.
-- reg-names : Must include the following entries:
-  - sxe
-  - bsev
-  - mbe
-  - ppe
-  - mce
-  - tfe
-  - ppb
-  - vdma
-  - frameid
-- iram : Must contain phandle to the mmio-sram device node that represents
-         IRAM region used by VDE.
-- interrupts : Must contain an entry for each entry in interrupt-names.
-- interrupt-names : Must include the following entries:
-  - sync-token
-  - bsev
-  - sxe
-- clocks : Must include the following entries:
-  - vde
-- resets : Must contain an entry for each entry in reset-names.
-- reset-names : Should include the following entries:
-  - vde
-
-Optional properties:
-- resets : Must contain an entry for each entry in reset-names.
-- reset-names : Must include the following entries:
-  - mc
-- iommus: Must contain phandle to the IOMMU device node.
-
-Example:
-
-video-codec@6001a000 {
-	compatible = "nvidia,tegra20-vde";
-	reg = <0x6001a000 0x1000 /* Syntax Engine */
-	       0x6001b000 0x1000 /* Video Bitstream Engine */
-	       0x6001c000  0x100 /* Macroblock Engine */
-	       0x6001c200  0x100 /* Post-processing Engine */
-	       0x6001c400  0x100 /* Motion Compensation Engine */
-	       0x6001c600  0x100 /* Transform Engine */
-	       0x6001c800  0x100 /* Pixel prediction block */
-	       0x6001ca00  0x100 /* Video DMA */
-	       0x6001d800  0x300 /* Video frame controls */>;
-	reg-names = "sxe", "bsev", "mbe", "ppe", "mce",
-		    "tfe", "ppb", "vdma", "frameid";
-	iram = <&vde_pool>; /* IRAM region */
-	interrupts = <GIC_SPI  9 IRQ_TYPE_LEVEL_HIGH>, /* Sync token interrupt */
-		     <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>, /* BSE-V interrupt */
-		     <GIC_SPI 12 IRQ_TYPE_LEVEL_HIGH>; /* SXE interrupt */
-	interrupt-names = "sync-token", "bsev", "sxe";
-	clocks = <&tegra_car TEGRA20_CLK_VDE>;
-	reset-names = "vde", "mc";
-	resets = <&tegra_car 61>, <&mc TEGRA20_MC_RESET_VDE>;
-	iommus = <&mc TEGRA_SWGROUP_VDE>;
-};
diff --git a/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
new file mode 100644
index 000000000000..3b6c1f031e04
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/nvidia,tegra-vde.yaml
@@ -0,0 +1,107 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/media/nvidia,tegra-vde.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra Video Decoder Engine
+
+maintainers:
+  - Dmitry Osipenko <digetx@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - nvidia,tegra132-vde
+              - nvidia,tegra124-vde
+              - nvidia,tegra114-vde
+              - nvidia,tegra30-vde
+          - enum:
+              - nvidia,tegra20-vde
+      - items:
+          - const: nvidia,tegra20-vde
+
+  reg:
+    maxItems: 9
+
+  reg-names:
+    items:
+      - const: sxe
+      - const: bsev
+      - const: mbe
+      - const: ppe
+      - const: mce
+      - const: tfe
+      - const: ppb
+      - const: vdma
+      - const: frameid
+
+  clocks:
+    maxItems: 1
+
+  resets:
+    maxItems: 2
+
+  reset-names:
+    items:
+      - const: vde
+      - const: mc
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: sync-token
+      - const: bsev
+      - const: sxe
+
+  iommus:
+    maxItems: 1
+
+  iram:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of the SRAM MMIO node.
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+
+additionalProperties: false
+
+examples:
+  - |
+    video-codec@6001a000 {
+      compatible = "nvidia,tegra20-vde";
+      reg = <0x6001a000 0x1000>, /* Syntax Engine */
+            <0x6001b000 0x1000>, /* Video Bitstream Engine */
+            <0x6001c000  0x100>, /* Macroblock Engine */
+            <0x6001c200  0x100>, /* Post-processing Engine */
+            <0x6001c400  0x100>, /* Motion Compensation Engine */
+            <0x6001c600  0x100>, /* Transform Engine */
+            <0x6001c800  0x100>, /* Pixel prediction block */
+            <0x6001ca00  0x100>, /* Video DMA */
+            <0x6001d800  0x300>; /* Video frame controls */
+      reg-names = "sxe", "bsev", "mbe", "ppe", "mce",
+                  "tfe", "ppb", "vdma", "frameid";
+      iram = <&iram>; /* IRAM MMIO region */
+      interrupts = <0  9 4>, /* Sync token */
+                   <0 10 4>, /* BSE-V */
+                   <0 12 4>; /* SXE */
+      interrupt-names = "sync-token", "bsev", "sxe";
+      clocks = <&clk 61>;
+      reset-names = "vde", "mc";
+      resets = <&rst 61>, <&mem 13>;
+      iommus = <&mem 15>;
+    };
-- 
2.32.0

