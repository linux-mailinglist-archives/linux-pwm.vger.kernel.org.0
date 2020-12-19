Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872D52DF198
	for <lists+linux-pwm@lfdr.de>; Sat, 19 Dec 2020 21:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbgLSUpz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 19 Dec 2020 15:45:55 -0500
Received: from mailout.easymail.ca ([64.68.200.34]:39970 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgLSUpz (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 19 Dec 2020 15:45:55 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 45F2BBFD50;
        Sat, 19 Dec 2020 20:45:14 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo04-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo04-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wmJsXWBXQu9v; Sat, 19 Dec 2020 20:45:14 +0000 (UTC)
Received: from localhost.localdomain (unknown [108.162.141.195])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id 55123BFBC9;
        Sat, 19 Dec 2020 20:44:59 +0000 (UTC)
From:   Simon South <simon@simonsouth.net>
To:     tpiepho@gmail.com, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        heiko@sntech.de, bbrezillon@kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Cc:     simon@simonsouth.net
Subject: [PATCH v2 3/3] pwm: rockchip: Do not start PWMs not already running
Date:   Sat, 19 Dec 2020 15:44:10 -0500
Message-Id: <0acdf3a78f670a2678e03b0bbbb01aa58a11ce9a.1608407584.git.simon@simonsouth.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608407584.git.simon@simonsouth.net>
References: <cover.1608407584.git.simon@simonsouth.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Currently the Rockchip PWM driver enables the signal ("bus") clock for
every PWM device it finds during probing, then disables it for any device
that was not already enabled (such as by a bootloader) when the kernel
started.

Instead of starting PWMs unnecessarily, check first to see whether a device
has already been enabled and if not, do not enable its signal clock.

Signed-off-by: Simon South <simon@simonsouth.net>
---
 drivers/pwm/pwm-rockchip.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
index f286a498b82c..b9faef3e9954 100644
--- a/drivers/pwm/pwm-rockchip.c
+++ b/drivers/pwm/pwm-rockchip.c
@@ -327,19 +327,6 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = clk_prepare_enable(pc->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't prepare enable bus clk: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(pc->pclk);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
-		clk_disable_unprepare(pc->clk);
-		return ret;
-	}
-
 	platform_set_drvdata(pdev, pc);
 
 	pc->data = id->data;
@@ -353,12 +340,23 @@ static int rockchip_pwm_probe(struct platform_device *pdev)
 		pc->chip.of_pwm_n_cells = 3;
 	}
 
+	ret = clk_prepare_enable(pc->pclk);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't enable APB clk: %d\n", ret);
+		return ret;
+	}
+
 	/* Keep the PWM clk enabled if the PWM appears to be up and running. */
 	enable_conf = pc->data->enable_conf;
 	ctrl = readl_relaxed(pc->base + pc->data->regs.ctrl);
 	enabled = ((ctrl & enable_conf) == enable_conf);
-	if (!enabled)
-		clk_disable(pc->clk);
+
+	ret = enabled ? clk_prepare_enable(pc->clk) : clk_prepare(pc->clk);
+	if (ret) {
+		dev_err(&pdev->dev, "Can't prepare bus clk: %d\n", ret);
+		clk_disable_unprepare(pc->pclk);
+		return ret;
+	}
 
 	clk_disable(pc->pclk);
 
-- 
2.29.2

