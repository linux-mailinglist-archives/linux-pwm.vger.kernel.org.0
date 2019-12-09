Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28602117887
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2019 22:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIVci (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 9 Dec 2019 16:32:38 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:45047 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfLIVci (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 9 Dec 2019 16:32:38 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieQdw-0004TS-Lu; Mon, 09 Dec 2019 22:32:36 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1ieQdw-0004JO-6V; Mon, 09 Dec 2019 22:32:36 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-pwm@vger.kernel.org, kernel@pengutronix.de
Subject: [PATCH 2/2] docs: pwm: rework documentation for the framework
Date:   Mon,  9 Dec 2019 22:32:33 +0100
Message-Id: <20191209213233.29574-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
References: <20191209213233.29574-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Rewrite most of the documentation to have the focus on the atomic API
and mention the legacy stuff only shortly.

The paragraphs about Locking and Helpers is dropped as they mostly
describe development outlooks which didn't happen yet (since the promise
to fix stuff "soon" was introduced in 2011).

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
Hello,

I hand-edited this patch to hopefully make it easier to review. Note that
once applied it is shown a bit more compact and thus harder to see the
actual differences.

Best regards
Uwe

 Documentation/driver-api/pwm.rst | 171 ++++++++++++++++---------------
 1 file changed, 86 insertions(+), 85 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index 8f31bcdbb631..bab9f34aa1e4 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -11,110 +11,111 @@ found as discrete devices on SoCs which have no fixed purpose. It's
 up to the board designer to connect them to LEDs or fans. To provide
 this kind of flexibility the generic PWM API exists.
 
-Identifying PWMs
-----------------
-
-Users of the legacy PWM API use unique IDs to refer to PWM devices.
-
-Instead of referring to a PWM device via its unique ID, board setup code
-should instead register a static mapping that can be used to match PWM
-consumers to providers, as given in the following example::
-
-	static struct pwm_lookup board_pwm_lookup[] = {
-		PWM_LOOKUP("tegra-pwm", 0, "pwm-backlight", NULL,
-			   50000, PWM_POLARITY_NORMAL),
-	};
-
-	static void __init board_init(void)
-	{
-		...
-		pwm_add_table(board_pwm_lookup, ARRAY_SIZE(board_pwm_lookup));
-		...
-	}
-
-Using PWMs
-----------
-
-Legacy users can request a PWM device using pwm_request() and free it
-after usage with pwm_free().
-
-New users should use the pwm_get() function and pass to it the consumer
-device or a consumer name. pwm_put() is used to free the PWM device. Managed
-variants of these functions, devm_pwm_get() and devm_pwm_put(), also exist.
-
-After being requested, a PWM has to be configured using::
-
-	int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
-
-This API controls both the PWM period/duty_cycle config and the
-enable/disable state.
-
-The pwm_config(), pwm_enable() and pwm_disable() functions are just wrappers
-around pwm_apply_state() and should not be used if the user wants to change
-several parameter at once. For example, if you see pwm_config() and
-pwm_{enable,disable}() calls in the same function, this probably means you
-should switch to pwm_apply_state().
-
-The PWM user API also allows one to query the PWM state with pwm_get_state().
-
-In addition to the PWM state, the PWM API also exposes PWM arguments, which
-are the reference PWM config one should use on this PWM.
-PWM arguments are usually platform-specific and allows the PWM user to only
-care about dutycycle relatively to the full period (like, duty = 50% of the
-period). struct pwm_args contains 2 fields (period and polarity) and should
-be used to set the initial PWM config (usually done in the probe function
-of the PWM user). PWM arguments are retrieved with pwm_get_args().
-
-All consumers should really be reconfiguring the PWM upon resume as
-appropriate. This is the only way to ensure that everything is resumed in
-the proper order.
+PWM consumers
+-------------
+
+A driver (e.g. for a backlight or a fan) first needs to "get" a PWM device
+using the function pwm_get() or devm_pwm_get().
+These return an opaque handle to a certain hardware PWM that can be used to
+configure the respective PWM. The relevant function is
+
+	int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state);
+
+This API controls both the PWM period/duty_cycle config, polarity and the
+enable/disable state. The usual way to use pwm_apply_state() is in combination
+with pwm_get_state() like:
+
+	pwm_get_state(pwm, &state);
+	state.duty_cycle = 0;
+	pwm_apply_state(pwm, &state);
+
+When the PWM isn't needed any more, drop the handle using pwm_put() after
+disabling the PWM.
+
+All consumers should really be reconfiguring the PWM upon resume as
+appropriate. This is the only way to ensure that everything is resumed in
+the proper order.
+
+PWM providers
+-------------
+
+There are two canonical ways to provide one or several PWMs: device tree and
+board code.
+
+For the former it is enough to register a PWM chip using pwmchip_add() with the
+pwm_chip's .dev member pointing to the providing device. pwm_get then yields
+references to this chip when the device passed to pwm_get has pwm handles
+according to Documentation/devicetree/bindings/pwm/pwm.txt.
+
+In board code you can register a pwm lookup table that is then used to satisfy
+pwm_get requests by consumers. See the documentation of pwm_add_table() for
+details.
 
