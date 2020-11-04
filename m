Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90552A6244
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 11:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbgKDKke (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 05:40:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:58606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729752AbgKDKj7 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:39:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B3D1ABAE;
        Wed,  4 Nov 2020 10:39:57 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
Subject: [PATCH v3 08/11] firmware: raspberrypi: Get rid of rpi_firmware_get()
Date:   Wed,  4 Nov 2020 11:39:34 +0100
Message-Id: <20201104103938.1286-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104103938.1286-1-nsaenzjulienne@suse.de>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There a no users left to the function as they all converted to
devm_rpi_firmware_get(). Just get rid of it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/firmware/raspberrypi.c             | 17 -----------------
 include/soc/bcm2835/raspberrypi-firmware.h |  6 ------
 2 files changed, 23 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 74bdb3bde9dc..67f7105f3fd2 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -297,23 +297,6 @@ static void rpi_firmware_put(void *data)
 	wake_up(&fw->wait);
 }
 
-/**
- * rpi_firmware_get - Get pointer to rpi_firmware structure.
- * @firmware_node:    Pointer to the firmware Device Tree node.
- *
- * Returns NULL is the firmware device is not ready.
- */
-struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
-{
-	struct platform_device *pdev = of_find_device_by_node(firmware_node);
-
-	if (!pdev)
-		return NULL;
-
-	return platform_get_drvdata(pdev);
-}
-EXPORT_SYMBOL_GPL(rpi_firmware_get);
-
 /**
  * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
  * @firmware_node:    Pointer to the firmware Device Tree node.
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index 8fe64f53a394..eaa4e516e4c6 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -140,7 +140,6 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
-struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
 struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
 					   struct device_node *firmware_node);
 #else
@@ -156,11 +155,6 @@ static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
 	return -ENOSYS;
 }
 
-static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
-{
-	return NULL;
-}
-
 static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
 					struct device_node *firmware_node)
 {
-- 
2.29.1

