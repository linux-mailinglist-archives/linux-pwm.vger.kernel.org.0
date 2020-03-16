Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67F72186922
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2020 11:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbgCPKcU (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Mar 2020 06:32:20 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:60210 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730607AbgCPKcU (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Mar 2020 06:32:20 -0400
Received: from ramsan ([84.195.182.253])
        by xavier.telenet-ops.be with bizsmtp
        id EyYH2200D5USYZQ01yYH4h; Mon, 16 Mar 2020 11:32:17 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0006Ej-5L; Mon, 16 Mar 2020 11:32:17 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jDn2f-0007ep-3V; Mon, 16 Mar 2020 11:32:17 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc:     linux-pwm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/3] pwm: rcar: Fix late Runtime PM enablement
Date:   Mon, 16 Mar 2020 11:32:14 +0100
Message-Id: <20200316103216.29383-2-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316103216.29383-1-geert+renesas@glider.be>
References: <20200316103216.29383-1-geert+renesas@glider.be>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Runtime PM should be enabled before calling pwmchip_add(), as PWM users
can appear immediately after the PWM chip has been added.
Likewise, Runtime PM should be disabled after the removal of the PWM
chip.

Fixes: ed6c1476bf7f16d5 ("pwm: Add support for R-Car PWM Timer")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pwm/pwm-rcar.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 2685577b6dd45be7..7ab9eb6616d950cb 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -229,24 +229,28 @@ static int rcar_pwm_probe(struct platform_device *pdev)
 	rcar_pwm->chip.base = -1;
 	rcar_pwm->chip.npwm = 1;
 
+	pm_runtime_enable(&pdev->dev);
+
 	ret = pwmchip_add(&rcar_pwm->chip);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", ret);
+		pm_runtime_disable(&pdev->dev);
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-
 	return 0;
 }
 
 static int rcar_pwm_remove(struct platform_device *pdev)
 {
 	struct rcar_pwm_chip *rcar_pwm = platform_get_drvdata(pdev);
+	int ret;
+
+	ret = pwmchip_remove(&rcar_pwm->chip);
 
 	pm_runtime_disable(&pdev->dev);
 
-	return pwmchip_remove(&rcar_pwm->chip);
+	return ret;
 }
 
 static const struct of_device_id rcar_pwm_of_table[] = {
-- 
2.17.1

