Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3063F100341
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 12:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfKRLBL (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 06:01:11 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKRLAp (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 06:00:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so18921862wrw.1;
        Mon, 18 Nov 2019 03:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jsifq8PTX0er46e43pUZkmCyPNqnaTwpRAxn8YySges=;
        b=AxdIa2+7XYravskLqghTUZppTTZptO8qgtCJ8FPixAp6+EU5OJstpE/ZAIfKD8JE/b
         jzg/hdoKslHHCtuW/rCVmM6KvSWifU2sfbvRHsgBkUJDSu4if41mbXAjD5KQidpE1Mvj
         Aa8ccEJos7u0q49ldpl3NK8RMDOJinitwm3d2U+xFQJK+m3bnQZw0vQLkaHs8RKospPy
         UK15nVIlImEynkAN/Ed2fsDxDcwXFoQ7RzN9LB8cQlzkBd8NCSszqCN6pnG8aTLXOInT
         RGTqi5s7R2srOuPNE52k+qro/45QT4GuU3ZUySevKB18V+NdHaR6h8G77hcA7g32sZ5/
         q4jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jsifq8PTX0er46e43pUZkmCyPNqnaTwpRAxn8YySges=;
        b=GrXp3nZR1d87VRdywkIJiJ0tW2V5kJmJ2rKg+/YZZdXsqBuTm3MfoUNx61JmmDudbQ
         zIP1kmKkRytQ85owN4QgrN676Uv0Ja/+aM9kW69Wgk8uSu2NyTYcSvLWhcSXLrbJV5M7
         w3h5YtXgQy2d9MX76oJ+wiuZt4Yyfus2C/4DFjzXTXM9ZHp09kPQjSHCWvs3QgecUrc8
         WwPW3SGqtbrDtBZk8Iv7pBfVTLTwDH90xUB+Eih27o17iAKTQcvxXhncEaippwOCm5MF
         mwcjpTGhBWRKgkpWWock3R7alYwWF7ZHsx8ecqUy0dRC7ITjaQaIMgZhoGTW5kXcWjOb
         iC3Q==
X-Gm-Message-State: APjAAAUzcWElVZ8xCavaC+Us5qmMebCVO5Gj3lfo5H1N7HY9t0V8izN2
        UihUKRFBeJoYNXp0YkerECw=
X-Google-Smtp-Source: APXvYqwUHWq7ibM4Sw/PPC1hM1P4uE5Ho0apvC2XIkz8SHsKzaAKYdlTw3hx8tCnK33bDFYGGvWLcw==
X-Received: by 2002:a05:6000:150:: with SMTP id r16mr28384394wrx.313.1574074842479;
        Mon, 18 Nov 2019 03:00:42 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id f67sm19873313wme.16.2019.11.18.03.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 03:00:42 -0800 (PST)
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
Subject: [PATCH v6 4/8] pwm: sun4i: Add an optional probe for bus clock
Date:   Mon, 18 Nov 2019 12:00:30 +0100
Message-Id: <20191118110034.19444-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118110034.19444-1-peron.clem@gmail.com>
References: <20191118110034.19444-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 6d97fef4ed43..ce83d479ba0e 100644
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
@@ -406,6 +415,16 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	/*
+	 * We're keeping the bus clock on for the sake of simplicity.
+	 * Actually it only needs to be on for hardware register accesses.
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
@@ -426,6 +445,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	return 0;
 
 err_pwm_add:
+	clk_disable_unprepare(pwm->bus_clk);
+err_bus:
 	reset_control_assert(pwm->rst);
 
 	return ret;
@@ -440,6 +461,7 @@ static int sun4i_pwm_remove(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	clk_disable_unprepare(pwm->bus_clk);
 	reset_control_assert(pwm->rst);
 
 	return 0;
-- 
2.20.1

