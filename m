Return-Path: <linux-pwm+bounces-1364-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E38E88545B1
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233C01C26EAE
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D0BD18028;
	Wed, 14 Feb 2024 09:34:34 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E4514270
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903273; cv=none; b=tznEJF7zOWLjNPn1pvR6BtDHCsckJjFWU8QIOUrNdv9mcO7hyYUIBHL2uGOr76HxBSDJ4Qa6iSnsiKPwmfpEtihWFeRhAcX4x087qGUMJfaCC7nI+Vgl3sfFNoUSNt9AmI085Mdb+coarAD+/XlGFsVyoquFhly04qS7z4waeAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903273; c=relaxed/simple;
	bh=Vi/5iWnBUnxr5Ov9Ah27dU8gNF91Cuh/pFOZC0M+m/U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NTDgBI6xG+rMmzz2ZJAxAFurn6sWyXMGSDVCsuuFt6EFLUgqLpIODJMP/uIwoIsHD+A4OpRNEsGQBJ1jONGDg2qRt4PCzVCOI2PcJoRp5Ls6hCSJbKamZYymq7FutYahuZeD0cIaqtkPYvV0KVSzrGeFUCrx6Ln9WfGlwdP6Flc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBet-0004o0-VG; Wed, 14 Feb 2024 10:34:27 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-000fC4-Td; Wed, 14 Feb 2024 10:34:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBer-004Y3B-2i;
	Wed, 14 Feb 2024 10:34:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 052/164] pwm: iqs620a: Create a wrapper for converting a pwm_chip to driver data
Date: Wed, 14 Feb 2024 10:31:39 +0100
Message-ID:  <cc7ab547b4c4b79456b548aa72205bcf4476db8c.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Vi/5iWnBUnxr5Ov9Ah27dU8gNF91Cuh/pFOZC0M+m/U=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtQzHW2MR2qu5qYm+bGqqzG2BTJXFyabaB9K44hdw6b2e JKqd3cnozELAyMXg6yYIot945pMqyq5yM61/y7DDGJlApnCwMUpABPJkmL/79m04/1EjhPTZbdM nb+x0nzlqqd7qqw2iK4/cOfA0bkZy9J/82RNk3Tw7wzdsNuwr/ZVz8HY7BPnfO78mvVzw3pR6fP RbgU/V25c3qDt3XV+0+dmjmMCLtb3ufsMJr2fzlMQsWBK893J7vkp1z5+YFxllRF/RPLA5WWHtX 83BTbYbclcFLH+xuefVkXz5kt+CGGOY3r67/o0Lydtngs+77gO+JuGVJvpbWQoWGNjIVHcos3TX TNHRehaeWv+bl7r4H6W0ISmPZn7ZN5+nceqwZMsPEN8h4adVUD1u0tSDhFFi7TZbOU8nU+3xP7U ELXj/K0wn7nna/MHxX8OPnsP2Ox9xfWIy+P0yuxzcfx5AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is no semantic change. The new function just implements what was
open-coded twice in the driver before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-iqs620a.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-iqs620a.c b/drivers/pwm/pwm-iqs620a.c
index 378ab036edfe..98008cae6d70 100644
--- a/drivers/pwm/pwm-iqs620a.c
+++ b/drivers/pwm/pwm-iqs620a.c
@@ -40,6 +40,11 @@ struct iqs620_pwm_private {
 	unsigned int duty_scale;
 };
 
+static inline struct iqs620_pwm_private *iqs620_pwm_from_chip(struct pwm_chip *chip)
+{
+	return container_of(chip, struct iqs620_pwm_private, chip);
+}
+
 static int iqs620_pwm_init(struct iqs620_pwm_private *iqs620_pwm,
 			   unsigned int duty_scale)
 {
@@ -73,7 +78,7 @@ static int iqs620_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (state->period < IQS620_PWM_PERIOD_NS)
 		return -EINVAL;
 
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	/*
 	 * The duty cycle generated by the device is calculated as follows:
@@ -109,7 +114,7 @@ static int iqs620_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct iqs620_pwm_private *iqs620_pwm;
 
-	iqs620_pwm = container_of(chip, struct iqs620_pwm_private, chip);
+	iqs620_pwm = iqs620_pwm_from_chip(chip);
 
 	mutex_lock(&iqs620_pwm->lock);
 
-- 
2.43.0


