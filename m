Return-Path: <linux-pwm+bounces-340-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7E0806E7D
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C534281BBD
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9012434563;
	Wed,  6 Dec 2023 11:48:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3C01BF
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:32 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-0006Mp-Qw; Wed, 06 Dec 2023 12:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-00DwtZ-DQ; Wed, 06 Dec 2023 12:48:26 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-00FQym-4N; Wed, 06 Dec 2023 12:48:26 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH v4 035/115] pwm: sun4i: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:49 +0100
Message-ID:  <e3f7af28e1a9c18e021be4d2180be68015a345e1.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=3GBsTcGHc+vpgWtdJ9fkda6/sPdRCK00xa66RjIchzs=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6JVAIF1g8nQTkYrQRAJKu8ySNZnIG+yXrCc KDfkRfTVkuJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBeiQAKCRCPgPtYfRL+ Tsn1CACLP/GU/FeH8EqTceSD1WrlBRk44zrR2+OtiO92fFXpgfUFuVNaWFvY64lD8JIlS8YJEt1 ipeoSEdsOThQ/9kkVq5IHR0Fb1O1RMq8PxeThJjfV721v6jqolDTtSEefXooSPoaGXWqiqk7ACC aGsbjVwXosiGTBAHxNIxYr+swOyy/fOKctQMpdGSP9XJwjgkURFVAEa1kG8S8cwQHNlavsNdKMj MeZ5LnlB3ad0KU4WR/gzXf5dP33T/zFKLaQ3CQnhxWyXhcJXca8UwQGkjD05kOv116LzUZ+6tvM uLe+Cu8ThrOEG/Bt0eih8x02tM5XHEST0y3xmMIQxzjLyqRB
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

struct pwm_chip::dev is about to change. To not have to touch this
driver in the same commit as struct pwm_chip::dev, use the macro
provided for exactly this purpose.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-sun4i.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
index 1a439025540d..44edf1ce5739 100644
--- a/drivers/pwm/pwm-sun4i.c
+++ b/drivers/pwm/pwm-sun4i.c
@@ -245,7 +245,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	if (!cstate.enabled) {
 		ret = clk_prepare_enable(sun4i_pwm->clk);
 		if (ret) {
-			dev_err(chip->dev, "failed to enable PWM clock\n");
+			dev_err(pwmchip_parent(chip), "failed to enable PWM clock\n");
 			return ret;
 		}
 	}
@@ -253,7 +253,7 @@ static int sun4i_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	ret = sun4i_pwm_calculate(sun4i_pwm, state, &duty, &period, &prescaler,
 				  &bypass);
 	if (ret) {
-		dev_err(chip->dev, "period exceeds the maximum value\n");
+		dev_err(pwmchip_parent(chip), "period exceeds the maximum value\n");
 		if (!cstate.enabled)
 			clk_disable_unprepare(sun4i_pwm->clk);
 		return ret;
-- 
2.42.0


