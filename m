Return-Path: <linux-pwm+bounces-7852-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A8768CF6F39
	for <lists+linux-pwm@lfdr.de>; Tue, 06 Jan 2026 08:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38D313015023
	for <lists+linux-pwm@lfdr.de>; Tue,  6 Jan 2026 07:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF493090E0;
	Tue,  6 Jan 2026 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="KY24gprE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CB62F9D82
	for <linux-pwm@vger.kernel.org>; Tue,  6 Jan 2026 07:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767682975; cv=none; b=D+0z2FKMxdlBteYmPYa2dlO0wKybwLCMDR+KLr3ehs8WPdOfYZV5tuSF78fgU8hHXCWEk8O24DuxVzzZeEHf+sGCJkKt7zKCGGAFxOgnz7/trCZzULwJKso98Rf/XY7XyHtGIEllboNH1fWdJF+QPFiqj6pb8GjxobmDJafUitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767682975; c=relaxed/simple;
	bh=dl7pYMeFGS3yu5g46TvWW9y/9LSwCxG+//0ej2AUWLU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YDzffXdB/fllX5C//v3x5BWTBUG/1TRkOFiJ6u3CCzWWY1zSSUYEZhlMzx6Q4wRkEKbgvrZo76q+7lpAOorNPLgM5F2dm+FVCt7NbC8cU2lqs2awps2elox7skVth366I0da0SByohk/XYzs26xwEZoJyVtt78gjylKclCpicks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=KY24gprE; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail2; t=1767682957; x=1767942157;
	bh=Ff33WQ4GQXy7iOXr07oKwZiyvNoomCN0lMUIfbK3JYQ=;
	h=From:Date:Subject:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KY24gprEBSRLNs4XwnP8ztibL8SJvCsGaIRZl5Luww9RJVgq2f1n7OooViBUZ4eoD
	 3F6SaU6rkt2Z8FKkDtCYGMXd54dsXinZA1/si92Lu22j0PqlHo6y936qjXCIRIiS7P
	 p2vYjFs4YRnMcmlR436AYZv+GH3MqaCL0KEjWv6rBnB2fQaUZRm1+wX9tc5RIIhve7
	 KsVZPYm2uGvLXnlYv/h78+W4ciQEraJ0pZaBmWJgIG5616aNBv3B0J7tLa0Yf80/qY
	 wlkpmcClHRROnnmb+0JHb6WYCyrOfKTpRiGvUrKAtF5zY/qcKxv5DEWfsr5Ah2eeAh
	 HIJA8EEJ5uclw==
X-Pm-Submission-Id: 4dlhv00m80z1DFFx
From: Sean Nyekjaer <sean@geanix.com>
Date: Tue, 06 Jan 2026 08:01:57 +0100
Subject: [PATCH] pwm: stm32: handle polarity change when PWM is enabled
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-stm32-pwm-v1-1-33e9e8a9fc33@geanix.com>
X-B4-Tracking: v=1; b=H4sIAGSzXGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDQwNT3eKSXGMj3YLyXF1Lw+QkCxNjMwuDNBMloPqCotS0zAqwWdGxtbU
 AIJCvw1sAAAA=
X-Change-ID: 20260105-stm32-pwm-91cb843680f4
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
 linux-pwm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

After commit 7346e7a058a2 ("pwm: stm32: Always do lazy disabling"),
polarity changes are ignored. Updates to the TIMx_CCER CCxP bits are
ignored by the hardware when the master output is enabled via the
TIMx_BDTR MOE bit.

Handle polarity changes by temporarily disabling the PWM when required,
in line with apply() implementations used by other PWM drivers.

Fixes: 7346e7a058a2 ("pwm: stm32: Always do lazy disabling")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
This patch is only applicable for stable tree's <= 6.12
How to explicitly state that and what is the procedure?
---
 drivers/pwm/pwm-stm32.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index eb24054f9729734da21eb96f2e37af03339e3440..d5f79e87a0653e1710d46e6bf9268a59638943fe 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -452,15 +452,23 @@ static int stm32_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	enabled = pwm->state.enabled;
 
+	if (state->polarity != pwm->state.polarity) {
+		if (enabled) {
+			stm32_pwm_disable(priv, pwm->hwpwm);
+			enabled = false;
+		}
+
+		ret = stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
+		if (ret)
+			return ret;
+	}
+
 	if (!state->enabled) {
 		if (enabled)
 			stm32_pwm_disable(priv, pwm->hwpwm);
 		return 0;
 	}
 
-	if (state->polarity != pwm->state.polarity)
-		stm32_pwm_set_polarity(priv, pwm->hwpwm, state->polarity);
-
 	ret = stm32_pwm_config(priv, pwm->hwpwm,
 			       state->duty_cycle, state->period);
 	if (ret)

---
base-commit: eb18504ca5cf1e6a76a752b73daf0ef51de3551b
change-id: 20260105-stm32-pwm-91cb843680f4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


