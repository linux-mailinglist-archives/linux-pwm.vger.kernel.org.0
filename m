Return-Path: <linux-pwm+bounces-105-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B193E7F2FC5
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 14:52:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40D19B20FB0
	for <lists+linux-pwm@lfdr.de>; Tue, 21 Nov 2023 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E133D3B8;
	Tue, 21 Nov 2023 13:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F279F10C1
	for <linux-pwm@vger.kernel.org>; Tue, 21 Nov 2023 05:52:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAP-0005Pa-11; Tue, 21 Nov 2023 14:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAO-00Aayl-3k; Tue, 21 Nov 2023 14:51:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1r5RAN-004xdE-Qg; Tue, 21 Nov 2023 14:51:51 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jonathan Corbet <corbet@lwn.net>,
	Thierry Reding <thierry.reding@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	James Clark <james.clark@arm.com>,
	Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-doc@vger.kernel.org,
	kernel@pengutronix.de,
	linux-pwm@vger.kernel.org
Subject: [PATCH v3 037/108] pwm: Provide devm_pwmchip_alloc() function
Date: Tue, 21 Nov 2023 14:49:39 +0100
Message-ID: <20231121134901.208535-38-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
References: <20231121134901.208535-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=5470; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=33tk1ra3E7BD8UFlUXt1nlBlRpOf0+9wzBGIYwmD0w8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlXLV13JFQ2jSBSYxXpUv9d/Ktdh466khPgnySq O8g/eU3KjWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZVy1dQAKCRCPgPtYfRL+ TnRpB/9RbdQd2mUV1NTJmpfIIEkhlYHXvynu0S8CbE/SPRq+5dBWZvaHyjyz1mJmKJHemFS/pns AOHLunCN2ae8MYu0W69WqG8tMQ2jkQ68XrcuT2k+g2333qXloV7io9r4nyKUAEH3dN1J64NzIro LZr76SsX4gGYHLRzTOOBJJ/M/gWWPt8+/OfYNSCyGK9ul8NlhRAvxMwOfJ8qbQj1hP4H3QJ7/0q VA7ud+WWFImLYpJIxIa8dGVwhoAmzn03SO1W+VxZJ/i7l0hZIVBTJg8Dd5EcRnQFHnZH+U38/yp XVHh1w4iqED8L4yh2pMDt5X5lbG7Zs9s4CQdQc2iemDtmPmL
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

This function allocates a struct pwm_chip and driver data. Compared to
the status quo the split into pwm_chip and driver data is new, otherwise
it doesn't change anything relevant (yet).

The intention is that after all drivers are switched to use this
allocation function, its possible to add a struct device to struct
pwm_chip to properly track the latter's lifetime without touching all
drivers again. Proper lifetime tracking is a necessary precondition to
introduce character device support for PWMs (that implements atomic
setting and doesn't suffer from the sysfs overhead of the /sys/class/pwm
userspace support).

The new function pwmchip_priv() (obviously?) only works for chips
allocated with devm_pwmchip_alloc().

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 .../driver-api/driver-model/devres.rst        |  1 +
 Documentation/driver-api/pwm.rst              | 10 +++---
 drivers/pwm/core.c                            | 32 ++++++++++++++++---
 include/linux/pwm.h                           |  5 +++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index c5f99d834ec5..e4df72c408d2 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -420,6 +420,7 @@ POWER
   devm_reboot_mode_unregister()
 
 PWM
+  devm_pwmchip_alloc()
   devm_pwmchip_add()
   devm_pwm_get()
   devm_fwnode_pwm_get()
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index bb264490a87a..994ea5368805 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -134,11 +134,11 @@ to implement the pwm_*() functions itself. This means that it's impossible
 to have multiple PWM drivers in the system. For this reason it's mandatory
 for new drivers to use the generic PWM framework.
 
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
+A new PWM controller/chip can be allocated using devm_pwmchip_alloc, then added
+using pwmchip_add() and removed again with pwmchip_remove(). pwmchip_add()
+takes a filled in struct pwm_chip as argument which provides a description of
+the PWM chip, the number of PWM devices provided by the chip and the
+chip-specific implementation of the supported PWM operations to the framework.
 
 When implementing polarity support in a PWM driver, make sure to respect the
 signal conventions in the PWM framework. By definition, normal polarity
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 58a9d3df73a1..0346709b60d8 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -196,6 +196,30 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 	return true;
 }
 
+void *pwmchip_priv(struct pwm_chip *chip)
+{
+	return (void *)chip + sizeof(*chip);
+}
+EXPORT_SYMBOL_GPL(pwmchip_priv);
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv)
+{
+	struct pwm_chip *chip;
+	size_t alloc_size;
+
+	alloc_size = size_add(sizeof(*chip), sizeof_priv);
+
+	chip = devm_kzalloc(parent, alloc_size, GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	chip->dev = parent;
+	chip->npwm = npwm;
+
+	return chip;
+}
+EXPORT_SYMBOL_GPL(devm_pwmchip_alloc);
+
 /**
  * __pwmchip_add() - register a new PWM chip
  * @chip: the PWM chip to add
@@ -208,9 +232,8 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
  */
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 {
-	struct pwm_device *pwm;
-	unsigned int i;
 	int ret;
+	unsigned i;
 
 	if (!chip || !chip->dev || !chip->ops || !chip->npwm)
 		return -EINVAL;
@@ -220,7 +243,7 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 
 	chip->owner = owner;
 
-	chip->pwms = kcalloc(chip->npwm, sizeof(*pwm), GFP_KERNEL);
+	chip->pwms = kcalloc(chip->npwm, sizeof(*chip->pwms), GFP_KERNEL);
 	if (!chip->pwms)
 		return -ENOMEM;
 
@@ -234,9 +257,8 @@ int __pwmchip_add(struct pwm_chip *chip, struct module *owner)
 	}
 
 	chip->id = ret;
-
 	for (i = 0; i < chip->npwm; i++) {
-		pwm = &chip->pwms[i];
+		struct pwm_device *pwm = &chip->pwms[i];
 
 		pwm->chip = chip;
 		pwm->hwpwm = i;
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index dda3a68e06dc..3c62cf329ee0 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -5,6 +5,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
+#include <linux/compiler_attributes.h>
 
 struct pwm_chip;
 
@@ -385,6 +386,10 @@ static inline void pwm_disable(struct pwm_device *pwm)
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
 
+void *pwmchip_priv(struct pwm_chip *chip) __attribute_const__;
+
+struct pwm_chip *devm_pwmchip_alloc(struct device *parent, unsigned int npwm, size_t sizeof_priv);
+
 int __pwmchip_add(struct pwm_chip *chip, struct module *owner);
 #define pwmchip_add(chip) __pwmchip_add(chip, THIS_MODULE)
 void pwmchip_remove(struct pwm_chip *chip);
-- 
2.42.0


