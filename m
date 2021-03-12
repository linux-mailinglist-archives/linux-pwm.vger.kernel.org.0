Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A01338CD8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 13:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231733AbhCLMZm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 07:25:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:57112 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230484AbhCLMZV (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Mar 2021 07:25:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81804B0B8;
        Fri, 12 Mar 2021 12:25:19 +0000 (UTC)
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
Subject: [PATCH v8 03/11] clk: bcm: rpi: Release firmware handle on unbind
Date:   Fri, 12 Mar 2021 13:24:46 +0100
Message-Id: <20210312122454.24480-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312122454.24480-1-nsaenzjulienne@suse.de>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Use devm_rpi_firmware_get() so as to make sure we release RPi's firmware
interface when unbinding the device.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>

 drivers/clk/bcm/clk-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
---
 drivers/clk/bcm/clk-raspberrypi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/bcm/clk-raspberrypi.c b/drivers/clk/bcm/clk-raspberrypi.c
index f89b9cfc4309..dd3b71eafabf 100644
--- a/drivers/clk/bcm/clk-raspberrypi.c
+++ b/drivers/clk/bcm/clk-raspberrypi.c
@@ -314,7 +314,7 @@ static int raspberrypi_clk_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	firmware = rpi_firmware_get(firmware_node);
+	firmware = devm_rpi_firmware_get(&pdev->dev, firmware_node);
 	of_node_put(firmware_node);
 	if (!firmware)
 		return -EPROBE_DEFER;
-- 
2.30.1

