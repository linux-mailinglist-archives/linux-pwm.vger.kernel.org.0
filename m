Return-Path: <linux-pwm+bounces-706-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD59828EF0
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 22:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BADD1F25C73
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 21:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FBD3DB81;
	Tue,  9 Jan 2024 21:34:52 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A6A3DBA8
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jan 2024 21:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-0006co-R2; Tue, 09 Jan 2024 22:34:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-001Z29-2w; Tue, 09 Jan 2024 22:34:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkB-00667s-01;
	Tue, 09 Jan 2024 22:34:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Robert Foss <rfoss@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/5] pwm: Fix out-of-bounds access in of_pwm_single_xlate()
Date: Tue,  9 Jan 2024 22:34:31 +0100
Message-ID:  <243908750d306e018a3d4bf2eb745d53ab50f663.1704835845.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
References: <cover.1704835845.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=884; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4ZYE4l67ASdyUFwT+NrxBsn0JJkwlJxIMxVpeih96FI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnbvpzMxu0sK+hAGiHzjvnoFb4iQRi8FFyRE2I LoXFiSe6OSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ276QAKCRCPgPtYfRL+ TgzvB/9fosz6sMqrHSsKRRcnQ7zCXvWzi+LsGmE6u7HrUfdg+7i0mGW9UNA6kVTqbX0zGf1o5nA aoKepPmD1iw2V72MUOBdO5p1hOZ43OMxGeGjoRfJ/zzjaQwIZ3BQgublAFYVhvrwMdU4ZzgOSJY HSSITvBaY5HZOHfwz6GufOKwly1tos/MVI115xsTrfkKyp+NKWacKYgJKiKhYXQA1d6ueXuKzf3 FLOVqmL4733KoV370LV4gVD56jOgwmq076XXrAMbA4px1n5eiTg78vZULDXkRJ12QXngnRz+6GG +5sT86NukrbhCBaYAilUKyYUYkLwywMh5dIXZ4wMkwtbqnpE
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

With args->args_count == 2 args->args[2] is not defined. Actually the
flags are contained in args->args[1].

Fixes: 3ab7b6ac5d82 ("pwm: Introduce single-PWM of_xlate function")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9a4c720c88aa..f2728ee787d7 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -152,7 +152,7 @@ of_pwm_single_xlate(struct pwm_chip *chip, const struct of_phandle_args *args)
 	pwm->args.period = args->args[0];
 	pwm->args.polarity = PWM_POLARITY_NORMAL;
 
-	if (args->args_count == 2 && args->args[2] & PWM_POLARITY_INVERTED)
+	if (args->args_count == 2 && args->args[1] & PWM_POLARITY_INVERTED)
 		pwm->args.polarity = PWM_POLARITY_INVERSED;
 
 	return pwm;
-- 
2.43.0


