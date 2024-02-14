Return-Path: <linux-pwm+bounces-1426-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C17C38545F4
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AC81C27153
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711621B81E;
	Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019DF199BE
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903287; cv=none; b=jMUjMDX0LOKXjDjbGPmRs1FKdeBimTZ/9ozOEMoI+aDAuz+9G/L7P+XsZGRD9556hcNT5qtr4nwYonVWeKY5colBs9ULZKtgre2VHiZgLN+pU6h1evLaJ+8lYw2hhdx1YSfcxPYpG589E/ELfY7bWYj+ztZXuuQD/SYsfFUjA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903287; c=relaxed/simple;
	bh=gI6fgHjRyxH3Qt9HapAhSqq3xRfx+GZ8KpfHRdKhT88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOZRuOxnGvGJENhTlI/PPN4Q1vRX3yEvO8FUr6YN3YwTAmSjplPgH6MK35RRC8Oa4TqDoJuSavjvx9wPZAQplJK9ZI4xP2DgjQdH7MbpYWt/zk10YtyjMSwVNcUuAKqK1awWR02cBidCn2wALpknlny6DlkrRg5ukVOEehOreHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-0005RU-QD; Wed, 14 Feb 2024 10:34:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-000fEe-JU; Wed, 14 Feb 2024 10:34:32 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBey-004Y6B-1g;
	Wed, 14 Feb 2024 10:34:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-pwm@vger.kernel.org
Cc: Alim Akhtar <alim.akhtar@samsung.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v6 096/164] pwm: samsung: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:32:23 +0100
Message-ID:  <4e8400a42979b6be0b80dff5ae964d8e9d6232eb.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1945; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gI6fgHjRyxH3Qt9HapAhSqq3xRfx+GZ8KpfHRdKhT88=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIi5dffod7rgEsvr7NFa/8oDDNfXE0QdPB0pK AogvDV4MFqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIuQAKCRCPgPtYfRL+ TvmIB/9nfm11krcHO1WDkPaq7yn2sgHJkG66SC3mgGtRwWSzNdGf/Ks1qwm2m/TFR6YHBMwrdNt 4w0c6pE+eeDaavHQPPDhwdIqzBcnp/G0kpQ4DxH/Yz2Fv92OZ0fiooDBDo8/QJ6D9d5sm+yppQE S3E7lId+KqwiaGBfR6b0byZPO0POor/7YLack1khWjziXBuwIo2QUkEcOWGAaOdZ5ID0PlQD7LU VnsdFMh6cPm7Xvtt1MxXUyCRHds7jqHLAcug99K2kEEgII/iV718Zh1xTqvPO4z6vxXfpBqEZxn Xz3kis9kVqYIWMyMZqCorBhflwXaaehhP7zLzc+h9bbbQyDM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct samsung_pwm_chip *our_chip just obtained
from it. This also has the advantage of not using struct
samsung_pwm_chip::chip any more which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-samsung.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pwm/pwm-samsung.c b/drivers/pwm/pwm-samsung.c
index 6e77302f7368..0f9a2a5e3ebc 100644
--- a/drivers/pwm/pwm-samsung.c
+++ b/drivers/pwm/pwm-samsung.c
@@ -326,12 +326,12 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 		period = NSEC_PER_SEC / period_ns;
 
-		dev_dbg(our_chip->chip.dev, "duty_ns=%d, period_ns=%d (%u)\n",
+		dev_dbg(chip->dev, "duty_ns=%d, period_ns=%d (%u)\n",
 						duty_ns, period_ns, period);
 
 		tin_rate = pwm_samsung_calc_tin(our_chip, pwm->hwpwm, period);
 
-		dev_dbg(our_chip->chip.dev, "tin_rate=%lu\n", tin_rate);
+		dev_dbg(chip->dev, "tin_rate=%lu\n", tin_rate);
 
 		tin_ns = NSEC_PER_SEC / tin_rate;
 		tcnt = period_ns / tin_ns;
@@ -355,8 +355,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	/* -1UL will give 100% duty. */
 	--tcmp;
 
-	dev_dbg(our_chip->chip.dev,
-				"tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
+	dev_dbg(chip->dev, "tin_ns=%u, tcmp=%u/%u\n", tin_ns, tcmp, tcnt);
 
 	/* Update PWM registers. */
 	writel(tcnt, our_chip->base + REG_TCNTB(pwm->hwpwm));
@@ -368,7 +367,7 @@ static int __pwm_samsung_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * shortly afer this update (before it autoreloaded the new values).
 	 */
 	if (oldtcmp == (u32) -1) {
-		dev_dbg(our_chip->chip.dev, "Forcing manual update");
+		dev_dbg(chip->dev, "Forcing manual update");
 		pwm_samsung_manual_update(our_chip, pwm);
 	}
 
-- 
2.43.0


