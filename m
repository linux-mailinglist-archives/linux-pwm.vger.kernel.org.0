Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC0D2E1F3B
	for <lists+linux-pwm@lfdr.de>; Wed, 23 Dec 2020 17:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729266AbgLWQE2 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 23 Dec 2020 11:04:28 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:49874 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbgLWQE1 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 23 Dec 2020 11:04:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 07F5DC0CFF;
        Wed, 23 Dec 2020 16:03:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ry7oTjkAQf7Z; Wed, 23 Dec 2020 16:03:45 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 4C34FC0CAA;
        Wed, 23 Dec 2020 16:03:23 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, robin.murphy@arm.com,
        lee.jones@linaro.org, heiko@sntech.de, bbrezillon@kernel.org,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v3 6/7] pwm: rockchip: Enable PWM clock of probed device only if running
Date:   Wed, 23 Dec 2020 11:01:08 -0500
Message-Id: <cb5a28d5fde04c09e9aace6ce619e445f895e0a8.1608735481.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608735481.git.simon@simonsouth.net>
References: <cover.1608735481.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently rockchip_pwm_probe() enables the PWM clock of every device it
matches, then disables the clock unless the device itself appears to have
been enabled (by a bootloader, presumably) before the kernel started.

Simplify this by enabling (rather, keeping enabled) the PWM clock of only
devices that are already running, as enabling the clock for any other
device during probing is unnecessary.

Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index 80f5e69d9b8a..02da7370db70 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -327,12 +327,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
-		return ret;
-	}
-
 	ret = clk_prepare_enable(pc->pclk);
 	if (ret) {
 		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
@@ -357,8 +351,19 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = ((ctrl & enable_conf) == enable_conf);
-	if (!enabled)
-		clk_disable(pc->clk);
+	if (enabled) {
+		ret = clk_prepare_enable(pc->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't enable PWM clk: %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = clk_prepare(pc->clk);
+		if (ret) {
+			dev_err(&pdev->dev, "Can't prepare PWM clk: %d\n", ret);
+			return ret;
+		}
+	}
 
 	clk_disable(pc->pclk);
 
-- 
2.29.2

