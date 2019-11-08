Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7B73F4278
	for <lists+linux-pwm@lfdr.de>; Fri,  8 Nov 2019 09:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbfKHIpy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 8 Nov 2019 03:45:54 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42699 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfKHIpb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 8 Nov 2019 03:45:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id a15so6014444wrf.9;
        Fri, 08 Nov 2019 00:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q1SErrR/PV8Tu23yQ+QPofy4bJ7Dz3186/De70+A1IY=;
        b=aNtq9XYb7Gu//QxS2dCLqucgCUuU8TBnf5eyiZhT71GJbpm0UqL9w82WhhkQHRVCUq
         NzeDeGxap26Im/l8wl6SakWrh5xds93z+g9ASE1k2qSh8genXmeldFSsKfndoe6J0GLa
         9YX4X1xMRj/oaVMEfFAuDLzD8bzOwtoNnTsSVHN0jLWX761Q9LV/ALME+UskSZQsJR2p
         av7GDVFzwQscc4CFe0oK/T1l1/hG5YUkxmYj+yv/EDylNkzBUM6fn8sIOmcFrFMyMb94
         sP0eRWAcpjkTAhD9xcFBL5MFAolAt0OojTyKlABS9QK5PNQJOd2kUK74iRb3bNNw+ZiW
         TGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q1SErrR/PV8Tu23yQ+QPofy4bJ7Dz3186/De70+A1IY=;
        b=SWqSBm4oXlgK4mwxBzlLeXNjucgeezMds58eOmZQq2xrXdnxgrSiPJvi/jaQFE10C4
         tKwBpoBGs4xTNCgvgQeu5Kj/5ux/cZpxXHkBvWKCorlSSYu7J0C8ZqhXgVdpBnxlUQwg
         fB4JTSauvCL/Fq2VBmMC4sedFBGM64bfY43amsvxjikvEB3VlU62Vw+bRJ4YOW76QRgb
         Ryo78kgI3W9hbf3fLbQJSCYVcERiUbBMnF/7K1vzVXKnb8JwmQ3oFelWcbkC818E2v6t
         VmEM+Ku84R047o40QO1uIo/kj8FKQb9/Mn4cO1HsC48KUv774l3Y0962L6IIc13BY7Nt
         OYBw==
X-Gm-Message-State: APjAAAWI+6haNUTWrZVEaHuSRPyP947rF+G8b29mR9F2bCB5nbZmAQI+
        NyQyHPl8Z7K4DlAwMnyptmBooDWPcis=
X-Google-Smtp-Source: APXvYqxd0/kwcmVD9KXQBezV2WMCtP44Hqqg6T96a3Zyb0CObgdqvf/lotqgnPAwLqFub2sJvDK8aw==
X-Received: by 2002:adf:9506:: with SMTP id 6mr7599277wrs.274.1573202728901;
        Fri, 08 Nov 2019 00:45:28 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id q25sm6662665wra.3.2019.11.08.00.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2019 00:45:28 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v4 3/7] pwm: sun4i: Add an optional probe for bus clock
Date:   Fri,  8 Nov 2019 09:45:13 +0100
Message-Id: <20191108084517.21617-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108084517.21617-1-peron.clem@gmail.com>
References: <20191108084517.21617-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM core needs bus clock to be enabled in order to work.

Add an optional probe for it and a fallback for previous
bindings without name on module clock.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 48 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 2b9a2a78591f..a10022d6c0fd 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -363,9 +364,38 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
+	/* Get all clocks and reset line */
+	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
+	if (IS_ERR(pwm->clk)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get clock failed %pe\n",
+				pwm->clk);
 		return PTR_ERR(pwm->clk);
+	}
+
+	/*
+	 * Fallback for old dtbs with a single clock and no name.
+	 * If a parent has a clock-name called "mod" whereas the
+	 * current node is unnamed the clock reference will be
+	 * incorrectly obtained and will not go into this fallback.
+	 */
+	if (!pwm->clk) {
+		pwm->clk = devm_clk_get(&pdev->dev, NULL);
+		if (IS_ERR(pwm->clk)) {
+			if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+				dev_err(&pdev->dev, "get clock failed %pe\n",
+					pwm->clk);
+			return PTR_ERR(pwm->clk);
+		}
+	}
+
+	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get bus_clock failed %pe\n",
+				pwm->bus_clk);
+		return PTR_ERR(pwm->bus_clk);
+	}
 
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
@@ -382,6 +412,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * We're keeping the bus clock on for the sake of simplicity.
+	 * Actually it only needs to be on for hardware register
+	 * accesses.
+	 */
+	ret = clk_prepare_enable(pwm->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot prepare and enable bus_clk\n");
+		goto err_bus;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -402,6 +443,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -416,6 +459,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

