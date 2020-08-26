Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE72531D4
	for <lists+linux-pwm@lfdr.de>; Wed, 26 Aug 2020 16:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbgHZOse (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 26 Aug 2020 10:48:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:59892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgHZOsa (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 26 Aug 2020 10:48:30 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 397782078D;
        Wed, 26 Aug 2020 14:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453309;
        bh=r3PPVBNd/192HHhzA+kMklycTSRNcnFogFFpGxYkYNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B2Di67tovHkZYgOUD+e0BVllM0NCV2gCyD2vVmrhWMVcZiBLgcXQCDmpf6uYQuHRm
         PKjL3pSeK8q1bBTzUm5Y6PhxJC19jwSKtwpt3xkKijBOqSOqg8sWT6BIa0DrYRJw/L
         tO0+uOc/BNuq/Pu53ipM/wVeMkpiTclFFOOFYCF4=
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
Subject: [PATCH 5/6] pwm: sprd: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:47:46 +0200
Message-Id: <20200826144747.9436-5-krzk@kernel.org>
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
 drivers/pwm/pwm-sprd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-sprd.c b/drivers/pwm/pwm-sprd.c
index be2394227423..5123d948efd6 100644
--- a/drivers/pwm/pwm-sprd.c
+++ b/drivers/pwm/pwm-sprd.c
@@ -228,11 +228,8 @@ static int sprd_pwm_clk_init(struct sprd_pwm_chip *spc)
 			if (ret == -ENOENT)
 				break;
 
-			if (ret != -EPROBE_DEFER)
-				dev_err(spc->dev,
-					"failed to get channel clocks\n");
-
-			return ret;
+			return dev_err_probe(spc->dev, ret,
+					     "failed to get channel clocks\n");
 		}
 
 		clk_pwm = chn->clks[SPRD_PWM_CHN_OUTPUT_CLK].clk;
-- 
2.17.1

