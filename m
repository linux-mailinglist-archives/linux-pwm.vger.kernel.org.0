Return-Path: <linux-pwm+bounces-393-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E13806EBF
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33691F2141A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EEC134553;
	Wed,  6 Dec 2023 11:49:01 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2F10EA
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:44 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOQ-0007kW-0u; Wed, 06 Dec 2023 12:48:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOO-00DwyK-5i; Wed, 06 Dec 2023 12:48:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqON-00FR3m-Sy; Wed, 06 Dec 2023 12:48:39 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 110/115] pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
Date: Wed,  6 Dec 2023 12:45:04 +0100
Message-ID:  <f48be8543c88c6be1a5f1d9688f86740f015bd56.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=yDRreQDQUU+KtmrrCIKUIGZ2bM8UFgu7Qnw6ULU5ZVk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF9fUTJ4q2XvS+FhufaWgUhH/+utk5YHnl7Du yJ+mN79hGqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBfXwAKCRCPgPtYfRL+ TjV0B/9V7IcwoHoF28Gq/P4o9YxRGPWJs0yHfO9wnWPwa/aTPHg7SEjPOmjobKVBwePJPOBKUu6 fFDWNiKqr2J3mHRyH4zyMTGcLA90sNcDAa+9/TvpOtNuAY/EMYDI9JEhggTmO1BAqY681/0QMEE dWYJ4RgynkCyyqYt+cyi6c3Zx42Nug8S167Zv8E9yLxSrjpc9C7NldGL66O2Lc0E5TFdfMtv1cm 1PnFnrVGMk1TaiN+9k7e8j151j1Qsi9DlAhLeW3dWzOeP9vhwXynhyFV6X9mo+1B10IIecsvTUx CugeCjKldWvYtyumcyjxK1NtExMa6SaBiae70coT8gp8Z7JV
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Memory holding a struct device must not be freed before the reference
count drops to zero. So a struct pwm_chip must not live in memory
freed by a driver on unbind. All in-tree drivers were fixed accordingly,
but as out-of-tree drivers, that were not adapted, still compile fine,
catch these in pwmchip_add().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 10 ++++++++++
 include/linux/pwm.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index fda72963016b..ce6f4b397468 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -216,6 +216,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	chip->dev = parent;
 	chip->npwm = npwm;
+	chip->uses_pwmchip_alloc = true;
 
 	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
 
@@ -241,6 +242,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
+	/*
+	 * a struct pwm_chip must be allocated using (devm_)pwmchip_alloc,
+	 * otherwise the embedded struct device might disappear too early
+	 * resulting in memory corruption.
+	 * Catch drivers that were not converted appropriately.
+	 */
+	if (!chip->uses_pwmchip_alloc)
+		return -EINVAL;
+
 	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index b410ff38beb5..6a5b245e8951 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -300,6 +300,7 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
+	bool uses_pwmchip_alloc;
 	struct pwm_device *pwms;
 	void *driver_data;
 };
-- 
2.42.0


