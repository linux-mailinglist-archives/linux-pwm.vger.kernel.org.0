Return-Path: <linux-pwm+bounces-1463-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05B85461F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A897D28AC25
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414618E2F;
	Wed, 14 Feb 2024 09:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15D1AAD4
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903292; cv=none; b=F/3gOYzLbcYecd2DAF81wTu1HQ2adsc8XGkHlUFMd7dJcdHbuhPSX3lMMqTOF1P3HeuYDVgO/uJoJznPxpQ5fulH3rM/KFsXVCDPMCphNlR3SD/RSA+tdKhYDLA4DqUSFBkUKQpelux6AEtFb00hgVTRpVpX9d9dd+FWjjlmZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903292; c=relaxed/simple;
	bh=p17FPEGdt5iTjNuLV9ceuEp0unNUnbj7ddT/qbdQK6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAnWCLhN6JlAcbmoa06gf5YgGXTYIq/JIUpbE8RDP33TrL0TC/pN0X9u4Bf1EKqgIFwK6Udh5axWWMBZNXobYB7ddskuC3+pfZa1qWay8HKwpj/aMIaJptyMC9G2F1+J78ovKAv+cWFDLDWMd7ppKYXUsWAKQh0zUd0f/bnR324=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005n0-7f; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fG3-14; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7l-35;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 118/164] pwm: stm32-lp: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:32:45 +0100
Message-ID:  <9ad2399e1a683a6344b12d7f70498393b8f8b9de.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1729; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=p17FPEGdt5iTjNuLV9ceuEp0unNUnbj7ddT/qbdQK6A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjSiFzVxGz5R9cEYI7bUJyRiPKUR9CFsjkaW i4NRo0cchuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI0gAKCRCPgPtYfRL+ Tt5yCACxBKnzZgWU3h2X0Pssz520fC4vS5n8IvUil7omtHL+QdVa1HqAdbHiMTefUpOE/lbprks 9OXdbLyHyS+AP3rtkm9pf6NY9qiwCju+j8WxGHcuIE7pxjlGqG14SIelfDF1boJKg6l2ojCdehb zJ7IfYpisafyoF8FIChFk1gzc/ONNfnNtvM/6nXQff6eJCbBGCCJ6xr/cA8PIRekYefwuYn6TsR PAvFL1Eh8cnPZadlN2AadmF7XYfpkVIOMOAqbmwXXV8sR+LsV/JQiZaq6/aO4myzasrgrwTEZqF O3XYnL0Xd+toiysEZWSScpaBTuzdmy2sGr79orItPwV+hTkj
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct stm32_pwm_lp *priv just obtained from
it. This also has the advantage of not using struct stm32_pwm_lp::chip
any more which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32-lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 439068f3eca1..bbab6be314a8 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
+		dev_dbg(chip->dev, "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
@@ -69,7 +69,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
 		if ((1 << presc) > STM32_LPTIM_MAX_PRESCALER) {
-			dev_err(priv->chip.dev, "max prescaler exceeded\n");
+			dev_err(chip->dev, "max prescaler exceeded\n");
 			return -EINVAL;
 		}
 		div = prd >> presc;
@@ -130,7 +130,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
-		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
+		dev_err(chip->dev, "ARR/CMP registers write issue\n");
 		goto err;
 	}
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-- 
2.43.0


