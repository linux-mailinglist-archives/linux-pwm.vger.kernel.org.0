Return-Path: <linux-pwm+bounces-378-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BF806EB3
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 12:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AA04B20ED2
	for <lists+linux-pwm@lfdr.de>; Wed,  6 Dec 2023 11:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE434556;
	Wed,  6 Dec 2023 11:48:56 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6751ED59
	for <linux-pwm@vger.kernel.org>; Wed,  6 Dec 2023 03:48:40 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOJ-00075H-KE; Wed, 06 Dec 2023 12:48:35 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-00Dww2-W1; Wed, 06 Dec 2023 12:48:33 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rAqOG-00FR1R-MZ; Wed, 06 Dec 2023 12:48:32 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: kernel@pengutronix.de,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org
Subject: [PATCH v4 075/115] pwm: meson: Make use of devm_pwmchip_alloc() function
Date: Wed,  6 Dec 2023 12:44:29 +0100
Message-ID:  <513593a5a3d4169abfdabe36de966e5095edfd3b.1701860672.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2613; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=Ue7uTWHXrmzSMDoSz9IIRmhParo0m7noVVdhB3JyFFM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlcF7vxeYCUx6b41zw71jBPl2OZ+JAcMvlG6qdo PQxFrMNnbSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZXBe7wAKCRCPgPtYfRL+ TpQoB/9jwwrVemdukqMpPIKwElv1MMey4NJFPvPG1p0tIYmn+U/Z5Z3oV489iLR0av9F66/FnDO xbLWKh+pioz8cfA1T14ObcO+NG7FDxTIofmGuJJ7BzYf2+NMCn92IFjMHnzXbkAjo+w+lzMjeuG 3QGpJ3WakoDR3vwCcam1GShhWmR8AAUmTWh7PboEqBhVBOvrsE6nU57hsZtC3qm/NkrTKVtygtm LAu51/WUIMPiJveV6KFbstu247sEXwvNQQN1x5K0qh+ql699mwgA5/4W8L3WOUWrdIMHtstlpSP +LqUGZlG9XRJ76wm9xIOrwCHgxohWLky0FXG8FEbnbLGx15I
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This prepares the pwm-meson driver to further changes of the pwm core
outlined in the commit introducing devm_pwmchip_alloc(). There is no
intended semantical change and the driver should behave as before.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/pwm/pwm-meson.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-meson.c b/drivers/pwm/pwm-meson.c
index 640d6fe63799..187cd6f35cce 100644
--- a/drivers/pwm/pwm-meson.c
+++ b/drivers/pwm/pwm-meson.c
@@ -102,7 +102,6 @@ struct meson_pwm_data {
 };
 
 struct meson_pwm {
-	struct pwm_chip chip;
 	const struct meson_pwm_data *data;
 	struct meson_pwm_channel channels[MESON_NUM_PWMS];
 	void __iomem *base;
@@ -115,7 +114,7 @@ struct meson_pwm {
 
 static inline struct meson_pwm *to_meson_pwm(struct pwm_chip *chip)
 {
-	return container_of(chip, struct meson_pwm, chip);
+	return pwmchip_get_drvdata(chip);
 }
 
 static int meson_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
@@ -449,7 +448,7 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 		mux_parent_data[i].name = meson->data->parent_names[i];
 	}
 
-	for (i = 0; i < meson->chip.npwm; i++) {
+	for (i = 0; i < chip->npwm; i++) {
 		struct meson_pwm_channel *channel = &meson->channels[i];
 		struct clk_parent_data div_parent = {}, gate_parent = {};
 		struct clk_init_data init = {};
@@ -535,29 +534,29 @@ static int meson_pwm_init_channels(struct pwm_chip *chip)
 
 static int meson_pwm_probe(struct platform_device *pdev)
 {
+	struct pwm_chip *chip;
 	struct meson_pwm *meson;
 	int err;
 
-	meson = devm_kzalloc(&pdev->dev, sizeof(*meson), GFP_KERNEL);
-	if (!meson)
-		return -ENOMEM;
+	chip = devm_pwmchip_alloc(&pdev->dev, MESON_NUM_PWMS, sizeof(*meson));
+	if (IS_ERR(chip))
+		return PTR_ERR(chip);
+	meson = to_meson_pwm(chip);
 
 	meson->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(meson->base))
 		return PTR_ERR(meson->base);
 
 	spin_lock_init(&meson->lock);
-	meson->chip.dev = &pdev->dev;
-	meson->chip.ops = &meson_pwm_ops;
-	meson->chip.npwm = MESON_NUM_PWMS;
+	chip->ops = &meson_pwm_ops;
 
 	meson->data = of_device_get_match_data(&pdev->dev);
 
-	err = meson_pwm_init_channels(&meson->chip);
+	err = meson_pwm_init_channels(chip);
 	if (err < 0)
 		return err;
 
-	err = devm_pwmchip_add(&pdev->dev, &meson->chip);
+	err = devm_pwmchip_add(&pdev->dev, chip);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register PWM chip: %d\n", err);
 		return err;
-- 
2.42.0


