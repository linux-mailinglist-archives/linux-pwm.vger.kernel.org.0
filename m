Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E97F0108452
	for <lists+linux-pwm@lfdr.de>; Sun, 24 Nov 2019 18:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKXRaH (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 24 Nov 2019 12:30:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35922 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfKXRaH (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 24 Nov 2019 12:30:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id n188so11186978wme.1;
        Sun, 24 Nov 2019 09:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sr+7BNL0b4tCp1MqDsXudPxzWoZbpaPXSrRxNlurcYk=;
        b=UqEa69xKeg3cqB4VbMFljhQGtuxAd10jRTcPE0LGk4j/hSErxDTUllZ/GrJa/FbIXG
         ZVT2g7Iv0pXgaqBE3UOEnoydCDGbMzmteXCcELyEpn+smCmGGRiT2J8/oW/+cacN7VnC
         zTzpErhnp/KBF7MCToR0Zdrk0C1rAOdg9fACXZEh9BFypwjVuXFPEKW/N0ZHME5X4l7n
         eX4kXDzdAA6JeSzhLoWOm3XEEazDC6+/lbCzA1bVcUUYvZ7tGQQ5OdD8lk56bsETe6eY
         YMm00Y9+IuadMtL4FawcIBSBWvHNbHtqgVoCsurLldWkwT4PL6f6QZyOJXhJXcOg/z7d
         HXuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sr+7BNL0b4tCp1MqDsXudPxzWoZbpaPXSrRxNlurcYk=;
        b=U3098q1qXq86hNd4vkWfPAFZzacCWXmjajs1Q0gROmA9XYf67XiXmJbQicC9LhpRfu
         1bC3ls1z3cEj+KsegRdlTzZ349aUY/nnuW61PzKrN4xWY3XEkIZO1MmJC42FGKU5BDEL
         qEWFeG8Ek6Rhx1DXftix+Ku3V2VYZAn0jIAYVJpc3nbpQ7SLhkz6jjttzk1i+qddA2Go
         dOmH7H7cE5A1BoloTxFaLKfKNpc1jv3SroMA/50Ed7br8Ozod8NOCUKvCcUQHWh+EOvi
         YF3FtNryUR8ZnlHxzCXXBChRGrUzb5xHeYYeCHDG+qMjKU1y6rIhcGVEr6qIwdmrxkxQ
         bNQw==
X-Gm-Message-State: APjAAAVYXgnfdci/GY5iQ69p0r7CGKpskpOsjCA0DpTaM8cjAtvySGeD
        2kHAhYo/KlEN7V5r1KwDZUs=
X-Google-Smtp-Source: APXvYqwb7kqkYB4bJbTmfa2R2ggNhznLIfWi1+2SWPBX/8mre7n4Sp7dEOjIC8bHGA4RcFkWR4cteA==
X-Received: by 2002:a7b:c416:: with SMTP id k22mr7117238wmi.10.1574616605112;
        Sun, 24 Nov 2019 09:30:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
        by smtp.gmail.com with ESMTPSA id n13sm5537275wmi.25.2019.11.24.09.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2019 09:30:04 -0800 (PST)
From:   =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Philipp Zabel <pza@pengutronix.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH v9 3/6] pwm: sun4i: Add an optional probe for bus clock
Date:   Sun, 24 Nov 2019 18:29:05 +0100
Message-Id: <20191124172908.10804-4-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191124172908.10804-1-peron.clem@gmail.com>
References: <20191124172908.10804-1-peron.clem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

H6 PWM core needs bus clock to be enabled in order to work.

Add an optional probe for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 drivers/pwm/pwm-sun4i.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 80026167044b..a6727dd89e28 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -78,6 +78,7 @@ struct sun4i_pwm_data {
 
 struct sun4i_pwm_chip {
 	struct pwm_chip chip;
+	struct clk *bus_clk;
 	struct clk *clk;
 	struct reset_control *rst;
 	void __iomem *base;
@@ -391,6 +392,14 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		}
 	}
 
+	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
+	if (IS_ERR(pwm->bus_clk)) {
+		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "get bus clock failed %pe\n",
+				pwm->bus_clk);
+		return PTR_ERR(pwm->bus_clk);
+	}
+
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
 	if (IS_ERR(pwm->rst)) {
 		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
@@ -407,6 +416,17 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * We're keeping the bus clock on for the sake of simplicity.
+	 * Actually it only needs to be on for hardware register accesses.
+	 */
+	ret = clk_prepare_enable(pwm->bus_clk);
+	if (ret) {
+		dev_err(&pdev->dev, "cannot prepare and enable bus_clk %pe\n",
+			ERR_PTR(ret));
+		goto err_bus;
+	}
+
 	pwm->chip.dev = &pdev->dev;
 	pwm->chip.ops = &sun4i_pwm_ops;
 	pwm->chip.base = -1;
@@ -427,6 +447,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -441,6 +463,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

