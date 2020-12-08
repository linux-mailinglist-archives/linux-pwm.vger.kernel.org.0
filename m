Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DD82D28A0
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Dec 2020 11:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbgLHKQw (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 8 Dec 2020 05:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgLHKQw (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 8 Dec 2020 05:16:52 -0500
Received: from antares.kleine-koenig.org (antares.kleine-koenig.org [IPv6:2a01:4f8:c0c:3a97::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A5A1C061749
        for <linux-pwm@vger.kernel.org>; Tue,  8 Dec 2020 02:16:12 -0800 (PST)
Received: by antares.kleine-koenig.org (Postfix, from userid 1000)
        id 5A484A9E91B; Tue,  8 Dec 2020 11:16:09 +0100 (CET)
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org
Subject: [PATCH v2] staging: greybus: Add TODO item about modernizing the pwm code
Date:   Tue,  8 Dec 2020 11:16:07 +0100
Message-Id: <20201208101607.42785-1-uwe@kleine-koenig.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

drivers/staging/greybus/pwm.c uses the old style PWM callbacks, new drivers
should stick to the atomic API instead.

Signed-off-by: Uwe Kleine-König <uwe@kleine-koenig.org>
---
On 12/8/20 10:39 AM, Johan Hovold wrote:
> No sign off?
> 
> Please also add a staging prefix since this part of greybus still lives
> there.

That after all these years I still fail occasionally to add a sign-off
... /me shakes his head about himself.

Anyhow, here comes a v2, also with the requested prefix.


 drivers/staging/greybus/TODO | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/greybus/TODO b/drivers/staging/greybus/TODO
index 31f1f2cb401c..6461e0132fe3 100644
--- a/drivers/staging/greybus/TODO
+++ b/drivers/staging/greybus/TODO
@@ -1,3 +1,5 @@
 * Convert all uses of the old GPIO API from <linux/gpio.h> to the
   GPIO descriptor API in <linux/gpio/consumer.h> and look up GPIO
   lines from device tree or ACPI.
+* Make pwm.c use the struct pwm_ops::apply instead of ::config, ::set_polarity,
+  ::enable and ::disable.
-- 
2.29.2

