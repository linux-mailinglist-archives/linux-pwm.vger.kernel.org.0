Return-Path: <linux-pwm+bounces-1738-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5093487762B
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 12:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CD51C2074F
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 11:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF6E1EB3B;
	Sun, 10 Mar 2024 11:01:15 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BD91EA8A
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710068475; cv=none; b=qtejsWnuPGG4dYlgIbAqcKMo6E0/CiY7CdBdq2+NhPcdMmUvrQaGMnw9bWb+6pRsggU0+HfGTTxr3wLHfNQFkNY/kmiY336uQj1f/rzqDm7IdDAb3bjpMzbSQatLrDrITYKxe8FtziqtG8DAC01e4n1U9pXZuzWV7kytwMVIfs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710068475; c=relaxed/simple;
	bh=CZKhlHBnADOPysxTMwc8/EGODAAlxcowgJvlgJZq1Gs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZRPKXN7X80how7fdns+a78yYbYzURBwznHQmvjWP3fBB3W0YEctqTJoUNS03mAIYc1/zrfcinhFC9BpafCsKDdu+fpaXFhGvXffSMua40mKM1+2KbVSLXqj9TaXNAXN+nRuhXIHPsx+/pXeyR7nOoAHPysZkt+dYXC5eiLRUZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvW-0000pr-5E; Sun, 10 Mar 2024 12:01:10 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-005V0q-L0; Sun, 10 Mar 2024 12:01:09 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjGvV-003OFe-1q;
	Sun, 10 Mar 2024 12:01:09 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: Ajit Pal Singh <ajitpal.singh@st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Lee Jones <lee@kernel.org>,
	kernel@pengutronix.de
Subject: [PATCH 3/6] pwm: sti: Drop member from driver data that only carries a constant
Date: Sun, 10 Mar 2024 12:00:56 +0100
Message-ID:  <7ddb76ef49fd84a07713b46c65374cb51f3b4ac0.1710068192.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
References: <cover.1710068192.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2790; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=CZKhlHBnADOPysxTMwc8/EGODAAlxcowgJvlgJZq1Gs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7ZLr3VrsxVAdvbDs2aDhHbm+uRzS4F5nBetE+ es1gVWDP8CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe2S6wAKCRCPgPtYfRL+ Tp0TB/9GvkkCxjTV3zFWkVUfuAafjncOGhgp6+FPV+VeMfPLRs5hxb6mJRFA5PBQJzVuPGjKmOt S7V2cOEQcxHRaVIaIjEpdq/oY5TjUd3WguXKORUCwuSc0+WVzDDQ4Eqlu9JwVDq/C6ucWrxM/6q 0s+96LSloWeqlsBPeSnaZzdo2Ic3z4F+MRAGs+bDnGaMvCzdYkEBj8yyECaPuQHJokWEUoeDf+R cvNJTk+6btzEezzYpwP+oWxv6FzzrfjAkLL0joAnIn4kdcheEkiSosI8ROdckv/srZr3OQfekod xhRvKSMzMbJeCy7OYY9EVRESM3BJyQUpC71nLzJcwLy/bYL2
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The .regfield member of struct sti_pwm_compat_data only holds a pointer
to the global array sti_pwm_regfields. Replace the few usages by
directly using this array and drop the member, saving a bit of memory
and a few pointer dereferences.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sti.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 919d25023e5a..fa86590a92a6 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -74,7 +74,6 @@ struct sti_cpt_ddata {
 };
 
 struct sti_pwm_compat_data {
-	const struct reg_field *reg_fields;
 	unsigned int pwm_num_devs;
 	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
@@ -505,38 +504,34 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 static int sti_pwm_probe_regmap(struct sti_pwm_chip *pc)
 {
 	struct device *dev = pc->dev;
-	const struct reg_field *reg_fields;
-	struct sti_pwm_compat_data *cdata = pc->cdata;
-
-	reg_fields = cdata->reg_fields;
 
 	pc->prescale_low = devm_regmap_field_alloc(dev, pc->regmap,
-					reg_fields[PWMCLK_PRESCALE_LOW]);
+					sti_pwm_regfields[PWMCLK_PRESCALE_LOW]);
 	if (IS_ERR(pc->prescale_low))
 		return PTR_ERR(pc->prescale_low);
 
 	pc->prescale_high = devm_regmap_field_alloc(dev, pc->regmap,
-					reg_fields[PWMCLK_PRESCALE_HIGH]);
+					sti_pwm_regfields[PWMCLK_PRESCALE_HIGH]);
 	if (IS_ERR(pc->prescale_high))
 		return PTR_ERR(pc->prescale_high);
 
 	pc->pwm_out_en = devm_regmap_field_alloc(dev, pc->regmap,
-						 reg_fields[PWM_OUT_EN]);
+						 sti_pwm_regfields[PWM_OUT_EN]);
 	if (IS_ERR(pc->pwm_out_en))
 		return PTR_ERR(pc->pwm_out_en);
 
 	pc->pwm_cpt_en = devm_regmap_field_alloc(dev, pc->regmap,
-						 reg_fields[PWM_CPT_EN]);
+						 sti_pwm_regfields[PWM_CPT_EN]);
 	if (IS_ERR(pc->pwm_cpt_en))
 		return PTR_ERR(pc->pwm_cpt_en);
 
 	pc->pwm_cpt_int_en = devm_regmap_field_alloc(dev, pc->regmap,
-						reg_fields[PWM_CPT_INT_EN]);
+						sti_pwm_regfields[PWM_CPT_INT_EN]);
 	if (IS_ERR(pc->pwm_cpt_int_en))
 		return PTR_ERR(pc->pwm_cpt_int_en);
 
 	pc->pwm_cpt_int_stat = devm_regmap_field_alloc(dev, pc->regmap,
-						reg_fields[PWM_CPT_INT_STAT]);
+						sti_pwm_regfields[PWM_CPT_INT_STAT]);
 	if (PTR_ERR_OR_ZERO(pc->pwm_cpt_int_stat))
 		return PTR_ERR(pc->pwm_cpt_int_stat);
 
@@ -605,7 +600,6 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	 * Setup PWM data with default values: some values could be replaced
 	 * with specific ones provided from Device Tree.
 	 */
-	cdata->reg_fields = sti_pwm_regfields;
 	cdata->max_prescale = 0xff;
 	cdata->max_pwm_cnt = 255;
 	cdata->pwm_num_devs = pwm_num_devs;
-- 
2.43.0


