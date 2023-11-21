Return-Path: <linux-pwm+bounces-100-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39287F2FB5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4AE11C214A2
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C255381E;
	Tue, 21 Nov 2023 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2543110CB
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:10 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAe-0006gw-Nm; Tue, 21 Nov 2023 14:52:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-00Ab33-DT; Tue, 21 Nov 2023 14:52:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAd-004xi3-4G; Tue, 21 Nov 2023 14:52:07 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 104/108] pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
Date: Tue, 21 Nov 2023 14:50:46 +0100
Message-ID: <20231121134901.208535-105-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1726; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=+O+bCik7etnHLWChYOuvB08+f7dCmsF5JXGY9Vl6V6g=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLW//zrj+QS6TjBVRYo8E8OetEIKLfyAeHC7s Q+zVOn+q9KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1vwAKCRCPgPtYfRL+ TqpgB/48OEzJDii3x1FKee8DmUV36F+TPn0Fnl+F/jGkJ7MSYwVqT9aiBP2m+pLPA//6XL9Bh4b ATi0yMgfPwoxVw2EkXRTBB3e5OoXM6w7ebrbKLCBeY0VnJRgmDEDYgVafgdX/3OZEFTZ8/oJYl7 Y7XQxc7pGhBNI17yQr/ST4T8Gjd8RJXvmxt9nIoIOmfSQwCnFlt78hJr8WQwtXe7hUYVISXwTzE /iNi23ZeLzxVeh3pPenhAU5dB5VOwS7bBwBNfTLrB3juAn6KJ0Le7nhhZHp9SG7Xx/vKwLLGz76 yr+k2bbsJs02/niymLsx9c2FAPlnOqQ/sBSpwbBQq2fMTAIf
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Memory holding a struct device must not be freed before the reference
count drops to zero. So a struct pwm_chip must not live in memory
freed by a driver on unbind. All in-tree drivers were fixed accordingly,
but as out-of-tree drivers, that were not adapted, still compile fine,
catch these in pwmchip_add().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/core.c  | 10 ++++++++++
 include/linux/pwm.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 0346709b60d8..15942210aa08 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -215,6 +215,7 @@ struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, si
 
 	chip->dev = parent;
 	chip->npwm = npwm;
+	chip->uses_pwmchip_alloc = true;
 
 	return chip;
 }
@@ -238,6 +239,15 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
 
+	/*
+	 * a struct pwm_chip must be allocated using (devm_)pwmchip_alloc,
+	 * otherwise the embedded struct device might disappear too early
+	 * resulting in memory corruption.
+	 * Catch drivers that were not converted appropriately.
+	 */
+	if (!chip->uses_pwmchip_alloc)
+		return -EINVAL;
+
 	if (!pwm_ops_check(chip))
 		return -EINVAL;
 
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 3c62cf329ee0..b8e70ee01d31 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -301,6 +301,7 @@ struct pwm_chip {
 	unsigned int of_pwm_n_cells;
 
 	/* only used internally by the PWM framework */
+	bool uses_pwmchip_alloc;
 	struct pwm_device *pwms;
 };
 
-- 
2.42.0


