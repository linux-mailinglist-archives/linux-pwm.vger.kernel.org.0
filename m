Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907B22531D2
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 16:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHZOs0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 10:48:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgHZOsZ (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:25 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A2E2214F1;
        Wed, 26 Aug 2020 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453304;
        bh=vQ5Zu72e2TzwYVaZX1BdryKwmtf97ebh0hkJi39RFDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QL57HJOfx0q3AoZ3G+ZrkuUZvrgY68YohwpgADn3uo8gpl56X0nhjVLon65/xsSLa
         4SBFMzwwKOlRsKt4IzdizknK4jU9wKTVItzUHrTTUkmDzNJz780+GVEM7S1Z4ZBx0S
         tR4WgYBwqR6u6fzWBIUrz974zl8wvUYaH67myEos=
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
Subject: [PATCH 4/6] pwm: sifive: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:45 +0200
Message-Id: <20200826144747.9436-4-krzk@kernel.org>
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
 drivers/pwm/pwm-sifive.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 62de0bb85921..2485fbaaead2 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -254,11 +254,9 @@ static int pwm_sifive_probe(struct platform_device *pdev)
 		return PTR_ERR(ddata->regs);
 
 	ddata->clk = devm_clk_get(dev, NULL);
-	if (IS_ERR(ddata->clk)) {
-		if (PTR_ERR(ddata->clk) != -EPROBE_DEFER)
-			dev_err(dev, "Unable to find controller clock\n");
-		return PTR_ERR(ddata->clk);
-	}
+	if (IS_ERR(ddata->clk))
+		return dev_err_probe(dev, PTR_ERR(ddata->clk),
+				     "Unable to find controller clock\n");
 
 	ret = clk_prepare_enable(ddata->clk);
 	if (ret) {
-- 
2.17.1

