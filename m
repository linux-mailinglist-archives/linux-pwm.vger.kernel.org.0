Return-Path: <linux-pwm+bounces-968-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B6883C1C6
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 13:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5A3290DDC
	for <lists+linux-pwm@lfdr.de>; Thu, 25 Jan 2024 12:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF43F45020;
	Thu, 25 Jan 2024 12:10:49 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5364439F
	for <linux-pwm@vger.kernel.org>; Thu, 25 Jan 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184649; cv=none; b=f4ysTtPKzdcuEQdzHhGFTcpLVUAuK4IvqT39RYA7rjw7ogPQA1fpjJT4O8A3mAy0EpVvxDBSfzzK7pBMgUHKjOwm43BsowZqIslCkNp14VnnC1n7lPyNLbAB2It3XOqWZB0GBls7a73++vt8HCG9RIOWL7B6rbcsheO0CKgtGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184649; c=relaxed/simple;
	bh=2my+KTISTjKr4blFD22AL+yDfNEk1kSQLWB/RlEBkzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dOIAtg7v5o4VQik2j2eS2TN62r0BrR8/pBkckKnPp37TzI55EWADbVmJ6ZpKuQVYZmWWyA925H+pv/UxU+kevkKfoKKNK1dWWBRvIltyxsdSzirRDT4Ux50If7c3AwlyhLk+4KwIZEdX8r/SF9yfyTQv6717IvhU4pdgn5+JNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZA-0003jN-7m; Thu, 25 Jan 2024 13:10:44 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-002HPy-R6; Thu, 25 Jan 2024 13:10:43 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rSyZ9-007mzR-2N;
	Thu, 25 Jan 2024 13:10:43 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH v5 020/111] pwm: mtk-disp: Make use of pwmchip_parent() macro
Date: Thu, 25 Jan 2024 13:08:42 +0100
Message-ID:  <0ebb99812e0d563437d2cdb8d980e89461e28a6d.1706182805.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=2my+KTISTjKr4blFD22AL+yDfNEk1kSQLWB/RlEBkzo=; b=owEBbAGT/pANAwAKAY+A+1h9Ev5OAcsmYgBlsk9RzviGTen8OjNSCvRF2x6ld2MV3ea52eNvR wOwyTtOPAeJATIEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZbJPUQAKCRCPgPtYfRL+ TommB/jA5Z6pZ/uA1Ye/QbFGhQsZEg4kXPITCIu9yH6QU3WHNF+nB93lX9TnTRKgv2PL8CHAxvw Fes6xRHy3yEqA+QBzVQP1rv/cBLA3hLxQeOvzyDxgQBBPSPEGw/KRG8ngkorYRQ0q6n3yk6bzbO vM14u1uKpaTXB0u/qkmY1X3+K9iQbPKcQeQ2NR+4Y7k6vQx8LuTQwfn+gjiPde9G5rRkTEH2dzN p/zMD/bW/DPn9TkUE9ZAKWQvSK59b5iulGBSob1qsb/IbxnaHutm9Nq84pRjts+gEBKgaR74Ajs VgxaS1rKwiBjBLXbkIFmHydOquk/GAZvEAZLSiOzik0hHr4=
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
 drivers/pwm/pwm-mtk-disp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index a72f7be36996..186aa5c04435 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -91,14 +91,14 @@ static int mtk_disp_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!mdp->enabled) {
 		err = clk_prepare_enable(mdp->clk_main);
 		if (err < 0) {
-			dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n",
+			dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n",
 				ERR_PTR(err));
 			return err;
 		}
 
 		err = clk_prepare_enable(mdp->clk_mm);
 		if (err < 0) {
-			dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n",
+			dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n",
 				ERR_PTR(err));
 			clk_disable_unprepare(mdp->clk_main);
 			return err;
@@ -181,13 +181,13 @@ static int mtk_disp_pwm_get_state(struct pwm_chip *chip,
 
 	err = clk_prepare_enable(mdp->clk_main);
 	if (err < 0) {
-		dev_err(chip->dev, "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_main: %pe\n", ERR_PTR(err));
 		return err;
 	}
 
 	err = clk_prepare_enable(mdp->clk_mm);
 	if (err < 0) {
-		dev_err(chip->dev, "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
+		dev_err(pwmchip_parent(chip), "Can't enable mdp->clk_mm: %pe\n", ERR_PTR(err));
 		clk_disable_unprepare(mdp->clk_main);
 		return err;
 	}
-- 
2.43.0


