Return-Path: <linux-pwm+bounces-1438-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C41854607
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59A251F2E11A
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BC913ADB;
	Wed, 14 Feb 2024 09:34:50 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99D1B28D
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903289; cv=none; b=Z+u5T6icvI7jtSS7oBUkzDefXKoeHiTdQSn9pr5giUuPfwNqgigJHQfZD/MXQSPJlaifLbA8fWosp6Qj8ZMEqZ3XjuB1xuy2Xq4lFDEtLuZ1emnKmodl2QXIifO6JddGFfhohjDR2397DL5EYQXvixaU+sfFJap3+U0VLgEnmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903289; c=relaxed/simple;
	bh=3dVqSmhY8p5H+vr5Gl/jpAORwwjUu1lh7OQVl0sdU+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pX2AROtov30lohQaUbVpO6IHVSbnOxZsgUFGWtzvcsYySJQ/sMoZtmiyPdlSoIDmGpYcptFkkQSkinctGA9wxHz00luhNYI+4ZhcQyUJ65P/pND8bLjbIztlJ64hxn1n7Q7k9bmoj5TpoCBSuBL4GgIUjjASwTk3q1ncmT6ih5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf6-0005rz-Cf; Wed, 14 Feb 2024 10:34:40 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-000fGP-Uu; Wed, 14 Feb 2024 10:34:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf2-004Y89-2q;
	Wed, 14 Feb 2024 10:34:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v6 124/164] pwm: sun4i: Make use of pwmchip_parent() accessor
Date: Wed, 14 Feb 2024 10:32:51 +0100
Message-ID:  <3ddaec73f3abefb45625d0a469026fa8d13da8c0.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3dVqSmhY8p5H+vr5Gl/jpAORwwjUu1lh7OQVl0sdU+s=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjZypwfClaOc9oFVyhz5spcDbeQ2oihX1A+s j7YGaJjb8mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI2QAKCRCPgPtYfRL+ Tst6B/9ab8tf00wMOOj6CQrwM/ghrf+e8czin3fZ3LSlb8g0UCyvYthJlcVRsfrGN0DYiTOVB61 l0WLagICH4i0mF0CBmpJX2JBLMAsAEdTDX5X1npWQ4to/QNVXPu/QCL847a3XxFuTYAwau5pJyh usUbdxiWL5HGFq0m9KcZFglndGeebUVfJaVNcu3kRaYhZf0dIhxSRxLMgKIzT6EdMwJyC6IxRsH dWfYvIOTyMiAhEKbhH6493GDcjLh/7rY4bG5eUPjrgKn8csvGUPAS5o46sgxizlHUFj9qlgQ9xm iqHvvMgpCAXL0xfFITkns0xKrmRojp2HZEWMl9auqKtZt5Jj
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
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1a439025540d..44edf1ce5739 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -245,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
+			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
@@ -253,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
-		dev_err(chip->dev, "period exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
-- 
2.43.0


