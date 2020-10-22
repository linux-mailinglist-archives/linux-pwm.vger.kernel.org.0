Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF0E29622A
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368902AbgJVP7O (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 11:59:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:48528 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368882AbgJVP7N (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 71B73AFCF;
        Thu, 22 Oct 2020 15:59:11 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org
Cc:     f.fainelli@gmail.com, linux-pwm@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v2 05/10] soc: bcm: raspberrypi-power: Release firmware handle on unbind
Date:   Thu, 22 Oct 2020 17:58:52 +0200
Message-Id: <20201022155858.20867-6-nsaenzjulienne@suse.de>
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
 drivers/soc/bcm/raspberrypi-power.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/soc/bcm/raspberrypi-power.c b/drivers/soc/bcm/raspberrypi-power.c
index 5d1aacdd84ef..a0b38db5886c 100644
--- a/drivers/soc/bcm/raspberrypi-power.c
+++ b/drivers/soc/bcm/raspberrypi-power.c
@@ -225,6 +225,20 @@ static int rpi_power_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int rpi_power_remove(struct platform_device *pdev)
+{
+	struct rpi_power_domains *rpi_domains = platform_get_drvdata(pdev);
+
+	of_genpd_del_provider(dev->of_node);
+
+	for (i = 0; i < RPI_POWER_DOMAIN_COUNT; i++)
+		pm_genpd_remove(&rpi_domains->domains[i].base);
+
+	rpi_firmware_put(rpi_domaina->fw);
+
+	return 0;
+}
+
 static const struct of_device_id rpi_power_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-power", },
 	{},
@@ -237,6 +251,7 @@ static struct platform_driver rpi_power_driver = {
 		.of_match_table = rpi_power_of_match,
 	},
 	.probe		= rpi_power_probe,
+	.remove		= rpi_power_remove,
 };
 builtin_platform_driver(rpi_power_driver);
 
-- 
2.28.0

