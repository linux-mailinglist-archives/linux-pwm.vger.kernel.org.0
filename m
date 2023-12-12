Return-Path: <linux-pwm+bounces-539-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5528E80F542
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 19:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072B81F217AC
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3AE7E774;
	Tue, 12 Dec 2023 18:10:02 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4FBD
	for <linux-pwm@vger.kernel.org>; Tue, 12 Dec 2023 10:09:59 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CY-00018d-98; Tue, 12 Dec 2023 19:09:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-00FOY6-SD; Tue, 12 Dec 2023 19:09:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rD7CX-001opO-Ij; Tue, 12 Dec 2023 19:09:49 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Russell King <linux@armlinux.org.uk>
Cc: linux-clk@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Anderson <sean.anderson@seco.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-pwm@vger.kernel.org
Subject: [PATCH 2/2] pwm: xilinx: Simplify using devm functions
Date: Tue, 12 Dec 2023 19:09:43 +0100
Message-ID:  <e51f9d16f7a0f29ce5c2385e11a14b1ebdac7530.1702403904.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702403904.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2370; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=pqqh+IxlHfU7VOKYnsJWW4bjYCEXlBsPm5O8mdl1h00=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBleKHnd6rwMdHhx7Qz6/qVwKIw53lQwrBfRNIBv MchT3GehdmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXih5wAKCRCPgPtYfRL+ TkkRCACRQCyqmefNKOdbC+jweaQ6JDJwVkg7xeOd3uBiFZb0RlFZ4mCrVEcT/f+qYQLErKoJBOL BdUwcucQG3T/IqWQ/9eXmSDRObMSpxfziWyLCZSISx9gXFlrWMjtY5cLN23l81NHIpleyEQw+x2 pJCn6jCaHMAekeRCy73A1qY57JUFpWk2g1cIzJY0NL/H+06tcRZyaDYPdSlCiBW0cFcSba7LgSR 09t2ZGhV/qWQWvv7JsrbPh/sg45qr8xV1H8siGLWmwDU8huxSoHTur0sTjAfUGfjVB908lwPXJE AQH4WO1ICZMrVTtvOh9PxyMR2U1WydRKKVTt/MU+mZ/sraXX
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

devm_clk_get() + clk_prepare_enable() can be simplified to
devm_clk_get_enabled(). Both clk_rate_exclusive_get() and pwmchip_add()
have devm variants.

This allows to completely drop the remove callback and the error path in
the probe function.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-xilinx.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

diff --git a/drivers/pwm/pwm-xilinx.c b/drivers/pwm/pwm-xilinx.c
index 5f3c2a6fed11..19a2a496d555 100644
--- a/drivers/pwm/pwm-xilinx.c
+++ b/drivers/pwm/pwm-xilinx.c
@@ -268,38 +268,26 @@ static int xilinx_pwm_probe(struct platform_device *pdev)
 	 * alas, such properties are not allowed to be used.
 	 */
 
-	priv->clk = devm_clk_get(dev, "s_axi_aclk");
+	priv->clk = devm_clk_get_enabled(dev, "s_axi_aclk");
 	if (IS_ERR(priv->clk))
 		return dev_err_probe(dev, PTR_ERR(priv->clk),
 				     "Could not get clock\n");
 
-	ret = clk_prepare_enable(priv->clk);
+	ret = devm_clk_rate_exclusive_get(dev, priv->clk);
 	if (ret)
-		return dev_err_probe(dev, ret, "Clock enable failed\n");
-	clk_rate_exclusive_get(priv->clk);
+		return dev_err_probe(dev, ret,
+				     "Could not get exclusive control over clock\n");
 
 	xilinx_pwm->chip.dev = dev;
 	xilinx_pwm->chip.ops = &xilinx_pwm_ops;
 	xilinx_pwm->chip.npwm = 1;
-	ret = pwmchip_add(&xilinx_pwm->chip);
-	if (ret) {
-		clk_rate_exclusive_put(priv->clk);
-		clk_disable_unprepare(priv->clk);
+	ret = devm_pwmchip_add(dev, &xilinx_pwm->chip);
+	if (ret)
 		return dev_err_probe(dev, ret, "Could not register PWM chip\n");
-	}
 
 	return 0;
 }
 
-static void xilinx_pwm_remove(struct platform_device *pdev)
-{
-	struct xilinx_pwm_device *xilinx_pwm = platform_get_drvdata(pdev);
-
-	pwmchip_remove(&xilinx_pwm->chip);
-	clk_rate_exclusive_put(xilinx_pwm->priv.clk);
-	clk_disable_unprepare(xilinx_pwm->priv.clk);
-}
-
 static const struct of_device_id xilinx_pwm_of_match[] = {
 	{ .compatible = "xlnx,xps-timer-1.00.a", },
 	{},
@@ -308,7 +296,6 @@ MODULE_DEVICE_TABLE(of, xilinx_pwm_of_match);
 
 static struct platform_driver xilinx_pwm_driver = {
 	.probe = xilinx_pwm_probe,
-	.remove_new = xilinx_pwm_remove,
 	.driver = {
 		.name = "xilinx-pwm",
 		.of_match_table = of_match_ptr(xilinx_pwm_of_match),
-- 
2.42.0


