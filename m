Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC827412C81
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348108AbhIUCpY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241656AbhIUCCf (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4DDEC1400A0;
        Mon, 20 Sep 2021 11:12:05 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i4so71805027lfv.4;
        Mon, 20 Sep 2021 11:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XIkaLltNAZEHFO/c9xmZHlt7cmXZw7U8aSqzSL63yiM=;
        b=QR7crULn70ioVU6cJO0TUJsZOug/kx8+q0kdL8r3yyOOhbJN1xwnsdqK3YFwYnPO1D
         YPRF2iN6UbB7tDMpSwsmRjNwuyn/xchFCV6zGvl+2ldyfEWNopx/xNPrLySVMeAuU1Md
         6y5mk7LvKPQ3mE69ZMmjY1QMoMADHlYmx2FPB0mSw3t9bUBYvBy+B/8zIAwOBCecVKn/
         dbTVsIP2LIV22P4iv5OwK15ctcxda++XsuBLn7j53nYXsh5jp8rcWmbmXY3wnBZNtJuU
         wPTLW4O+tCatbuutLuvqrGe5pN4z16nHuxgLrLutnhJQRbzpEDMbOuNz1sArrkzi2/Rz
         6KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XIkaLltNAZEHFO/c9xmZHlt7cmXZw7U8aSqzSL63yiM=;
        b=IvdGUD7+qAKLPpJmFZHsCCwZOCHRqaJVr08VXuXQb4UD4cQnCUVYrESOiaCtgpIqBP
         UgPx4inydu/biWXxKbRxhb7n3/nBrglzbq39v4T9D8ucxYqXpVFQvKxD9+Wo2CIlnl+X
         skmBKcIswh9n10grRDqw2t1NxxfmDVM8ikyzaLb80y0UsnJuAzIWCj9XxcZWh/YrZVG7
         BgJe4sZqHMsOa3nSNMyHtQkaC48am/D/w0br3JXo/aqYqrx7fXlGCq+2S39zjr2JV0Ei
         d6OGnWXBaHvFI9Af2wlvHCoAkqiS+073vIFzbgyMsKOsTW/VU/m3VV6TV9KoAcNV7Po7
         QOcw==
X-Gm-Message-State: AOAM533IgEjBOXr7T4H4JrjZ3R1y5NkaHJfZdKTQwpGV50LhPfa3UeVQ
        eRFh7XR+iMmlXhVErELkqLM=
X-Google-Smtp-Source: ABdhPJzdPPIUbg2iHniLs9xciDT3bW0EtPPoQm7NGnWQa4QJPeZfcF+zbA9DAs7CR26Xo7o9MypucA==
X-Received: by 2002:a2e:300c:: with SMTP id w12mr5558269ljw.302.1632161524353;
        Mon, 20 Sep 2021 11:12:04 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:04 -0700 (PDT)
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
Subject: [PATCH v12 05/35] dt-bindings: clock: tegra-car: Document new clock sub-nodes
Date:   Mon, 20 Sep 2021 21:11:15 +0300
Message-Id: <20210920181145.19543-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Document sub-nodes which describe Tegra SoC clocks that require a higher
voltage of the core power domain in order to operate properly on a higher
clock rates.  Each node contains a phandle to OPP table and power domain.

The root PLLs and system clocks don't have any specific device dedicated
to them, clock controller is in charge of managing power for them.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/clock/nvidia,tegra20-car.yaml    | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
index 459d2a525393..f832abb7f11a 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra20-car.yaml
@@ -42,6 +42,36 @@ properties:
   "#reset-cells":
     const: 1
 
+patternProperties:
+  "^(sclk)|(pll-[cem])$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - nvidia,tegra20-sclk
+          - nvidia,tegra30-sclk
+          - nvidia,tegra30-pllc
+          - nvidia,tegra30-plle
+          - nvidia,tegra30-pllm
+
+      operating-points-v2: true
+
+      clocks:
+        items:
+          - description: node's clock
+
+      power-domains:
+        maxItems: 1
+        description: phandle to the core SoC power domain
+
+    required:
+      - compatible
+      - operating-points-v2
+      - clocks
+      - power-domains
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -59,6 +89,13 @@ examples:
         reg = <0x60006000 0x1000>;
         #clock-cells = <1>;
         #reset-cells = <1>;
+
+        sclk {
+            compatible = "nvidia,tegra20-sclk";
+            operating-points-v2 = <&opp_table>;
+            clocks = <&tegra_car TEGRA20_CLK_SCLK>;
+            power-domains = <&domain>;
+        };
     };
 
     usb-controller@c5004000 {
-- 
2.32.0

