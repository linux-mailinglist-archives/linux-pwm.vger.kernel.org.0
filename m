Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1934E100179
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Nov 2019 10:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbfKRJiJ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Nov 2019 04:38:09 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38720 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726716AbfKRJhr (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 18 Nov 2019 04:37:47 -0500
Received: by mail-wr1-f65.google.com with SMTP id i12so18561894wro.5;
        Mon, 18 Nov 2019 01:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiEB14HdJo07lXE127L0D4zLI4SiB6r7sIlA8IG1R+w=;
        b=P8eEcz0rpMwHCPRfIcNF7thKCA2HcPHqC95B0QFpDk663hyYC/nXYlpRG2l0mANVq8
         vmDXNF3g4M5+cNxIy1taw8q3s9r2d5QAmFcHAjQ7kBNpjqjaUKL7DXIDBUOrLd80TdT2
         C+lAUnZCi5tKfFCNtcrSYboJJDA596WPmEiuF09l1lT5+pCLs2tqAoFfiBjnr9xaEjcp
         8X6hDjMU/t+C/xxdCapOxprOWxjoOK0It7gzOyMEOneDBqTlfCnqFaaCGIeM5OKFPM+M
         GyBstZgzR8aenHjLxpjqmPnubVKgiF1l2f9LaaHUoE+rnucKwLNk2P6tyHyZ+2lPJGdJ
         eEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiEB14HdJo07lXE127L0D4zLI4SiB6r7sIlA8IG1R+w=;
        b=ra87QaueYkqvkH9hFzojfgPi6U49xC53TzflEidViH80lk9Z7F4bBZEBYdIUzQJap6
         L8eg9p7+bFKo3DQn1w1bxac48tsnwPB36uzZJGNJrHtAav6IGPc3pvDYun1Z/QByz2GV
         mheS7Tsas71JKCEfq8DAW9+Iku9RfGEaQfgHn8RrEeVu2yBMbPFrNb/+17omibpqnb9l
         qBMY8K03/uLIUs5LdtQwYhXPfce8z+c0qGmvYCN6HEPmnMm/ECtw/W56lqkuVvNTZ9FM
         Jlk8ejFTI5N4fMqTsyfW981Q9XIfHut2R7bmT1kTtelviWolq33bOffcfemo4Et8mdWd
         2t/w==
X-Gm-Message-State: APjAAAV0SGsBcBl3m1taVv5idL5/mHOw0l+Av7G8AspeOSAp9NGieGhK
        BrGD5yoakTMxfm+082RS+jzBQNvfQJJF0g==
X-Google-Smtp-Source: APXvYqwTngUkIiY9ZbT6/ObAG2RnFts4cd7nnJ9PwnrchZyQajMB6mNe0CMJioRCBqdlAR8I5rEy9g==
X-Received: by 2002:adf:db4b:: with SMTP id f11mr1434099wrj.239.1574069866054;
        Mon, 18 Nov 2019 01:37:46 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id w10sm19006687wmd.26.2019.11.18.01.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Nov 2019 01:37:45 -0800 (PST)
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
Subject: [PATCH v5 4/8] pwm: sun4i: Add an optional probe for bus clock
Date:   Mon, 18 Nov 2019 10:37:23 +0100
Message-Id: <20191118093727.21899-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191118093727.21899-1-peron.clem@gmail.com>
References: <20191118093727.21899-1-peron.clem@gmail.com>
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
 drivers/pwm/pwm-sun4i.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index bbb1ed194c0e..93f4d44e9fa8 100644
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
+			dev_err(&pdev->dev, "get bus_clock failed %pe\n",
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

