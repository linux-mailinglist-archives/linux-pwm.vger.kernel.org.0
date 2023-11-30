Return-Path: <linux-pwm+bounces-262-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B637FE99A
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 08:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B59281DB3
	for <lists+linux-pwm@lfdr.de>; Thu, 30 Nov 2023 07:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287CF1DDD2;
	Thu, 30 Nov 2023 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D787712C
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 23:21:21 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bMO-0002Hn-Bc; Thu, 30 Nov 2023 08:21:20 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bMN-00Ca2I-Sy; Thu, 30 Nov 2023 08:21:19 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8bMN-00BNqS-Jk; Thu, 30 Nov 2023 08:21:19 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: Reduce number of pointer dereferences in pwm_device_request()
Date: Thu, 30 Nov 2023 08:21:06 +0100
Message-ID: <20231130072105.966848-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=BkWnANAXtrC/s1ZrbUpNtTZVtHHd8ZtgeS0Jcqu1vBA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlaDfhiSgMrlmEglukyZsXKNBN7J+FgeHZxe9kk vXLi3cRk3eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZWg34QAKCRCPgPtYfRL+ TklqB/967lZG4Hg1PN+TuJPG6pnIigCrEreT039Xb1O98nsGsDQymqm3PcCo0N6YzErSsfp5sJ8 6cY6Qwh5Ke23i9eglNs2aAKrQvFdJKGSZghh+1vmOZWKlBRFUFc9WBxa9en0ifK//b4bmOMlkfi qmt2hsutyoolAMxtJt0pCT72+1E0MEbRoGDph13TWsECJnwFzcM4MFcUwKSxcixtJXbRWAW3xNN wlwekb0nXW1p410GqlfXmoi1KpP0GI1iaK7s7qj5L46g1PLQGi+1nlxumRLGSJr0UaPIGP5zhF7 21WZdvHbvCWv/fjk57zbVG4AfmcWQn5fr/TxvQ9Ce1nW3VjQ
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

pwm->chip and pwm->chip->ops are used several times in this function.
Introduce local variables for these.

There is no semantical change, but with ARCH=arm, allmodconfig and
gcc-13 bloat-o-meter reports a slight improvement:

	add/remove: 1/1 grow/shrink: 1/1 up/down: 8/-36 (-28)
	Function                                     old     new   delta
	pwm_apply_state                              476     480      +4
	__initcall__kmod_core__307_1092_pwm_debugfs_init4       -       4      +4
	__initcall__kmod_core__307_1090_pwm_debugfs_init4       4       -      -4
	pwm_request_from_chip                        628     596     -32
	Total: Before=15091, After=15063, chg -0.19%

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index f60b715abe62..eea93ed8a49b 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -59,22 +59,24 @@ static struct pwm_chip *pwmchip_find_by_name(const char *name)
 static int pwm_device_request(struct pwm_device *pwm, const char *label)
 {
 	int err;
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
 
 	if (test_bit(PWMF_REQUESTED, &pwm->flags))
 		return -EBUSY;
 
-	if (!try_module_get(pwm->chip->owner))
+	if (!try_module_get(chip->owner))
 		return -ENODEV;
 
-	if (pwm->chip->ops->request) {
-		err = pwm->chip->ops->request(pwm->chip, pwm);
+	if (ops->request) {
+		err = ops->request(chip, pwm);
 		if (err) {
-			module_put(pwm->chip->owner);
+			module_put(chip->owner);
 			return err;
 		}
 	}
 
-	if (pwm->chip->ops->get_state) {
+	if (ops->get_state) {
 		/*
 		 * Zero-initialize state because most drivers are unaware of
 		 * .usage_power. The other members of state are supposed to be
@@ -84,7 +86,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		err = pwm->chip->ops->get_state(pwm->chip, pwm, &state);
+		err = ops->get_state(chip, pwm, &state);
 		trace_pwm_get(pwm, &state, err);
 
 		if (!err)

base-commit: 53a2eaaf19c4e652ac53b5b2441582a555768516
-- 
2.42.0.586.gbc5204569f7d.dirty


