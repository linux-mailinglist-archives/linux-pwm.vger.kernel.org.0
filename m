Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F837D0302
	for <lists+linux-pwm@lfdr.de>; Thu, 19 Oct 2023 22:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjJSUHz (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 19 Oct 2023 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjJSUHy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 19 Oct 2023 16:07:54 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5BD5116
        for <linux-pwm@vger.kernel.org>; Thu, 19 Oct 2023 13:07:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ6-0000Ah-V6; Thu, 19 Oct 2023 22:07:48 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ5-002rfv-T9; Thu, 19 Oct 2023 22:07:47 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1qtZJ5-001veH-JX; Thu, 19 Oct 2023 22:07:47 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-pwm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
Subject: [PATCH 2/5] pwm: stm32: Make ch parameter unsigned
Date:   Thu, 19 Oct 2023 22:07:01 +0200
Message-ID: <20231019200658.1754190-9-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
References: <20231019200658.1754190-7-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=7f75PVVxVopmOVTh1aUDtvsneuXS9AhU8k3+zgRBTe8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlMYxkxM0GUmvVtAQdmfgUDj+XP46m8mONLLbLs Ddk9JypUF2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZTGMZAAKCRCPgPtYfRL+ TvvaCACj+8dG+4/zQL/4OubeWWXtiHBVpDUgr/dabE71cYW38ec1vTqrm3gzR/z49xvFozkyJ6G EDixygJzPs7KQilRIbXtm3xmlV02wg57bHmp+nCL8mMRCmGPAKlSpYljLOrPNibDG9O0eCsmLm5 m2vKbon4Jd1dL+NbvlNIpTZsymf6z5a5mDtS1ILWrPjViTxznqVYqutA5FfcYczFUYlmCQ/raVb 66VPiKdCwio/rXsJgvcBzVJvboF9SroW5Pq8o0Fl/SX9QrKiVfsBuMs/nJHBsD3erp5YSa/ur5n HpEZPmAKp9sET6F1TmtiV+G79bw03xKOcHQyKBB1uahjOoug
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Philipp Zabel <p.zabel@pengutronix.de>

The channel parameter is only ever set to pwm->hwpwm.
Make it unsigned int as well.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-stm32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 5e48584e3bd4..009f9c1a5eca 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -308,7 +308,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	return ret;
 }
 
-static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
+static int stm32_pwm_config(struct stm32_pwm *priv, unsigned int ch,
 			    int duty_ns, int period_ns)
 {
 	unsigned long long prd, div, dty;
@@ -371,7 +371,7 @@ static int stm32_pwm_config(struct stm32_pwm *priv, int ch,
 	return 0;
 }
 
-static int stm32_pwm_set_polarity(struct stm32_pwm *priv, int ch,
+static int stm32_pwm_set_polarity(struct stm32_pwm *priv, unsigned int ch,
 				  enum pwm_polarity polarity)
 {
 	u32 mask;
@@ -386,7 +386,7 @@ static int stm32_pwm_set_polarity(struct stm32_pwm *priv, int ch,
 	return 0;
 }
 
-static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
+static int stm32_pwm_enable(struct stm32_pwm *priv, unsigned int ch)
 {
 	u32 mask;
 	int ret;
@@ -411,7 +411,7 @@ static int stm32_pwm_enable(struct stm32_pwm *priv, int ch)
 	return 0;
 }
 
-static void stm32_pwm_disable(struct stm32_pwm *priv, int ch)
+static void stm32_pwm_disable(struct stm32_pwm *priv, unsigned int ch)
 {
 	u32 mask;
 
-- 
2.42.0

