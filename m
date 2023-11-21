Return-Path: <linux-pwm+bounces-4-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 188357F2F49
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C65DD2819C9
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A060C537FE;
	Tue, 21 Nov 2023 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E128D71
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:51:47 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAH-0004uO-JL; Tue, 21 Nov 2023 14:51:45 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAH-00AawV-6k; Tue, 21 Nov 2023 14:51:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAG-004xaf-Tv; Tue, 21 Nov 2023 14:51:44 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH v3 002/108] pwm: Provide a macro to get the parent device of a given chip
Date: Tue, 21 Nov 2023 14:49:04 +0100
Message-ID: <20231121134901.208535-3-u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=PQUcHWEQGBwh9iBxbicV185K7zKwKouqxRA+9pEIY8o=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLVPBL8/jQk2o9nXMRfNPJrKMKH582wYAKaCE vpcupsyJK6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1TwAKCRCPgPtYfRL+ TteDB/45VlAQx+N7fUzt27P0zPuoesf+EAYGCklbWq7O5+NjRdg6ruzcOwQtYVf94LnHybJFmfz 9BzxmKL2X4d/R4J5ZkD6VYAo86/ipykaNYitZhLrBqdi2QLIiuAUUfOL8PN+NsLOqdM1zmqinR8 +SdVOMARipj/y20r8sqg+zNQKCrMcz2mkdHVr+4jE5k72aRJTzG1itrqbIrGQWoA3WUZ/nYH/MO loBuVBaf0K2rQlbWCRRpZ6D7C0geSIYze2gO+1Udk5azJkn8W4n1KhRCDao0n86HJnAd+nplPjv uY42U42G4ckVNEphEgeAxuoJFNKE8Dyv7CA9JatbP0JNk3LE
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
index c27a4bb76012..dda3a68e06dc 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -303,6 +303,11 @@ struct pwm_chip {
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