-Implementing a PWM driver
--------------------------
-
-Currently there are two ways to implement pwm drivers. Traditionally
-there only has been the barebone API meaning that each driver has
-to implement the pwm_*() functions itself. This means that it's impossible
-to have multiple PWM drivers in the system. For this reason it's mandatory
-for new drivers to use the generic PWM framework.
-
-A new PWM controller/chip can be added using pwmchip_add() and removed
-again with pwmchip_remove(). pwmchip_add() takes a filled in struct
-pwm_chip as argument which provides a description of the PWM chip, the
-number of PWM devices provided by the chip and the chip-specific
-implementation of the supported PWM operations to the framework.
-
-When implementing polarity support in a PWM driver, make sure to respect the
-signal conventions in the PWM framework. By definition, normal polarity
-characterizes a signal starts high for the duration of the duty cycle and
-goes low for the remainder of the period. Conversely, a signal with inversed
-polarity starts low for the duration of the duty cycle and goes high for the
-remainder of the period.
-
-Drivers are encouraged to implement ->apply() instead of the legacy
-->enable(), ->disable() and ->config() methods. Doing that should provide
-atomicity in the PWM config workflow, which is required when the PWM controls
-a critical device (like a regulator).
-
-The implementation of ->get_state() (a method used to retrieve initial PWM
-state) is also encouraged for the same reason: letting the PWM user know
-about the current PWM state would allow him to avoid glitches.
+PWM implementers
+----------------
+
+The main task a pwm hardware driver has to complete is to provide a struct
+pwm_chip and register it using pwmchip_add().
+
+The following members have to be provided:
+
+ - .dev: Pointer to the device that provides the PWMs
+ - .ops: Callbacks for hardware access. The only function callback that is
+   required is .apply which is the back-end for pwm_apply_state(). See below
+   for more details.
+ - .base: integer ID of the first pwm provided by this chip. Usually you want
+   to pass a negative number here, then this ID is allocated dynamically. Apart
+   from legacy usage the base has only internal semantics providing a unique
+   identification for each PWM. (Note this is only a hint and might be modified
+   on registration.)
+ - .npwm: number of PWMs provided by this chip.
+
+Optionally you can provide a function callback .of_xlate that is used for
+device tree lookups. If not provided of_pwm_simple_xlate() is used implementing
+the lookup as described in the generic pwm dt binding.
 
 Drivers should not implement any power management. In other words,
 consumers should implement it as described in the "Using PWMs" section.
 
+The .ops structure allows to define the following callbacks:
+
+ - .request: Optional function that is called on pwm_get(). When this function
+   returns a non-zero value this results in pwm_get() failing.
+ - .free: Counterpart to .request called from pwm_put().
+ - .apply: depending on the passed state the following behaviour is expected to
+   be implemented:
+
+   All state changes should only be effective after the currently running
+   period (if any) is completed. For a disabled pwm they can and should be
+   effective immediately.
+
+   If state->enabled is false, the values state->period and state->duty_cycle
+   are ignored and the output must be ensured to be inactive (that is
+   constant low if state->polarity == PWM_POLARITY_NORMAL, or constant high if
+   state->polarity == PWM_POLARITY_INVERSED).
+
+   If state->enabled is true, the output must be configured to run in periods of
+   length state->period nanoseconds. For each period the output should be active
+   (i.e. high if state->polarity == PWM_POLARITY_NORMAL, low otherwise) during
+   the first state->duty_cycle nanoseconds of each period and inactive for the
+   rest of it.
+
+   When the .apply callback returns to the caller the newly configured state
+   should already be active.
+
+   .apply is the only place where the output wave is supposed to be changed. All
+   other functions should not modify the configured state.
+
+ - .get_state: Optional function that should read the configuration from the
+   hardware and fill the provided state variable accordingly.
+ - .owner should be initialized to THIS_MODULE.
-Locking
--------
-
-The PWM core list manipulations are protected by a mutex, so pwm_request()
-and pwm_free() may not be called from an atomic context. Currently the
-PWM core does not enforce any locking to pwm_enable(), pwm_disable() and
-pwm_config(), so the calling context is currently driver specific. This
-is an issue derived from the former barebone API and should be fixed soon.
 
-Helpers
--------
-
-Currently a PWM can only be configured with period_ns and duty_ns. For several
-use cases freq_hz and duty_percent might be better. Instead of calculating
-this in your driver please consider adding appropriate helpers to the framework.
+Legacy Usage
+------------
+
+The PWM API evolved in the past and not all users are converted yet. To get
+hands on a PWM device you might see code using pwm_request (and pwm_free to
+dispose it). Also for the different configuration possibilities there used to be
+pwm_config/pwm_enable/pwm_disable. struct pwm_ops still contains the matching
+callbacks that are still used if provided. New usage of all these functions is
+discouraged.
-- 
2.24.0

