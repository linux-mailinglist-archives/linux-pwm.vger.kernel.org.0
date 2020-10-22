Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD46296245
	for <lists+linux-pwm@lfdr.de>; Thu, 22 Oct 2020 18:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S369057AbgJVQAF (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 22 Oct 2020 12:00:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:48470 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S368855AbgJVP7I (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Thu, 22 Oct 2020 11:59:08 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4A8ADAC23;
        Thu, 22 Oct 2020 15:59:06 +0000 (UTC)
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
        sboyd@kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: [PATCH v2 01/10] firmware: raspberrypi: Introduce rpi_firmware_put()
Date:   Thu, 22 Oct 2020 17:58:48 +0200
Message-Id: <20201022155858.20867-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022155858.20867-1-nsaenzjulienne@suse.de>
References: <20201022155858.20867-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

When unbinding the firmware device we need to make sure it has no
consumers left. Otherwise we'd leave them with a firmware handle
pointing at freed memory.

Keep a reference count of all consumers and make sure they all finished
unbinding before we do.

Suggested-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

@Uwe: I didn't found it necessary to call 'try_module_get()' as the rest
      of modules depend on the 'rpi_firmware_get/put()' symbols which already
      block users from unloading the module prematurely.

 drivers/firmware/raspberrypi.c             | 30 +++++++++++++++++++++-
 include/soc/bcm2835/raspberrypi-firmware.h |  3 +++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
index 2371d08bdd17..e5ba609e3985 100644
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
 
@@ -275,6 +282,8 @@ static int rpi_firmware_remove(struct platform_device *pdev)
 	rpi_hwmon = NULL;
 	platform_device_unregister(rpi_clk);
 	rpi_clk = NULL;
+
+	wait_event(fw->wait, refcount_dec_if_one(&fw->consumers));
 	mbox_free_channel(fw->chan);
 
 	return 0;
@@ -289,14 +298,33 @@ static int rpi_firmware_remove(struct platform_device *pdev)
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
+	if (!refcount_inc_not_zero(&fw->consumers))
+		return NULL;
+
+	return fw;
 }
 EXPORT_SYMBOL_GPL(rpi_firmware_get);
 
+/**
+ * rpi_firmware_put - Put pointer to rpi_firmware structure.
+ * @rpi_firmware:    Pointer to struct rpi_firmware
+ */
+void rpi_firmware_put(struct rpi_firmware *fw)
+{
+	refcount_dec(&fw->consumers);
+	wake_up(&fw->wait);
+}
+EXPORT_SYMBOL_GPL(rpi_firmware_put);
+
 static const struct of_device_id rpi_firmware_of_match[] = {
 	{ .compatible = "raspberrypi,bcm2835-firmware", },
 	{},
diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index cc9cdbc66403..7836ea51fbdf 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -141,6 +141,7 @@ int rpi_firmware_property(struct rpi_firmware *fw,
 int rpi_firmware_property_list(struct rpi_firmware *fw,
 			       void *data, size_t tag_size);
 struct rpi_firmware *rpi_firmware_get(struct device_node *firmware_node);
+void rpi_firmware_put(struct rpi_firmware *fw);
 #else
 static inline int rpi_firmware_property(struct rpi_firmware *fw, u32 tag,
 					void *data, size_t len)
@@ -158,6 +159,8 @@ static inline struct rpi_firmware *rpi_firmware_get(struct device_node *firmware
 {
 	return NULL;
 }
+
+void rpi_firmware_put(struct rpi_firmware *fw) { }
 #endif
 
 #endif /* __SOC_RASPBERRY_FIRMWARE_H__ */
-- 
2.28.0

