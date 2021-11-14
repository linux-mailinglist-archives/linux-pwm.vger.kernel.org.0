Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9298A44FAEC
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhKNTjQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236203AbhKNTi7 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:38:59 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33AC061767;
        Sun, 14 Nov 2021 11:36:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id y26so37504004lfa.11;
        Sun, 14 Nov 2021 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=QhEZ8tLrd3loe2fHwxK6+51M7PXBhYl2Mb3I/CA3ScH2m6Kjyk6heV5l8nMCzW90HO
         rTUwhpfLT4qom95awhIvBEd/ZCMV2yRJcNNBD6s9BrgbOYOsPjGybWYQvzslajFCIs8H
         Afs5Rt6w3qQ+0XHhVE8DMtP7pFA9Qk9Wcjjh4PEe6XQWNenE/6xRSN8GZmslq1LB6Kn8
         g3Qxc+QYbg/YgSuiY5Dpiu4dCOfXoDYfIyxSzJ902bqMc5XVe/9IIbpn1hUUN/0BvOu4
         PjwMRCoROJqI2+8I7FJspdHzmDqhkgsG875PDL2/bpfUVroxNpoHzhSQ+WY/reTg7kGe
         blMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uELYhg3LoYYilCBTSAEvuuZR4UEF9kvdsKmUqE/otlI=;
        b=QDstXRFaeD8Y4XWKeaNPqa/OJ5qj/gqozodfc58T5CbkVmNOIA3RfmRq26t4jtLsTC
         TgvSFR9bAWVNLIt7Sg2RI7bfmZfCgO7nuPqdECO0/folliu1pEKGc1uneE7kyPX/Cha6
         l/SBZIikpa48hVlBvSQB9OSGWVqmjq/vPRmrIq0oABf0hsqV/8g8BysbnAR7w9H0uXbu
         g8cDYqoZjZs0wV+VuiA3w3ZzAVdD+ItviA1oE+928pci9ia5iTMLpruvLzDtnzVTGZER
         Pl8jwcUmOyyafX3JRbiD7Sv+qICcBJt6vN1r+T26G7hjZeZ41MA6L4sYj5bjpKVJQq6r
         y2yg==
X-Gm-Message-State: AOAM530FHCvzkhV0NEcPKTEGWGFHDENCgeozIwEIRr00nepT0EI/O+wq
        iZZTQkFw0Rc0c431tutZ3NQ=
X-Google-Smtp-Source: ABdhPJy78tsaHkTtXQkUANfdWprKBp3QKCSyznqTf+vgxWn5eWntkrq5cYbdV+7IaqR1XP1suHMkvA==
X-Received: by 2002:a05:6512:23a4:: with SMTP id c36mr29320459lfv.634.1636918563468;
        Sun, 14 Nov 2021 11:36:03 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:03 -0800 (PST)
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
Subject: [PATCH v15 07/39] dt-bindings: host1x: Document Memory Client resets of Host1x, GR2D and GR3D
Date:   Sun, 14 Nov 2021 22:34:03 +0300
Message-Id: <20211114193435.7705-8-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
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
2.33.1

