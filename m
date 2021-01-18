Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BEC2FA142
	for <lists+linux-pwm@lfdr.de>; Mon, 18 Jan 2021 14:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391627AbhARMeM (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 18 Jan 2021 07:34:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:38274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391607AbhARMdk (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 18 Jan 2021 07:33:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B67D9B93D;
        Mon, 18 Jan 2021 12:32:58 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v7 04/11] gpio: raspberrypi-exp: Release firmware handle on unbind
Date:   Mon, 18 Jan 2021 13:32:37 +0100
Message-Id: <20210118123244.13669-5-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210118123244.13669-1-nsaenzjulienne@suse.de>
References: <20210118123244.13669-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
interface when unbinding the device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 drivers/gpio/gpio-raspberrypi-exp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-raspberrypi-exp.c b/drivers/gpio/gpio-raspberrypi-exp.c
index bb100e0124e6..64a552ecc2ad 100644
--- a/drivers/gpio/gpio-raspberrypi-exp.c
+++ b/drivers/gpio/gpio-raspberrypi-exp.c
@@ -208,7 +208,7 @@ static int rpi_exp_gpio_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	fw = rpi_firmware_get(fw_node);
+	fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
 	of_node_put(fw_node);
 	if (!fw)
 		return -EPROBE_DEFER;
-- 
2.29.2

