Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18D0B4B4403
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Feb 2022 09:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiBNIYM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 14 Feb 2022 03:24:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbiBNIYK (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 14 Feb 2022 03:24:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326F225C4A
        for <linux-pwm@vger.kernel.org>; Mon, 14 Feb 2022 00:24:03 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeO-0007jy-Da; Mon, 14 Feb 2022 09:24:00 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeN-00GVbZ-Al; Mon, 14 Feb 2022 09:23:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJWeL-002szU-RM; Mon, 14 Feb 2022 09:23:57 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: brcmstb: Remove useless locking
Date:   Mon, 14 Feb 2022 09:23:54 +0100
Message-Id: <20220214082354.295451-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
References: <20220214082354.295451-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2096; h=from:subject; bh=9e9X/ZgWkLK7WwJIknJxvnOaJ1EGWaD9VMR1/QBP288=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBiChGWiobZXxfhx0UVMWdZAS/EQa7xjfNuLKwYy81D lBzSp/WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYgoRlgAKCRDB/BR4rcrsCdhbB/ 9utfiU1VSLd3NcX3qAIHVMtkcfq0SehAgPnRnBPZ4mFvp+ea/9h59G6IYVHbPOOyH7uOEYsvxW/jG+ J0h5iT5URGWFJ16ugPtISGlokcIyjFmfYxriREiFG9iye/cirg9GnsdO3EhTYcCJakEOtATtNdJHfP 2v2VSM17SK3wsZklowiGvm7txo5NLYqu1YS6oIu10CrAqL+cVEYEeVk0v45Miu8CN6ItoEZ6uRpAJg 9+2ztN+p3LkvxrU1H/sn2las4V5sVivI5M93SmMablx/uEDs0cZAuGC9NYOQqkqbNH/CgRMK9Oltqu Sfav8rZ/VcgLpu9mGaGQYKW4Ag7ODw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The lock only protects against concurrent users of the PWM API. This is not
expected to be necessary. And if there was such an issue, this is better
handled in the pwm core instead as it affects all drivers in the same way.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-brcmstb.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 99974390aa38..3db3f96edf78 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -53,7 +53,6 @@
 
 struct brcmstb_pwm {
 	void __iomem *base;
-	spinlock_t lock;
 	struct clk *clk;
 	struct pwm_chip chip;
 };
@@ -159,7 +158,6 @@ static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * generator output a base frequency for the constant frequency
 	 * generator to derive from.
 	 */
-	spin_lock(&p->lock);
 	brcmstb_pwm_writel(p, cword >> 8, PWM_CWORD_MSB(channel));
 	brcmstb_pwm_writel(p, cword & 0xff, PWM_CWORD_LSB(channel));
 
@@ -171,7 +169,6 @@ static int brcmstb_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* Configure on and period value */
 	brcmstb_pwm_writel(p, pc, PWM_PERIOD(channel));
 	brcmstb_pwm_writel(p, dc, PWM_ON(channel));
-	spin_unlock(&p->lock);
 
 	return 0;
 }
@@ -182,7 +179,6 @@ static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm *p,
 	unsigned int shift = channel * CTRL_CHAN_OFFS;
 	u32 value;
 
-	spin_lock(&p->lock);
 	value = brcmstb_pwm_readl(p, PWM_CTRL);
 
 	if (enable) {
@@ -194,7 +190,6 @@ static inline void brcmstb_pwm_enable_set(struct brcmstb_pwm *p,
 	}
 
 	brcmstb_pwm_writel(p, value, PWM_CTRL);
-	spin_unlock(&p->lock);
 }
 
 static int brcmstb_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -243,8 +238,6 @@ static int brcmstb_pwm_probe(struct platform_device *pdev)
 	if (!p)
 		return -ENOMEM;
 
-	spin_lock_init(&p->lock);
-
 	p->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(p->clk)) {
 		dev_err(&pdev->dev, "failed to obtain clock\n");
-- 
2.34.1

