Return-Path: <linux-pwm+bounces-704-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBD9828EEF
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 22:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 725251F26012
	for <lists+linux-pwm@lfdr.de>; Tue,  9 Jan 2024 21:35:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B584A3DB9F;
	Tue,  9 Jan 2024 21:34:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A03DB86
	for <linux-pwm@vger.kernel.org>; Tue,  9 Jan 2024 21:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-0006eB-RZ; Tue, 09 Jan 2024 22:34:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-001Z2N-Et; Tue, 09 Jan 2024 22:34:44 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rNJkC-006688-1E;
	Tue, 09 Jan 2024 22:34:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 5/5] pwm: Drop duplicate check against chip->npwm in of_pwm_xlate_with_flags()
Date: Tue,  9 Jan 2024 22:34:35 +0100
Message-ID:  <b06e445a6ed62a339add727eccb969a33d678386.1704835845.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=805; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=lrOgNpDOKw5peW48I5RJHjVP7X8pPhO/YLk/1R9pics=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlnbvuzVfwnHAZcdpV5HQgMOLxibtXQ/iI/xLot hFcpm+CyPqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZZ277gAKCRCPgPtYfRL+ Tn6iB/4+vfdx6nRH3s3eaXFx91zLoK+uNyHIEGVwPpSHu38cGqyKrkJDnXKf+okyl5R8ydTpRYG NBrwEbucx9nfEHBbNsjRtAr9J5P+aMYx3a81hP4/G6tGzqFf7Ja1aJzMrBIGH+D7y27/lagxjWG a0z4tbERNN8GfQw5qp3mX0dRTT4sNoLrA1nL2/jAl95mnOYGghTkypikuS/D6Xn1ELsRRyRlbxz L69an777lXFZGZse8peLX9s5wdTCdN6ED/vRB0cUY6cZf7ZTYYHS//6t2UfXqyB2z4Bzf++1a6o XBRxz31Nxs4NjyxGtLkoN2iIZKnZU+KQ1wuUBCdZdH/J1JOU
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

args->args[0] is passed as parameter "index" to pwm_request_from_chip().
The latter function also checks for index >= npwm, so
of_pwm_xlate_with_flags() doesn't need to do that.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 606d9ef0c709..b025d90e201c 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -111,9 +111,6 @@ of_pwm_xlate_with_flags(struct pwm_chip *chip, const struct of_phandle_args *arg
 	if (args->args_count < 1)
 		return ERR_PTR(-EINVAL);
 
-	if (args->args[0] >= chip->npwm)
-		return ERR_PTR(-EINVAL);
-
 	pwm = pwm_request_from_chip(chip, args->args[0], NULL);
 	if (IS_ERR(pwm))
 		return pwm;
-- 
2.43.0


