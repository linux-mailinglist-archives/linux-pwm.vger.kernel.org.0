Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408A9102B14
	for <lists+linux-pwm@lfdr.de>; Tue, 19 Nov 2019 18:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfKSRxa (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 19 Nov 2019 12:53:30 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37772 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbfKSRx3 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 19 Nov 2019 12:53:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id t1so24949087wrv.4;
        Tue, 19 Nov 2019 09:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jsifq8PTX0er46e43pUZkmCyPNqnaTwpRAxn8YySges=;
        b=cBidvaueQsZTh/Frc70oKIqbOXFsI31ZCgK+cvPz7uDUQVgnrF8XXl/ND9nEuJgu7Y
         eOSIlc4pHu2jvj6YIEeg3+4CVutsG5r6Dv+JWjMmDauVIf2l44hRPkf7tzTXIC6/mvyd
         ZD2vZGtnImp5VjL1vI66KiUnPnC/ULh0VmfNSD5vQ7LeN61CBFQxkiIyaRKEvbrihFRB
         pTpBauPOy8hWr3AXRaNINzrHmCEnvUBIh5xi0M9JOboR8IoYrYloNKVjBmAaptZNdUCO
         ORORJsOIGnMOXObKAFQml63ayUqG8j1zjagW+F8qHYN13h9DPYuKgYEAMXU9u6/MnvWn
         DC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jsifq8PTX0er46e43pUZkmCyPNqnaTwpRAxn8YySges=;
        b=AVOioiavEPjj0dnXus94GdlU5RxFgxxu/zcsOjCojfa8D5XVo/IGAqCyGZMEnubA/z
         ZXGJS93L/bENRTWVTvZ1CaI2iT1ZquTfKufYdvvLeLmbMQfXLnBCpeSkymNrOO0ypD1j
         CpXfXATTc7MPhTgw+Y12fDCMQFPZDIniYvQCmY111uksFtU185tYid6qcA8BhfxtxYS3
         AnCI2N4C7V4Bc9HrfIbqmac5ygFm7PFdLmfST4gTAsEbtnlP7dHUtadt5pTesV7n7IMH
         HjG5stWQhyaimzmBVuGZuDYDZLy23A+pSeNlpxGZOo/oJyqY/7MYS05U3gC0pFRASwm/
         S1CA==
X-Gm-Message-State: APjAAAVHXVKFeluOb1mM3NrF1SqpakFeGq3T659EUd/21C9zQBnxlRHa
        B/dIOkmu20AbMXoyN7JPKYM=
X-Google-Smtp-Source: APXvYqxLWxt/WyrFLqrGFY1V0vJ+g8vbDOhRT6OpisfVcWiUoWWKXZb1BiJK06DNDICYviBRXNyOjQ==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr5347849wrq.127.1574186007205;
        Tue, 19 Nov 2019 09:53:27 -0800 (PST)
Received: from clement-Latitude-7490.outsight.local (lputeaux-656-1-11-33.w82-127.abo.wanadoo.fr. [82.127.142.33])
        by smtp.gmail.com with ESMTPSA id l13sm3772618wmh.12.2019.11.19.09.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2019 09:53:26 -0800 (PST)
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
Subject: [PATCH v7 4/8] pwm: sun4i: Add an optional probe for bus clock
Date:   Tue, 19 Nov 2019 18:53:15 +0100
Message-Id: <20191119175319.16561-5-peron.clem@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191119175319.16561-1-peron.clem@gmail.com>
References: <20191119175319.16561-1-peron.clem@gmail.com>
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

