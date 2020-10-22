Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C6296232
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 17:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368851AbgJVP7w (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 11:59:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368878AbgJVP7M (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 41DD3AC23;
        Thu, 22 Oct 2020 15:59:10 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 04/10] reset: raspberrypi: Release firmware handle on unbind
Date:   Thu, 22 Oct 2020 17:58:51 +0200
Message-Id: <20201022155858.20867-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022155858.20867-1-nsaenzjulienne@suse.de>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Upon unbinding the device make sure we release RPi's firmware interface.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/reset/reset-raspberrypi.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-raspberrypi.c
index 02f59c06f69b..29311192e2c9 100644
--- a/drivers/reset/reset-raspberrypi.c
+++ b/drivers/reset/reset-raspberrypi.c
@@ -99,7 +99,17 @@ static int rpi_reset_probe(struct platform_device *pdev)
 	priv->rcdev.ops = &rpi_reset_ops;
 	priv->rcdev.of_node = dev->of_node;
 
-	return devm_reset_controller_register(dev, &priv->rcdev);
+	return reset_controller_register(&priv->rcdev);
+}
+
+static int rpi_reset_remove(struct platform_device *pdev)
+{
+	struct rpi_reset *priv = platform_get_drvdata(pdev);
+
+	reset_controller_unregister(&priv->rcdev);
+	rpi_firmware_put(priv->fw);
+
+	return 0;
 }
 
 static const struct of_device_id rpi_reset_of_match[] = {
@@ -110,6 +120,7 @@ MODULE_DEVICE_TABLE(of, rpi_reset_of_match);
 
 static struct platform_driver rpi_reset_driver = {
 	.probe	= rpi_reset_probe,
+	.remove	= rpi_reset_remove,
 	.driver	= {
 		.name = "raspberrypi-reset",
 		.of_match_table = rpi_reset_of_match,
-- 
2.28.0

