Return-Path: <linux-pwm+bounces-3130-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EAE96F880
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C665282DDA
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BF91D2F6C;
	Fri,  6 Sep 2024 15:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c8aHjBzc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2F51D1F60
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637417; cv=none; b=k6PVebkwZs8YFHhHx97MDYkpBFI8KKYbypwaVaX2UCXF+EfPqiQfoZG7OlaJweEiP9VSR7ZiBDJfpWwT6zUJ3QGZyPXFZvsCJ2saS7KP0vRS4ZxMMmu3ca6ygXLdU+tFt9ZXuwq4RN86+/sQ9/QaxO3v2cl83Z0jg05x2U1TbyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637417; c=relaxed/simple;
	bh=ZLbpkoYeA1IlPdUTtfiArEArw2LH/QnXbYL5NPENjFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jvvu1ghep+UPNCwGMMXO6iY0kJaWxNjQ2ariXLhEvfDCPcRw7xioezEjWZwfy8tJCUojRpIyOJqHeYDJ32bXjWXPzjUyJ+rwzKyatMw63Kk14hHjDKfQ4W+7qnsCl6R16eTMVw8p41rketIMk3zJyLLx5Nt3KeyXhs7zvtTBr+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c8aHjBzc; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so2846239a12.0
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637413; x=1726242213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6OLpOK+sCzopZXYHpeSh3M4ZXFFO4ND0aD1lhmoYHSw=;
        b=c8aHjBzcnOPYQHXZ4KP6DMkf7Mwi5mDHjHvEaqRC9KnHkSoqfzJUJv2l40rVrReJev
         xWXxAzp4kuia8pQLSwXEFj4WVpwswWUQLPk2zqD7Z7qZ+6sZvmuJvGuP9mRAW7pEVOG0
         N0AV1uQhMIOAG1FzUOttKcw2twNe78tnq49ryvrLDHWkzNNqSxmukMWa0jwMe1SakJSn
         4ik9FHuwSZxcjx3QWAZDCjDQpSBxlzTLlcryXB9sU9CML91p2lqjGpBQBezir0Nz0jWB
         TQj5AFeK3ZryX14XEzrGPaVR/RGCmDw/5lW/X/JHkexN9LLctCocn0nck1LZxtdyqbnZ
         gy8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637413; x=1726242213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6OLpOK+sCzopZXYHpeSh3M4ZXFFO4ND0aD1lhmoYHSw=;
        b=M3LugV04ErGRwFEUU9ho1xuKXsSi3eMpP5wrm0yp1qrXmuDyHdAMvYnHSOlJRQ4Rg7
         9S+iIAAnYiYBZDtd0bL/xuHYbQWwqPzVHDZOErmgpZfqQtfSf9Vb6tExkT+qY31DJdE8
         kRCSfNhPUWZxnBvlKqVgEMmOIwRyc7/m4zsV7VqZIIyEjjqzRGdFVcH3W5YAC/Qpv1c+
         92tSY0eaI5qJmAglmpbEWemzLMi6VjNUfpZ1RZE59d/BJVha3S4pkHnb/xcW+WSI7vTH
         yqGc9ijl5PEkDxnMlVhIiSbEQcIQzcRrkx6UgMff5HN8PV+SulFeI0NSx/V8Ac+rp5+b
         jqjw==
X-Gm-Message-State: AOJu0YxShqcDwUiD1ylKLGPCC5fbw+igE2VbGIryKJajXJTZijtcryk6
	QRr39nMAuX4yDUXa6s9uCQsSabzt4igSCJyWpowzCjiwb8ThUgIrctq8xPcsjQrjhzd0VgKNKze
	F
X-Google-Smtp-Source: AGHT+IG9/3WLHPv9Cvl8G1GUraTy2fVnYIA4oOakDbAEaX8hIyQ5mWrFrYKrKTBRtxx0Kx8ipM+9mQ==
X-Received: by 2002:a17:906:fd8b:b0:a86:b762:52ec with SMTP id a640c23a62f3a-a8a88873489mr230123966b.51.1725637412783;
        Fri, 06 Sep 2024 08:43:32 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d13c3ef59sm4734866b.153.2024.09.06.08.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:32 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 2/7] pwm: New abstraction for PWM waveforms
