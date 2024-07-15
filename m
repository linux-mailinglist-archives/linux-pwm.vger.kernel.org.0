Return-Path: <linux-pwm+bounces-2802-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A089312E5
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E8D280DEA
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7BC13A3E0;
	Mon, 15 Jul 2024 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0qKlmfuo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C0184114
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042209; cv=none; b=duSpNwSFwDjxqQvue/GEW4x9ARsYcoDfD+JIuRziIt+VKwIS2ROPFsj0kWg6KlmabEYUbr5TdlHFIHnB0hWIRhEVP6C0TQ5GLZBUNN3uVsBWCJbGL3YP8kQbREt573MaqtQOIHdRFaSTb7qx7ZiVNYjBKNzyr5tTq/dGLiW5R+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042209; c=relaxed/simple;
	bh=XDgziVAOPUWr9vpqwZRDcPG+FCPY3I6vclUbcRoQNFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxbuH3wIZcdlKaeJ7l0QWiMc4RcyzAfR1xd2KuUNZVSmXbaIz6bM1mBck17zpZrTVMZsIsHxUkmFL/PfOXS4LpQk7H1ZKtWgyLIu6l6cDclC8VD09brQ7lfSLBYg44EHYhK4CuFvPKIvRjwdbs2b6BdsK+C8soPGqV2pD6svNhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0qKlmfuo; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52ea0f18500so4283967e87.3
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042205; x=1721647005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhz0UyEMqrqHUc9HIaMNrJJVzB2O1hcUxVwXdmAWHGw=;
        b=0qKlmfuo5KwlA0G2ePNkCEnMbhORYkuBr2jJI/nYgX8o8fXa8YjLOp6VBtvUsYRhpE
         OdlWhy5xFu5Q8wPwajw0JWZXUuaqYFBgKfCO2+zOmYteuWyyTS1/mKuUpJre/A6isRmg
         267OpRdSm1sYuj6m3cm6cHkD1PpHbHRUfe1+7iA/kgNRckBens8DY+aftJRPWGI1/BJo
         p3FuURtd2ikBiWFyKkH/dwdsKrEP154ItVf0VvtXZnJTsW9C3KgxjnTJeijEg8TapHs2
         ce76bW7n84n4hM3gojmlHZFyzszbuSLvc0aa0Z+XCD3lodrU7YL1FTe+nAqcDTc66aTE
         3PiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042205; x=1721647005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lhz0UyEMqrqHUc9HIaMNrJJVzB2O1hcUxVwXdmAWHGw=;
        b=j0G8FNqv/knA6B/WqIywGYEqQFlmzLuL33ygjZ3kcYwfl9UL+50yP9PTBssPvr5Uvl
         KnM1mA6yip+XVDTG9tL1vvxBzcwwpRC5htAWafBBpdt0M7DADHuvn5NOa/ShCvOO9Wgo
         m4je2ro6L0WZdxEeiGpl1nqRcLqer4F26EzJVpsGwQDFjOyPTiVcPL9IKCpsgW3UTQOl
         6GMdQm23RkuI68yO2ShdyiuAybwFhwv0CFLLa8reVVc3HOFVgX0s+Q3oW5Sf1q6VJgt9
         EbAuQpEaHOQG+2Fv++lg9ZOLuphpJA0QGhDhLmADQQr1jZDfNyA6cVF2lSVKVCUv53hL
         qisA==
X-Gm-Message-State: AOJu0YwBYjNZ/FV+5Iha7r9u6R4moI5sNLMfko/Y7wIW9uYtXqW+jKNU
	62PA2/W+Us3sUdwTPZ1WU0I9TLRJPf4YE7DKZDlfbZIE7OVenUsGJlClJloHnroPIjz5f6EFKdN
	s
