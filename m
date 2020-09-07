Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 831742606A5
	for <lists+linux-pwm@lfdr.de>; Mon,  7 Sep 2020 23:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIGVk4 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 7 Sep 2020 17:40:56 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:36959 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgIGViT (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 7 Sep 2020 17:38:19 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 1C85A23E3F;
        Mon,  7 Sep 2020 23:38:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1599514696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9oaXYuQdxPh9VlCvAjj3novCGW4IyL0WbQroKGqFxtM=;
        b=uPshtjo/GA3gIz12NiyRGmPuMj2pN9fkgbi5nT7kk76Gslx1bNwISSzsOWAvcGAzrtu5zz
        4MwZAx3TVvnl61m/TYtvD/7l1WYfufRa0v/SRUUcLL8AfHkPm0/LBluD1PcCd5y2bB8AD3
        GvcMnXw21iEl4wW5pilTN65oNaaKo0c=
From:   Michael Walle <michael@walle.cc>
To:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
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
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH v9 03/13] mfd: simple-mfd-i2c: add sl28cpld support
Date:   Mon,  7 Sep 2020 23:37:52 +0200
Message-Id: <20200907213802.26745-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200907213802.26745-1-michael@walle.cc>
References: <20200907213802.26745-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the core support for the board management controller found on the
SMARC-sAL28 board.

Also add a virtual symbol which pulls in the simple-mfd-i2c driver and
provide a common symbol on which the subdevice drivers can depend on.

At the moment, this controller is used on the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
Changes since v8:
 - none

Changes since v7:
 - added MFD_SL28CPLD virtual Kconfig symbol
 - Please note, that I intentionally removed the Acked-for-MFD-by
   because of this change.

Changes since v6:
 - renamed "sl28cpld-r1" to "sl28cpld"

Changes since v5:
 - none

Changes since v4:
 - new patch

 drivers/mfd/Kconfig          | 10 ++++++++++
 drivers/mfd/simple-mfd-i2c.c |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 62f2838da66c..4b918fdcc7c7 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1174,6 +1174,16 @@ config MFD_SIMPLE_MFD_I2C
 	  sub-devices represented by child nodes in Device Tree will be
 	  subsequently registered.
 
+config MFD_SL28CPLD
+	tristate "Kontron sl28cpld Board Management Controller"
+	select MFD_SIMPLE_MFD_I2C
+	help
+	  Say yes here to enable support for the Kontron sl28cpld board
+	  management controller.
+
+	  It can be found on the following boards:
+		* SMARC-sAL28
+
 config MFD_SM501
 	tristate "Silicon Motion SM501"
 	depends on HAS_DMA
diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 28e96a246be1..87f684cff9a1 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -38,6 +38,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{ .compatible = "kontron,sl28cpld" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.20.1

