Return-Path: <linux-pwm+bounces-965-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803FD83C1C5
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A304290BB6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D43AF3A27E;
	Thu, 25 Jan 2024 12:10:48 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF332C92
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184648; cv=none; b=Soou3jODiRDLhYzFidwKRifCarAoBFvs0TrW3ahsu4jTK1W4Z+CsHRPRyT9QQpR6g9QNx78KFNW46aKMRIv/cMp9ilZQfjiJtIVh9+EvBd3QhzLuhAi9DAiKr+Ppgm35Neg5R3Ej9oy/3BkV9kGbpKoMSJDiYLjNziKXHKb+UTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184648; c=relaxed/simple;
	bh=0dQgcY2HF1eIjp3vD8TcbyUnDhEvbLPvWkzK9X+p9bc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJ788Sq3/sZWtMzpLmMT6S9bDGSEdAOW6XoFiBO44s5zM/BFlhw7uxuXZT7urVvn2joR/SlX5vgAY3k6Ob8eOK3IsavK1TGQlblUPF1QUlsz5NDxd11c/xbdoZABqSpnWZAIiXzXbHjyt097LM54jZCrfqVMdbh2LAgrwCgnXyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZB-0003kQ-1u; Thu, 25 Jan 2024 13:10:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-002HQE-KZ; Thu, 25 Jan 2024 13:10:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-007mzh-1n;
	Thu, 25 Jan 2024 13:10:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v5 024/111] pwm: rcar: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:46 +0100
Message-ID:  <d97349209a2bf06bb2573a25baa9c8729894bb54.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1007; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=0dQgcY2HF1eIjp3vD8TcbyUnDhEvbLPvWkzK9X+p9bc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9V0DGRT0LBvbfDAJn54a8VNHgeOT35QNTPT JmsSPeg/ySJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPVQAKCRCPgPtYfRL+ TtkfB/9zbM0BGRbBWM5L6nbdTyz2PgKO0lbtImuv+7Eyp6teXt+s81LjizQQNk7a7ET/8fu2u+B GCqAmlyzrAYOlEbhbJvhcwcLnz3C2lHbtu8FkKJv4JIoaRpwyrhmAi4KWVhMYyNiJgIz/iaOz5L jZHxkxwjYLamwSbxA9N+zvkdToSGpuFj84Ekvv5Yp1vbnIXg7+V/6/mYNrVLqeFT5aIkoZHLZu9 cM30gktPEGMMwvhH2Y22I7CjLn0u6FRIdrJJnDwIuA3yH8hQb5ZQDAwxpLsl9AU9vCjcoAdVXFm ljrajjByIYSnb7g2CA/tyS20UGBUItl4o5sZTVHhHwcVj0aJ
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
 drivers/pwm/pwm-rcar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-rcar.c b/drivers/pwm/pwm-rcar.c
index 13269f55fccf..4838762137d1 100644
--- a/drivers/pwm/pwm-rcar.c
+++ b/drivers/pwm/pwm-rcar.c
@@ -132,12 +132,12 @@ static int rcar_pwm_set_counter(struct rcar_pwm_chip *rp, int div, int duty_ns,
 
 static int rcar_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	return pm_runtime_get_sync(chip->dev);
+	return pm_runtime_get_sync(pwmchip_parent(chip));
 }
 
 static void rcar_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	pm_runtime_put(chip->dev);
+	pm_runtime_put(pwmchip_parent(chip));
 }
 
 static int rcar_pwm_enable(struct rcar_pwm_chip *rp)
-- 
2.43.0


