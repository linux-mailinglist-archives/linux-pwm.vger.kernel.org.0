Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0CE22DA4E
	for <lists+linux-pwm@lfdr.de>; Sun, 26 Jul 2020 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgGYXTD (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 25 Jul 2020 19:19:03 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:55099 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727978AbgGYXTC (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 25 Jul 2020 19:19:02 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id D78DA23E3F;
        Sun, 26 Jul 2020 01:18:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1595719139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2B8ttJ42dTzqVNdmFa3MX4YvKetSzzq/kFHiQy1AgA=;
        b=m+Ehso6CLT/Ck9ZM3H3xskkzr3b0I/HsSi5C7c8W7/rhwwnKDCS9yUZHTqX1ixQdSkg76Q
        7fvdoOusdlfr5U+dmdDTHxrezF70JkOR/v7TiXCFr/5lKUkqzq8+iLzlevnb1ak2ORh+DH
        CgJW6zUpxsigEGELWzDqEcP/0F+07U8=
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
Subject: [PATCH v6 03/13] mfd: simple-mfd-i2c: add sl28cpld support
Date:   Sun, 26 Jul 2020 01:18:24 +0200
Message-Id: <20200725231834.25642-4-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200725231834.25642-1-michael@walle.cc>
References: <20200725231834.25642-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Add the core support for the board management controller found on the
SMARC-sAL28 board.

At the moment, this controller is used on the Kontron SMARC-sAL28 board.

Signed-off-by: Michael Walle <michael@walle.cc>
---
Changes since v5:
 - none

Changes since v4:
 - new patch

 drivers/mfd/simple-mfd-i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/simple-mfd-i2c.c b/drivers/mfd/simple-mfd-i2c.c
index 45090ddad104..dd19abd41d30 100644
--- a/drivers/mfd/simple-mfd-i2c.c
+++ b/drivers/mfd/simple-mfd-i2c.c
@@ -37,6 +37,7 @@ static int simple_mfd_i2c_probe(struct i2c_client *i2c)
 }
 
 static const struct of_device_id simple_mfd_i2c_of_match[] = {
+	{ .compatible = "kontron,sl28cpld-r1" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, simple_mfd_i2c_of_match);
-- 
2.20.1

