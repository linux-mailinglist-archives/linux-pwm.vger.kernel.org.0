Return-Path: <linux-pwm+bounces-1440-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09890854604
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD29E1C22108
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7447614000;
	Wed, 14 Feb 2024 09:34:51 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3D31AAD8
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903290; cv=none; b=GfDATrrMh2DpjaPSKMB5OBJ6i8PP1jGOZ+WtYddB6WCVV6WAWBis8yyrK5SsfioHgSLM6CvvXjV5O7yM/NoI6HI9p9UYJ1UcM/6+8GtDheGm6Bi8/G/TXPGSYc1foGXNfbH55zMk6ctj7V2hiW1WWWx1e2KfzPFXCEKf/WvxaZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903290; c=relaxed/simple;
	bh=9pbYq/JqWHgeRvzUqud4LTAjbUNCWE/lCmwu6JWthEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FakMsNwZhsPDBXMdiQGI9HWrcWchKUkUhitXw5xr9Xen5mIT4njTARuSgYnEIZf7o+fyGdX+I96DocbmQpxbjqWqObK5oUfsoS6jfnIYkFnX6n5GKaMTIAQ3gMFMOjxZJRXjBDgtR6phuY6FE584XHGQiTbIFBHDkR1jncLNPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf8-00062Y-Tr; Wed, 14 Feb 2024 10:34:42 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-000fHC-N2; Wed, 14 Feb 2024 10:34:38 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBf4-004Y95-24;
	Wed, 14 Feb 2024 10:34:38 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 136/164] pwm: tiehrpwm: Simplify code to determine the pwmchip's parent device
Date: Wed, 14 Feb 2024 10:33:03 +0100
Message-ID:  <b2b06a3aabf8c04969d59ddf7ba565b303855878.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=900; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9pbYq/JqWHgeRvzUqud4LTAjbUNCWE/lCmwu6JWthEA=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIjn/o1KfOZ9oEKsQKEtn6iNap3LnTjWydxuO YAj27o714eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyI5wAKCRCPgPtYfRL+ TgkXCACE0ZZcgcLBSmE5Mi+L4fHIHboualcQvXqECTqOvDJJetztqZxGn3gB9tSHLItrTXd3bCO /QKBsOcYDgsKnv34A9t6h1dXUMpfiew/9G9FF/NxlnrSJplx1HyQoAyxtryySSeTORzabDgZvht ds1aM/SVvGzXueV3wYhS3vNuIvLdQ4CnbKXrFKXa17CWcYuV6lMTVpXNsHhJQ8J+1gdzS/IpVDX oiRvqkLepNtStJWtJcZECXB5jVnlisV4MqNjmiDtkVqCWdpc+bzdkGwMI1RTMRfA0HQ5M76MH5e deceE8RcOlvWfbmP8pfqr3J4OAbgjYR43eDYVPRqn6XyOdzY
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

There is already a pointer to the pwmchip, make use of it directly
instead of using the struct ehrpwm_pwm_chip *ddata just obtained from
it. This also has the advantage of not using struct
ehrpwm_pwm_chip::chip any more which will be dropped soon.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index af231fa74fa9..9848493dee97 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -347,7 +347,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s: %d\n",
-			dev_name(pc->chip.dev), ret);
+			dev_name(chip->dev), ret);
 		return ret;
 	}
 
-- 
2.43.0


