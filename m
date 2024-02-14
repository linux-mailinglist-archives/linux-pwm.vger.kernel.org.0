Return-Path: <linux-pwm+bounces-1337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC80585458F
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8611C2640A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906D318637;
	Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DE21803E
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903268; cv=none; b=eEhCmPodhceE3Pcz+N/dUJIQYkqbGanbOfuIYJj1Q70RNo9AKRhysEpDAF6yDuri5WpxEo8GSUkC4QSNxtY60Js60X6A3sUyZ6Iq6OJHaE5D/JGh61AhXWL76jkuwOeYeLQt+M5wLuYgMaVaJFvsfTrAknM8W2S0gN20E8J+/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903268; c=relaxed/simple;
	bh=tdUHksxyzRmwZdWcceI7MItuTLn8MGbyCL/aGsWqkjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AuU5+hJvrGAIGzCrF+UttDqiP4UyQ6cDu2vuOGSIG4Svd28GP+hFxUIKxm6QRxK3mh4AlzokuWZSpXNvhRYhJr4hil9oGZQBfDACKv317cL4vX016vvlwbCHGZ59oSzbceiYbT90Dpmet21ZSnrWMDEWq0iiUUwAm/5Hvg+/1/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-0004ci-KN; Wed, 14 Feb 2024 10:34:23 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBep-000fAl-05; Wed, 14 Feb 2024 10:34:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeo-004Y1n-2z;
	Wed, 14 Feb 2024 10:34:22 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 033/164] pwm: dwc: Make use of devm_pwmchip_alloc() function
Date: Wed, 14 Feb 2024 10:31:20 +0100
Message-ID:  <64e64a9a8644600d51b234ad9bcae951b5748998.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1842; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=tdUHksxyzRmwZdWcceI7MItuTLn8MGbyCL/aGsWqkjg=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHQVP/+7dEeHG061+3CUwMLLb8txyxXkqm68IvTin+ 6Xs4Y6DnYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5NB+9n8W2+Y+Szhrcbal 7tYHtbl9xss4X0vP3OlhJKP0dR7nktvZde9tDDmbVL5tlli2bC9TjvhJu5fuukL6qgaS3/Vj8/I Pv26fcE50+oalphcqzLPceaMfmf/N/ZpwQFhTTmexkw7f6ps5Fvemxv9QUTaKjMm5t7vC1wyoZe GlK5uK45S333nMkldtsHKe3tG9qw5/usUR9F7GWaYtbXui0P8s0RyRCrPKWRWWorwiBtcmS756+ uOKppXWYjb9zfK8wbX8QQ99Nt0x3vj7s1rttMs1QTOdTvvqb91ika6me7ZVOTd2zvM9H3QTRD8Y SrjvEtAu2Pjv/xbbixFhBWs/6z99H76I/Y7Q0f8rTDrZAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-dwc driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Also convert the to_dwc_pwm() helper macro to a static inline to get
some type safety.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-dwc-core.c | 10 ++++------
 drivers/pwm/pwm-dwc.h      |  7 +++++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-dwc-core.c b/drivers/pwm/pwm-dwc-core.c
index ac7a0b2cb8b9..de1d2ac3316c 100644
--- a/drivers/pwm/pwm-dwc-core.c
+++ b/drivers/pwm/pwm-dwc-core.c
@@ -164,15 +164,13 @@ struct pwm_chip *dwc_pwm_alloc(struct device *dev)
 	struct pwm_chip *chip;
 	struct dwc_pwm *dwc;
 
-	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
-	if (!dwc)
-		return ERR_PTR(-ENOMEM);
-	chip = &dwc->chip;
+	chip = devm_pwmchip_alloc(dev, DWC_TIMERS_TOTAL, sizeof(*dwc));
+	if (IS_ERR(chip))
+		return chip;
+	dwc = to_dwc_pwm(chip);
 
 	dwc->clk_ns = 10;
-	chip->dev = dev;
 	chip->ops = &dwc_pwm_ops;
-	chip->npwm = DWC_TIMERS_TOTAL;
 
 	dev_set_drvdata(dev, chip);
 	return chip;
diff --git a/drivers/pwm/pwm-dwc.h b/drivers/pwm/pwm-dwc.h
index 432a3b4c81fd..5887371803fd 100644
--- a/drivers/pwm/pwm-dwc.h
+++ b/drivers/pwm/pwm-dwc.h
@@ -40,12 +40,15 @@ struct dwc_pwm_ctx {
 };
 
 struct dwc_pwm {
-	struct pwm_chip chip;
 	void __iomem *base;
 	unsigned int clk_ns;
 	struct dwc_pwm_ctx ctx[DWC_TIMERS_TOTAL];
 };
-#define to_dwc_pwm(p)	(container_of((p), struct dwc_pwm, chip))
+
+static inline struct dwc_pwm *to_dwc_pwm(struct pwm_chip *chip)
+{
+	return pwmchip_get_drvdata(chip);
+}
 
 static inline u32 dwc_pwm_readl(struct dwc_pwm *dwc, u32 offset)
 {
-- 
2.43.0


