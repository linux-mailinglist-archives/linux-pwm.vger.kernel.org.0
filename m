Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620CC2812CB
	for <lists+linux-pwm@lfdr.de>; Fri,  2 Oct 2020 14:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBMdA (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 2 Oct 2020 08:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725964AbgJBMdA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Fri, 2 Oct 2020 08:33:00 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9738C0613D0;
        Fri,  2 Oct 2020 05:32:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 747C723F20F;
        Fri,  2 Oct 2020 14:32:58 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.988
X-Spam-Level: 
X-Spam-Status: No, score=-2.988 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.088, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D26-kqQQJXtG; Fri,  2 Oct 2020 14:32:56 +0200 (CEST)
Received: from lem-wkst-02.lemonage.de. (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPA id 6D0BE23F087;
        Fri,  2 Oct 2020 14:32:56 +0200 (CEST)
From:   poeschel@lemonage.de
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "GitAuthor: Lars Poeschel" <poeschel@lemonage.de>,
        linux-kernel@vger.kernel.org (open list),
        linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
        linux-doc@vger.kernel.org (open list:DOCUMENTATION)
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] Documentation: Reflect the changes to pwm sysfs
Date:   Fri,  2 Oct 2020 14:32:44 +0200
Message-Id: <20201002123247.3073352-1-poeschel@lemonage.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002123048.3073128-1-poeschel@lemonage.de>
References: <20201002123048.3073128-1-poeschel@lemonage.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

From: Lars Poeschel <poeschel@lemonage.de>

This is an update to the documentation to reflect the change to pwm
sysfs.

/sys/class/pwm/pwmchipN/pwmX style exports are marked as deprecated.
They are still available as symlinks to the new interface.
New exports are available as /sys/class/pwm/pwm-N-X

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
---
 Documentation/ABI/obsolete/sysfs-class-pwm | 52 +++++++++++++++++++
 Documentation/ABI/testing/sysfs-class-pwm  | 60 ++++++++++++----------
 Documentation/driver-api/pwm.rst           |  7 +--
 3 files changed, 90 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/sysfs-class-pwm

diff --git a/Documentation/ABI/obsolete/sysfs-class-pwm b/Documentation/ABI/obsolete/sysfs-class-pwm
new file mode 100644
index 000000000000..92ba4f3586e9
--- /dev/null
+++ b/Documentation/ABI/obsolete/sysfs-class-pwm
@@ -0,0 +1,52 @@
+What:		/sys/class/pwm/pwmchipN/pwmX
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+Description:
+		A /sys/class/pwm/pwmchipN/pwmX directory is created for
+		each exported PWM channel where X is the exported PWM
+		channel number.
+
+What:		/sys/class/pwm/pwmchipN/pwmX/period
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+Description:
+		Sets the PWM signal period in nanoseconds.
+
+What:		/sys/class/pwm/pwmchipN/pwmX/duty_cycle
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+Description:
+		Sets the PWM signal duty cycle in nanoseconds.
+
+What:		/sys/class/pwm/pwmchipN/pwmX/polarity
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+Description:
+		Sets the output polarity of the PWM signal to "normal" or
+		"inversed".
+
+What:		/sys/class/pwm/pwmchipN/pwmX/enable
+Date:		May 2013
+KernelVersion:	3.11
+Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+Description:
+		Enable/disable the PWM signal.
+		0 is disabled
+		1 is enabled
+
+What:		/sys/class/pwm/pwmchipN/pwmX/capture
+Date:		June 2016
+KernelVersion:	4.8
+Contact:	Lee Jones <lee.jones@linaro.org>
+Description:
+		Capture information about a PWM signal. The output format is a
+		pair unsigned integers (period and duty cycle), separated by a
+		single space.
+
+  This ABI is deprecated and will be removed after 2025. It is replaced by
+  another sysfs ABI documented in Documentation/ABI/testing/sysfs-class-pwm
+
diff --git a/Documentation/ABI/testing/sysfs-class-pwm b/Documentation/ABI/testing/sysfs-class-pwm
index c20e61354561..87582dea1027 100644
--- a/Documentation/ABI/testing/sysfs-class-pwm
+++ b/Documentation/ABI/testing/sysfs-class-pwm
@@ -38,50 +38,58 @@ Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
 Description:
 		Unexports a PWM channel.
 
-What:		/sys/class/pwm/pwmchipN/pwmX
-Date:		May 2013
-KernelVersion:	3.11
-Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+What:		/sys/class/pwm/pwm-N-X
+		/sys/class/pwm/pwmchipN/pwm-N-X
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
-		A /sys/class/pwm/pwmchipN/pwmX directory is created for
+		A /sys/class/pwm/pwm-N-X directory is created for
 		each exported PWM channel where X is the exported PWM
-		channel number.
+		channel number and N is the number of the pwmchip
+		that this pwm belongs to.
+		/sys/class/pwm/pwmchipN/pwm-N-X is the same
 
-What:		/sys/class/pwm/pwmchipN/pwmX/period
-Date:		May 2013
-KernelVersion:	3.11
-Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+What:		/sys/class/pwm/pwm-N-X/period
+		/sys/class/pwm/pwmchipN/pwm-N-X/period
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
 		Sets the PWM signal period in nanoseconds.
 
-What:		/sys/class/pwm/pwmchipN/pwmX/duty_cycle
-Date:		May 2013
-KernelVersion:	3.11
-Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+What:		/sys/class/pwm/pwm-N-X/duty_cycle
+		/sys/class/pwm/pwmchipN/pwm-N-X/duty_cycle
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
 		Sets the PWM signal duty cycle in nanoseconds.
 
-What:		/sys/class/pwm/pwmchipN/pwmX/polarity
-Date:		May 2013
-KernelVersion:	3.11
-Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+What:		/sys/class/pwm/pwm-N-X/polarity
+		/sys/class/pwm/pwmchipN/pwm-N-X/polarity
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
 		Sets the output polarity of the PWM signal to "normal" or
 		"inversed".
 
-What:		/sys/class/pwm/pwmchipN/pwmX/enable
-Date:		May 2013
-KernelVersion:	3.11
-Contact:	H Hartley Sweeten <hsweeten@visionengravers.com>
+What:		/sys/class/pwm/pwm-N-X/enable
+		/sys/class/pwm/pwmchipN/pwm-N-X/enable
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
 		Enable/disable the PWM signal.
 		0 is disabled
 		1 is enabled
 
-What:		/sys/class/pwm/pwmchipN/pwmX/capture
-Date:		June 2016
-KernelVersion:	4.8
-Contact:	Lee Jones <lee.jones@linaro.org>
+What:		/sys/class/pwm/pwm-N-X/capture
+		/sys/class/pwm/pwmchipN/pwm-N-X/capture
+Date:		October 2020
+KernelVersion:	5.9
+Contact:	Lars Poeschel <poeschel@lemonage.de>
 Description:
 		Capture information about a PWM signal. The output format is a
 		pair unsigned integers (period and duty cycle), separated by a
diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index ab62f1bb0366..9361cd9b136c 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -89,9 +89,10 @@ will find:
 
 The PWM channels are numbered using a per-chip index from 0 to npwm-1.
 
-When a PWM channel is exported a pwmX directory will be created in the
-pwmchipN directory it is associated with, where X is the number of the
-channel that was exported. The following properties will then be available:
+When a PWM channel is exported a pwm-N-X directory will be created in the
+/sys/class/pwm/ directory. N is number of the PWM chip this pwm is associated
+with and X is the number of the channel that was exported. The following
+properties will then be available:
 
   period
     The total period of the PWM signal (read/write).
-- 
2.28.0