Date: Fri,  6 Sep 2024 17:42:58 +0200
Message-ID:  <88d66bf04e90c21bde1b48baba9bf23446b7e701.1725635013.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
References: <cover.1725635013.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13198; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=ZLbpkoYeA1IlPdUTtfiArEArw2LH/QnXbYL5NPENjFE=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrTbyux/FG8pX95SaVUm5qSWkfP++pmY427ffRhFE/+4S Ij7GAd1MhqzMDByMciKKbLYN67JtKqSi+xc++8yzCBWJpApDFycAjCRhDz2/8UCj/8KPJNvlnds Pvjj4WRDzXvPrBftD38xV/p8Sv+uGa4L2noze4I4FqWbeazOsjaVn1NyM6/mep4xs7CML98Ot63 Cr8K4zx96rJtn1sYl/yw8p55X41HwlzuSpp8dHufMYHmU5/Y6lyf8vUyK35Kr/ld+BP2t0ZC0yw mRi05aqd20Ou2s59tZG07zxXN82pYys5c/ZndfflueD2erzkqRogfikTZmXpOuvzsuZOo23WZFu KKARd3+RxtLvvfKqSvoLFq7Wnnf/ln7+YQDG1jev0hSzdtwVUcqOkPmSN656uPR1z6czd2/v8Bw /4HEiNfnIpfpLWn/77a/7saPm5v1P2y9vWfDQYeqWVlfAA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Up to now the configuration of a PWM setting is described exclusively by
a struct pwm_state which contains information about period, duty_cycle,
polarity and if the PWM is enabled. (There is another member usage_power
which doesn't completely fit into pwm_state, I ignore it here for
simplicity.)

Instead of a polarity the new abstraction has a member duty_offset_ns
that defines when the rising edge happens after the period start. This
is more general, as with a pwm_state the rising edge can only happen at
the period's start or such that the falling edge is at the end of the
period (i.e. duty_offset_ns == 0 or duty_offset_ns == period_length_ns -
duty_length_ns).

A disabled PWM is modeled by .period_length_ns = 0. In my eyes this is a
nice usage of that otherwise unusable setting, as it doesn't define
anything about the future which matches the fact that consumers should
consider the state of the output as undefined and it's just there to say
"No further requirements about the output, you can save some power.".

Further I renamed period and duty_cycle to period_length_ns and
duty_length_ns. In the past there was confusion from time to time about
duty_cycle being measured in nanoseconds because people expected a
percentage of period instead. With "length_ns" as suffix the semantic
should be more obvious to people unfamiliar with the pwm subsystem.
period is renamed to period_length_ns for consistency.

The API for consumers doesn't change yet, but lowlevel drivers can
implement callbacks that work with pwm_waveforms instead of pwm_states.
A new thing about these callbacks is that the calculation of hardware
settings needed to implement a certain waveform is separated from
actually writing these settings. The motivation for that is that this
allows a consumer to query the hardware capabilities without actually
modifying the hardware state.

The rounding rules that are expected to be implemented in the
round_waveform_tohw() are: First pick the biggest possible period not
bigger than wf->period_length_ns. For that period pick the biggest
possible duty setting not bigger than wf->duty_length_ns. Third pick the
biggest possible offset not bigger than wf->duty_offset_ns. If the
requested period is too small for the hardware, it's expected that a
setting with the minimal period and duty_length_ns = duty_offset_ns = 0
is returned and this fact is signaled by a return value of 1.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 234 ++++++++++++++++++++++++++++++++++++++++----
 include/linux/pwm.h |  36 +++++++
 2 files changed, 249 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 9752eb446879..a5aec732e2a4 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -49,6 +49,102 @@ static void pwmchip_unlock(struct pwm_chip *chip)
 
 DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
 
