Return-Path: <linux-pwm+bounces-1741-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D587772D
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 14:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 993981F210D2
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Mar 2024 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF462C68F;
	Sun, 10 Mar 2024 13:47:38 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C261E504
	for <linux-pwm@vger.kernel.org>; Sun, 10 Mar 2024 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078458; cv=none; b=DVyKFhnUHNk5dAivPBxX4/g0QjcV91Pa056CNK9LedzHHRyqHp1cMRsXlyjK4eAaU2s1LZfOnIajFiABujguk7OswH6jjlr5gplGbZkXUez7SW9rQN879u2lFb02CsMca86hYek2+FDonkzbCb43kFJCJi997iY83FNCqi35Xm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078458; c=relaxed/simple;
	bh=1cQj6Ag0jrBOXVCE38wZhXvNBhBM4U8Erlz9YqBqJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AwdO8D4vyejtYoJ5P7Dm3bAKD4dfDybNopSIaAmtWvhOMhz0UOzl+DCIwGPB8M8B46d0GS+XrF+a9+naETLI7ebg/0lvpx3B+MMyhmzSPGfb5H0USeuM6AKTemBiXIrZJOZ/QDwkg46PdyWTQgi4/1BH1NbhXeq6Gmz4UT8rAhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWT-0000uh-TV; Sun, 10 Mar 2024 14:47:29 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWT-005WrE-3H; Sun, 10 Mar 2024 14:47:29 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rjJWT-003SJz-02;
	Sun, 10 Mar 2024 14:47:29 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>
Cc: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	linux-pwm@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] pwm: bcm2835: Drop open coded variant of devm_clk_rate_exclusive_get()
Date: Sun, 10 Mar 2024 14:47:18 +0100
Message-ID: <cover.1710078146.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=612; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1cQj6Ag0jrBOXVCE38wZhXvNBhBM4U8Erlz9YqBqJF0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl7bnofps4ikn0+D+/sH3BOXnWeaqJmknZNT+ET B+GpZMu4dmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZe256AAKCRCPgPtYfRL+ TmJmB/0WZlnYt3D5+31AjrsqNWjTUBSepPeWmoW1bYIyx7tmG5HYLBG3VySKhuBUhi5jCy91rPK 65+8zquvHb1G+sTdRrfaXR90TTz5m2u+Qef/YuMEVraykBrruWV9Z62nMZ/PXmfHsxTH2mxY6GT wYsRO0evppKlyvI+L0sLRzDhuUHPMPQ2HP+2qjJjyjSq+ixtuXLgDsbDHlUflHErWLur2mMbWjg ZzczbJuMAj5CP2RgAdcdTAvnFHvtSYcmwjmalKSBuLa1gIIuTTT9RjAM3Hlugbfi0RgpOGCNfsV DBh0TcP9OgJ/Kx1pSxB5vASxAJ4MDl/Jw+19dVZS9/ynmRFv
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

the main motivation for this series is the 2nd patch. The first is just
a minor simplification. Note this series depends on
b0cde62e4c548b2e7cb535caa6eb0df135888601 which is currently waiting in
next for the upcoming merge window.

Best regards
Uwe

Uwe Kleine-König (2):
  pwm: bcm2835: Introduce a local variable for &pdev->dev
  pwm: bcm2835: Drop open coded variant of devm_clk_rate_exclusive_get()

 drivers/pwm/pwm-bcm2835.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

base-commit: 8ffc8b1bbd505e27e2c8439d326b6059c906c9dd
-- 
2.43.0


