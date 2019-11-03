Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8528AED4AF
	for <lists+linux-pwm@lfdr.de>; Sun,  3 Nov 2019 21:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfKCUeO (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 3 Nov 2019 15:34:14 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:41480 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbfKCUdu (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 3 Nov 2019 15:33:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so14775982wrm.8;
        Sun, 03 Nov 2019 12:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CQuQmd85Ia5RpOjrEh6LyCYQrdLstz30Cf07TMDdjnM=;
        b=TrdbbXY8ypON0YbPaQmrkrlR7rMjj2Qh82MRAPOCdd0paTG/Umqko8Prl9yV3KxJXm
         VtWAq3qtwR4OdW9J4+sWI47Nvpwyr8YDUEHKuFqrbtJOKQNnTaM/NgDwLh4YAvQsZ4Y4
         Ivm8GXNo9iyoJ7ZZ0Nrw/lZj1De1IIOPLLNjDK5WLT3eJZAzPVZLpUanjzKedtRS95dU
         3fpB7x5FPTGuK6ZW4i1dDWE/zd/OCIcdg8zTo8xd+NiwS+gYC5bRm7EXd+/lzgUXS1vO
         ydQurPrXkzNMWOwSb5AFDDB/7Hrw3WkN+uc4jbpL7jSWKvCI63NwIff2TXfg9/I1emlz
         hIRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CQuQmd85Ia5RpOjrEh6LyCYQrdLstz30Cf07TMDdjnM=;
        b=rTGzOMUF3MgZ7HH243ur5SBrs3shB6/rmSykTiYmxqq62xlabECszqUO1CUnRr7Rzv
         vnILaJ3nmv8H+93g/h4PIUG8kP/PordMCaSFr5BLlVg5u3inBcN2CXlCPIQYXeQLkhn7
         3YKZNQTdA8LeaSSCac0KlaJVpGL3DUujgo/NyHCOhDM6iwXZml1dU7xSqB1tooCyfxyy
         LHVlXRWTs0gcxTvp2maVhfeXFHBOAOy35+b4P8D8e/U9wAxWbZcj58/VVZJevhkrsBE+
         nR1k/FblNZBYiUZyNOI2TAMeBNnFgKVqaPxDXQL2cw24jKSgHdlqcWz6wwOQMii1+CCI
         Q1QQ==
X-Gm-Message-State: APjAAAXonVUgY/e5/gZlFu4pc5F1NuTot/PYHUXahjso1vhCMzoG2k+b
        OpWcq6owkZFfBc7zERcPD5w=
X-Google-Smtp-Source: APXvYqz9NxelR6cYGd/bIquEkav8T9DMbDKeUx6KTsMHkh35YBDpLXPNrCIkcBfpUZsilGTzTVN0ow==
X-Received: by 2002:adf:f744:: with SMTP id z4mr11427861wrp.205.1572813228347;
        Sun, 03 Nov 2019 12:33:48 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id x16sm13644026wrp.91.2019.11.03.12.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 12:33:47 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?=27Uwe=20Kleine-K=C3=B6nig=27?= 
        <u.kleine-koenig@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v2 3/7] pwm: sun4i: Add an optional probe for bus clock
Date:   Sun,  3 Nov 2019 21:33:30 +0100
Message-Id: <20191103203334.10539-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191103203334.10539-1-peron.clem@gmail.com>
References: <20191103203334.10539-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index d194b8ebdb00..b5e7ac364f59 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -367,6 +368,31 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	if (IS_ERR(pwm->clk))
 		return PTR_ERR(pwm->clk);
 
+	/* Get all clocks and reset line */
+	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
+	if (IS_ERR(pwm->clk)) {
+		dev_err(&pdev->dev, "get clock failed %ld\n",
+			PTR_ERR(pwm->clk));
+		return PTR_ERR(pwm->clk);
+	}
+
+	/* Fallback for old dtbs with a single clock and no name */
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
+
 	pwm->rst = devm_reset_control_get_optional(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
 		if (PTR_ERR(pwm->rst) == -EPROBE_DEFER)
@@ -381,6 +407,13 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/* Enable bus clock */
+	ret = clk_prepare_enable(pwm->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Cannot prepare_enable bus_clk\n");
+		goto err_bus;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -401,6 +434,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -415,6 +450,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

