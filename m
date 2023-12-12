Return-Path: <linux-pwm+bounces-525-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ECC980E63B
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 09:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC554B20CF7
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Dec 2023 08:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394872554C;
	Tue, 12 Dec 2023 08:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="QPnsgTfo";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="HT4lKnG4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gofer.mess.org (gofer.mess.org [88.97.38.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2BC10B;
	Tue, 12 Dec 2023 00:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370078; bh=2Pw20VBRXdfmL7SgSifOivpj0hhLB50AYu53xedYzp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPnsgTfoV8z5MFBYObjmfuemhy4aTCLgCEMCdIEtFyDoYi8H78j7BTr42Ma/paCCt
	 MyBGgYsCW8KXuD/nPelBP0M2Iq6NBGy0JirzvtlWiRmMIGgcdKCner2LIXrY2kLbYh
	 fBEiy5vM0l8oFtnuGroUAEDmHFwIFuDZNrsQVmurvBzunmZznfHrvr7liPaipulbN4
	 cexoDXH8FStEcVzcqw6BiexGlUjfU4V/EEIry8QcI1qyuCW5U/PzFLKySiPFQREalG
	 SpRA0xCweZA+Z33PmAw0zmPNh7L5aRNg38z9yCF2tqLrEFe3UrfjKADyTK+Tv/x9eX
	 bfgukpw5JV5ug==
Received: by gofer.mess.org (Postfix, from userid 501)
	id 62E12100A03; Tue, 12 Dec 2023 08:34:38 +0000 (GMT)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1702370062; bh=2Pw20VBRXdfmL7SgSifOivpj0hhLB50AYu53xedYzp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT4lKnG42tiemYgOwTflbY2RrCzyFwlFqQsInBmJW8jRfRtPiz2mlY2ezOeQMnG4k
	 XabBGFiVSKlWMBThdv4sF6MmLjtLSOWNskCcCF/Ew5v7CB0izzS7WsE/2m7bufX15N
	 tR1H0cdbthcyOs5+Ph57h0CfWIOh/oiWqwdn/4ZM3VUC9FJ0wOayNb5KgCilL3HLrq
	 2Y7uA97oV38Wa3WnIfGcWGfQ2ESbj8D+A7pq4gooSrBbxPL6CuYwNj9QyvyzLLfuIu
	 AFWMMPztzywuV+UfEh5Qw6mUUNymjJ/RCmGvDDeBd1pc1n1LVVPPnAhYTATTxDmIaX
	 CwqsYp3RZEnww==
Received: from localhost.localdomain (bigcore-58.local [IPv6:2a02:8011:d000:212:ca7f:54ff:fe51:14d6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by gofer.mess.org (Postfix) with ESMTPSA id A7C671009FC;
	Tue, 12 Dec 2023 08:34:22 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Sean Young <sean@mess.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 4/6] pwm: Make it possible to apply PWM changes in atomic context
Date: Tue, 12 Dec 2023 08:34:03 +0000
Message-ID: <57f48330eb606356e86be17f85253f0e3d6ab104.1702369869.git.sean@mess.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1702369869.git.sean@mess.org>
References: <cover.1702369869.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PWM devices require sleeping, for example if the pwm device is
connected over I2C. However, many PWM devices could be used from atomic
context, e.g. memory mapped PWM. This is useful for, for example, the
pwm-ir-tx driver which requires precise timing. Sleeping causes havoc
with the generated IR signal.

Since not all PWM devices can support atomic context, we also add a
pwm_might_sleep() function to check if is not supported.

Signed-off-by: Sean Young <sean@mess.org>
---
 Documentation/driver-api/pwm.rst |  9 +++++
 MAINTAINERS                      |  2 +-
 drivers/pwm/core.c               | 67 +++++++++++++++++++++++++-------
 include/linux/pwm.h              | 25 ++++++++++++
 4 files changed, 89 insertions(+), 14 deletions(-)

diff --git a/Documentation/driver-api/pwm.rst b/Documentation/driver-api/pwm.rst
index f1d8197c8c430..3c28ccc4b6113 100644
--- a/Documentation/driver-api/pwm.rst
+++ b/Documentation/driver-api/pwm.rst
@@ -46,6 +46,15 @@ After being requested, a PWM has to be configured using::
 This API controls both the PWM period/duty_cycle config and the
 enable/disable state.
 
+PWM devices can be used from atomic context, if the PWM does not sleep. You
+can check if this the case with::
+
+        bool pwm_might_sleep(struct pwm_device *pwm);
+
+If false, the PWM can also be configured from atomic context with::
+
+	int pwm_apply_atomic(struct pwm_device *pwm, struct pwm_state *state);
+
 As a consumer, don't rely on the output's state for a disabled PWM. If it's
 easily possible, drivers are supposed to emit the inactive state, but some
 drivers cannot. If you rely on getting the inactive state, use .duty_cycle=0,
diff --git a/MAINTAINERS b/MAINTAINERS
index c584805952209..5342cf32d73ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17576,7 +17576,7 @@ F:	drivers/video/backlight/pwm_bl.c
 F:	include/dt-bindings/pwm/
 F:	include/linux/pwm.h
 F:	include/linux/pwm_backlight.h
-K:	pwm_(config|apply_might_sleep|ops)
+K:	pwm_(config|apply_might_sleep|apply_atomic|ops)
 
 PXA GPIO DRIVER
 M:	Robert Jarzmik <robert.jarzmik@free.fr>
diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c2d78136625d5..30c0623dbd5ba 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -433,24 +433,15 @@ static void pwm_apply_debug(struct pwm_device *pwm,
 }
 
 /**
- * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * pwm_apply_unchecked() - atomically apply a new state to a PWM device
  * @pwm: PWM device
  * @state: new state to apply
  */
-int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+static int pwm_apply_unchecked(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
 	int err;
 
-	/*
-	 * Some lowlevel driver's implementations of .apply() make use of
-	 * mutexes, also with some drivers only returning when the new
-	 * configuration is active calling pwm_apply_might_sleep() from atomic context
-	 * is a bad idea. So make it explicit that calling this function might
-	 * sleep.
-	 */
-	might_sleep();
-
 	if (!pwm || !state || !state->period ||
 	    state->duty_cycle > state->period)
 		return -EINVAL;
@@ -471,16 +462,66 @@ int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
 
 	pwm->state = *state;
 
+	return 0;
+}
+
+/**
+ * pwm_apply_might_sleep() - atomically apply a new state to a PWM device
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	int err;
+
+	/*
+	 * Some lowlevel driver's implementations of .apply() make use of
+	 * mutexes, also with some drivers only returning when the new
+	 * configuration is active calling pwm_apply_might_sleep() from atomic context
+	 * is a bad idea. So make it explicit that calling this function might
+	 * sleep.
+	 */
+	might_sleep();
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm->chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = pwm_apply_unchecked(pwm, state);
+		non_block_end();
+	} else {
+		err = pwm_apply_unchecked(pwm, state);
+	}
+
 	/*
 	 * only do this after pwm->state was applied as some
 	 * implementations of .get_state depend on this
 	 */
