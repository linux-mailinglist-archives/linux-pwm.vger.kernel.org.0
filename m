Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E639C7746A4
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Aug 2023 20:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjHHS7A (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Aug 2023 14:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjHHS6m (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Aug 2023 14:58:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01E0175DDD
        for <linux-pwm@vger.kernel.org>; Tue,  8 Aug 2023 10:19:55 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQN0-0006va-Mh; Tue, 08 Aug 2023 19:19:46 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMz-002246-SV; Tue, 08 Aug 2023 19:19:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qTQMy-00BTBF-Uj; Tue, 08 Aug 2023 19:19:44 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: [PATCH v1 017/101] pwm: dwc: Make use of devm_pwmchip_alloc() function
Date:   Tue,  8 Aug 2023 19:18:07 +0200
Message-Id: <20230808171931.944154-18-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
References: <20230808171931.944154-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3379; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=RLuB426lzOkZcZbW38/VwjDrLpjubQFySqsNGYM0B48=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBk0njDFjXoaS8Sx/5YjOyBK24gmDPaxQqdLhWIo ADVIpUOH5aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZNJ4wwAKCRCPgPtYfRL+ TmPACACzhcR7nudAnljigNcR0py1aByOGGM3N5kkrTJM27fhcy0O/6ASvmFTvzaQx5zOiD9AkHN rTP2UPafFYhHEbgX7kj75zBGYMllFjaH5GWDhOMxc9+tD27tmYVoLhknlNDwJfVxd0hdSDIWRJI G/9Q7sA3fqvhjKS3RrqpIJVmyKNGgHGRve8ZaxdQstTw1OkOzrt1bKkIm4DBlYr9f8Gl2avhtby v4HU6nY47ZgoBMtbnkg1xe1gjN3I+ZzzM2ZSXZ3r8X4RhlWKACadlu4tWeyNDegQBKf7mFOk3cY 6sO4XZ41z+fUc7LDbkjaX/BOc7SnGNs56kjq+w12/uI/BXLr
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This prepares the pwm-dwc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc.c | 43 +++++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/pwm/pwm-dwc.c b/drivers/pwm/pwm-dwc.c
index 53fe00ccd47e..19b9a23d5ee1 100644
--- a/drivers/pwm/pwm-dwc.c
+++ b/drivers/pwm/pwm-dwc.c
@@ -51,11 +51,13 @@ struct dwc_pwm_ctx {
 };
 
 struct dwc_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
-#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+static inline struct dwc_pwm *to_dwc_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_priv(chip);
+}
 
 static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
 {
@@ -197,31 +199,32 @@ static const struct pwm_ops dwc_pwm_ops = {
 	.get_state = dwc_pwm_get_state,
 };
 
-static struct dwc_pwm *dwc_pwm_alloc(struct device *dev)
+static struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 {
-	struct dwc_pwm *dwc;
+	struct pwm_chip *chip;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
+	chip = devm_pwmchip_alloc(dev, DWC_TIMERS_TOTAL, sizeof(struct dwc_pwm));
+	if (!chip)
 		return NULL;
 
-	dwc->chip.dev = dev;
-	dwc->chip.ops = &dwc_pwm_ops;
-	dwc->chip.npwm = DWC_TIMERS_TOTAL;
+	chip->ops = &dwc_pwm_ops;
 
-	dev_set_drvdata(dev, dwc);
-	return dwc;
+	dev_set_drvdata(dev, chip);
+
+	return chip;
 }
 
 static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 {
 	struct device *dev = &pci->dev;
 	struct dwc_pwm *dwc;
+	struct pwm_chip *chip;
 	int ret;
 
-	dwc = dwc_pwm_alloc(dev);
-	if (!dwc)
+	chip = dwc_pwm_alloc(dev);
+	if (!chip)
 		return -ENOMEM;
+	dwc = to_dwc_pwm(chip);
 
 	ret = pcim_enable_device(pci);
 	if (ret) {
@@ -243,7 +246,7 @@ static int dwc_pwm_probe(struct pci_dev *pci, const struct pci_device_id *id)
 		return -ENOMEM;
 	}
 
-	ret = devm_pwmchip_add(dev, &dwc->chip);
+	ret = devm_pwmchip_add(dev, chip);
 	if (ret)
 		return ret;
 
@@ -262,14 +265,14 @@ static void dwc_pwm_remove(struct pci_dev *pci)
 #ifdef CONFIG_PM_SLEEP
 static int dwc_pwm_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-		if (dwc->chip.pwms[i].state.enabled) {
+		if (chip->pwms[i].state.enabled) {
 			dev_err(dev, "PWM %u in use by consumer (%s)\n",
-				i, dwc->chip.pwms[i].label);
+				i, chip->pwms[i].label);
 			return -EBUSY;
 		}
 		dwc->ctx[i].cnt = dwc_pwm_readl(dwc, DWC_TIM_LD_CNT(i));
@@ -282,8 +285,8 @@ static int dwc_pwm_suspend(struct device *dev)
 
 static int dwc_pwm_resume(struct device *dev)
 {
-	struct pci_dev *pdev = container_of(dev, struct pci_dev, dev);
-	struct dwc_pwm *dwc = pci_get_drvdata(pdev);
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct dwc_pwm *dwc = to_dwc_pwm(chip);
 	int i;
 
 	for (i = 0; i < DWC_TIMERS_TOTAL; i++) {
-- 
2.40.1

