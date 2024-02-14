Return-Path: <linux-pwm+bounces-1373-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12FF18545BD
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 10:35:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6DDD1F2E047
	for <lists+linux-pwm@lfdr.de>; Wed, 14 Feb 2024 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADE4182DB;
	Wed, 14 Feb 2024 09:34:36 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC651175A7
	for <linux-pwm@vger.kernel.org>; Wed, 14 Feb 2024 09:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903276; cv=none; b=W0hqDV/WbagIf7ES7yCZjztPhj2zw1IwUM9qYL0Gr/kxMZOoEuUguZrEl1xUuUXOA1ypuJYE7+IbaTj8ky/D3TiDmWN2m8oRcv3jgm+ejR7oLT4ph0tr4DQpTDp/QLzbriD24NyjFMirBk9AYfT3I2JGlrg5V3SerrQrcHHgYr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903276; c=relaxed/simple;
	bh=LIQAqKb+HhBtdctfiQ8f98Tg2rvOlbDVy9CesJRwQFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1HfaQ7acRl8r1TDBV+lgWhhBpMv+JrkLb68nI+D111jnFSHgmvoM/fimy3BoSBRPVaf1rlwg8idV5TXY0xKSzD8NesQhyOMjQcWQsc/6Y80mhed/xmvNifGLSy8y6mTE+CixNGH22IwQNDRxKJDn4iE5j6KEvQy7SWgOvvipFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBew-00050i-1r; Wed, 14 Feb 2024 10:34:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-000fCq-4K; Wed, 14 Feb 2024 10:34:28 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1raBeu-004Y45-0A;
	Wed, 14 Feb 2024 10:34:28 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de
Subject: [PATCH v6 066/164] pwm: lpss: Don't set driver data
Date: Wed, 14 Feb 2024 10:31:53 +0100
Message-ID:  <25671b7562d96b67fd05b3fa6fc76538ddf5914f.1707900770.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1308; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=LIQAqKb+HhBtdctfiQ8f98Tg2rvOlbDVy9CesJRwQFg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlzIiWFMnyxzy5aNY9b/GMSZoW3ZH8PMZ1XtwDk z+SZgMRhzOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZcyIlgAKCRCPgPtYfRL+ Tse5CACyXGyyY1G/CPRF5s+2JO4yXTyjpfion8LcBZKlSxFu8wG2kceW7nuh5dU2MZEt+ZKp6cT JltVwjVAcKKEk9VBjTMxTyMuFsDmX/MUL+rn48nx9Zg1Kla4pRLvYEuZEa+ayLyOqrkSduMH5PN yoWE845bFx4zUVY9dvkHvCtfkI9m/gsE+XLbRtHwUUD0dbqSzg9pYOjaZGc7kGBXqsZlF9fIh2F JTbDzCjrgwR4rYYpmgsnQPP6OfN3kwYG6eOt49RBl1R5VBJqImErcxzWyLyDoyrJncaFGgy8++T auTdcrBkturqdZkhOoLeEsk+/z1Hrz71KJ5rLgh+PE83zYb1
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

The drivers don't make use of driver data, neither in the variant
pci_get_drvdata() nor as platform_get_drvdata() nor as
dev_get_drvdata(). Drop setting driver data accordingly.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-lpss-pci.c      | 2 --
 drivers/pwm/pwm-lpss-platform.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index b4134bee2863..34acfe99b74f 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -34,8 +34,6 @@ static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
-	pci_set_drvdata(pdev, lpwm);
-
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_allow(&pdev->dev);
 
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platform.c
index 319809aac2c4..5f6ee300e342 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -35,8 +35,6 @@ static int pwm_lpss_probe_platform(struct platform_device *pdev)
 	if (IS_ERR(lpwm))
 		return PTR_ERR(lpwm);
 
-	platform_set_drvdata(pdev, lpwm);
-
 	/*
 	 * On Cherry Trail devices the GFX0._PS0 AML checks if the controller
 	 * is on and if it is not on it turns it on and restores what it
-- 
2.43.0


