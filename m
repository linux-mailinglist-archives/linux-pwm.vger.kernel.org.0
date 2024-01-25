Return-Path: <linux-pwm+bounces-978-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB33483C1D0
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6999D1F217BC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC8A3D99E;
	Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2952745025
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184653; cv=none; b=InSG2MrB4G7oxIUIuCeEIEhD8oYwuA5FjpflZ7DOgJenU0ZEL93iFA7pvPxMbz4ySbjZ0kgI0/AWpSKEwtBi0ea/ResgVQnuoEC1gjemwOLgLMeBVZbaR6a3UZsIwGB3SKFL1Tg7IJLaw6aztNYA2QGYPb+Xw+HFJ3u7sENvWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184653; c=relaxed/simple;
	bh=gjagr69awNqoHvBZmnbIudJKRh6O9+7pu8n9U9XHJ/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdLTsoWOqXXl6K7e+wx/QO77RqvYR75jgQivOHImIV70Pq1hCfSERci4cKh7x6wRXWTLaLzxrsDToGpWiYcAVYeIasOzrVfw8Ta1vaPlkA3YCqQ1E488IIilBal39hZDzYudNHgaUkUGUoouuNY5h43Cg1JNyh+kZEdEFF/vYtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZD-0003xi-P3; Thu, 25 Jan 2024 13:10:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-002HQi-7Q; Thu, 25 Jan 2024 13:10:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZC-007n0D-0V;
	Thu, 25 Jan 2024 13:10:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 032/111] pwm: tiecap: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:54 +0100
Message-ID:  <945bcab1ffa2d493afd0f360805dd16aa2b55154.1706182805.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
References: <cover.1706182805.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2801; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=gjagr69awNqoHvBZmnbIudJKRh6O9+7pu8n9U9XHJ/g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9fyC+439cPP+L+7Dmabf6vjK0ybDiC9sqDE SFPAiYK23OJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPXwAKCRCPgPtYfRL+ Tpm5B/9SPUjo7wxIU8zgxsMed61wnMEZrtef0HMcKNDN7d3Er2KY7Y/HHRIMUF4F1QTDH9k0XNS +ioH1+JMkYamK7QsF2vu2RfzmHjZYR0vUW0K/FhF+lxzb3VJYjCHow6sCvccYfMX/7OhjJrsvWA BXgZeAmLAh8IIi4cgi4ycS4kxsodpqxjIIRKGhP8uZyT2zgUFK11jSWWX4g38VOJhiZdS1gH0m9 xjsyyWH60cuyAmVSscUSHNCrXEqPXPQPSFCCpRSccl9iyMBLBXBCk7iEXgoLgzp101KuEFsh3af SeLgic/9OzpGB0Qa3bs94hNByLraKvFYZFLF6RpwzqU53WHd
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiecap.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pwm/pwm-tiecap.c b/drivers/pwm/pwm-tiecap.c
index d974f4414ac9..8c4f67774f24 100644
--- a/drivers/pwm/pwm-tiecap.c
+++ b/drivers/pwm/pwm-tiecap.c
@@ -70,7 +70,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		duty_cycles = (u32)c;
 	}
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -100,7 +100,7 @@ static int ecap_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		writew(value, pc->mmio_base + ECCTL2);
 	}
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -111,7 +111,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 	struct ecap_pwm_chip *pc = to_ecap_pwm_chip(chip);
 	u16 value;
 
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	value = readw(pc->mmio_base + ECCTL2);
 
@@ -124,7 +124,7 @@ static int ecap_pwm_set_polarity(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	writew(value, pc->mmio_base + ECCTL2);
 
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 
 	return 0;
 }
@@ -135,7 +135,7 @@ static int ecap_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	u16 value;
 
 	/* Leave clock enabled on enabling PWM */
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(chip));
 
 	/*
 	 * Enable 'Free run Time stamp counter mode' to start counter
@@ -162,7 +162,7 @@ static void ecap_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	writew(value, pc->mmio_base + ECCTL2);
 
 	/* Disable clock on PWM disable */
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(chip));
 }
 
 static int ecap_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -271,11 +271,11 @@ static void ecap_pwm_remove(struct platform_device *pdev)
 
 static void ecap_pwm_save_context(struct ecap_pwm_chip *pc)
 {
-	pm_runtime_get_sync(pc->chip.dev);
+	pm_runtime_get_sync(pwmchip_parent(&pc->chip));
 	pc->ctx.ecctl2 = readw(pc->mmio_base + ECCTL2);
 	pc->ctx.cap4 = readl(pc->mmio_base + CAP4);
 	pc->ctx.cap3 = readl(pc->mmio_base + CAP3);
-	pm_runtime_put_sync(pc->chip.dev);
+	pm_runtime_put_sync(pwmchip_parent(&pc->chip));
 }
 
 static void ecap_pwm_restore_context(struct ecap_pwm_chip *pc)
-- 
2.43.0


