Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B673957C904
	for <lists+linux-pwm@lfdr.de>; Thu, 21 Jul 2022 12:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbiGUKbp (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 21 Jul 2022 06:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbiGUKbm (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 21 Jul 2022 06:31:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD067392B
        for <linux-pwm@vger.kernel.org>; Thu, 21 Jul 2022 03:31:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSz-0002W0-QW; Thu, 21 Jul 2022 12:31:38 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSy-002IMq-Rm; Thu, 21 Jul 2022 12:31:36 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oETSx-006ZIP-Od; Thu, 21 Jul 2022 12:31:35 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, kernel@pengutronix.de,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        "Wesley W. Terpstra" <wesley@sifive.com>
Subject: [PATCH 4/7] pwm: sifive: Enable clk only after period check in .apply()
Date:   Thu, 21 Jul 2022 12:31:26 +0200
Message-Id: <20220721103129.304697-4-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
References: <20220721103129.304697-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1762; h=from:subject; bh=c0fLWKgziDkgWoI6+H8lb5WHbrXxOiw4wARKI8YtL8w=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBi2Sr1Zw4qH9xQt0jcTvyTAVVW8eBROsYO15Sy4QQA WoS5sU2JATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYtkq9QAKCRDB/BR4rcrsCRvCB/ 9frF0VhcjV6YFcVmo+uGdJ5lcNa5Z7TmrJDlamHndttyGzLZ+3xD5JrHqwsCmGwYnxL+Z5qP1BWD3a cASV0TRseaXW0A+SbyGVyMOhZXGTpArSCUO1jCqoWcDsb+kavyPZJresq507ZPqpBQANP5X5sWG2Y/ 9l37G0coHGDTAN8NzI+qDZcynQVZcKIe+K+rhQ3ssLxVtFCiQPjUiuvslDNc1/wXyucXdeKgep9Azr f9ksZ+YmZYHN5pkJ+1ftn8gD7PuFLqqjy2rZUOd5U9fs2c5SAxtREuFlE7k5Xz4mXh40vYmNQlU7O1 wfq+fXcovK5KMepW7TroZ9ixWEnv2W
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

For the period check and the initial calculations of register values there
is no hardware access needed. So delay enabling the clk a bit to simplify
the code flow a bit.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sifive.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
index 6017e311a879..d833536b5e7a 100644
--- a/drivers/pwm/pwm-sifive.c
+++ b/drivers/pwm/pwm-sifive.c
@@ -139,12 +139,6 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->polarity != PWM_POLARITY_INVERSED)
 		return -EINVAL;
 
-	ret = clk_enable(ddata->clk);
-	if (ret) {
-		dev_err(ddata->chip.dev, "Enable clk failed\n");
-		return ret;
-	}
-
 	cur_state = pwm->state;
 	enabled = cur_state.enabled;
 
@@ -167,14 +161,19 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period != ddata->approx_period) {
 		if (ddata->user_count != 1) {
 			mutex_unlock(&ddata->lock);
-			ret = -EBUSY;
-			goto exit;
+			return -EBUSY;
 		}
 		ddata->approx_period = state->period;
 		pwm_sifive_update_clock(ddata, clk_get_rate(ddata->clk));
 	}
 	mutex_unlock(&ddata->lock);
 
+	ret = clk_enable(ddata->clk);
+	if (ret) {
+		dev_err(ddata->chip.dev, "Enable clk failed\n");
+		return ret;
+	}
+
 	writel(frac, ddata->regs + PWM_SIFIVE_PWMCMP(pwm->hwpwm));
 
 	if (state->enabled != enabled) {
@@ -186,9 +185,8 @@ static int pwm_sifive_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 		}
 	}
 
-exit:
 	clk_disable(ddata->clk);
-	return ret;
+	return 0;
 }
 
 static const struct pwm_ops pwm_sifive_ops = {
-- 
2.36.1

