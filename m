Return-Path: <linux-pwm+bounces-614-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E662D81C732
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 10:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B2E1F21A2B
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Dec 2023 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAC7F9D2;
	Fri, 22 Dec 2023 09:14:55 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3328F9C8
	for <linux-pwm@vger.kernel.org>; Fri, 22 Dec 2023 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGbcG-0004hG-Vw; Fri, 22 Dec 2023 10:14:49 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGbcF-000iw7-8r; Fri, 22 Dec 2023 10:14:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rGbcG-001bk9-2r; Fri, 22 Dec 2023 10:14:48 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] pwm: Add pwm_apply_state() compatibility stub
Date: Fri, 22 Dec 2023 10:14:46 +0100
Message-ID: <20231222091445.342131-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1325; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=CdxDglPWkQDicNxG8DuG1DT839oit4D71qA7yWeuOnI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlhVOFZWL3Fy2o86uu9IFgJhujJOIHDrqmIRipp hMpkD+g4TmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYVThQAKCRCPgPtYfRL+ Tje3CAC1Q7+hql+YpZrh2vzlXAzFvCZZuIbd5xqKMOH2dvDYeodUxdVCPyADWCGUdPB4R+BHvR3 lD+UXIm8k3JE5f+Q3jp9uHnZEWmO9BPGH2/nqTfM5OY+Z+guYgeieLdZjguxaWsr7CkxelOePEH kOoXozO2nIrFL/0WFh7QSc8eka8ItxXwf0soYNdrmpZCOJUfZ9CtlPLZIWP0Pigx+14rG95vMq/ LZ2aT0zxU40MBR7i93h70K759HW8OYIR4OKyQ/234xwOJja/IWRRDTmSouQVOvRnG8GA5ms+Zw8 +6LzvF6trNAgY2cz/+0s+kIXSY7Ue0oVECL2WZLjoFaTQchp
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

From: Thierry Reding <thierry.reding@gmail.com>

In order to make the transition to the new pwm_apply_might_sleep() a bit
smoother, add a compatibility stub. This will prevent new calls to the
old function introduced via other subsystems from breaking builds. Once
the next merge window has closed we can take another stab at removing
the stub.

Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
---
Hello,

I found this patch in Thierry's for-next branch, but neither in my
mailbox nor on lore.k.o. So just sending it out make sure we have a
record of this patch on the mailing list before it enters the mainline.

Best regards
Uwe

 include/linux/pwm.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 5dd665d8c909..2a5e1154652e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -537,6 +537,13 @@ static inline void pwm_apply_args(struct pwm_device *pwm)
 	pwm_apply_might_sleep(pwm, &state);
 }
 
+/* only for backwards-compatibility, new code should not use this */
+static inline int pwm_apply_state(struct pwm_device *pwm,
+				  const struct pwm_state *state)
+{
+	return pwm_apply_might_sleep(pwm, state);
+}
+
 struct pwm_lookup {
 	struct list_head list;
 	const char *provider;

base-commit: 881791886bfa8e353c3203f95bfbaaeee25d2d50
-- 
2.42.0


