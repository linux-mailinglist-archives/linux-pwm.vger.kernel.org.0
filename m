Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC56404807
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Sep 2021 11:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhIIJuI (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 9 Sep 2021 05:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhIIJuG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 9 Sep 2021 05:50:06 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EEDC06175F
        for <linux-pwm@vger.kernel.org>; Thu,  9 Sep 2021 02:48:57 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0000GS-RE; Thu, 09 Sep 2021 11:48:55 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0007fV-AO; Thu, 09 Sep 2021 11:48:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1mOGfv-0005nE-9K; Thu, 09 Sep 2021 11:48:55 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de,
        =?UTF-8?q?M=C3=A5rten=20Lindahl?= <marten.lindahl@axis.com>
Subject: [PATCH 2/2] pwm: Make it explicit that pwm_apply_state() might sleep
Date:   Thu,  9 Sep 2021 11:48:49 +0200
Message-Id: <20210909094849.313936-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909094849.313936-1-u.kleine-koenig@pengutronix.de>
References: <20210909094849.313936-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patch-Hashes: v=1; h=sha256; i=ADb3X3G6cTKGPLEU01jqBnEkf1z6W7XmJPr+ak+as70=; m=cPi2oQpBA0UOP+uG776+b5rdTfkX0rEMvkiDpl7Te+w=; p=gRlwPJU6+GAk5P42OuTuFQ/D9TOrcwNWMwJfGz/vBAA=; g=92d5dd006f08fb17a9c8950685aabab037f5788b
X-Patch-Sig: m=pgp; i=u.kleine-koenig@pengutronix.de; s=0x0D2511F322BFAB1C1580266BE2DCDD9132669BD6; b=iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmE52H0ACgkQwfwUeK3K7AnQiQf/ZvA 4Boli3XKtSRU7GU0j5HVOCduLQCF6IZaISUPpV593q8o/UV+Akbtd1t5jyU/dAv0xiwOkdHZdJPVS dkM7mx/7SLPMtBH/S8YNY7xBsfZ0w2ZTx43PPfcR2rRKAms27uSICf8MO52owuC2PcLZSyeZnDdrX 4coFLRRfR+EP43SMvrNvMEZaYKgB8v4L5fWuPFpkYW5jMBaywUlbS69+dPLDJNdIznfhSnNp+P2ab rxGOGQ+ILUrLYgrlqCZW3DFxN1xzSZgg+D+5DxhXmp3MkNigwKfyGZHczUm/qGvL0hqjpGN4h0zzt o3ojcf5+gj/ynwYYqrDHh58+BWMCXwQ==
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

At least some implementations sleep. So mark pwm_apply_state() with a
might_sleep() to make callers aware. In the worst case this uncovers a
valid atomic user, then we revert this patch and at least gained some more
knowledge and then can work on a concept similar to
gpio_get_value/gpio_get_value_cansleep.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 9 +++++++++
 include/linux/pwm.h | 4 ++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 4527f09a5c50..b7cda8a3eb85 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -532,6 +532,15 @@ int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state)
 	struct pwm_chip *chip;
 	int err;
 
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_state() from atomic context
+	 * is a bad idea. So make it explict that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
+
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
 		return -EINVAL;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 515e33978e97..e6dac95e4960 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -441,6 +441,7 @@ static inline void pwm_free(struct pwm_device *pwm)
 static inline int pwm_apply_state(struct pwm_device *pwm,
 				  const struct pwm_state *state)
 {
+	might_sleep();
 	return -ENOTSUPP;
 }
 
@@ -452,6 +453,7 @@ static inline int pwm_adjust_config(struct pwm_device *pwm)
 static inline int pwm_config(struct pwm_device *pwm, int duty_ns,
 			     int period_ns)
 {
+	might_sleep();
 	return -EINVAL;
 }
 
@@ -464,11 +466,13 @@ static inline int pwm_capture(struct pwm_device *pwm,
 
 static inline int pwm_enable(struct pwm_device *pwm)
 {
+	might_sleep();
 	return -EINVAL;
 }
 
 static inline void pwm_disable(struct pwm_device *pwm)
 {
+	might_sleep();
 }
 
 static inline int pwm_set_chip_data(struct pwm_device *pwm, void *data)
-- 
2.30.2