X-Google-Smtp-Source: AGHT+IEw5FXBSpq89NvvqumHzLNWsouFpXU3aHqS3T+4zAjef3HJ72Pc/Kx0s3HtmRryTLm3D4GZ7Q==
X-Received: by 2002:ac2:4e0a:0:b0:52c:8210:13bc with SMTP id 2adb3069b0e04-52eb99d3e70mr12092631e87.64.1721042204498;
        Mon, 15 Jul 2024 04:16:44 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dabf1a0sm6100679f8f.28.2024.07.15.04.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:44 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 3/8] pwm: New abstraction for PWM waveforms
Date: Mon, 15 Jul 2024 13:16:08 +0200
Message-ID:  <a4bdcfd66bc40fd245f521b89797993eba993afe.1721040875.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
References: <cover.1721040875.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=12806; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=XDgziVAOPUWr9vpqwZRDcPG+FCPY3I6vclUbcRoQNFk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmlQT+HKJbv2rU3/gbLlErHbELIFM0yT0mS8oYP pDv4Cyep7mJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZpUE/gAKCRCPgPtYfRL+ Th52B/9M5PnjDW2+N6dAmQP7SPRUs++9FIB1rfQgt00rAnN8MK6lQAky6w4U5QdmNQA0pKYhB/r pN2RG6q1xzSfLqwoyTNfx2LwmEkGu4zMMkjSEksY3ZXLe4F9RhQ/LgwqmQUyBwwSUnF04hQjN+A l1icO3BHPwQbUyj++1QWHaiusSvHFFGbU6MWUu5WWeWZMO1p8/o0HTbzJjkOq1957D56L24pGxz Aj5Exa3JxJiT/zN+eoY4OY569dY9x1OM61EWE9oMOFzBeQgZSrBFnNB0vIuGH0ltAqj/czBwbBv 0FwttskWyLoRMIMD27990Hh6Hesei5QPSpVD0u2AUqgigIRQ
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Up to now the configuration of a PWM setting is described exclusively by
a struct pwm_state which contains information about period, duty_cycle,
polarity and if the PWM is enabled. (There is another member usage_power
which doesn't completely fit into pwm_state, I ignore it here for
simplicity.)

Instead of a polarity the new abstraction has a member duty_offset that
defines when the rising edge happens after the period start. This is
more general, as with a pwm_state the rising edge can only happen at the
period's start or such that the falling edge is at the end of the period
(i.e. duty_offset == 0 or duty_offset == period_length - duty_length).

A disabled PWM is modeled by .period_length = 0. In my eyes this is a
nice usage of that otherwise unusable setting, as it doesn't define
anything about the future which matches the fact that consumers should
consider the state of the output as undefined and it's just there to say
"No further requirements about the output, you can save some power.".

Further I renamed period and duty_cycle to period_length and
duty_length. In the past there was confusion from time to time about
duty_cycle being measured in nanoseconds because people expected a
percentage of period instead. With "length" as suffix the semantic
should be more obvious to people unfamiliar with the pwm subsystem.
period is renamed to period_length for consistency.

The API for consumers doesn't change yet, but lowlevel drivers can
implement callbacks that work with pwm_waveforms instead of pwm_states.
A new thing about these callbacks is that the calculation of hardware
settings needed to implement a certain waveform is separated from
actually writing these settings. The motivation for that is that this
allows a consumer to query the hardware capabilities without actually
modifying the hardware state.

The rounding rules that are expected to be implemented in the
round_waveform_tohw() are: First pick the biggest possible period not
bigger than wf->period_length. For that period pick the biggest possible
duty setting not bigger than wf->duty_length. Third pick the biggest
possible offset not bigger than wf->duty_offset. If the requested period
is too small for the hardware, it's expected that a setting with the
minimal period and duty_length = duty_offset = 0 is returned and this
fact is signaled by a return value of 1.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 225 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/pwm.h |  35 +++++++
 2 files changed, 239 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index b97e2ea0691d..1f52cabe0131 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -49,6 +49,102 @@ static void pwmchip_unlock(struct pwm_chip *chip)
 
 DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
 
