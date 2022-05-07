Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6282051E5A7
	for <lists+linux-pwm@lfdr.de>; Sat,  7 May 2022 10:43:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446103AbiEGIrh (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 7 May 2022 04:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353489AbiEGIrg (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 7 May 2022 04:47:36 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAC3F889
        for <linux-pwm@vger.kernel.org>; Sat,  7 May 2022 01:43:50 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnG2W-0003ZA-VT; Sat, 07 May 2022 10:43:49 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnG2W-000rna-UN; Sat, 07 May 2022 10:43:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nnG2U-00885o-Rb; Sat, 07 May 2022 10:43:46 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] pwm: mediatek: Implement .apply() callback
Date:   Sat,  7 May 2022 10:43:37 +0200
Message-Id: <20220507084337.167890-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1612; h=from:subject; bh=1KW6ty6GQ2hPJLt+FmKcTNmj+Zi8+DqoBiVLGQsCtaQ=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBidjE1BE8QaAG8kut8vuwP3pNWJ+MbI0NoKyRVRwrT LZ5Sk6WJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYnYxNQAKCRDB/BR4rcrsCYnLB/ 0XT4bvhgerT8ZpBENu+CGRC0wyQ+GST9QmS1RA5dA1PSPitenhwiNFwL1Rem7vYeIvWjGlHcyZGHPo DGqv9AWug1qGxkwfMxeqvS7xIQSw4GLpchoUPsTyXybkc1cR95A88G0gq6dRRhOBOljAY5sfrRuE0I 2C2BVUUziHMnlSXvk1EsvJydBAstYrb8s2Bh6OOxvDAXaqVCW1CuVCtss5ICgRaz2Vzlt2n+qo/8TS Aoj0U69s/WVdkNCyWb4vVqRBc6nh4unYb8cDzecKToI2/jCZvC4m9yAB6u20XmIFMI9rHq3t8+Zjak xTjBBVwblUZzAx6cY7FUhH5i7rUB/l
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

To eventually get rid of all legacy drivers convert this driver to the
modern world implementing .apply().
This just pushed a variant of pwm_apply_legacy() into the driver that was
slightly simplified because the driver doesn't provide a .set_polarity()
callback.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-mediatek.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
index 568b13a48717..e264bb74fdde 100644
--- a/drivers/pwm/pwm-mediatek.c
+++ b/drivers/pwm/pwm-mediatek.c
@@ -198,10 +198,33 @@ static void pwm_mediatek_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	pwm_mediatek_clk_disable(chip, pwm);
 }
 
+static int pwm_mediatek_apply(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const struct pwm_state *state)
+{
+	int err;
+
+	if (state->polarity != PWM_POLARITY_NORMAL)
+		return -EINVAL;
+
+	if (!state->enabled) {
+		if (pwm->state.enabled)
+			pwm_mediatek_disable(chip, pwm);
+
+		return 0;
+	}
+
+	err = pwm_mediatek_config(pwm->chip, pwm, state->duty_cycle, state->period);
+	if (err)
+		return err;
+
+	if (!pwm->state.enabled)
+		err = pwm_mediatek_enable(chip, pwm);
+
+	return err;
+}
+
 static const struct pwm_ops pwm_mediatek_ops = {
-	.config = pwm_mediatek_config,
-	.enable = pwm_mediatek_enable,
-	.disable = pwm_mediatek_disable,
+	.apply = pwm_mediatek_apply,
 	.owner = THIS_MODULE,
 };
 

base-commit: 2bf8ee0faa988b5cec3503ebf2f970a0e84d24ee
-- 
2.35.1

