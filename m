Return-Path: <linux-pwm+bounces-198-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D50647F85A4
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 22:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E705281FC5
	for <lists+linux-pwm@lfdr.de>; Fri, 24 Nov 2023 21:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A833C08F;
	Fri, 24 Nov 2023 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CAB198D
	for <linux-pwm@vger.kernel.org>; Fri, 24 Nov 2023 13:52:22 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-0002d2-Tn; Fri, 24 Nov 2023 22:52:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-00BLvt-Aw; Fri, 24 Nov 2023 22:52:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r6e5y-007hOb-1q; Fri, 24 Nov 2023 22:52:18 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/3] pwm: Provide wrappers for storing and getting private data
Date: Fri, 24 Nov 2023 22:52:10 +0100
Message-ID: <20231124215208.616551-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
References: <20231124215208.616551-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=yCNKlXBCRVhLmYr9X+2N55yc5q20przbsEw/GOnGIQ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlYRsKkzIgM5uiW4uFEIQYSiuto/LYMGX2OD9O1 TQf0V4cR5aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWEbCgAKCRCPgPtYfRL+ TgxWB/9yhU6XQyKQpgME3CPnlRKbhKaLQe3s02SpSNN0WihI/f+CnnD0aEofJ3ajL1J5kivArrs U2+Az0E/qWWCOFu+6x/lVC/jNwtI+zi1kA8h28UiSMuytVH7nhhmKDulwvtE5hL/W2HKNSKGSZ4 N43h36XJnc/jANMXR9Po/h6Tlr05NFY/0hFHRwyjTOj2g6qXTS78VSahnwe0Sewh+FvDdHIFdDF MEHJR01aBS6uARKX/vRCBZrYm7pvi3g7u1ks/7dbPTN4GjsCVwI+2L+bNoP8Crc1r1qiJbI3P4/ rN1KQi+Zmeky0rrzhZTjWFS16/Pd0YN1TbV7MNTH8tUPXlqG
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Also call pwmchip_set_drvdata() in pwmchip_alloc() to have a sane
default. Might replace pwmchip_priv()?!

After struct pwm_chip got its own struct device, this can make use of
dev_get_drvdata() and dev_set_drvdata() on that device.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  |  2 ++
 include/linux/pwm.h | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 17577a1c4efc..0cbce704cc0b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -216,6 +216,8 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 	chip->dev = parent;
 	chip->npwm = npwm;
 
+	pwmchip_set_drvdata(chip, pwmchip_priv(chip));
+
 	return chip;
 }
 EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 3c62cf329ee0..7a32ac687717 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -302,6 +302,7 @@ struct pwm_chip {
 
 	/* only used internally by the PWM framework */
 	struct pwm_device *pwms;
+	void *drvdata;
 };
 
 static inline struct device *pwmchip_parent(struct pwm_chip *chip)
@@ -309,6 +310,24 @@ static inline struct device *pwmchip_parent(struct pwm_chip *chip)
 	return chip->dev;
 }
 
+static inline void *pwmchip_get_drvdata(struct pwm_chip *chip)
+{
+	/*
+	 * After pwm_chip got a dedicated struct device, this can be replaced by
+	 * dev_get_drvdata(&chip->dev);
+	 */
+	return chip->drvdata;
+}
+
+static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
+{
+	/*
+	 * After pwm_chip got a dedicated struct device, this can be replaced by
+	 * dev_set_drvdata(&chip->dev, data);
+	 */
+	chip->drvdata = data;
+}
+
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.42.0


