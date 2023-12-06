Return-Path: <linux-pwm+bounces-341-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAF7E806E7C
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E82281BC9
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCC934570;
	Wed,  6 Dec 2023 11:48:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5B61BD
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:29 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOA-0006Ls-CS; Wed, 06 Dec 2023 12:48:26 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00DwtN-Uf; Wed, 06 Dec 2023 12:48:25 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqO9-00FQya-Li; Wed, 06 Dec 2023 12:48:25 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-pwm@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 032/115] pwm: stm32-lp: Make use of pwmchip_parent() macro
Date: Wed,  6 Dec 2023 12:43:46 +0100
Message-ID:  <ba8f7a49a8206d24854777b65c2e679f93852fe3.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1687; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=8GTUfYbqD+5GD5mrEVpFS9bTtV3cMkLFhtuMi1iJw5k=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF6G7un905HHfA/LXXzvzNjnU6AdxmMub7RNl LYax0QqA3CJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBehgAKCRCPgPtYfRL+ Tm1rCAC3RTd0mfQnKD8mThUZ+hnBLc7lcxLx0DmKDP+7CnPzGnM8NWYuqHckQqHg1cHs/zqtUeC h5IM1PIL1TD5IXfQqHBIIcQX/CC43gCnGsSCMqKoEry+CWG9cnI6E6pQ9FshAnl6JANs79QHpLb 792WjXMkJMR3zoDMJi+xaKQcx/fcByFvwrmxNDZ+UuDkj4Up2Ja3ujwpMu/5CWqFo0Fa/v9wwMA UAZNEHSldWcdwTj3X+s9yysXYrP0lQ9bM2xPa+iW0qXVYgJETvjFbxqXFfIoKijGTIhyNj17o8z vr1FflwXP+sBNVRLlER3ASS9bDX30n2L1gN8nPzFETGhruTx
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
 drivers/pwm/pwm-stm32-lp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 439068f3eca1..3754faeca838 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -61,7 +61,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	do_div(div, NSEC_PER_SEC);
 	if (!div) {
 		/* Clock is too slow to achieve requested period. */
-		dev_dbg(priv->chip.dev, "Can't reach %llu ns\n", state->period);
+		dev_dbg(pwmchip_parent(chip), "Can't reach %llu ns\n", state->period);
 		return -EINVAL;
 	}
 
@@ -69,7 +69,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 	while (div > STM32_LPTIM_MAX_ARR) {
 		presc++;
 		if ((1 << presc) > STM32_LPTIM_MAX_PRESCALER) {
-			dev_err(priv->chip.dev, "max prescaler exceeded\n");
+			dev_err(pwmchip_parent(chip), "max prescaler exceeded\n");
 			return -EINVAL;
 		}
 		div = prd >> presc;
@@ -130,7 +130,7 @@ static int stm32_pwm_lp_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				       (val & STM32_LPTIM_CMPOK_ARROK) == STM32_LPTIM_CMPOK_ARROK,
 				       100, 1000);
 	if (ret) {
-		dev_err(priv->chip.dev, "ARR/CMP registers write issue\n");
+		dev_err(pwmchip_parent(chip), "ARR/CMP registers write issue\n");
 		goto err;
 	}
 	ret = regmap_write(priv->regmap, STM32_LPTIM_ICR,
-- 
2.42.0


