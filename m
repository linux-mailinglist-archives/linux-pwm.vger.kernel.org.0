Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907C57C8395
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Oct 2023 12:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjJMKrc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 13 Oct 2023 06:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjJMKrb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 13 Oct 2023 06:47:31 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A04BD;
        Fri, 13 Oct 2023 03:47:27 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 501)
        id 584D3100100; Fri, 13 Oct 2023 11:47:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194046; bh=cqss2B5a2PjBlYIFpZklT248DB07ue+qVmrQyspsCUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RvRMgrHry4Y4LsVtp+ipnOWb2RkoXZwoiG2nBMj/4fZcIrx8VpNcNPEbPJdu9QdDK
         HBtoMCBLpztJj/duGUzwtsbgn3Cw8fzv7TbRQLCEh+hxm5maMQ4ohhp5pZ12TWncJC
         iA2tRBiZZa97ICIQ4YpYevEdu3DlHDl2ntvSv0oabUgk+nL9T7mJ3X37UoZ9Otx3db
         jqqBvwEJO7zLRfGFUq9id2ANDx+zOnqvUXQJCR1ekjPbTK6CpS6LHl1kcCuYKTv54Z
         3hvTpdlB5Q39NiWloL2SzaMHyALZqCNv9oHPlgpff/39H8wAm2vL5wTLs+F8pp9jas
         4gdC/bIB+u2nw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from bigcore.mess.org (unknown [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gofer.mess.org (Postfix) with ESMTPSA id D9EB110005E;
        Fri, 13 Oct 2023 11:47:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1697194043; bh=cqss2B5a2PjBlYIFpZklT248DB07ue+qVmrQyspsCUw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFxSQUoWKERA0Q7iR+gRw2j3QTmV/tVah/f8SBfftpjazSqU9PvyGo3EnLFiLJGlp
         ovjQ8k9qtv7AOQmI1zRHOT90S5hQNtsdRtoi/rqh5xd5S7Mo4I8bxN75d951rKeEnj
         g35mNJNLne5f1GZKpzUEfiiRRJUrz31e+P6Gqh4iZPNtdenIM+qSMMCv3rIZl8hIhA
         V5vD7w6ZprQJvShkthxIt/NmMQ+sEWCl9ydPYa7aA1tuufRnJDooYcogWfWZ8iBCDN
         TIkWqnePt0EOtqHY37VcDQ3cPcnkB2NsQJlsQQmJ5jcfbYSOGpIKCSox5qpWo/ZwIa
         QVrJzRYkAAbQQ==
From:   Sean Young <sean@mess.org>
To:     linux-media@vger.kernel.org,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        Sean Young <sean@mess.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: [PATCH v2 3/3] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date:   Fri, 13 Oct 2023 11:46:16 +0100
Message-ID: <1560b474f7d426bc77100665c14c3a29c3af3e75.1697193646.git.sean@mess.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697193646.git.sean@mess.org>
References: <cover.1697193646.git.sean@mess.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This makes the driver much more precise.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index c5f37c03af9c..3e801fa8ee2c 100644
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
+	struct completion completion;
+	struct pwm_state *state;
+	uint carrier;
+	uint duty_cycle;
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
+	wait_for_completion(&pwm_ir->completion);
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
+		pwm_apply_state_atomic(pwm_ir->pwm, pwm_ir->state);
+
+		if (pwm_ir->txbuf_index >= pwm_ir->txbuf_len) {
+			complete(&pwm_ir->completion);
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
+		init_completion(&pwm_ir->completion);
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
2.42.0