+static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
+{
+	if (wf->period_length_ns) {
+		if (wf->duty_length_ns + wf->duty_offset_ns < wf->period_length_ns)
+			*state = (struct pwm_state){
+				.enabled = true,
+				.polarity = PWM_POLARITY_NORMAL,
+				.period = wf->period_length_ns,
+				.duty_cycle = wf->duty_length_ns,
+			};
+		else
+			*state = (struct pwm_state){
+				.enabled = true,
+				.polarity = PWM_POLARITY_INVERSED,
+				.period = wf->period_length_ns,
+				.duty_cycle = wf->period_length_ns - wf->duty_length_ns,
+			};
+	} else {
+		*state = (struct pwm_state){
+			.enabled = false,
+		};
+	}
+}
+
+static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
+{
+	if (state->enabled) {
+		if (state->polarity == PWM_POLARITY_NORMAL)
+			*wf = (struct pwm_waveform){
+				.period_length_ns = state->period,
+				.duty_length_ns = state->duty_cycle,
+				.duty_offset_ns = 0,
+			};
+		else
+			*wf = (struct pwm_waveform){
+				.period_length_ns = state->period,
+				.duty_length_ns = state->period - state->duty_cycle,
+				.duty_offset_ns = state->duty_cycle,
+			};
+	} else {
+		*wf = (struct pwm_waveform){
+			.period_length_ns = 0,
+		};
+	}
+}
+
+static int pwm_check_rounding(const struct pwm_waveform *wf,
+			      const struct pwm_waveform *wf_rounded)
+{
+	if (!wf->period_length_ns)
+		return 0;
+
+	if (wf->period_length_ns < wf_rounded->period_length_ns)
+		return 1;
+
+	if (wf->duty_length_ns < wf_rounded->duty_length_ns)
+		return 1;
+
+	if (wf->duty_offset_ns < wf_rounded->duty_offset_ns)
+		return 1;
+
+	return 0;
+}
+
+static int __pwm_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const struct pwm_waveform *wf, void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+
+	return ops->round_waveform_tohw(chip, pwm, wf, wfhw);
+}
+
+static int __pwm_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+				       const void *wfhw, struct pwm_waveform *wf)
+{
+	const struct pwm_ops *ops = chip->ops;
+
+	return ops->round_waveform_fromhw(chip, pwm, wfhw, wf);
+}
+
+static int __pwm_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+
+	return ops->read_waveform(chip, pwm, wfhw);
+}
+
+static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *wfhw)
+{
+	const struct pwm_ops *ops = chip->ops;
+
+	return ops->write_waveform(chip, pwm, wfhw);
+}
+
+#define WFHWSIZE 20
+
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -182,6 +278,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
 static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
+	const struct pwm_ops *ops;
 	int err;
 
 	if (!pwm || !state)
@@ -205,6 +302,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	}
 
 	chip = pwm->chip;
+	ops = chip->ops;
 
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
@@ -213,18 +311,69 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	    state->usage_power == pwm->state.usage_power)
 		return 0;
 
-	err = chip->ops->apply(chip, pwm, state);
-	trace_pwm_apply(pwm, state, err);
-	if (err)
-		return err;
+	if (ops->write_waveform) {
+		struct pwm_waveform wf;
+		char wfhw[WFHWSIZE];
 
-	pwm->state = *state;
+		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
 
-	/*
-	 * only do this after pwm->state was applied as some
-	 * implementations of .get_state depend on this
-	 */
-	pwm_apply_debug(pwm, state);
+		pwm_state2wf(state, &wf);
+
+		/*
+		 * The rounding is wrong here for states with inverted polarity.
+		 * While .apply() rounds down duty_cycle (which represents the
+		 * time from the start of the period to the inner edge),
+		 * .round_waveform_tohw() rounds down the time the PWM is high.
+		 * Can be fixed if the need arises, until reported otherwise
+		 * let's assume that consumers don't care.
+		 */
+
+		err = __pwm_round_waveform_tohw(chip, pwm, &wf, &wfhw);
+		if (err) {
+			if (err > 0)
+				/*
+				 * This signals an invalid request, typically
+				 * the requested period (or duty_offset) is
+				 * smaller than possible with the hardware.
+				 */
+				return -EINVAL;
+
+			return err;
+		}
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG)) {
+			struct pwm_waveform wf_rounded;
+
+			err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+			if (err)
+				return err;
+
+			if (pwm_check_rounding(&wf, &wf_rounded))
+				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+					wf.duty_length_ns, wf.period_length_ns, wf.duty_offset_ns,
+					wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
+		}
+
+		err = __pwm_write_waveform(chip, pwm, &wfhw);
+		if (err)
+			return err;
+
+		pwm->state = *state;
+
+	} else {
+		err = ops->apply(chip, pwm, state);
+		trace_pwm_apply(pwm, state, err);
+		if (err)
+			return err;
+
+		pwm->state = *state;
+
+		/*
+		 * only do this after pwm->state was applied as some
+		 * implementations of .get_state depend on this
+		 */
+		pwm_apply_debug(pwm, state);
+	}
 
 	return 0;
 }
@@ -292,6 +441,41 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
 }
 EXPORT_SYMBOL_GPL(pwm_apply_atomic);
 