-	pwm_apply_debug(pwm, state);
+	if (!err)
+		pwm_apply_debug(pwm, state);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL_GPL(pwm_apply_might_sleep);
 
+/**
+ * pwm_apply_atomic() - apply a new state to a PWM device from atomic context
+ * Not all PWM devices support this function, check with pwm_might_sleep().
+ * @pwm: PWM device
+ * @state: new state to apply
+ */
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
+{
+	WARN_ONCE(!pwm->chip->atomic,
+		  "sleeping PWM driver used in atomic context\n");
+
+	return pwm_apply_unchecked(pwm, state);
+}
+EXPORT_SYMBOL_GPL(pwm_apply_atomic);
+
 /**
  * pwm_capture() - capture and report a PWM signal
  * @pwm: PWM device
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index c9cb87b59ac80..495af3627939c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -285,6 +285,7 @@ struct pwm_ops {
  * @npwm: number of PWMs controlled by this chip
  * @of_xlate: request a PWM device given a device tree PWM specifier
  * @of_pwm_n_cells: number of cells expected in the device tree PWM specifier
+ * @atomic: can the driver's ->apply() be called in atomic context
  * @pwms: array of PWM devices allocated by the framework
  */
 struct pwm_chip {
@@ -297,6 +298,7 @@ struct pwm_chip {
 	struct pwm_device * (*of_xlate)(struct pwm_chip *chip,
 					const struct of_phandle_args *args);
 	unsigned int of_pwm_n_cells;
+	bool atomic;
 
 	/* only used internally by the PWM framework */
 	struct pwm_device *pwms;
@@ -305,6 +307,7 @@ struct pwm_chip {
 #if IS_ENABLED(CONFIG_PWM)
 /* PWM user APIs */
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
+int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
 
 /**
@@ -375,6 +378,17 @@ static inline void pwm_disable(struct pwm_device *pwm)
 	pwm_apply_might_sleep(pwm, &state);
 }
 
+/**
+ * pwm_might_sleep() - is pwm_apply_atomic() supported?
+ * @pwm: PWM device
+ *
+ * Returns: false if pwm_apply_atomic() can be called from atomic context.
+ */
+static inline bool pwm_might_sleep(struct pwm_device *pwm)
+{
+	return !pwm->chip->atomic;
+}
+
 /* PWM provider APIs */
 int pwm_capture(struct pwm_device *pwm, struct pwm_capture *result,
 		unsigned long timeout);
@@ -403,6 +417,11 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+static inline bool pwm_might_sleep(struct pwm_device *pwm)
+{
+	return true;
+}
+
 static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 					const struct pwm_state *state)
 {
@@ -410,6 +429,12 @@ static inline int pwm_apply_might_sleep(struct pwm_device *pwm,
 	return -EOPNOTSUPP;
 }
 
+static inline int pwm_apply_atomic(struct pwm_device *pwm,
+				   const struct pwm_state *state)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int pwm_adjust_config(struct pwm_device *pwm)
 {
 	return -EOPNOTSUPP;
-- 
2.43.0


