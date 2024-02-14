Return-Path: <linux-pwm+bounces-1416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600688545F8
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0B43B22ABA
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219531AAC4;
	Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1991A19472
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903285; cv=none; b=RUDM2UNXVJ0ra1ezRMDrrpm0XFtvq+S21TB1j0uCCvOT9eI91rhQgyMQ2cKYm37sIMviM6Oft2TCj0eT3CGxY8KRJzNo6gAvlWcI5JBywRnNcEs8SggevlAYgwNw4H+w+q1LJfFLY40HEVCPVeZJm7zGYdxm8tZs+nShPU0yktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903285; c=relaxed/simple;
	bh=bZTsW8lAwjzlND0LcwKPlCEPg8gdCtmlWf6i463Sq1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1ESjU1+UHCo5pPENMF9tRSAGAxrySluNzTGFtpQEblmdgBBWJJVIpQtiTGQtl/1lVFxcAeglDWe53c00eWMMD6xD3jU4SaIuN8/q/IEirhrqyRUu6Gr9X6xlDccPvZxls5M1IRxIGW9gN2G7HKkdZ+l5WFpkc6yorpsmZrBYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf5-0005ik-3n; Wed, 14 Feb 2024 10:34:39 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-000fFi-8S; Wed, 14 Feb 2024 10:34:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf1-004Y7R-0a;
	Wed, 14 Feb 2024 10:34:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 113/164] pwm: stm32: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:32:40 +0100
Message-ID:  <54ace92a3c02d22f15a79c7ecf00c29f28386a33.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=872; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=bZTsW8lAwjzlND0LcwKPlCEPg8gdCtmlWf6i463Sq1k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjN2bCo4elWQTi51iNbI+Kc+Jt2OcDstTYJh EROUhArW/6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIzQAKCRCPgPtYfRL+ TtuFB/0VadLMWhIrTIg38YKPDtgTBx6Tn4VV33yfCIaelHzLHNHL6Cu3b76q6dbMT+sXHYNaOL9 IxrLgjvVR51f+/yumbGQesuyBlJ4wqZknMLGmdSiHcLlrKsprfrovyVcD8Ckf861FWYmNf8p+4D 3e+RNxtmM/3fAs+1dQxqyMi6tlUxJtt7ozjR/7GLp7+tpv4XD0cbxT9tUuHvV2zf+sObWcmV8jA vriK8BShqzzJs2zZW4LSq8wxMvh4b3VOhaSMsKUfI8HU+R3Pskjvw8Hz3cjPhxaw8PCJ2AHQV+S pPS1nsPMXGiwJ/EOgR2rLGzZvmKsRsQCFNKPjUqAIYFOj3Fh
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct stm32_pwm *priv just obtained from it. This
also has the advantage of not using struct stm32_pwm::chip any more
which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 5f10cba492ec..202114c00ad3 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	ret = clk_enable(priv->clk);
 	if (ret) {
-		dev_err(priv->chip.dev, "failed to enable counter clock\n");
+		dev_err(chip->dev, "failed to enable counter clock\n");
 		goto unlock;
 	}
 
-- 
2.43.0


