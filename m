Return-Path: <linux-pwm+bounces-336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C821806E6F
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008AC1F21554
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27772358AE;
	Wed,  6 Dec 2023 11:48:41 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3FD67
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOC-0006Os-06; Wed, 06 Dec 2023 12:48:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-00Dwu1-J1; Wed, 06 Dec 2023 12:48:27 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOB-00FQzE-A1; Wed, 06 Dec 2023 12:48:27 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 042/115] pwm: Provide wrappers for storing and getting driver private data
Date: Wed,  6 Dec 2023 12:43:56 +0100
Message-ID:  <031b8788a381cd9ce57b36ae4f5850cf93605bc5.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=mi904fqwiM5EaHbyNXgj1AiqUyOvv8y5+vwYbZ8TdxA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6S0lGGLbxMZwHLEkliz5kElxM1j2/1ntuC5 3shntRe7j2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBekgAKCRCPgPtYfRL+ TsswCACaRNddyrnfuIXSh8+rczv7mB8ilxzAHL3MHVHTkzilEsAy/ESIdMDw0qWroO2R0UPmUcN wq8CLsiJYHA1xKb7Y5vaRb8l91qUt9K2gmztpep2DABnXeJ6s6TYYRG0ungc8/7CMKLGbb04vwk wfV93GhTXCsAVPp0kiTfgHVXCtxjUSlnakqZbkBVo0FR3FiuO7d7JWaYAuIADMKVJIoejiTDQq9 zT9uZGaoVKxp81N7lwhDE3HFYswk14pINGX5fKNgLNNStOO5eYfxamUOJyMwFF0CCBdn/DIKNku R4SNZ5waWPaZV8WH1zYaesQ05+t1Zu2Wivs1BtELPEFwexCm
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

These functions are useful to store and query driver private data a
After struct pwm_chip got its own struct device, this can make use of
dev_get_drvdata() and dev_set_drvdata() on that device.  These functions
are required already now to convert drivers to pwmchip_alloc() which
must happen before changing pwm_chip::dev.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index e069900d1a36..e07b7a0c8471 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -300,6 +300,7 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	struct pwm_device *pwms;
+	void *driver_data;
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
@@ -307,6 +308,24 @@ static inline struct device *pwmchip_parent(struct pwm_chip *chip)
 	return chip->dev;
 }
 
+static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
+{
+	/*
+	 * After pwm_chip got a dedicated struct device, this can be replaced by
+	 * dev_get_drvdata(&chip->dev);
+	 */
+	return chip->driver_data;
+}
+
+static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
+{
+	/*
+	 * After pwm_chip got a dedicated struct device, this can be replaced by
+	 * dev_set_drvdata(&chip->dev, data);
+	 */
+	chip->driver_data = data;
+}
+
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.42.0


