Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC32338CE8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Mar 2021 13:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhCLMZn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 12 Mar 2021 07:25:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:57234 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231450AbhCLMZ0 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 12 Mar 2021 07:25:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 623F0B0B6;
        Fri, 12 Mar 2021 12:25:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     u.kleine-koenig@pengutronix.de
Cc:     f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        wahrenst@gmx.net, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, p.zabel@pengutronix.de,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        linux-clk@vger.kernel.org, sboyd@kernel.org,
        linux-rpi-kernel@lists.infradead.org, bgolaszewski@baylibre.com,
        andy.shevchenko@gmail.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH v8 08/11] input: raspberrypi-ts: Release firmware handle when not needed
Date:   Fri, 12 Mar 2021 13:24:51 +0100
Message-Id: <20210312122454.24480-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210312122454.24480-1-nsaenzjulienne@suse.de>
References: <20210312122454.24480-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

There is no use for the firmware interface after getting the touch
buffer address, so release it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
---

Changes since v5:
 - Correct commit message

Changes since v3:
 - Release firmware handle in probe function

Changes since v2:
 - Use devm_rpi_firmware_get(), instead of remove function

 drivers/input/touchscreen/raspberrypi-ts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/raspberrypi-ts.c b/drivers/input/touchscreen/raspberrypi-ts.c
index ef6aaed217cf..5000f5fd9ec3 100644
--- a/drivers/input/touchscreen/raspberrypi-ts.c
+++ b/drivers/input/touchscreen/raspberrypi-ts.c
@@ -160,7 +160,7 @@ static int rpi_ts_probe(struct platform_device *pdev)
 	touchbuf = (u32)ts->fw_regs_phys;
 	error = rpi_firmware_property(fw, RPI_FIRMWARE_FRAMEBUFFER_SET_TOUCHBUF,
 				      &touchbuf, sizeof(touchbuf));
-
+	rpi_firmware_put(fw);
 	if (error || touchbuf != 0) {
 		dev_warn(dev, "Failed to set touchbuf, %d\n", error);
 		return error;
-- 
2.30.1

