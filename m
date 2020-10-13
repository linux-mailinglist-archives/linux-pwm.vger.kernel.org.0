Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DD728CA1E
	for <lists+linux-pwm@lfdr.de>; Tue, 13 Oct 2020 10:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391338AbgJMIV0 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 13 Oct 2020 04:21:26 -0400
Received: from antares.kleine-koenig.org ([94.130.110.236]:48232 "EHLO
        antares.kleine-koenig.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390681AbgJMIV0 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 13 Oct 2020 04:21:26 -0400
X-Greylist: delayed 350 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Oct 2020 04:21:26 EDT
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 4E610A52BC0; Tue, 13 Oct 2020 10:15:35 +0200 (CEST)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Ajit Pal Singh <ajitpal.singh@st.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        linux-pwm@vger.kernel.org
Subject: [PATCH] pwm: sti: fix error handling
Date:   Tue, 13 Oct 2020 10:15:31 +0200
Message-Id: <20201013081531.661528-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This commit fixes several faults:

 - Iff a clk was returned by of_clk_get_by_name() it must be dereferenced
   by calling clk_put().
 - A clk that was prepared must be unprepared.
 - The .remove callback isn't supposed to call pwm_disable().
 - The necessary resources needed by the PWM must not be freed before
   pwmchip_remove() was called.

Fixes: 378fe115d19d ("pwm: sti: Add new driver for ST's PWM IP")
Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
 drivers/pwm/pwm-sti.c | 49 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 1508616d794c..f89f8cbdfdfc 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -605,7 +605,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	ret = clk_prepare(pc->pwm_clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		goto err_pwm_clk_prepare;
 	}
 
 skip_pwm:
@@ -615,13 +615,14 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
 	if (IS_ERR(pc->cpt_clk)) {
 		dev_err(dev, "failed to get PWM capture clock\n");
-		return PTR_ERR(pc->cpt_clk);
+		ret = PTR_ERR(pc->cpt_clk);
+		goto err_cpt_clk_get;
 	}
 
 	ret = clk_prepare(pc->cpt_clk);
 	if (ret) {
 		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		goto err_cpt_clk_prepare;
 	}
 
 skip_cpt:
@@ -632,9 +633,7 @@ static int sti_pwm_probe(struct platform_device *pdev)
 
 	ret = pwmchip_add(&pc->chip);
 	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
+		goto err_pwmchip_add;
 	}
 
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
@@ -653,20 +652,46 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, pc);
 
 	return 0;
+
+err_pwmchip_add:
+
+	if (cdata->cpt_num_devs) {
+		clk_unprepare(pc->cpt_clk);
+err_cpt_clk_prepare:
+
+		clk_put(pc->cpt_clk);
+	}
+err_cpt_clk_get:
+
+	if (cdata->pwm_num_devs) {
+		clk_unprepare(pc->pwm_clk);
+err_pwm_clk_prepare:
+
+		clk_put(pc->pwm_clk);
+	}
+	return ret;
 }
 
 static int sti_pwm_remove(struct platform_device *pdev)
 {
 	struct sti_pwm_chip *pc = platform_get_drvdata(pdev);
-	unsigned int i;
+	int ret;
+
+	ret = pwmchip_remove(&pc->chip);
+	if (ret)
+		return ret;
 
-	for (i = 0; i < pc->cdata->pwm_num_devs; i++)
-		pwm_disable(&pc->chip.pwms[i]);
+	if (pc->cdata->cpt_num_devs) {
+		clk_unprepare(pc->cpt_clk);
+		clk_put(pc->cpt_clk);
+	}
 
-	clk_unprepare(pc->pwm_clk);
-	clk_unprepare(pc->cpt_clk);
+	if (pc->cdata->pwm_num_devs) {
+		clk_unprepare(pc->pwm_clk);
+		clk_put(pc->pwm_clk);
+	}
 
-	return pwmchip_remove(&pc->chip);
+	return 0;
 }
 
 static const struct of_device_id sti_pwm_of_match[] = {
-- 
2.28.0

