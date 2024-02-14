Return-Path: <linux-pwm+bounces-1336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD15C854592
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAA91F2E025
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8723E18633;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C6816419
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=U4aq8Vlp7xIuayRO3MMr1JOq+x7ZwDln3U6IYoYMBx7GF7Zy5/cAZwVHJydnui1T53JaYBhgmjRDVZ/pJx3ea76M9MZxF0bNEo1EZLi47BBS60liad7F1zIo3CzxOT+WWLNruXXFESKK+htZFxeDpoILmOrbZL00dnX49kbBRog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=ytJ6GmrJ9bpgSdxi2IT+4ymvRGcvWNR/l1mgiaeCSwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oeOMClO7x4qnrBmSwRogehGWoqAcILVW9L19mDSyBrln7cT2D1pjdc7vvH3ekJvlWF1wGXHaYzaN//LMOApiXV/R6EJuc2MRbEtL82Z63yxHakKJRFnnbD0XGSWu1t0gDlV5ih/JLILumMkKVXJJXX1UmCLxBSz1RNsRJ10xIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-0004Yk-Lt; Wed, 14 Feb 2024 10:34:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-000f9l-UE; Wed, 14 Feb 2024 10:34:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-004Y1L-2l;
	Wed, 14 Feb 2024 10:34:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 026/164] pwm: crc: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:31:13 +0100
Message-ID:  <66d55649e13526bbd95d7bfd1cacfa0beb9efd43.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ytJ6GmrJ9bpgSdxi2IT+4ymvRGcvWNR/l1mgiaeCSwY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIho/7yqGrPbZkMT5IdY6OZ4Tya88qJz3Vo+i BoHwt3EL0GJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIaAAKCRCPgPtYfRL+ TgaMCACzH1qNeLnwEZZIbWC0SPUWY7dJrZ2IYYPYt0qqt6pyrxO/PGxRybujjlKKnb7YDRWsmJR i1rNstCThgBcVPi3MLYASEjM/j7bNUJNliQrMg2rizbezeApynJDY4+xJJdz0LhQOg/YkM21g4u qZDQD5bA5d1eAMg5RIP7xAvGZDUWX8AydNfYluTT1ONllIso8aXicYD20O8cYCcUe9SDAfgMnGx M8ddENemsM9dqkNhjTAB/Y2gq9erwiU7ToH20k3WSFT4n39GQ/cQykD93auwGOdBXvt03a5snpu /278n45hJEBjrm53lePSP3npx50hc+Mt2H+BtiySf9yi5zgz
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct crystalcove_pwm *crc_pwm just obtained from
it. This also has the advantage of not using struct
crystalcove_pwm::chip any more which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-crc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-crc.c b/drivers/pwm/pwm-crc.c
index e09358901ab5..d985a9d3336d 100644
--- a/drivers/pwm/pwm-crc.c
+++ b/drivers/pwm/pwm-crc.c
@@ -55,7 +55,7 @@ static int crc_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 			 const struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = chip->dev;
 	int err;
 
 	if (state->period > PWM_MAX_PERIOD_NS) {
@@ -125,7 +125,7 @@ static int crc_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 			     struct pwm_state *state)
 {
 	struct crystalcove_pwm *crc_pwm = to_crc_pwm(chip);
-	struct device *dev = crc_pwm->chip.dev;
+	struct device *dev = chip->dev;
 	unsigned int clk_div, clk_div_reg, duty_cycle_reg;
 	int error;
 
-- 
2.43.0


