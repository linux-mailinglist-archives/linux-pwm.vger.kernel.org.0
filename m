Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3FE2D7B76
	for <lists+linux-pwm@lfdr.de>; Fri, 11 Dec 2020 17:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390064AbgLKQtZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 11 Dec 2020 11:49:25 -0500
Received: from mx2.suse.de ([195.135.220.15]:34276 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389714AbgLKQsv (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 11 Dec 2020 11:48:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E06B5AE55;
        Fri, 11 Dec 2020 16:48:08 +0000 (UTC)
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
Subject: [PATCH v6 01/11] firmware: raspberrypi: Keep count of all consumers
Date:   Fri, 11 Dec 2020 17:47:50 +0100
Message-Id: <20201211164801.7838-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201211164801.7838-1-nsaenzjulienne@suse.de>
References: <20201211164801.7838-1-nsaenzjulienne@suse.de>
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
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

---
Changes since v5:
 - Add comment to avoid people blindly switching the memory allocation
   to the devm variant.
 - Fix function documentation as per Florian's comment.

 Changes since v3:
- Use kref instead of waiting on refcount

 drivers/firmware/raspberrypi.c             | 40 ++++++++++++++++++++--
 include/soc/bcm2835/raspberrypi-firmware.h |  2 ++
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 30259dc9b805..b65e4c495772 100644
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
@@ -225,12 +228,31 @@ static void rpi_register_clk_driver(struct device *dev)
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
+	/*
+	 * Memory will be freed by rpi_firmware_delete() once all users have
+	 * released their firmware handles. Don't use devm_kzalloc() here.
+	 */
+	fw = kzalloc(sizeof(*fw), GFP_KERNEL);
 	if (!fw)
 		return -ENOMEM;
 
@@ -247,6 +269,7 @@ static int rpi_firmware_probe(struct platform_device *pdev)
 	}
 
 	init_completion(&fw->c);
+	kref_init(&fw->consumers);
 
 	platform_set_drvdata(pdev, fw);
 
@@ -275,7 +298,8 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
-	mbox_free_channel(fw->chan);
+
+	rpi_firmware_put(fw);
 
 	return 0;
 }
@@ -284,16 +308,26 @@ static int rpi_firmware_remove(struct platform_device *pdev)
  * rpi_firmware_get - Get pointer to rpi_firmware structure.
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

