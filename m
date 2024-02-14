Return-Path: <linux-pwm+bounces-1445-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6EDB85460C
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9149428A8BC
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EB9414A8C;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D101B943
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=B05wq4EBBX3c0RYuB6uQfRDVr5RFqG6auOZxjdsqthX2KcLdKf6Pyds0H2sKjs11+zGraVVy6UmgE5GBrwKt9DSu3RDuwE6tWIyOWCGRu69PYOuBiH9ecIPt7b1C1vRVR0Rle369Hq6JtzydTy24dQXCGOdnu48ytUwg1i3lcMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=3B/r01Rwt+UpfKUdprpNwpdkLZbZZF74SsJaxMTgaIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BIFU7xttoIzMee/9GbubEjVoDgJbEP5PfUL5c9wsOkkIahJkVRNGQtOwc49Kk4BnUnolJFqwupFVWbA2wUkUm5kgdI4QousL9TS2aPSpmsNa6WJWnqSzwGT4pL/6Z3y6Gk5yCxyECpqxDLY2I8hehDfeJ54UQh+k3mwmeLVrPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBfA-0006A1-G0; Wed, 14 Feb 2024 10:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-000fHs-DH; Wed, 14 Feb 2024 10:34:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-004Y9m-15;
	Wed, 14 Feb 2024 10:34:40 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH v6 147/164] pwm: vt8500: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:33:14 +0100
Message-ID:  <c3c45a08f2ccb8bb13b4042c73f93064876586eb.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1440; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3B/r01Rwt+UpfKUdprpNwpdkLZbZZF74SsJaxMTgaIQ=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjzD/xlcSPQXypy6w9oOawV6+HN83LLUeSew mwiR7QytKOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI8wAKCRCPgPtYfRL+ TunzB/0aK/XGscWyd87L1OKzi3lKLC4rIHujMBlVR5nG42obyi6agVhWVRHI9os/Gx8D6MZtOkB SzNwW6mA40v8ZnRLhieHRooWW8o6WMglcBTRnTtNK9zhc7vXpaINmljRAyKRHpK7BpjcKk7oVYk LUDet1UiPmGfwxsrkxD8pi4W95t0HJvlI+F690wQuA1oYhkdtOvEBqMHncZL57VugKKPb2Yonu6 uJzGuSEQ8NHHzESwObNmMJ8ghos7NNSzoc+/9tgjeEUMtC7U38RtZL6k73vcxku1cDgmvhKVpdV jS6rJVtmuw0OeApoaTQWwSWm62s4vHo7WF1NqI3zJP+wg3tu
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
 drivers/pwm/pwm-vt8500.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-vt8500.c b/drivers/pwm/pwm-vt8500.c
index 6da9b8f88afc..fb4dbc88b0a3 100644
--- a/drivers/pwm/pwm-vt8500.c
+++ b/drivers/pwm/pwm-vt8500.c
@@ -63,7 +63,7 @@ static inline void vt8500_pwm_busy_wait(struct pwm_chip *chip, int nr, u8 bitmas
 		cpu_relax();
 
 	if (unlikely(!loops))
-		dev_warn(chip->dev, "Waiting for status bits 0x%x to clear timed out\n",
+		dev_warn(pwmchip_parent(chip), "Waiting for status bits 0x%x to clear timed out\n",
 			 mask);
 }
 
@@ -78,7 +78,7 @@ static int vt8500_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
 	}
 
@@ -129,7 +129,7 @@ static int vt8500_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 
 	err = clk_enable(vt8500->clk);
 	if (err < 0) {
-		dev_err(chip->dev, "failed to enable clock\n");
+		dev_err(pwmchip_parent(chip), "failed to enable clock\n");
 		return err;
 	}
 
-- 
2.43.0


