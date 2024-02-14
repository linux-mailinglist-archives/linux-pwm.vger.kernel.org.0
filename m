Return-Path: <linux-pwm+bounces-1319-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582CD854581
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC20A1F2E070
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E7168CE;
	Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1091427F
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903265; cv=none; b=nq6+WnzoZnzma5d5t9TPKla1mKVvAtq8QVM1tEkSdpdMDnS/mA23izeJuSr42mehkNJ3VbvsCRCdpUUekn+ATAq7b9r+qwmA09ZmmWLXejcecGk/2+R4b9obHpaTjntjVf3oonSrKvuwO/0r317Z3RG7LZBIJ3R3TJrkC8AzwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903265; c=relaxed/simple;
	bh=n/J5oDlPxXReTz+uCLIDIov5v8tmfWnZ3qghGaABPIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbORPNsiQ1VfdNLQha27pwFEavpi0jog1NgUM/KXG+0iHSeF7j5GQdHvnbswgLnpEyfB2IcenQkhNqjIYKad91wbo9L4LDYjjzmghWJvqwb9yLC001lCrLipPqQbPlUdOrftHjMVodPN3D9q0ziRrtbWUfsw49x2cJckxnQkIAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-0004NZ-GU; Wed, 14 Feb 2024 10:34:18 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBek-000f6W-1n; Wed, 14 Feb 2024 10:34:18 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBej-004Xzc-39;
	Wed, 14 Feb 2024 10:34:17 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v6 002/164] pwm: Provide wrappers for storing and getting driver private data
Date: Wed, 14 Feb 2024 10:30:49 +0100
Message-ID:  <67514cdf29d29bd8b4ad8d44fac87f6ae6dca1e5.1707900770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707900770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2034; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=n/J5oDlPxXReTz+uCLIDIov5v8tmfWnZ3qghGaABPIg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhNuHK8L4hLivwDo3aT2U9LOc+OSPRE0NSKf 0O5VJ6ktUqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyITQAKCRCPgPtYfRL+ TmD9B/9ELRx/esLQ6bnxuzi4QyNr6h2PaQU401+Q2OYIaIVjUoqtKfOj94e+7hLWue5cHd1/OSo Bn8Sl5nqrA+c6MdIHoT2EZZrzCNpC9mvGYIZyoxlPvn0usBdEBtGeGSPMWrL5tiecnLEBQhEtzp mby4+6pbZCzN/g7QhyU/eSMf+FrHcnFu3lHRu8SFBDTqxxCwD+y4J4srCZAnlwA3kZ4zdACby+/ m2mpJZ/Oum6nRTcCd0Rkh8VnkaaFAY1TAC1LaO6YKdrBSqu6nfLcy8oH3pRg8ziSB1yz+KwkVD6 bH7zFMSNxRlVbMirUc7x2YnMduvcbawvu0hZNxt24vxB6RPz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

These functions are useful to store and query driver private data
depending on the pwm_chip. After struct pwm_chip got its own struct
device, this can make use of dev_get_drvdata() and dev_set_drvdata() on
that device. These functions are required already now to convert
drivers to pwmchip_alloc() which must happen before changing
pwm_chip::dev.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 07af6910bdce..29a7d9140f77 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -272,6 +272,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @atomic: can the driver's ->apply() be called in atomic context
+ * @driver_data: Private pointer for driver specific info
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -286,6 +287,7 @@ struct pwm_chip {
 	bool atomic;
 
 	/* only used internally by the PWM framework */
+	void *driver_data;
 	struct pwm_device *pwms;
 };
 
@@ -294,6 +296,24 @@ static inline struct device *pwmchip_parent(const struct pwm_chip *chip)
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
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.43.0


