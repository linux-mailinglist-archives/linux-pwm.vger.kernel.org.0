Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAB2A620E
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Nov 2020 11:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgKDKjw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 4 Nov 2020 05:39:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:58490 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727001AbgKDKjv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Wed, 4 Nov 2020 05:39:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id EF2D3AD76;
        Wed,  4 Nov 2020 10:39:48 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com
Cc:     linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, wahrenst@gmx.net,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        p.zabel@pengutronix.de, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org, linux-clk@vger.kernel.org,
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org,
        bgolaszewski@baylibre.com, andy.shevchenko@gmail.com
Subject: [PATCH v3 01/11] firmware: raspberrypi: Introduce devm_rpi_firmware_get()
Date:   Wed,  4 Nov 2020 11:39:27 +0100
Message-Id: <20201104103938.1286-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201104103938.1286-1-nsaenzjulienne@suse.de>
References: <20201104103938.1286-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When unbinding the firmware device we need to make sure it has no
consumers left. Otherwise we'd leave them with a firmware handle
pointing at freed memory.

Keep a reference count of all consumers and introduce
devm_rpi_firmware_get() which will automatically decrease the reference
count upon unbinding consumer drivers.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>

---

Changes since v2:
 - Create devm_rpi_firmware_get()

 drivers/firmware/raspberrypi.c             | 46 ++++++++++++++++++++++
 include/soc/bcm2835/raspberrypi-firmware.h |  8 ++++
 2 files changed, 54 insertions(+)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 2371d08bdd17..74bdb3bde9dc 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -11,7 +11,9 @@
 #include <linux/module.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
+#include <linux/wait.h>
 #include <soc/bcm2835/raspberrypi-firmware.h>
 
 #define MBOX_MSG(chan, data28)		(((data28) & ~0xf) | ((chan) & 0xf))
@@ -27,6 +29,9 @@ struct rpi_firmware {
 	struct mbox_chan *chan; /* The property channel. */
 	struct completion c;
 	u32 enabled;
+
+	refcount_t consumers;
+	wait_queue_head_t wait;
 };
 
 static DEFINE_MUTEX(transaction_lock);
@@ -247,6 +252,8 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&fw->c);
+	refcount_set(&fw->consumers, 1);
+	init_waitqueue_head(&fw->wait);
 
 	platform_set_drvdata(pdev, fw);
 
@@ -275,11 +282,21 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
+
+	wait_event(fw->wait, refcount_dec_if_one(&fw->consumers));
 	mbox_free_channel(fw->chan);
 
 	return 0;
 }
 
+static void rpi_firmware_put(void *data)
+{
+	struct rpi_firmware *fw = data;
+
+	refcount_dec(&fw->consumers);
+	wake_up(&fw->wait);
+}
+
 /**
  * rpi_firmware_get - Get pointer to rpi_firmware structure.
  * @firmware_node:    Pointer to the firmware Device Tree node.
@@ -297,6 +314,35 @@ struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
+/**
+ * devm_rpi_firmware_get - Get pointer to rpi_firmware structure.
+ * @firmware_node:    Pointer to the firmware Device Tree node.
+ *
+ * Returns NULL is the firmware device is not ready.
+ */
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node)
+{
+	struct platform_device *pdev = of_find_device_by_node(firmware_node);
+	struct rpi_firmware *fw;
+
+	if (!pdev)
+		return NULL;
+
+	fw = platform_get_drvdata(pdev);
+	if (!fw)
+		return NULL;
+
+	if (!refcount_inc_not_zero(&fw->consumers))
+		return NULL;
+
+	if (devm_add_action_or_reset(dev, rpi_firmware_put, fw))
+		return NULL;
+
+	return fw;
+}
+EXPORT_SYMBOL_GPL(devm_rpi_firmware_get);
+
 static const struct of_device_id rpi_firmware_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-firmware", },
 	{},
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index cc9cdbc66403..8fe64f53a394 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -141,6 +141,8 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
+struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					   struct device_node *firmware_node);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
@@ -158,6 +160,12 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
 {
 	return NULL;
 }
+
+static inline struct rpi_firmware *devm_rpi_firmware_get(struct device *dev,
+					struct device_node *firmware_node)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
-- 
2.29.1

