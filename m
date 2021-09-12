Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C7340807D
	for <lists+linux-pwm@lfdr.de>; Sun, 12 Sep 2021 22:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236738AbhILUMP (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 12 Sep 2021 16:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbhILULI (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 12 Sep 2021 16:11:08 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F5BC061574;
        Sun, 12 Sep 2021 13:09:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id e26so5140169wmk.2;
        Sun, 12 Sep 2021 13:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1AOM2RfjwsrGWR/uPrYeS/Sf+AYl6Sxk5Zgv7MiC4jY=;
        b=Dq3P3RRgJcqhcBh5BG9KO6CwsVH0mrKQnWOGCvOT4T1EFxj1AAlWyrHItGMz3hadTC
         lwz6mX2UdEXVMPLyyEUpCx8CRfbN0DQ+byj4Sy0rmHY3whnxhPMXVI5prvpxA2YWNsZ2
         KkNXQhfT+Vd5SjTt8wehgzX4wSdNOrqfP1m5rqm/xZ6b+7b25rvaalgv8G8myN2HCB4F
         jZslbkJsNeOWiy8sk/nT4Y7T3XGE1SzHXOgvlL0RWEDSdpwv5l4zveiR9pMXBCaiRLhR
         X1ulXY03uY6Qk36KfGgg9hK5mFE1ACgns2v7NgdU6Nk566CAx+Ldnf37dN3/n/nFsrdO
         LwkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1AOM2RfjwsrGWR/uPrYeS/Sf+AYl6Sxk5Zgv7MiC4jY=;
        b=4isUPe5K9zifYrhujV7sVCFl097V/0AKOYTVpZxrDmztNravkdfP0seh7BHOsu3uyn
         mcc7ix79gK4Vi64SZIfm4Sm+2g5lQ9lWwJiokTgYY2e9CbJFDAq6HPBtODebRNIcdahV
         A/lk8RJGIXh16NXrhF1TYqKvJfVUxcJs+YvLcwylV2VbGUlsUNILf7pP822Dw5UkppfF
         FiuKmKaIWAKU+tS0tYE7fomPyIVRkRGpA1Jr5QmoVEfsEf3hshrVVJ9CU3ZgZ89GFnXs
         I1z1liVHLXUpoow7LKMuNjbMKdUSf772vKJ/Fa1NutJYJi/LhBY4J1RjMbPUKRH91fIj
         u+pQ==
X-Gm-Message-State: AOAM531tLfwA8mj+b+zOZuKDPA5l7q9JZxhp72acgyyTooFn7AvK1YLi
        GJPs1qC9xRHHu+UED9ES1sg=
X-Google-Smtp-Source: ABdhPJxw34GNDCRDT8MU7zKTgdsV2n63kBh9Hmu14z0qokFeoDFjF2GQ8OyM2QjooyQFpIy1D/5WBw==
X-Received: by 2002:a1c:7208:: with SMTP id n8mr7712537wmc.7.1631477392315;
        Sun, 12 Sep 2021 13:09:52 -0700 (PDT)
Received: from localhost.localdomain (46-138-83-36.dynamic.spd-mgts.ru. [46.138.83.36])
        by smtp.gmail.com with ESMTPSA id v10sm5463476wrg.15.2021.09.12.13.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 13:09:52 -0700 (PDT)
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
Subject: [PATCH v11 08/34] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Sun, 12 Sep 2021 23:08:06 +0300
Message-Id: <20210912200832.12312-9-digetx@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210912200832.12312-1-digetx@gmail.com>
References: <20210912200832.12312-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Memory Client should be blocked before hardware reset is asserted in order
to prevent memory corruption and hanging of memory controller.

Document Memory Client resets of Host1x, GR2D and GR3D hardware units.

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

