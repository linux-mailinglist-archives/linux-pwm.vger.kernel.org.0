Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 444233696FD
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Apr 2021 18:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhDWQfQ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 23 Apr 2021 12:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbhDWQfP (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 23 Apr 2021 12:35:15 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B439BC061574
        for <linux-pwm@vger.kernel.org>; Fri, 23 Apr 2021 09:34:38 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZylI-0005bs-Qk; Fri, 23 Apr 2021 18:34:36 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1lZylI-0006Ja-9v; Fri, 23 Apr 2021 18:34:36 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel@pengutronix.de, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2] pwm: reword docs about pwm_apply_state()
Date:   Fri, 23 Apr 2021 18:32:26 +0200
Message-Id: <20210423163225.2438763-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210423074411.2167332-1-u.kleine-koenig@pengutronix.de>
References: <20210423074411.2167332-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

The main issue is that the current documentation talks about the
non-existent function pwm_get_last_applied_state. (This was right in the
context of
https://lore.kernel.org/linux-pwm/20210406073036.26857-1-u.kleine-koenig@pengutronix.de/
but was then missed to adapt when this patch was reduced to a
documentation update.)

While at is also clarify "last applied PWM state" to "PWM state that was
passed to the last invocation of pwm_apply_state()" to better
distinguish to the last actually implemented state and reword to drop a
word repetition.

Fixes: 539ed98e2bd3 ("pwm: Clarify documentation about pwm_get_state()")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

the only change compared to v1 is that I didn't use --word-diff to
create the patch. I just found out that git am cannot apply patches
created with --word-diff.

Best regards
Uwe

 Documentation/driver-api/pwm.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 381f3c46cdac..a7ca4f58305a 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -55,11 +55,11 @@ several parameter at once. For example, if you see pwm_config() and
 pwm_{enable,disable}() calls in the same function, this probably means you
 should switch to pwm_apply_state().
 
-The PWM user API also allows one to query the last applied PWM state with
-pwm_get_last_applied_state(). Note this is different to what the driver has
-actually implemented if the request cannot be implemented exactly with the
-hardware in use. There is currently no way for consumers to get the actually
-implemented settings.
+The PWM user API also allows one to query the PWM state that was passed to the
+last invocation of pwm_apply_state() using pwm_get_state(). Note this is
+different to what the driver has actually implemented if the request cannot be
+satisfied exactly with the hardware in use. There is currently no way for
+consumers to get the actually implemented settings.
 
 In addition to the PWM state, the PWM API also exposes PWM arguments, which
 are the reference PWM config one should use on this PWM.

base-commit: 64d7d074acd52e1bdff621f2cb86c0aae9bcef80
-- 
2.30.2

