Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF59188FBE
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 21:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgCQUwE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 16:52:04 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:34185 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgCQUuv (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 16:50:51 -0400
Received: from apollo.fritz.box (unknown [IPv6:2a02:810c:c200:2e91:6257:18ff:fec4:ca34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0EC5523E4D;
        Tue, 17 Mar 2020 21:50:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1584478248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O32DELDjRU5+PMHK61TCvsZ+IJXO1DNHAkIMR41h4Oo=;
        b=BmHiCugHoAJPjWdcPsqC/XucGyimUwyR7ljjoG2WIKdykksBgKQ8THpqZIbWocuQYvpvOw
        55hBB22TCO4PjNoISSMzLGGrf7TkFC6xc+6Zr+M2zViunfOf0Cik6S8+mN2sdBFKfKNwab
        GPV93vOrnwD822EFBaNiWGtbPtzT6cA=
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
        Marc Zyngier <maz@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH 02/18] mfd: mfd-core: Don't overwrite the dma_mask of the child device
Date:   Tue, 17 Mar 2020 21:50:01 +0100
Message-Id: <20200317205017.28280-3-michael@walle.cc>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317205017.28280-1-michael@walle.cc>
References: <20200317205017.28280-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++
X-Spam-Level: ******
X-Rspamd-Server: web
X-Spam-Status: Yes, score=6.40
X-Spam-Score: 6.40
X-Rspamd-Queue-Id: 0EC5523E4D
X-Spamd-Result: default: False [6.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_SPAM(0.00)[0.549];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[23];
         MID_CONTAINS_FROM(1.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         ASN(0.00)[asn:31334, ipnet:2a02:810c:8000::/33, country:DE];
         FREEMAIL_CC(0.00)[linaro.org,baylibre.com,kernel.org,suse.com,roeck-us.net,gmail.com,pengutronix.de,linux-watchdog.org,nxp.com,linutronix.de,lakedaemon.net,walle.cc,arm.com];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam: Yes
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Commit cdfee5623290 ("driver core: initialize a default DMA mask for
platform device") initialize the DMA of a platform device. But if the
parent doesn't have a dma_mask set, for example if it's an I2C device,
the dma_mask of the child platform device will be set to zero again.
Which leads to many "DMA mask not set" warnings, if the MFD cell has the
of_compatible property set.

[    1.877937] sl28cpld-pwm sl28cpld-pwm: DMA mask not set
[    1.883282] sl28cpld-pwm sl28cpld-pwm.0: DMA mask not set
[    1.888795] sl28cpld-gpio sl28cpld-gpio: DMA mask not set

Thus don't overwrite the dma_mask of the children. Instead set the
dma_mask of the platform device.

Signed-off-by: Michael Walle <michael@walle.cc>
Suggested-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/mfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index f5a73af60dd4..e735565969b3 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -138,7 +138,7 @@ static int mfd_add_device(struct device *parent, int id,
 
 	pdev->dev.parent = parent;
 	pdev->dev.type = &mfd_dev_type;
-	pdev->dev.dma_mask = parent->dma_mask;
+	pdev->platform_dma_mask = parent->dma_mask ? *parent->dma_mask : 0;
 	pdev->dev.dma_parms = parent->dma_parms;
 	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;
 
-- 
2.20.1

