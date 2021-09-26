Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C44418BAE
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Sep 2021 00:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbhIZWoN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 26 Sep 2021 18:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbhIZWoK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 26 Sep 2021 18:44:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C2C061570;
        Sun, 26 Sep 2021 15:42:32 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id m3so68752784lfu.2;
        Sun, 26 Sep 2021 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yMo8zD+Y4gBSxPVZ+67KkVYFkJ7TR9WX94Fb70e9izk=;
        b=fcIYQRh9XxRIRXB/80/nSQZZbSclhF1IL2Ysssmz6UKjW/8VpVzXFUvmz9grBShsTu
         VY5ke319Yg3BYCLYbFEy5O8IeLmQn9yib7lZ2ftgx2+fIKvsmLFpV0gXmKw3cSgiighL
         z44ewmkuBPt55RT3SFFzXQ3xeJSsGDr0R4F5fmCAgEZ3Efq3SxBDHo37JYtEBEgNhF5e
         sqYnRxIxZOHNZc31mQcCtuct8H5wSkbK0FZqVF2bFwuxog0VZwrjfcsus/XQPqBML4Qq
         L8c/AYAqg5mMqw1TOVr8DG9+zLXCh6uEPr60TGhx0UtzFD0QyNg5T/qESzi3qS9Skfa2
         9UHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yMo8zD+Y4gBSxPVZ+67KkVYFkJ7TR9WX94Fb70e9izk=;
        b=Nu6SKFcqJh50azuFrLdtn7v6Hbnvl7FEBQBX4O2+ysvl8Smtg1qSpZKt9UudadzXAD
         IQgMYlB7IrTbyBrrHaMWYfAV4zx7STULtl/QOaLbgnqQ4cP5PEIKmZ+u5bR0ptKFdUQn
         e1FDVFH9AsP9ssnE61CGdNjfRbnjkJUCybHSBakg1IBcsARcO4+wOQmmfjGgSLhVJHqf
         Pv70IoNti+pmcpw9D9AkMf98N5DGbyBHGinV01YLNmZ5vDtku/Wd5rSzk+Cl6FeYAdaR
         JOHUBi5B3yspElkQVlqQcQvmNg2mv9btVcaxko2sBFIqfdoIN23dfNBX0M+bVfn44YlB
         d5kA==
X-Gm-Message-State: AOAM533IFjZM4jjItq8hS19zxtCZ8BvBfO2utTn1MEEVvco/K5kAOTQu
        MSNU6kbjSxadzil1QVCpKZA=
X-Google-Smtp-Source: ABdhPJxo7iqkV9l9gRrhuOVZ5G8rPWWXpZNjmUEhYykmnabkYmPdy6DxYveMBgNr9BLYgvhEo0AjEQ==
X-Received: by 2002:a2e:9a98:: with SMTP id p24mr25245378lji.55.1632696151415;
        Sun, 26 Sep 2021 15:42:31 -0700 (PDT)
Received: from localhost.localdomain (46-138-80-108.dynamic.spd-mgts.ru. [46.138.80.108])
        by smtp.gmail.com with ESMTPSA id m10sm1408899lfr.272.2021.09.26.15.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 15:42:31 -0700 (PDT)
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
Subject: [PATCH v13 05/35] dt-bindings: clock: tegra-car: Document new clock sub-nodes
Date:   Mon, 27 Sep 2021 01:40:28 +0300
Message-Id: <20210926224058.1252-6-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210926224058.1252-1-digetx@gmail.com>
References: <20210926224058.1252-1-digetx@gmail.com>
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

Reviewed-by: Rob Herring <robh@kernel.org>
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

