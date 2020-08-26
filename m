Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAEE2531CC
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHZOsK (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 10:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:59090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726843AbgHZOsJ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:09 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C1FD2078D;
        Wed, 26 Aug 2020 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453288;
        bh=xX8No7Dlt35uVRtG106IwB/R7I/5/jIBaMyqJ0vQmGI=;
        h=From:To:Cc:Subject:Date:From;
        b=byy3D3tns5AIyEhsP6N685UlNNM4Np1NcLWi4Kz3mfpU6GO11lchcfMMXlnWKaiEs
         9caKQ8wIDDAcf43Mj3+RXx/5EJ6cBZLWsieGF3Al7nYik1drYyc5TpkijjP8D8HLN7
         nVoWPi3D5m0rCkAw+iNI6rwMXuzClgI+P/AaTTVc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-pwm@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/6] pwm: bcm2835: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:42 +0200
Message-Id: <20200826144747.9436-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-bcm2835.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pwm/pwm-bcm2835.c b/drivers/pwm/pwm-bcm2835.c
index d78f86f8e462..6841dcfe27fc 100644
--- a/drivers/pwm/pwm-bcm2835.c
+++ b/drivers/pwm/pwm-bcm2835.c
@@ -152,13 +152,9 @@ static int bcm2835_pwm_probe(struct platform_device *pdev)
 		return PTR_ERR(pc->base);
 
 	pc->clk = devm_clk_get(&pdev->dev, NULL);
-	if (IS_ERR(pc->clk)) {
-		ret = PTR_ERR(pc->clk);
-		if (ret != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "clock not found: %d\n", ret);
-
-		return ret;
-	}
+	if (IS_ERR(pc->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk),
+				     "clock not found\n");
 
 	ret = clk_prepare_enable(pc->clk);
 	if (ret)
-- 
2.17.1

