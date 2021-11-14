Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6AA544FAFE
	for <lists+linux-pwm@lfdr.de>; Sun, 14 Nov 2021 20:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhKNTnW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 14 Nov 2021 14:43:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhKNTjT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 14 Nov 2021 14:39:19 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA59EC0613B9;
        Sun, 14 Nov 2021 11:36:23 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id y26so37505414lfa.11;
        Sun, 14 Nov 2021 11:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lzFtA16LetdYQr69hwWW6HmkTpjJj0vMycP3EfoabOc=;
        b=EE/chLe/LsFvIUSeQyQmGN91PrUcAuSyz0tVUW7sGhNUufPV6/cTlGndbYNLVSKxi+
         pNeJ/5bVtPYdNvdEoVffcIqOFzUpwuinreJBdVasxtx8x8vZ+2daOqSDO+rcZM2hpyUU
         svPqIbepnvLGSTm1Pm0FET5yEAw1i9JaThSjz+lx7KFyuqAoCfq6/CPaGsefoMD0URW7
         q0Gd8/cw2W5XymGDWKQnC7SzVOxkQK+rl9z41sC9M9AgwFXdg47UcFcUx0DCba+Tl7Zc
         ko2LcjI3O7767rW6hRJ5ncO7fyWi8DJnkWdDadSpTXNygghRX/vemDtc+qJHPygtpwnK
         hlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lzFtA16LetdYQr69hwWW6HmkTpjJj0vMycP3EfoabOc=;
        b=U41EB8VBPX3lfBsLK1iXo8X6WGNeN8inhRSyODehyfpggpDk9B3Nw1AfuHQVxvThto
         ZoKIXl+FYh6MdXdQnX+rKUzOSHOxcmam6as//i7l7orvduHbGergiVI6kUoUOa4gOGVF
         uDMB7uEe146zmyJuf3GyXBFxWf8YOMW5RGgQ+G8z5ux7egO6HOdgzvFmXNS9GN1ppT2r
         eqHxfUIvWepi5Kgry5x9fanXxWSNQMGZzeHW8AhCElXf3WscoO6EITjpBQWehA1kDZY4
         wcImb1sHSFZ4PAe9QxyYBtfSX1wJLCv2zdBwxjDr/ycVx7ThzHbYksHAoehKCKU8bGF2
         OgDg==
X-Gm-Message-State: AOAM5319gduwBP279+WyWj/8O+gMCuSd3cWVBoz6b1vXRBe+Fwz5p1ij
        EIILMOVWpRfp3xv1hS4beKg=
X-Google-Smtp-Source: ABdhPJwzhTah3r572OPXiaN6H8ghNMzmv0cpc8MTKf0k+5qKxAcGDcGG3yg9M33eUKPg9UQxs2539A==
X-Received: by 2002:a05:6512:689:: with SMTP id t9mr30313571lfe.614.1636918582380;
        Sun, 14 Nov 2021 11:36:22 -0800 (PST)
Received: from localhost.localdomain (46-138-46-211.dynamic.spd-mgts.ru. [46.138.46.211])
        by smtp.gmail.com with ESMTPSA id p18sm1191280lfu.127.2021.11.14.11.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Nov 2021 11:36:22 -0800 (PST)
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
Subject: [PATCH v15 27/39] soc/tegra: fuse: Reset hardware
Date:   Sun, 14 Nov 2021 22:34:23 +0300
Message-Id: <20211114193435.7705-28-digetx@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211114193435.7705-1-digetx@gmail.com>
References: <20211114193435.7705-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The FUSE controller is enabled at a boot time. Reset it in order to put
hardware and clock into clean and disabled state.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/soc/tegra/fuse/fuse-tegra.c | 25 +++++++++++++++++++++++++
 drivers/soc/tegra/fuse/fuse.h       |  1 +
 2 files changed, 26 insertions(+)

diff --git a/drivers/soc/tegra/fuse/fuse-tegra.c b/drivers/soc/tegra/fuse/fuse-tegra.c
index f2151815db58..cc032729a143 100644
--- a/drivers/soc/tegra/fuse/fuse-tegra.c
+++ b/drivers/soc/tegra/fuse/fuse-tegra.c
@@ -14,6 +14,7 @@
 #include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
 
@@ -243,6 +244,30 @@ static int tegra_fuse_probe(struct platform_device *pdev)
 		goto restore;
 	}
 
+	fuse->rst = devm_reset_control_get_optional(&pdev->dev, "fuse");
+	if (IS_ERR(fuse->rst)) {
+		err = PTR_ERR(fuse->rst);
+		dev_err(&pdev->dev, "failed to get FUSE reset: %pe\n",
+			fuse->rst);
+		goto restore;
+	}
+
+	/*
+	 * FUSE clock is enabled at a boot time, hence this resume/suspend
+	 * disables the clock besides the h/w resetting.
+	 */
+	err = pm_runtime_resume_and_get(&pdev->dev);
+	if (err)
+		goto restore;
+
+	err = reset_control_reset(fuse->rst);
+	pm_runtime_put(&pdev->dev);
+
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to reset FUSE: %d\n", err);
+		goto restore;
+	}
+
 	/* release the early I/O memory mapping */
 	iounmap(base);
 
diff --git a/drivers/soc/tegra/fuse/fuse.h b/drivers/soc/tegra/fuse/fuse.h
index de58feba0435..1b719d85bd04 100644
--- a/drivers/soc/tegra/fuse/fuse.h
+++ b/drivers/soc/tegra/fuse/fuse.h
@@ -43,6 +43,7 @@ struct tegra_fuse {
 	void __iomem *base;
 	phys_addr_t phys;
 	struct clk *clk;
+	struct reset_control *rst;
 
 	u32 (*read_early)(struct tegra_fuse *fuse, unsigned int offset);
 	u32 (*read)(struct tegra_fuse *fuse, unsigned int offset);
-- 
2.33.1

