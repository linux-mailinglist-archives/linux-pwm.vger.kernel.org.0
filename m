Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C3543A6FF
	for <lists+linux-pwm@lfdr.de>; Tue, 26 Oct 2021 00:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234489AbhJYWsS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 25 Oct 2021 18:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234381AbhJYWsO (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 25 Oct 2021 18:48:14 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC02C061745;
        Mon, 25 Oct 2021 15:45:51 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id h11so3745820ljk.1;
        Mon, 25 Oct 2021 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nXolFcz4QOLnIUZoiZ0Ry5uu5XANR011N6AEo6cZVfo=;
        b=DFM6sYRPZ8DXZXIU7Z6b73CuokdoFmhJ42EyQPI6iBIOmzdHrQtBjx2MJU5rOc8M58
         xju49IqtGJG68zWBZD/ep7cssGXLJ2427tJ+FeVOTm8kT4rVXBUEjTUecSXI1tHv3ORl
         sg7rVI1YfUdN5ynEHenkXbFPwA8htvBbwSN+XFy1kgV8sMUqTF9ctarRr9fdB7HBzNQ3
         h1zcOaBaXwnSeRuI9IfQBTdjJzXOqQvL0Yyt1R9C+HpW6VG7Eu4QS3/4dRVRcwsnPa1t
         P/m/1nH0RtRroBVwGogUrTAaYzcTAOHRaqVvamjgYsiwTIogS2Md/Xn9ZWYeqIiEoJhc
         FYjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nXolFcz4QOLnIUZoiZ0Ry5uu5XANR011N6AEo6cZVfo=;
        b=s/U2VT8blqziubViTtpTCMHV1ISbrVRhVIwEDLfVB1m+ybWKWzULO1SasB2IrMM3Sr
         xpViBtbsEfKDFaB2YkC+dUs9cnArp4cgxWkZbBTmndwCtwBvIKTlwUnepOPwTR7DzF2Q
         e18k/SH7GL/OyOOVtfP0539xdfm5DhYsAfd2w5NtiO0btxeg/4NoE5KH1MaH2WoEqSL2
         YR8sAvZAh0tqfwy5OBpDO9cAYMkFtknB6ea/L+Dq6U4ritMCQFIbsHQz4hDuriOD8sH6
         aOug9gT8rtWFyMO0z4Yj0ZKc70S8S7cN0xniZlKQt6qRHcBOC6TnhhV/mjw1qxO334f/
         dxDg==
X-Gm-Message-State: AOAM533RgEQyV2xUNbZIfb8//9kr1/f9ZEKPK0/UftEpj8R82gKXlrJ8
        Xj6XotdvHIMOdkuPxYcTeRQ=
X-Google-Smtp-Source: ABdhPJzU97QRuOu/GD/PWcLyUSSujXNS2wZq54jb9q+ctmsbd4g1VGg221OSD+erXWjv+9b+AYOEtQ==
X-Received: by 2002:a2e:8097:: with SMTP id i23mr21892283ljg.287.1635201949823;
        Mon, 25 Oct 2021 15:45:49 -0700 (PDT)
Received: from localhost.localdomain (46-138-41-28.dynamic.spd-mgts.ru. [46.138.41.28])
        by smtp.gmail.com with ESMTPSA id t20sm2040956lft.240.2021.10.25.15.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:45:49 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH v14 04/39] dt-bindings: clock: tegra-car: Document new clock sub-nodes
Date:   Tue, 26 Oct 2021 01:39:57 +0300
Message-Id: <20211025224032.21012-5-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211025224032.21012-1-digetx@gmail.com>
References: <20211025224032.21012-1-digetx@gmail.com>
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
2.33.1

