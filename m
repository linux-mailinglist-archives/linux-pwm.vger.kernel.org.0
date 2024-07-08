Return-Path: <linux-pwm+bounces-2722-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30EB892A08E
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 12:53:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86C38B215C9
	for <lists+linux-pwm@lfdr.de>; Mon,  8 Jul 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34CB78C6B;
	Mon,  8 Jul 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TgxJKoZp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF1F7603A
	for <linux-pwm@vger.kernel.org>; Mon,  8 Jul 2024 10:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720435982; cv=none; b=Q9/9k97rynVm4L215vJuGjtpzcsJcjf14lcLm+gB796s5h/zM6f8ie4U1AW3qnaMS+97NNRdHfNov6IdwVhJb6IxfWGc7OfyzwFDaluXowwurPjYxeX8cx50P8lcCX2hWRACWZt6zkRzQ5otOXP7/xGsZIjLDb1+W5gnGT73Ksk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720435982; c=relaxed/simple;
	bh=WQ1tdQJ8LGKBiWT+pmlsAYiB2OzWVFeNGMvJEuabIak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OxMqWlBGvHxDbivld8xQOEhOAGaVpOf9Vd8/4mMKdQgUQLlzrBommLLU/27zLPr/lGaQXCxjh6bMojK2+2vSj7LEky0xhulWhilZriVMHDXO7G5Fo1+YKDetS3goS3dWnaIALywVwwMXb6NeuUl52LYcBx5rFFd+1PnuUPsW4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TgxJKoZp; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1051360so1737041fa.0
        for <linux-pwm@vger.kernel.org>; Mon, 08 Jul 2024 03:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1720435978; x=1721040778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mpt6NFsPkisaY1MwVr6kXrTsatrXRavGiwZl9130ebI=;
        b=TgxJKoZp4CGjrXvHS5M3I8XO1J6gJRbiLXdUIeo/oJ0fo539DUWhgYD1GrWFu+Um3A
         mQ9fYWq8K1tcJ0CXgD0zy2bCOH/KvSWb5RHJAw7R+UKyUbK/aFrFQwcijJn0sjGaL8Fl
         0EuX0MhGZULcWyDrWOy8kzupmAdMXqrqzPffFCvDYWyqBE0f+KUQFUaiteHMkzzhzxSX
         LDcraWv92Uqa3tdbGv98E9Zxwdd27MMqUkh7U3OT8mRm2HaGjqO9qeJ8b2Lo9h+9GZxI
         78NHsBawpOErHgHvBLDnsPr+nLy6i08HuRMhJS9zsDXU+In9lM80+yl6klZt/nZIYKSa
         Q24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720435978; x=1721040778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mpt6NFsPkisaY1MwVr6kXrTsatrXRavGiwZl9130ebI=;
        b=ts+gJzpmn8bu/62Rbjrf7b6iFXc2o/sLdhWNKhbIrIN1+MUFBV87uNsdI4/i93IsO7
         qjVuxoCqwKG8wKad5g3tcoFzWMR7m54BYsrkBJPb3OgeoBDz3WWyjokBvjbBX/jv0Chs
         o3tgbo03qvCgFbFACbCxCo1wHC2sz6ef+3qV0UNe8D5Xc8xPlv05kY6jGPTIhxMrAVF4
         iliuLpqoUSluKpJR7yEG6duVzrvoqGM2HPpa6w+c3XTgnUEpd3nPszOjRobRhICR0nqB
         aqNomueCUgpKxaxgL1LGGyr5JY1wRlSdJ398VOk/sk0cf+nWQ/ZanQKwzSh9Me3ioXsT
         byzQ==
X-Gm-Message-State: AOJu0Ywb0tQyv/oFOsmsq1yXsowtI2cFK+iPfOqR46Cedej3RUbYp4Y5
	hX3BkB4MgPY+SKvy2jb1hz1LVsB+UDaRiyfou5GOC0CKC/dmvGcW1031o8qHmHisUqmHqj0GHpj
	t
X-Google-Smtp-Source: AGHT+IG1Kyf6+PqZfCJhkCxwpP2yCSENJwwTLW1fympL37tJ+rPZDfY6sUvPMiFk+1HfICML4Msv1A==
X-Received: by 2002:a2e:3c03:0:b0:2ee:4ccf:ca4f with SMTP id 38308e7fff4ca-2ee8eda42e4mr71360861fa.31.1720435978299;
        Mon, 08 Jul 2024 03:52:58 -0700 (PDT)
