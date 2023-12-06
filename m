Return-Path: <linux-pwm+bounces-308-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D276F806E5A
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 627B1B20E17
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDE134558;
	Wed,  6 Dec 2023 11:48:28 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74AD3
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:23 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO6-0005z2-8o; Wed, 06 Dec 2023 12:48:22 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00Dwrk-Rz; Wed, 06 Dec 2023 12:48:21 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO5-00FQwt-J7; Wed, 06 Dec 2023 12:48:21 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v4 007/115] pwm: Provide a macro to get the parent device of a given chip
Date: Wed,  6 Dec 2023 12:43:21 +0100
Message-ID:  <9d0facb0f3e2d28789384f4e1ae0951803e840ab.1701860672.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
References: <cover.1701860672.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=XZZVlkm47rrlh1Cfy7O0ZOLmdQqoQvoicHRKG1/JYgk=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtSCuKilGa5mdj0F9rUaT1aefXDn4rQHSrGx6/3YK6SDf xTOvxvRyWjMwsDIxSArpshi37gm06pKLrJz7b/LMINYmUCmMHBxCsBEZPdwMMy1eXBLqejVX3+V Wx2WdTaxZj7ajSuy9D7qqt9zcXxj32XANTtk2rPU5BWH5y+8+UXWn+PL2cZ0JXbBFakLnM7uu1T NmP5R/ipTyq1ZP17pnKydOmO2/u+nts+EHeUPMnnY+1XcKjnJ6bCrw96PvaTEpefHA819PilF+d qzt15bKpm5WVgkWyotteb7Lq+M8rr/Cx+IPGSx/nnuFdunMtk9y18rxTcs8Vz4aTXH9nOlH8rn/ E1dPvM6a5LGqlcbDMJexkuLicwruRme+9o+a0W7S8mybGZNtdI85lCF6Kk5cuwNdzQXe3F2HGye lBirFM9/kqfoZYuauAr/dfbS7JvBtV8eO5h7rH2w5e4+AA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Currently a pwm_chip stores in it's struct device *dev member a pointer
to the parent device. Preparing a change that embeds a full struct
device in struct pwm_chip, this accessor macro should be used in all
drivers directly accessing chip->dev now. This way struct pwm_chip and
this macro can be changed without having to touch all drivers in the
same change set.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 include/linux/pwm.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index f87655c06c82..e069900d1a36 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -302,6 +302,11 @@ struct pwm_chip {
 	struct pwm_device *pwms;
 };
 
+static inline struct device *pwmchip_parent(struct pwm_chip *chip)
+{
+	return chip->dev;
+}
+
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_state(struct pwm_device *pwm, const struct pwm_state *state);
-- 
2.42.0