+static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
+{
+	if (wf->period_length) {
+		if (wf->duty_length + wf->duty_offset < wf->period_length)
+			*state = (struct pwm_state){
+				.enabled = true,
+				.polarity = PWM_POLARITY_NORMAL,
+				.period = wf->period_length,
+				.duty_cycle = wf->duty_length,
+			};
+		else
+			*state = (struct pwm_state){
+				.enabled = true,
+				.polarity = PWM_POLARITY_INVERSED,
+				.period = wf->period_length,
+				.duty_cycle = wf->period_length - wf->duty_length,
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
+				.period_length = state->period,
+				.duty_length = state->duty_cycle,
+				.duty_offset = 0,
+			};
+		else
+			*wf = (struct pwm_waveform){
+				.period_length = state->period,
+				.duty_length = state->period - state->duty_cycle,
+				.duty_offset = state->duty_cycle,
+			};
+	} else {
+		*wf = (struct pwm_waveform){
+			.period_length = 0,
+		};
+	}
+}
+
+static int pwm_check_rounding(const struct pwm_waveform *wf,
+			      const struct pwm_waveform *wf_rounded)
+{
+	if (!wf->period_length)
+		return 0;
+
+	if (wf->period_length < wf_rounded->period_length)
+		return 1;
+
+	if (wf->duty_length < wf_rounded->duty_length)
+		return 1;
+
+	if (wf->duty_offset < wf_rounded->duty_offset)
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
@@ -213,18 +311,60 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
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
+		 * The rounding is wrong here for states with inverted
+		 * polarity. While .apply() rounds down duty_cycle (which
+		 * represents the time from the start of the period to the inner
+		 * edge), .round_waveform_tohw() rounds down the time the PWM is
+		 * high. Can be fixed if the ned arises, until reported
+		 * otherwise let's assume that consumers don't care.
+		 */
+
+		err = __pwm_round_waveform_tohw(chip, pwm, &wf, &wfhw);
+		if (err)
+			return err;
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
+					wf.duty_length, wf.period_length, wf.duty_offset,
+					wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
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
@@ -292,6 +432,41 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
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
@@ -430,7 +605,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		}
 	}
 
-	if (ops->get_state) {
+	if (ops->read_waveform || ops->get_state) {
 		/*
 		 * Zero-initialize state because most drivers are unaware of
 		 * .usage_power. The other members of state are supposed to be
@@ -440,11 +615,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
 
@@ -1131,12 +1302,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
index 464054a45e57..2a1f1f25a56c 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -49,6 +49,30 @@ enum {
 	PWMF_EXPORTED = 1,
 };
 
+/*
+ * struct pwm_waveform - description of a PWM waveform
+ * @period_length: PWM period
+ * @duty_length: PWM duty cycle
+ * @duty_offset: offset of the rising edge from the period's start
+ *
+ * This is a representation of a PWM waveform alternative to struct pwm_state
+ * below. It's more expressive than struct pwm_state as it contains a
+ * duty_offset and so can represent offsets other than $period - $duty_cycle
+ * which is done using .polarity = PWM_POLARITY_INVERSED. Note there is no
+ * explicit bool for enabled. A "disabled" PWM is represented by .period = 0.
+ *
+ * Note that the behaviour of a "disabled" PWM is undefined. Depending on the
+ * hardware's capabilities it might drive the active or inactive level, go
+ * high-z or even continue to toggle.
+ *
+ * The unit for all three members is nanoseconds.
+ */
+struct pwm_waveform {
+	u64 period_length;
+	u64 duty_length;
+	u64 duty_offset;
+};
+
 /*
  * struct pwm_state - state of a PWM channel
  * @period: PWM period (in nanoseconds)
@@ -259,6 +283,17 @@ struct pwm_ops {
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
2.43.0


