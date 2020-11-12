Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 239CD2B0A47
	for <lists+linux-pwm@lfdr.de>; Thu, 12 Nov 2020 17:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgKLQlA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 12 Nov 2020 11:41:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:44752 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728263AbgKLQlA (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 12 Nov 2020 11:41:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4473AB95;
        Thu, 12 Nov 2020 16:40:57 +0000 (UTC)
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
Subject: [PATCH v4 01/11] firmware: raspberrypi: Keep count of all consumers
Date:   Thu, 12 Nov 2020 17:36:19 +0100
Message-Id: <20201112163630.17177-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112163630.17177-1-nsaenzjulienne@suse.de>
References: <20201112163630.17177-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When unbinding the firmware device we need to make sure it has no
consumers left. Otherwise we'd leave them with a firmware handle
pointing at freed memory.

Keep a reference count of all consumers and introduce rpi_firmware_put()
which will permit automatically decrease the reference count upon
unbinding consumer drivers.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

Changes since v3:
- Use kref instead of waiting on refcount

 drivers/firmware/raspberrypi.c             | 37 +++++++++++++++++++---
 include/soc/bcm2835/raspberrypi-firmware.h |  2 ++
 2 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 2371d08bdd17..438e17074a97 100644
--- a/drivers/firmware/raspberrypi.c
+++ b/drivers/firmware/raspberrypi.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/dma-mapping.h>
+#include <linux/kref.h>
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of_platform.h>
@@ -27,6 +28,8 @@ struct rpi_firmware {
 	struct mbox_chan *chan; /* The property channel. */
 	struct completion c;
 	u32 enabled;
+
+	struct kref consumers;
 };
 
 static DEFINE_MUTEX(transaction_lock);
@@ -225,12 +228,27 @@ static void rpi_register_clk_driver(struct device *dev)
 						-1, NULL, 0);
 }
 
+static void rpi_firmware_delete(struct kref *kref)
+{
+	struct rpi_firmware *fw = container_of(kref, struct rpi_firmware,
+					       consumers);
+
+	mbox_free_channel(fw->chan);
+	kfree(fw);
+}
+
+void rpi_firmware_put(struct rpi_firmware *fw)
+{
+	kref_put(&fw->consumers, rpi_firmware_delete);
+}
+EXPORT_SYMBOL_GPL(rpi_firmware_put);
+
 static int rpi_firmware_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct rpi_firmware *fw;
 
-	fw = devm_kzalloc(dev, sizeof(*fw), GFP_KERNEL);
+	fw = kzalloc(sizeof(*fw), GFP_KERNEL);
 	if (!fw)
 		return -ENOMEM;
 
@@ -247,6 +265,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&fw->c);
+	kref_init(&fw->consumers);
 
 	platform_set_drvdata(pdev, fw);
 
@@ -275,25 +294,35 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
-	mbox_free_channel(fw->chan);
+
+	rpi_firmware_put(fw);
 
 	return 0;
 }
 
 /**
- * rpi_firmware_get - Get pointer to rpi_firmware structure.
  * @firmware_node:    Pointer to the firmware Device Tree node.
  *
+ * The reference to rpi_firmware has to be released with rpi_firmware_put().
+ *
  * Returns NULL is the firmware device is not ready.
  */
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 {
 	struct platform_device *pdev = of_find_device_by_node(firmware_node);
+	struct rpi_firmware *fw;
 
 	if (!pdev)
 		return NULL;
 
-	return platform_get_drvdata(pdev);
+	fw = platform_get_drvdata(pdev);
+	if (!fw)
+		return NULL;
+
+	if (!kref_get_unless_zero(&fw->consumers))
+		return NULL;
+
+	return fw;
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index cc9cdbc66403..fdfef7fe40df 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -140,6 +140,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 			  u32 tag, void *data, size_t len);
 int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
+void rpi_firmware_put(struct rpi_firmware *fw);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
@@ -154,6 +155,7 @@ static inline int rpi_firmware_property_list(struct rpi_firmware *fw,
 	return -ENOSYS;
 }
 
+static inline void rpi_firmware_put(struct rpi_firmware *fw) { }
 static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node)
 {
 	return NULL;
-- 
2.29.2

