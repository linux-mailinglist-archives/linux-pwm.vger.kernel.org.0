Return-Path: <linux-pwm+bounces-228-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0737A7FD1EC
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1B6282D13
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605F12E64;
	Wed, 29 Nov 2023 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="sFslIrDj";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="R8A9Ztle"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0421BCC;
	Wed, 29 Nov 2023 01:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249248; bh=86qGc+C1bzoMBqXYz1VUZShwwdjBHm4PTYqZtPorDr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFslIrDjvfJCb4xq3/T4HaSHgI9t55wNoziJAJYqxoR3/Hni0b4JfVemz/pNgInLZ
	 V+ET98QqCmaJmgBqFnH+kuwYQBQafRArAGDWP4e4UHhrg9ULfyiiuPfQRoDsxVEwhr
	 Cyo9Hzz+raiwciBrgZlNQ3pTaNPHDk5CzKXyNhfFKpAEt6vHlMm05648ktSLor4Dzr
	 G72+xtM8RiGvRS1hqwWEkAuVDEq4dQCg5DtQcDEKbw3mY6V0mQ3Wmt6wgYJNIzFrbd
	 0idxXbyyWErrPaNSy/xgst9cudrs39V/G3rd4br09/wzz969pjy05TqSco6siI6xMn
	 gFbvemiaicF7Q==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 2666F100101; Wed, 29 Nov 2023 09:14:08 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1701249229; bh=86qGc+C1bzoMBqXYz1VUZShwwdjBHm4PTYqZtPorDr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R8A9ZtleLSz6m0a+Q7czGK5fLN87caTL/IXjRTkhfUMhdFa2IHcFcp3bZLf8SibVn
	 +po2ohdU7NHZjN6wIgbWn0gjy388oRYlZKQonlG9d4T8wcwIC32i2WlHXHEoZTW5Wi
	 pHk1tWk2AZwzdnV/MziLXAKskciCQPT010oQVgJ3nlJab6RQTHwl3UuDmE3gAtqvoX
	 mXpgKjX+ypGABaLMRO/0atPtiXe2EXj1ZTvR2SJeLTKKCZXe6E9ZBx+Jrkd6UEXUwD
	 C1sBdy9zY2uanEBfLcTVLWCaxm0DiBZjaqQ/YMwe6SjkVR3AaTsmCUOA/iKm2f8Ezs
	 TT81Agosi5kdQ==
Received: from localhost.localdomain (bigcore-99.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id 82A96100104;
	Wed, 29 Nov 2023 09:13:49 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v6 4/4] media: pwm-ir-tx: trigger edges from hrtimer interrupt context
Date: Wed, 29 Nov 2023 09:13:37 +0000
Message-ID: <88fdb3a200989458c6f95c26fa9bb84c1e864798.1701248996.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1701248996.git.sean@mess.org>
References: <cover.1701248996.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This makes the generated IR much more precise. Before this change, the
driver is unreliable and many users opted to use gpio-ir-tx instead.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/pwm-ir-tx.c | 79 ++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/media/rc/pwm-ir-tx.c b/drivers/media/rc/pwm-ir-tx.c
index cf51e2760975..8575c4596d7b 100644
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
2.43.0


