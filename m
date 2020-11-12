Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2E12B0A64
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728989AbgKLQoA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:44:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:49198 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727739AbgKLQoA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 11:44:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9A345AB95;
        Thu, 12 Nov 2020 16:43:58 +0000 (UTC)
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
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v4 05/11] reset: raspberrypi: Release firmware handle on unbind
Date:   Thu, 12 Nov 2020 17:36:23 +0100
Message-Id: <20201112163630.17177-6-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112163630.17177-1-nsaenzjulienne@suse.de>
References: <20201112163630.17177-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
interface when unbinding the device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v2:
 - Use devm_rpi_firmware_get(), instead of remove function

 drivers/reset/reset-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/reset-raspberrypi.c b/drivers/reset/reset-raspberrypi.c
index 02f59c06f69b..fa23db554bcf 100644
--- a/drivers/reset/reset-raspberrypi.c
+++ b/drivers/reset/reset-raspberrypi.c
@@ -82,7 +82,7 @@ static int rpi_reset_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(np);
+	fw = devm_rpi_firmware_get(&pdev->dev, np);
 	of_node_put(np);
 	if (!fw)
 		return -EPROBE_DEFER;
-- 
2.29.2