+static int pwm_get_state_hw(struct pwm_device *pwm, struct pwm_state *state)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	int ret = -EOPNOTSUPP;
+
+	if (ops->read_waveform) {
+		char wfhw[WFHWSIZE];
+		struct pwm_waveform wf;
+
+		BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+		scoped_guard(pwmchip, chip) {
+
+			ret = __pwm_read_waveform(chip, pwm, &wfhw);
+			if (ret)
+				return ret;
+
+			ret = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf);
+			if (ret)
+				return ret;
+		}
+
+		pwm_wf2state(&wf, state);
+
+	} else if (ops->get_state) {
+		scoped_guard(pwmchip, chip)
+			ret = ops->get_state(chip, pwm, state);
+
+		trace_pwm_get(pwm, state, ret);
+	}
+
+	return ret;
+}
+
 /**
  * pwm_adjust_config() - adjust the current PWM config to the PWM arguments
  * @pwm: PWM device
@@ -430,7 +614,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		}
 	}
 
-	if (ops->get_state) {
+	if (ops->read_waveform || ops->get_state) {
 		/*
 		 * Zero-initialize state because most drivers are unaware of
 		 * .usage_power. The other members of state are supposed to be
@@ -440,11 +624,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		 */
 		struct pwm_state state = { 0, };
 
-		scoped_guard(pwmchip, chip)
-			err = ops->get_state(chip, pwm, &state);
-
-		trace_pwm_get(pwm, &state, err);
-
+		err = pwm_get_state_hw(pwm, &state);
 		if (!err)
 			pwm->state = state;
 
@@ -1131,12 +1311,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
 {
 	const struct pwm_ops *ops = chip->ops;
 
-	if (!ops->apply)
-		return false;
+	if (ops->write_waveform) {
+		if (!ops->round_waveform_tohw ||
+		    !ops->round_waveform_fromhw ||
+		    !ops->write_waveform)
+			return false;
 
-	if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
-		dev_warn(pwmchip_parent(chip),
-			 "Please implement the .get_state() callback\n");
+		if (WFHWSIZE < ops->sizeof_wfhw) {
+			dev_warn(pwmchip_parent(chip), "WFHWSIZE < %zu\n", ops->sizeof_wfhw);
+			return false;
+		}
+	} else {
+		if (!ops->apply)
+			return false;
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && !ops->get_state)
+			dev_warn(pwmchip_parent(chip),
+				 "Please implement the .get_state() callback\n");
+	}
 
 	return true;
 }
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 3ea73e075abe..6a26a5210dab 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -49,6 +49,31 @@ enum {
 	PWMF_EXPORTED = 1,
 };
 
+/*
+ * struct pwm_waveform - description of a PWM waveform
+ * @period_length_ns: PWM period
+ * @duty_length_ns: PWM duty cycle
+ * @duty_offset_ns: offset of the rising edge from the period's start
+ *
+ * This is a representation of a PWM waveform alternative to struct pwm_state
+ * below. It's more expressive than struct pwm_state as it contains a
+ * duty_offset_ns and so can represent offsets other than $period - $duty_cycle
+ * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
+ * explicit bool for enabled. A "disabled" PWM is represented by
+ * .period_length_ns = 0.
+ *
+ * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
+ * hardware's capabilities it might drive the active or inactive level, go
+ * high-z or even continue to toggle.
+ *
+ * The unit for all three members is nanoseconds.
+ */
+struct pwm_waveform {
+	u64 period_length_ns;
+	u64 duty_length_ns;
+	u64 duty_offset_ns;
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -259,6 +284,17 @@ struct pwm_ops {
 	void (*free)(struct pwm_chip *chip, struct pwm_device *pwm);
 	int (*capture)(struct pwm_chip *chip, struct pwm_device *pwm,
 		       struct pwm_capture *result, unsigned long timeout);
+
+	size_t sizeof_wfhw;
+	int (*round_waveform_tohw)(struct pwm_chip *chip, struct pwm_device *pwm,
+				   const struct pwm_waveform *wf, void *wfhw);
+	int (*round_waveform_fromhw)(struct pwm_chip *chip, struct pwm_device *pwm,
+				     const void *wfhw, struct pwm_waveform *wf);
+	int (*read_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
+			    void *wfhw);
+	int (*write_waveform)(struct pwm_chip *chip, struct pwm_device *pwm,
+			      const void *wfhw);
+
 	int (*apply)(struct pwm_chip *chip, struct pwm_device *pwm,
 		     const struct pwm_state *state);
 	int (*get_state)(struct pwm_chip *chip, struct pwm_device *pwm,
-- 
2.45.2


