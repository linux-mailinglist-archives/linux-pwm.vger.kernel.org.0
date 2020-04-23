Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8F31B628C
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Apr 2020 19:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgDWRqf (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Apr 2020 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729997AbgDWRqb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Apr 2020 13:46:31 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EC8C09B042;
        Thu, 23 Apr 2020 10:46:31 -0700 (PDT)
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id C4AA22305A;
        Thu, 23 Apr 2020 19:46:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1587663989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEc2Gou41BL3m+JkXNh0S7dWuskCnoHw4qZ/tnV0NvI=;
        b=Su+MiabBuDU2j7Z62BVZ3bAwqxj1h0oWVUDkNQx67hVzjrvYYBTwSIYm2Y0m2JAqdjbK+M
        WNK50XO9/gIZ7aC4cbdxXplDXy0G3v4TrYPTJcV9qCjuCB7HVtebYwkbMPp4/AMlu98tnH
        XUjRmwcFuzKXEqExHLQS6zwMvS9kG8g=
From:   Michael Walle <michael@walle.cc>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-pwm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>, Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v3 03/16] mfd: mfd-core: match device tree node against reg property
Date:   Thu, 23 Apr 2020 19:45:30 +0200
Message-Id: <20200423174543.17161-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200423174543.17161-1-michael@walle.cc>
References: <20200423174543.17161-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: C4AA22305A
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[1.007];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[25];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,linuxfoundation.org,walle.cc];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There might be multiple children with the device tree compatible, for
example if a MFD has multiple instances of the same function. In this
case only the first is matched and the other children get a wrong
of_node reference.
Add a new option to match also against the unit address of the child
node. Additonally, a new helper OF_MFD_CELL_REG is added.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/mfd/mfd-core.c   | 29 ++++++++++++++++++++---------
 include/linux/mfd/core.h | 26 ++++++++++++++++++++------
 2 files changed, 40 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index e735565969b3..4ecb376338f7 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -117,6 +117,7 @@ static int mfd_add_device(struct device *parent, int id,
 	struct device_node *np = NULL;
 	int ret = -ENOMEM;
 	int platform_id;
+	u32 of_reg;
 	int r;
 
 	if (id == PLATFORM_DEVID_AUTO)
@@ -151,16 +152,26 @@ static int mfd_add_device(struct device *parent, int id,
 
 	if (parent->of_node && cell->of_compatible) {
 		for_each_child_of_node(parent->of_node, np) {
-			if (of_device_is_compatible(np, cell->of_compatible)) {
-				if (!of_device_is_available(np)) {
-					/* Ignore disabled devices error free */
-					ret = 0;
-					goto fail_alias;
-				}
-				pdev->dev.of_node = np;
-				pdev->dev.fwnode = &np->fwnode;
-				break;
+			if (!of_device_is_compatible(np, cell->of_compatible))
+				continue;
+
+			/* also match the unit address if set */
+			if (cell->of_reg & MFD_OF_REG_VALID) {
+				if (of_property_read_u32(np, "reg", &of_reg))
+					continue;
+				if ((cell->of_reg & MFD_OF_REG_MASK) != of_reg)
+					continue;
 			}
+
+			if (!of_device_is_available(np)) {
+				/* Ignore disabled devices error free */
+				ret = 0;
+				goto fail_alias;
+			}
+
+			pdev->dev.of_node = np;
+			pdev->dev.fwnode = &np->fwnode;
+			break;
 		}
 	}
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index d01d1299e49d..c2c0ad6b14f3 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -13,8 +13,11 @@
 #include <linux/platform_device.h>
 
 #define MFD_RES_SIZE(arr) (sizeof(arr) / sizeof(struct resource))
+#define MFD_OF_REG_VALID	BIT(31)
+#define MFD_OF_REG_MASK		GENMASK(30, 0)
 
-#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _match)\
+#define MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
+		     _of_reg, _match)					\
 	{								\
 		.name = (_name),					\
 		.resources = (_res),					\
@@ -22,24 +25,32 @@
 		.platform_data = (_pdata),				\
 		.pdata_size = (_pdsize),				\
 		.of_compatible = (_compat),				\
+		.of_reg = (_of_reg),					\
 		.acpi_match = (_match),					\
 		.id = (_id),						\
 	}
 
+#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat,	\
+			_of_reg)					\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
+		     ((_of_reg) | MFD_OF_REG_VALID), NULL)		\
+
 #define OF_MFD_CELL(_name, _res, _pdata, _pdsize,_id, _compat)		\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, NULL)	\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat,	\
+		     0, NULL)						\
 
 #define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match)	\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, _match)	\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0,	\
+		     _match)						\
 
 #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id)		\
-	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, NULL)	\
+	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, NULL) \
 
 #define MFD_CELL_RES(_name, _res)					\
-	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, NULL)		\
+	MFD_CELL_ALL(_name, _res, NULL, 0, 0, NULL, 0, NULL)		\
 
 #define MFD_CELL_NAME(_name)						\
-	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, NULL)		\
+	MFD_CELL_ALL(_name, NULL, NULL, 0, 0, NULL, 0, NULL)		\
 
 struct irq_domain;
 struct property_entry;
@@ -78,6 +89,9 @@ struct mfd_cell {
 	 */
 	const char		*of_compatible;
 
+	/* matching the reg property if set */
+	unsigned int		of_reg;
+
 	/* Matches ACPI */
 	const struct mfd_cell_acpi_match	*acpi_match;
 
-- 
2.20.1

