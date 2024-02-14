Return-Path: <linux-pwm+bounces-1322-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095185458D
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C38C9B226A3
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EF318042;
	Wed, 14 Feb 2024 09:34:26 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B467C175A9
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903265; cv=none; b=HlJE2rxPJtxJk2Soo7D5jXMbui3hCtcLvWtOISmlSsdMXaRqV3QYFr2xW4Oi54rpaVP1dEk1S26gFtc4oCDHl4v33QtD9tILowcKIh2HheTv8PgDgNHw3QaJW9QyyABmrNWkrTSqSfk8J+O+4wwjOLtWJYabbOrqm+fW1gtNhzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903265; c=relaxed/simple;
	bh=b9f7H/MsXwBDAk/myztuyL8bNkCQGo4c7QFpYH1j7Ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vqp6JxT07cknTIu/Uaw723jkPdjnESiDiLORUnXc5Rgo42b3+Bh68I5TCpNfDzWaEYAbj9z+Ac7lui2kiSsgoWKCASGUkOLKvEIMTrK9cK4hgeN+qSFm+0tR5JTIfthWLl9eyWFU9Uf4MGvy8BX++9uBiKWw0xIxpReEKEpZv9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBen-0004VD-Fn; Wed, 14 Feb 2024 10:34:21 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-000f8l-Lf; Wed, 14 Feb 2024 10:34:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBem-004Y0p-1u;
	Wed, 14 Feb 2024 10:34:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	linux-pwm@vger.kernel.org
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	kernel@pengutronix.de
Subject: [PATCH v6 018/164] pwm: bcm-kona: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:31:05 +0100
Message-ID:  <f0086ed37f30c4d25bf226e722f5ae52a73974d9.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1168; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=b9f7H/MsXwBDAk/myztuyL8bNkCQGo4c7QFpYH1j7Ts=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIhfxoagEs8DsyBHSI4CzwFV8c03xz1nrpqaj oHrJfwLTYGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIXwAKCRCPgPtYfRL+ TjwwB/wNfrC9pNVda+Evg6b/aCT+bNQxMAoOd6iQiFdhhw+y3vtgdz2IC/yFf7ZT0XAGwReuEQF fokBIxoCONYd4VANALv/6OFHOX+gSXhqMQtwbOd6ceiC94jC3dxOD28jGx5dyyVAK6kzIwWMuOS t47PdnPM/7cWitXuJ+JkGpqyh2NWx9ZKcrApazSMvKHj1Fl1MOf0pm+Rvuy5B8lThboQ2jCL++W WAe/hiaIZvUkCjnQuwvAS28SFTmN/pI/mF7WlLgJbQgEGH43JTAq42KsbjFnuMK2QHF7VDDbNVl q6O5K32oHtRb9tVeYPz5CiZqnzQOGdyXJeZKSZdfPShjqD2b
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the accessor
function provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-bcm-kona.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-bcm-kona.c b/drivers/pwm/pwm-bcm-kona.c
index 45046a5c20a5..47acae8d7478 100644
--- a/drivers/pwm/pwm-bcm-kona.c
+++ b/drivers/pwm/pwm-bcm-kona.c
@@ -164,7 +164,7 @@ static int kona_pwmc_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
@@ -193,7 +193,7 @@ static int kona_pwmc_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	ret = clk_prepare_enable(kp->clk);
 	if (ret < 0) {
-		dev_err(chip->dev, "failed to enable clock: %d\n", ret);
+		dev_err(pwmchip_parent(chip), "failed to enable clock: %d\n", ret);
 		return ret;
 	}
 
-- 
2.43.0