Received: from localhost (p50915e7b.dip0.t-ipconnect.de. [80.145.94.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264d6d41cesm147133775e9.16.2024.07.08.03.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 03:52:57 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/6] pwm: New abstraction for PWM waveforms
Date: Mon,  8 Jul 2024 12:52:28 +0200
Message-ID:  <6f7deef208bf25baad7daa8ff35621fb68e7aeb4.1720435656.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
References: <cover.1720435656.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11779; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=WQ1tdQJ8LGKBiWT+pmlsAYiB2OzWVFeNGMvJEuabIak=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmi8TwFCxuEN1LF0Bi0vED9Q+cPd9ZskZQXcF55 oMB2TlxhimJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZovE8AAKCRCPgPtYfRL+ TljMB/wICzCrg5w7KNoMUuNqsfdJbLNBEN08ijU878THwEjfdMqEEiyf/2EvosUQqhrN8SIJ8FD C3mBTuykHKykLLd8CFhWEPxUars3SV2v4WMgGHtOlrwTXylxkkIs4V/lh4U+/75Sz4ZAmG9yYw8 eOSPW+BO1adTvvQBxfQrIjoZkIZVhutjyZzC1H0iDPjIoae3Hk2QZSrdVHGXapkYr40R+ejemv0 9N6rbGa6SmnSAzYrHn8ONV8DCiC5hbLOQKPwNWyydYaVuX4H84Kit07laJFpsNMaarvsAMZF7tz uaN4kHZmyxnFsObDq+QrMgh2hKFTFpRVvpEMvaZ50E/mx3wM
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Up to now the configuration of a PWM setting is decribed exclusively by
a struct pwm_state which contains information about period, duty_cycle,
polarity and if the PWM is enabled. (There is another member usage_power
which doesn't completely fit into pwm_state, I ignore it here for
simplicity.)

Instead of a polarity the new abstraction has a member duty_offset that
defines when the rising edge happens after the period start. This is
more general, as with a pwm_state the rising edge can only happen at the
period's start or such that the falling edge is at the end of the period
(i.e. duty_offset == 0 or duty_offset == period_lengh - duty_length).

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
period is renamed period_length for consistency.

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
 drivers/pwm/core.c  | 194 +++++++++++++++++++++++++++++++++++++++-----
 include/linux/pwm.h |  35 ++++++++
 2 files changed, 208 insertions(+), 21 deletions(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index c31e12e76495..8e68481a7b33 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -49,6 +49,72 @@ static void pwmchip_unlock(struct pwm_chip *chip)
 
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
+#define WFHWSIZE 20
+
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
@@ -182,6 +248,7 @@ static bool pwm_state_valid(const struct pwm_state *state)
 static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 {
 	struct pwm_chip *chip;
+	const struct pwm_ops *ops;
 	int err;
 
 	if (!pwm || !state)
@@ -205,6 +272,7 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
 	}
 
 	chip = pwm->chip;
+	ops = chip->ops;
 
 	if (state->period == pwm->state.period &&
 	    state->duty_cycle == pwm->state.duty_cycle &&
@@ -213,18 +281,59 @@ static int __pwm_apply(struct pwm_device *pwm, const struct pwm_state *state)
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
+		 * XXX The rounding is wrong here for states with inverted
+		 * polarity. While .apply() rounds down duty_cycle (which
+		 * represents the time from the start of the period to the inner
+		 * edge), .round_waveform_tohw() rounds down the time the PWM is
+		 * high.
+		 */
+
+		err = ops->round_waveform_tohw(chip, pwm, &wf, &wfhw);
+		if (err)
+			return err;
+
+		if (IS_ENABLED(PWM_DEBUG)) {
+			struct pwm_waveform wf_rounded;
+
+			err = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+			if (err)
+				return err;
+
+			if (pwm_check_rounding(&wf, &wf_rounded))
+				dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+					wf.duty_length, wf.period_length, wf.duty_offset,
+					wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
+		}
+
+		err = ops->write_waveform(chip, pwm, &wfhw);
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
@@ -292,6 +401,41 @@ int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state)
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
+			ret = ops->read_waveform(chip, pwm, &wfhw);
+			if (ret)
+				return ret;
+
+			ret = ops->round_waveform_fromhw(chip, pwm, &wfhw, &wf);
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
@@ -433,7 +577,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
 		}
 	}
 
-	if (ops->get_state) {
+	if (ops->read_waveform || ops->get_state) {
 		/*
 		 * Zero-initialize state because most drivers are unaware of
 		 * .usage_power. The other members of state are supposed to be
@@ -443,11 +587,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
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
 
@@ -1134,12 +1274,24 @@ static bool pwm_ops_check(const struct pwm_chip *chip)
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
index 5176dfebfbfd..b5dff2a99038 100644
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


