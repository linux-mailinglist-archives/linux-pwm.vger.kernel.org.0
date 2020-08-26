Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC8202531D7
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 16:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHZOsh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 10:48:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:60112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727817AbgHZOsf (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:35 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6185722BEF;
        Wed, 26 Aug 2020 14:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453315;
        bh=35hMooZ97OwQTX5jjyj8bENeQbr8kEyo4eXDZLy1lwI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x3kYit/gvf86y+JFUux3GqCO99SWjnPVlhnZf6IpzDlQZzoEcVsp3YTpc3MDCtbXo
         oX6eqODelTnXDj3Ju15PdNXcmcEmS0I5a/glLHAAewv0P+Fi0X593uhmfE342tf03u
         6a1hXYC4ZXLX0yWlT+D4jUbMz7zmLQgVr2KvbukQ=
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
Subject: [PATCH 6/6] pwm: sun4i: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:47 +0200
Message-Id: <20200826144747.9436-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826144747.9436-1-krzk@kernel.org>
References: <20200826144747.9436-1-krzk@kernel.org>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pwm/pwm-sun4i.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 961c59c99bb3..38a4c5c1317b 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -423,38 +423,26 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
 	 * back to the first clock of the PWM.
 	 */
 	pwm->clk = devm_clk_get_optional(&pdev->dev, "mod");
-	if (IS_ERR(pwm->clk)) {
-		if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "get mod clock failed %pe\n",
-				pwm->clk);
-		return PTR_ERR(pwm->clk);
-	}
+	if (IS_ERR(pwm->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
+				     "get mod clock failed\n");
 
 	if (!pwm->clk) {
 		pwm->clk = devm_clk_get(&pdev->dev, NULL);
-		if (IS_ERR(pwm->clk)) {
-			if (PTR_ERR(pwm->clk) != -EPROBE_DEFER)
-				dev_err(&pdev->dev, "get unnamed clock failed %pe\n",
-					pwm->clk);
-			return PTR_ERR(pwm->clk);
-		}
+		if (IS_ERR(pwm->clk))
+			return dev_err_probe(&pdev->dev, PTR_ERR(pwm->clk),
+					     "get unnamed clock failed\n");
 	}
 
 	pwm->bus_clk = devm_clk_get_optional(&pdev->dev, "bus");
-	if (IS_ERR(pwm->bus_clk)) {
-		if (PTR_ERR(pwm->bus_clk) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "get bus clock failed %pe\n",
-				pwm->bus_clk);
-		return PTR_ERR(pwm->bus_clk);
-	}
+	if (IS_ERR(pwm->bus_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->bus_clk),
+				     "get bus clock failed\n");
 
 	pwm->rst = devm_reset_control_get_optional_shared(&pdev->dev, NULL);
-	if (IS_ERR(pwm->rst)) {
-		if (PTR_ERR(pwm->rst) != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "get reset failed %pe\n",
-				pwm->rst);
-		return PTR_ERR(pwm->rst);
-	}
+	if (IS_ERR(pwm->rst))
+		return dev_err_probe(&pdev->dev, PTR_ERR(pwm->rst),
+				     "get reset failed\n");
 
 	/* Deassert reset */
 	ret = reset_control_deassert(pwm->rst);
-- 
2.17.1

