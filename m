Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4141F51
	for <lists+linux-pwm@lfdr.de>; Wed, 12 Jun 2019 10:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731291AbfFLIgm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 12 Jun 2019 04:36:42 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:43468 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbfFLIgl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 12 Jun 2019 04:36:41 -0400
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 22FC54D06D;
        Wed, 12 Jun 2019 10:36:39 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Dan Murphy <dmurphy@ti.com>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-leds@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 3/3] leds-pwm.c: support ACPI via firmware-node framework
Date:   Wed, 12 Jun 2019 10:36:08 +0200
Message-Id: <5df196d63671205d6722d21bec0ae5857a6b91eb.1560327219.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1560327219.git.nikolaus.voss@loewensteinmedical.de>
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DT specific handling is replaced by firmware-node abstration to support
ACPI specification of PWM LEDS.

Example ASL:
Device (PWML)
{
    Name (_HID, "PRP0001")
    Name (_DSD, Package () {
          ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
          Package () { Package () {"compatible",
                                    Package () {"pwm-leds"}}}})

    Device (PWL0)
    {
        Name (_HID, "PRP0001")
        Name (_DSD, Package () {
              ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
              Package () {
                           Package () {"label", "alarm-led"},
                           Package () {"pwms", Package ()
                                       {\_SB_.PCI0.PWM, 0, 600000, 0}},
                           Package () {"linux,default-state", "off"}}})
    }
}

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/leds/leds-pwm.c | 45 ++++++++++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index af08bcdc4fd8..3ce4d53c0cc9 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -75,7 +75,7 @@ static inline size_t sizeof_pwm_leds_priv(int num_leds)
 }
 
 static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
-		       struct led_pwm *led, struct device_node *child)
+		       struct led_pwm *led, struct fwnode_handle *fwnode)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
 	struct pwm_args pargs;
@@ -88,8 +88,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	led_data->cdev.max_brightness = led->max_brightness;
 	led_data->cdev.flags = LED_CORE_SUSPENDRESUME;
 
-	if (child)
-		led_data->pwm = devm_of_pwm_get(dev, child, NULL);
+	if (fwnode)
+		led_data->pwm = devm_fwnode_pwm_get(dev, fwnode, NULL);
 	else
 		led_data->pwm = devm_pwm_get(dev, led->name);
 	if (IS_ERR(led_data->pwm)) {
@@ -114,7 +114,8 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	if (!led_data->period && (led->pwm_period_ns > 0))
 		led_data->period = led->pwm_period_ns;
 
-	ret = devm_of_led_classdev_register(dev, child, &led_data->cdev);
+	ret = devm_of_led_classdev_register(dev, to_of_node(fwnode),
+					    &led_data->cdev);
 	if (ret == 0) {
 		priv->num_leds++;
 		led_pwm_set(&led_data->cdev, led_data->cdev.brightness);
@@ -126,27 +127,35 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 	return ret;
 }
 
-static int led_pwm_create_of(struct device *dev, struct led_pwm_priv *priv)
+static int led_pwm_create_fwnode(struct device *dev, struct led_pwm_priv *priv)
 {
-	struct device_node *child;
+	struct fwnode_handle *fwnode;
 	struct led_pwm led;
 	int ret = 0;
 
 	memset(&led, 0, sizeof(led));
 
-	for_each_child_of_node(dev->of_node, child) {
-		led.name = of_get_property(child, "label", NULL) ? :
-			   child->name;
+	device_for_each_child_node(dev, fwnode) {
+		ret = fwnode_property_read_string(fwnode, "label", &led.name);
+		if (ret && is_of_node(fwnode))
+			led.name = to_of_node(fwnode)->name;
 
-		led.default_trigger = of_get_property(child,
-						"linux,default-trigger", NULL);
-		led.active_low = of_property_read_bool(child, "active-low");
-		of_property_read_u32(child, "max-brightness",
-				     &led.max_brightness);
+		if (!led.name) {
+			fwnode_handle_put(fwnode);
+			return -EINVAL;
+		}
 
-		ret = led_pwm_add(dev, priv, &led, child);
+		fwnode_property_read_string(fwnode, "linux,default-trigger",
+					    &led.default_trigger);
+
+		led.active_low = fwnode_property_read_bool(fwnode,
+							   "active-low");
+		fwnode_property_read_u32(fwnode, "max-brightness",
+					 &led.max_brightness);
+
+		ret = led_pwm_add(dev, priv, &led, fwnode);
 		if (ret) {
-			of_node_put(child);
+			fwnode_handle_put(fwnode);
 			break;
 		}
 	}
@@ -164,7 +173,7 @@ static int led_pwm_probe(struct platform_device *pdev)
 	if (pdata)
 		count = pdata->num_leds;
 	else
-		count = of_get_child_count(pdev->dev.of_node);
+		count = device_get_child_node_count(&pdev->dev);
 
 	if (!count)
 		return -EINVAL;
@@ -182,7 +191,7 @@ static int led_pwm_probe(struct platform_device *pdev)
 				break;
 		}
 	} else {
-		ret = led_pwm_create_of(&pdev->dev, priv);
+		ret = led_pwm_create_fwnode(&pdev->dev, priv);
 	}
 
 	if (ret)
-- 
2.17.1

