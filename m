Return-Path: <linux-pwm+bounces-235-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C9B7FD3EC
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 11:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9282832DB
	for <lists+linux-pwm@lfdr.de>; Wed, 29 Nov 2023 10:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276651A5A8;
	Wed, 29 Nov 2023 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCADAF
	for <linux-pwm@vger.kernel.org>; Wed, 29 Nov 2023 02:18:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HeZ-0001Po-Mm; Wed, 29 Nov 2023 11:18:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HeY-00CNjm-Ht; Wed, 29 Nov 2023 11:18:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r8HeY-00Ale9-8p; Wed, 29 Nov 2023 11:18:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	kernel@pengutronix.de,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] pwm: Update kernel doc for struct pwm_chip
Date: Wed, 29 Nov 2023 11:18:32 +0100
Message-ID: <20231129101831.908952-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231129125826.08d7d178@canb.auug.org.au>
References: <20231129125826.08d7d178@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=tsm5bQuNyv52mW3JCZFnEoHg3N8bF61pCfqHO/cC8NI=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtR0/u+Mqf8zDFjjK5dfypiXkJPIMPW4cszLzKot06655 Zgxr7rVyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBElFrY/1cnzPxU7ffF0jbg WZ6EZooIB49T/aO1AVe7rFvuTJ9W2pD4xKtxneh0o5cCP7jcVpk7fmXnXCPLflDih4+Upc4zZ6f GaUWHbH6J7XZPnrQ46dwcPZlVOQH7j9znFV4aVfRVd9PJfW/9HXJ1XgS8uqetF1f9WGrv+1NdS7 19rV/2exulf3Zd4K8VmGQ7qaSae479uVSPoInuFjdunf+mYNnNbCmT+rKmInrCC3W2kyoVgt0i9 gd6Jfcz1J7VOmpT8pqJ0ab7iTRv835raV/dMs9FLGc+97sFx/79+Eng72u7t+aXWROvmxUmsylt 28iol7io9Jjz8U+XmZJnRm6YuO2V2KNtU07su7HAXLsGAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Commit c572f3b9c8b7 ("pwm: Replace PWM chip unique base by unique ID")
changed the members of struct pwm_chip, but failed to update the
documentation accordingly. Catch up and document the new member and drop
description for the two removed ones.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c27a4bb76012..f87655c06c82 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -281,11 +281,10 @@ struct pwm_ops {
  * @dev: device providing the PWMs
  * @ops: callbacks for this PWM controller
  * @owner: module providing this chip
- * @base: number of first PWM controlled by this chip
+ * @id: unique number of this PWM chip
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
- * @list: list node for internal use
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {

base-commit: 5d67b8f81b9d598599366214e3b2eb5f84003c9f
-- 
2.42.0


