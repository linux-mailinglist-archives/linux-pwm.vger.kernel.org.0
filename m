Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0CEEFE1B
	for <lists+linux-pwm@lfdr.de>; Tue,  5 Nov 2019 14:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbfKENPG (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 5 Nov 2019 08:15:06 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52338 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388710AbfKENPG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 5 Nov 2019 08:15:06 -0500
Received: by mail-wm1-f65.google.com with SMTP id c17so13507806wmk.2;
        Tue, 05 Nov 2019 05:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rylm49vbwAP0jTLqPJTMvxfUjjjnX0b1bndG2Prv3MM=;
        b=czvQULzeZnU/hHelxIDEbrHjoHdaiPYQD8gnbGsKhOEh19ZBw8jd8B0nls9dBjk0SH
         Tb6wvy6h9Nkzy5j/9X8SLNn166nTOTPmABsrBk0ocCLCrF+510qtKrT++c2NbY4RRtLo
         mNH5VaXaXyU5Yjdic9cvMEqDR4x8pUvL92nVY9+oGXcDYx9Du1LePiojZOnup3C5/LpZ
         s7yf7fp4OG0BqmTFjkJZ6UOrhb0LQ8W4KZ3GIiZQ5SWe8pHvaTP8aZh4ren+mwRLy2lb
         lRLVpRh92D7yC1H8DLTUShi6GLwke4L37aSDDeMQrxLwvdFhgXuefoaU/+5sYoP2znqG
         G05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rylm49vbwAP0jTLqPJTMvxfUjjjnX0b1bndG2Prv3MM=;
        b=GZGL/k0fNb7zWzlJjcsN2F95B220PudK4uHpnwjw+YOfeabFZZY3C2eWCaAetaxBIW
         XaHWofBej+zu5cimFgmNipzqaqPNa6KQsXs8y/Gb1J6d8+i1/1ibyOWH2611coY3xCbo
         WaVUO2+8u2J2hkk18TcNT7I1wEH4kLkKXhUCfd16WhQfCfJ6YvJkziWKZOddytiQ1n7m
         yqjH2medrhUCIQCKK9WZljCM6/vu0iLi5JRJv8d5c8/KTRvgIfZeQLDxTA59ZGJxISQ4
         sTd9G949wDpyF4kglRCkmurpsUHzIwaqela479aAB4wK6+mjcXmo1UHg+r+HJ2WuIdmr
         It5g==
X-Gm-Message-State: APjAAAXQUAOd2Ea4HdGifF73Dh/24chmWZGsgATu6pQ8mK7byT43LODl
        ZxaiB5KUxDZbMbr25/MvisY=
X-Google-Smtp-Source: APXvYqznbNCR4gLMX1epuZh7z03kgXnDOQWlHW6f0JH8v91E8iiEzK9mKwb3zm4PfWZeD9g5ak73aw==
X-Received: by 2002:a1c:2706:: with SMTP id n6mr4432965wmn.154.1572959703335;
        Tue, 05 Nov 2019 05:15:03 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id a6sm13549920wmj.1.2019.11.05.05.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 05:15:02 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v3 3/7] pwm: sun4i: Add an optional probe for bus clock
Date:   Tue,  5 Nov 2019 14:14:52 +0100
Message-Id: <20191105131456.32400-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191105131456.32400-1-peron.clem@gmail.com>
References: <20191105131456.32400-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 45 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 9ba83769a478..54e19fa56a4e 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -363,9 +364,35 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->base))
 		return PTR_ERR(pwm->base);
 
-	pwm->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pwm->clk))
+	/* Get all clocks and reset line */
+	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
+	if (IS_ERR(pwm->clk)) {
+		dev_err(&pdev->dev, "get clock failed %ld\n",
+			PTR_ERR(pwm->clk));
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
+			dev_err(&pdev->dev, "get clock failed %ld\n",
+				PTR_ERR(pwm->clk));
+			return PTR_ERR(pwm->clk);
+		}
+	}
+
+	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		dev_err(&pdev->dev, "get bus_clock failed %ld\n",
+			PTR_ERR(pwm->bus_clk));
+		return PTR_ERR(pwm->bus_clk);
+	}
 
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
@@ -382,6 +409,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
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
@@ -402,6 +440,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -416,6 +456,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

