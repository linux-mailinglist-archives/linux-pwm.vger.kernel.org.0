Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C467412C87
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Sep 2021 04:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351592AbhIUCp0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 20 Sep 2021 22:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241758AbhIUCCu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 20 Sep 2021 22:02:50 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4EAC1400B6;
        Mon, 20 Sep 2021 11:12:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p29so70462928lfa.11;
        Mon, 20 Sep 2021 11:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p6xrHF0JDm5yvfpc+kvah6ca7+v53gn0YbmmBZcvayY=;
        b=WFXTdUuw9sHZDxdLO19JLehOjo572zoAKuHr1r4FSdcB9MRrNxD5c7WlF9DHdgYY8N
         Oc7icpLMHPR5BcKAzWBmUwJVYXmZ2kDxQebER8B6Yv5ylHFAT0qBpPd1dznr1N98jQ/+
         /EtlnQVaIzYCb3cTgUfy5AowDajnzMtJIS7XMp5Pa7kzbQlFL8hh0HOxIvY8CRKa89ZH
         IVnHU5NbekBgoj+niWMAzTEJMFZTuslpR4TUURvFqjPUoi3azwvXg7CPjSoJlbWs3zwR
         zN2jBO3SGvxtOn42cjasmLXTIpBrC/f3yBCJ3Z10EalkguCJ/kgIBWdv5yUbPYkf0FdO
         5xvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p6xrHF0JDm5yvfpc+kvah6ca7+v53gn0YbmmBZcvayY=;
        b=7N2wRwy6wnzvft76a8kzdY9LPSqDL+uhHbvQC/ZAd49hSH+QAU2BJ0kiTm+QNIP9PT
         3NNXofEHRSHXhAW3BBPAzixfRHyebfbee+N9ZVezG+YjHAhOUbBCfAhXSWrO1lOw7XtL
         VhNB6Q38S7cNsRk7Y5RhFUmJZQFh3Vyp7alBzK+AulblMWUKrklO3AqS9Z8vjKgjPe24
         kgQXF90OCOeOoYBWPm2uOAhveYqJwAxGlZ6F+fp3Ifml7fCy2uXz1EKGtQc7BubIgzFv
         0u+C8Inj+bQUXnNgQowgx1g5B8grb9xDAtg4VYEwj1egLtIvXisVMPEMMhw84AE7BfR7
         kwHg==
X-Gm-Message-State: AOAM530E3CpK1Aj7sqOfsUiuXciS21OIMUJ9ZWyDuZR+eb27bSpL1goz
        rtQcDdxDDMTQLQJlObQNLQ0=
X-Google-Smtp-Source: ABdhPJxhgCSXEqJu5uXjMmUsgdSPkr/rR7vtJjtIDlSFWsXCRu1kRUDtZRxdnh9manyqCvHFbOStkQ==
X-Received: by 2002:a19:c38b:: with SMTP id t133mr19315865lff.196.1632161528474;
        Mon, 20 Sep 2021 11:12:08 -0700 (PDT)
Received: from localhost.localdomain (46-138-151-206.dynamic.spd-mgts.ru. [46.138.151.206])
        by smtp.gmail.com with ESMTPSA id u3sm1775677lju.107.2021.09.20.11.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 11:12:08 -0700 (PDT)
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
Subject: [PATCH v12 08/35] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Mon, 20 Sep 2021 21:11:18 +0300
Message-Id: <20210920181145.19543-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920181145.19543-1-digetx@gmail.com>
References: <20210920181145.19543-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 .../bindings/display/tegra/nvidia,tegra20-host1x.txt          | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
index 62861a8fb5c6..e61999ce54e9 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-host1x.txt
@@ -19,6 +19,7 @@ Required properties:
   See ../reset/reset.txt for details.
 - reset-names: Must include the following entries:
   - host1x
+  - mc
 
 Optional properties:
 - operating-points-v2: See ../bindings/opp/opp.txt for details.
@@ -198,6 +199,7 @@ of the following host1x client modules:
     See ../reset/reset.txt for details.
   - reset-names: Must include the following entries:
     - 2d
+    - mc
 
   Optional properties:
   - interconnects: Must contain entry for the GR2D memory clients.
@@ -224,6 +226,8 @@ of the following host1x client modules:
   - reset-names: Must include the following entries:
     - 3d
     - 3d2 (Only required on SoCs with two 3D clocks)
+    - mc
+    - mc2 (Only required on SoCs with two 3D clocks)
 
   Optional properties:
   - interconnects: Must contain entry for the GR3D memory clients.
-- 
2.32.0

