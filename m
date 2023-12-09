Return-Path: <linux-pwm+bounces-479-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D1380B74F
	for <lists+linux-pwm@lfdr.de>; Sun, 10 Dec 2023 00:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3C75B20A18
	for <lists+linux-pwm@lfdr.de>; Sat,  9 Dec 2023 23:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8001CFA7;
	Sat,  9 Dec 2023 23:01:07 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D30E115
	for <linux-pwm@vger.kernel.org>; Sat,  9 Dec 2023 15:01:05 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jj-00068x-Lk; Sun, 10 Dec 2023 00:01:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jj-00EjgP-96; Sun, 10 Dec 2023 00:01:03 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rC6Jj-00HQE9-0E; Sun, 10 Dec 2023 00:01:03 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] pwm: Drop two unused API functions
Date: Sun, 10 Dec 2023 00:00:47 +0100
Message-ID:  <a4c2f497eb79f621830ac041074439e109374070.1702162780.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702162780.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702162780.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1133; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=s2sebiidQQo8YSc4MyTvEk3c2Ea1znVR0Mr+i9c5tq4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBldPGk74OzGQ/pLX4xl7GICoSyOr0NO58O0YUxm g46zzDmWOqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXTxpAAKCRCPgPtYfRL+ TjdTCACKYtD55ePcXGOrgl+gP2HVN+uahg90znWBVh/hPK6ifnVXuR8G8PjW3BaM/wMuyWhgUZC 6FQcM1qcfrEEL2G656D6kcnWMZnb4CwZAWw0ShPIHWD0PxuaTCOy3Fp7WyBtPCsunnjkKtm4bJR HcRlcRBCSFoIZk7GbJ2zHrz3FuCByRWNLvlaWue1A37F5y+8N0GJPaW+vlIAaDa63QTevqH49x/ uaTYfg7aYjikaAyZ5LchxfPL4s4jh5yV9WvD5aaYBpH1jgeAlAs4UtvVKfDnYCJHivL7EuTs+Lm jX0hbK7OSJbIbiYnSvOnBxbUIM626oHOUu+8QrlhydzGQo7R
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

These functions are unused. Also I think there is no valid use case
where these are correct to be called. So drop them.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f87655c06c82..20363da3e6ef 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -111,12 +111,6 @@ static inline bool pwm_is_enabled(const struct pwm_device *pwm)
 	return state.enabled;
 }
 
-static inline void pwm_set_period(struct pwm_device *pwm, u64 period)
-{
-	if (pwm)
-		pwm->state.period = period;
-}
-
 static inline u64 pwm_get_period(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
@@ -126,12 +120,6 @@ static inline u64 pwm_get_period(const struct pwm_device *pwm)
 	return state.period;
 }
 
-static inline void pwm_set_duty_cycle(struct pwm_device *pwm, unsigned int duty)
-{
-	if (pwm)
-		pwm->state.duty_cycle = duty;
-}
-
 static inline u64 pwm_get_duty_cycle(const struct pwm_device *pwm)
 {
 	struct pwm_state state;
-- 
2.42.0


