Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9027F00E5
	for <lists+linux-pwm@lfdr.de>; Sat, 18 Nov 2023 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjKRQRY (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 18 Nov 2023 11:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjKRQRW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 18 Nov 2023 11:17:22 -0500
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F54194;
        Sat, 18 Nov 2023 08:17:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324238; bh=Sc+cZKZYUYODq7Oxpy2O0guVGUacU69a1vla/2Bix6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fNZaVnFAARGjhK5ftm01BKJGNTq9C+Qb8/pRfBZNbhdCiIgexuRdq3S1ko0AcQOBG
         XfET85WQoxGHt7btpCUrRNfPuBRFk2VNkIKiPyH4zmirGTDgnktxVv3VMuPJQwG7mK
         cerwY7xyZVTQbLvOidoQqpfydilm/plOgIk8Uxbwy56TvJfaI4AQieFKZCM6/W5Dvi
         VTVkN8krCB2808/xOTSz1pSLWKoOCyQERf75SLRZavyws5I2f18FnxBAVJpHhZ6ac8
         aNmj99ShiXG2zvYGktcB/pYBkMWX6XrIqj9POk2RyyvYFLSjCX/V04zXfB2TiYJEN4
         5Bod9cuL2Rigw==
Received: by gofer.mess.org (Postfix, from userid 501)
        id 707531002A2; Sat, 18 Nov 2023 16:17:18 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1700324201; bh=Sc+cZKZYUYODq7Oxpy2O0guVGUacU69a1vla/2Bix6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UrXuVYW2qcBRpWmDgFEdK0qSJbBlMcLLTFlIIzGLgijzwdlmYsQ3xxrtp8uYxMPsV
         n6gRzEwUj/2864SR3lK+LN/NrOwfptTZ1JpzKpeuWPctvqbv+UeTHoOyPqS4a96wwh
         thLafx9wOf8R3W9JR0QFOo4fhLmmFbL8/iuSkHqGRAvt+hOZlR1ZWfrFTz7L4lAbDR
         QXw1pi/MnLfivJvfPLjJlvP/8Y4OOQSECyt6GCTIxrx2ADQN7ib36LsPsYO6fMzOvN
         GaTjISnoL0HSHeTeRvau9cG/B2ZTjlLS9ricXtXwWpOLcjq4WZGVixz38DVmt+fwYH
         2BISks382N/5A==
Received: from bigcore.mess.org (bigcore-239.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id 5A301100064;
        Sat, 18 Nov 2023 16:16:41 +0000 (GMT)
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org, linux-pwm@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v5 4/4] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date:   Sat, 18 Nov 2023 16:16:20 +0000
Message-ID: <b49c4e2a8dccbd4a073fb22bab728d1cb2ec159c.1700323916.git.sean@mess.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <cover.1700323916.git.sean@mess.org>
References: <cover.1700323916.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This makes the generated IR much more precise. Before this change, the
driver is unreliable and many users opted to use gpio-ir-tx instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index ccb86890adcea..5465bd38d9412 100644
--- a/drivers/media/rc/pwm-ir-tx.c
+++ b/drivers/media/rc/pwm-ir-tx.c
@@ -10,6 +10,8 @@
 #include <linux/slab.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/hrtimer.h>
+#include <linux/completion.h>
 #include <media/rc-core.h>
 
 #define DRIVER_NAME	"pwm-ir-tx"
@@ -17,8 +19,14 @@
 
 struct pwm_ir {
 	struct pwm_device *pwm;
-	unsigned int carrier;
-	unsigned int duty_cycle;
+	struct hrtimer timer;
+	struct completion tx_done;
+	struct pwm_state *state;
+	u32 carrier;
+	u32 duty_cycle;
+	uint *txbuf;
+	uint txbuf_len;
+	uint txbuf_index;
 };
 
 static const struct of_device_id pwm_ir_of_match[] = {
@@ -82,6 +90,62 @@ static int pwm_ir_tx(struct rc_dev *dev, unsigned int *txbuf,
 	return count;
 }
 
+static int pwm_ir_tx_atomic(struct rc_dev *dev, unsigned int *txbuf,
+			    unsigned int count)
+{
+	struct pwm_ir *pwm_ir = dev->priv;
+	struct pwm_device *pwm = pwm_ir->pwm;
+	struct pwm_state state;
+
+	pwm_init_state(pwm, &state);
+
+	state.period = DIV_ROUND_CLOSEST(NSEC_PER_SEC, pwm_ir->carrier);
+	pwm_set_relative_duty_cycle(&state, pwm_ir->duty_cycle, 100);
+
+	pwm_ir->txbuf = txbuf;
+	pwm_ir->txbuf_len = count;
+	pwm_ir->txbuf_index = 0;
+	pwm_ir->state = &state;
+
+	hrtimer_start(&pwm_ir->timer, 0, HRTIMER_MODE_REL);
+
+	wait_for_completion(&pwm_ir->tx_done);
+
+	return count;
+}
+
+static enum hrtimer_restart pwm_ir_timer(struct hrtimer *timer)
+{
+	struct pwm_ir *pwm_ir = container_of(timer, struct pwm_ir, timer);
+	ktime_t now;
+
+	/*
+	 * If we happen to hit an odd latency spike, loop through the
+	 * pulses until we catch up.
+	 */
+	do {
+		u64 ns;
+
+		pwm_ir->state->enabled = !(pwm_ir->txbuf_index % 2);
+		pwm_apply_atomic(pwm_ir->pwm, pwm_ir->state);
+
+		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
+			complete(&pwm_ir->tx_done);
+
+			return HRTIMER_NORESTART;
+		}
+
+		ns = US_TO_NS(pwm_ir->txbuf[pwm_ir->txbuf_index]);
+		hrtimer_add_expires_ns(timer, ns);
+
+		pwm_ir->txbuf_index++;
+
+		now = timer->base->get_time();
+	} while (hrtimer_get_expires_tv64(timer) < now);
+
+	return HRTIMER_RESTART;
+}
+
 static int pwm_ir_probe(struct platform_device *pdev)
 {
 	struct pwm_ir *pwm_ir;
@@ -103,10 +167,19 @@ static int pwm_ir_probe(struct platform_device *pdev)
 	if (!rcdev)
 		return -ENOMEM;
 
+	if (pwm_is_atomic(pwm_ir->pwm)) {
+		init_completion(&pwm_ir->tx_done);
+		hrtimer_init(&pwm_ir->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		pwm_ir->timer.function = pwm_ir_timer;
+		rcdev->tx_ir = pwm_ir_tx_atomic;
+	} else {
+		dev_info(&pdev->dev, "tx will not be accurate as pwm device does not support atomic mode");
+		rcdev->tx_ir = pwm_ir_tx;
+	}
+
 	rcdev->priv = pwm_ir;
 	rcdev->driver_name = DRIVER_NAME;
 	rcdev->device_name = DEVICE_NAME;
-	rcdev->tx_ir = pwm_ir_tx;
 	rcdev->s_tx_duty_cycle = pwm_ir_set_duty_cycle;
 	rcdev->s_tx_carrier = pwm_ir_set_carrier;
 
-- 
2.42.1

