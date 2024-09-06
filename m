Return-Path: <linux-pwm+bounces-3131-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B6A96F881
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6AE282EF9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Sep 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F41D1F60;
	Fri,  6 Sep 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lpCuLeIH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ECB1D2F61
	for <linux-pwm@vger.kernel.org>; Fri,  6 Sep 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725637418; cv=none; b=nmOv8TN6ZnMpePXW3jX/UMIohrXeh7r3X43a7tlzdjCpOJVT4oN3ms4cvX0lpWOFUG5P2EmgjXEFf2aZejoWPD2k6gJOiJs4vq/REceO5IgknoPJabFzhyM1ed5NLyTF87yAnvlEphfmsBUW11SJl/TwQZ6bDKEHgc3hWd1sueM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725637418; c=relaxed/simple;
	bh=Jf0tLkCEoX06MlQMEniRHbvB1Cz6mgIW9+EWndqQs6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RR2/tl0rj0FzXBeLI5knijTlIbHNDR5w1b32Y4Cu8NeY5wYU3WZTPwyDleHrL9XTRx7pwhSehBI5lGyLvzRyO/1I0L2haFVp/bzWG13DhKV8yyfNx+0gN1ujHyK0bfAcNQ2qCm/DyqCFU7pW3f4/JsH6WMywSYpoxHEpyt/juG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lpCuLeIH; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8d0d82e76aso45163966b.3
        for <linux-pwm@vger.kernel.org>; Fri, 06 Sep 2024 08:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725637415; x=1726242215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xE+RaCzyvHzx8+xEzyBU8o/Wv9M+0XIF/9Ark42tQc=;
        b=lpCuLeIHLOjUGs58fcHE9O5HiYraiexClg8TpdkmemewVYJwrSnglCgY5lfs3q7KJl
         rexekPZ6txo03odhum34hlue+OiTBWFS+dE9+is5dXNM9UbxcBc4NpGe+lqesOb3VHsa
         9GGxnfBQdoNUn9dODjXPuUmGcyx0NObsbIc0JRVJ18eFUi04Uj9Ijs1H0nr3bNfkKiNz
         1Ktr6dCWBvAy6kHt82CwEtue+DKXJIj21LpIcrm6qXaFHIoAwK3dvEh7AQXnSgmGDbCz
         BS3qcrc5AzLGnDocTkd/OyM7MNCMi/+RylVCrbfzkg7c4UQHTOC/pXLyEIAkPIkJk0kG
         S23g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725637415; x=1726242215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3xE+RaCzyvHzx8+xEzyBU8o/Wv9M+0XIF/9Ark42tQc=;
        b=nYTDn2JOcmAm3DmV2NOmi4iPohXBPgtBJtdg7RavRD+68Vtp+l+OCRwMnhtgHyg1kw
         kiVbCYj0DBJ6DjymgI7Gdx23K4q607BVZ1au6DZR8pqGVw4tT3P/wIzdvrmbsMS1SKMM
         askXdYfLSeTuqliADNy/DWbqymW4NWke+tkfIsNiZi0CdTGHeTV0ze8uFlu1/Xe0/4dn
         gAHOzy/69lQGSRNa3WfduIOcilz+6D0URpV2X4W5lxakxrI3f6KD92EzhbHoJEuzGeDH
         fyH4LJ2N4vVv8ab4L89pTqIEq5KD/uReqAwzhlCyXazHLxPdeK3eANRRDAMrtSqoUta9
         vfJQ==
X-Gm-Message-State: AOJu0YwFHylDXNe22T3swSYsOQXSrNvS3AYEd318KV2srrbtYT0+XlPK
	IbVXf8ST5LrE0dlTveUgDhdvUGbApCxaaXECvbXGm8m88HU9pXHPUaXe5RgCudHZA+yo5iV5lQi
	5
X-Google-Smtp-Source: AGHT+IGThrs+UK3wSO8S+TtbXJhlwKbYaik5gjTjQKVOQ+9RCoKN1aon4MSMQntOjHQn4TE/on8wWg==
X-Received: by 2002:a17:907:9802:b0:a86:7b71:7b74 with SMTP id a640c23a62f3a-a897fa719ebmr2040199566b.55.1725637414651;
        Fri, 06 Sep 2024 08:43:34 -0700 (PDT)
Received: from localhost (p5dc68d3d.dip0.t-ipconnect.de. [93.198.141.61])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a6236d26esm292697966b.140.2024.09.06.08.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 08:43:34 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Kent Gibson <warthog618@gmail.com>,
	David Lechner <dlechner@baylibre.com>
Subject: [PATCH v4 3/7] pwm: Provide new consumer API functions for waveforms
Date: Fri,  6 Sep 2024 17:42:59 +0200
Message-ID:  <857ae911c23a474e6de4a1ba0b224bc8d982d624.1725635013.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10837; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=Jf0tLkCEoX06MlQMEniRHbvB1Cz6mgIW9+EWndqQs6E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm2yMJrdE7OTayrvuYhnHLoweN/4mfyiqQ5S4ZM BUxfRW4dYmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZtsjCQAKCRCPgPtYfRL+ TgBlB/91CsUBnYu+MjP+aetzJ8XE3u9RKP3V1ckq8wmcXmqF1iSJDh5pz0g1SGqWSJGZzABanzR Ng7vN1hFU4g47wN0VzKKqotm7aFLW1CDSaAEJx3Zihu8144+qeI3ZTD9iU3vXo2sb8d9gYe+3Xz 75S4mYKO0MYIhoOQJR8T21Hngt/mzxHgIYhIJUJbTX4yP6LSZp1O81l3YxjhdS7EnAYpBpSp3Pt t8XuFQJthyvGCr2XxI7fdOmJiFJxh2jgl8Cx7hoxJNHjrpX1f09bI6cu7r4OjIhcFxAKIaRkUwY ivl8QlUrKv45c6VGqdSlAX+xsClazKct4UBoPL75Slt4NxWj
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Provide API functions for consumers to work with waveforms.

Note that one relevant difference between pwm_get_state() and
pwm_get_waveform*() is that the latter yields the actually configured
hardware state, while the former yields the last state passed to
pwm_apply*() and so doesn't account for hardware specific rounding.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 261 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h |   6 +-
 2 files changed, 266 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index a5aec732e2a4..c7f39f9f4bcf 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -49,6 +49,30 @@ static void pwmchip_unlock(struct pwm_chip *chip)
 
 DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
 
+static bool pwm_wf_valid(const struct pwm_waveform *wf)
+{
+	/*
+	 * For now restrict waveforms to period_length_ns <= S64_MAX to provide
+	 * some space for future extensions. One possibility is to simplify
+	 * representing waveforms with inverted polarity using negative values
+	 * somehow.
+	 */
+	if (wf->period_length_ns > S64_MAX)
+		return false;
+
+	if (wf->duty_length_ns > wf->period_length_ns)
+		return false;
+
+	/*
+	 * .duty_offset_ns is supposed to be smaller than .period_length_ns, apart
+	 * from the corner case .duty_offset_ns = 0 + .period_length_ns = 0.
+	 */
+	if (wf->duty_offset_ns && wf->duty_offset_ns >= wf->period_length_ns)
+		return false;
+
+	return true;
+}
+
 static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
 {
 	if (wf->period_length_ns) {
@@ -95,6 +119,29 @@ static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
 	}
 }
 
+static int pwmwfcmp(const struct pwm_waveform *a, const struct pwm_waveform *b)
+{
+	if (a->period_length_ns > b->period_length_ns)
+		return 1;
+
+	if (a->period_length_ns < b->period_length_ns)
+		return -1;
+
+	if (a->duty_length_ns > b->duty_length_ns)
+		return 1;
+
+	if (a->duty_length_ns < b->duty_length_ns)
+		return -1;
+
+	if (a->duty_offset_ns > b->duty_offset_ns)
+		return 1;
+
+	if (a->duty_offset_ns < b->duty_offset_ns)
+		return -1;
+
+	return 0;
+}
+
 static int pwm_check_rounding(const struct pwm_waveform *wf,
 			      const struct pwm_waveform *wf_rounded)
 {
@@ -145,6 +192,220 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
 
 #define WFHWSIZE 20
 
+/**
+ * pwm_round_waveform_might_sleep - Query hardware capabilities
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @wf: waveform to round and output parameter
+ *
+ * Typically a given waveform cannot be implemented exactly by hardware, e.g.
+ * because hardware only supports coarse period resolution or no duty_offset.
+ * This function returns the actually implemented waveform if you pass wf to
+ * pwm_set_waveform_might_sleep now.
+ *
+ * Note however that the world doesn't stop turning when you call it, so when
+ * doing
+ *
+ * 	pwm_round_waveform_might_sleep(mypwm, &wf);
+ * 	pwm_set_waveform_might_sleep(mypwm, &wf, true);
+ *
+ * the latter might fail, e.g. because an input clock changed its rate between
+ * these two calls and the waveform determined by
+ * pwm_round_waveform_might_sleep() cannot be implemented any more.
+ *
+ * Returns 0 on success, 1 if there is no valid hardware configuration matching
+ * the input waveform under the PWM rounding rules or a negative errno.
+ */
+int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	struct pwm_waveform wf_req = *wf;
+	char wfhw[WFHWSIZE];
+	int ret_tohw, ret_fromhw;
+
+	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+	if (!pwm_wf_valid(wf))
+		return -EINVAL;
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	ret_tohw = __pwm_round_waveform_tohw(chip, pwm, wf, wfhw);
+	if (ret_tohw < 0)
+		return ret_tohw;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_tohw > 1)
+		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform_tohw: requested %llu/%llu [+%llu], return value %d\n",
+			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
+
+	ret_fromhw = __pwm_round_waveform_fromhw(chip, pwm, wfhw, wf);
+	if (ret_fromhw < 0)
+		return ret_fromhw;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ret_fromhw > 0)
+		dev_err(&chip->dev, "Unexpected return value from __pwm_round_waveform_fromhw: requested %llu/%llu [+%llu], return value %d\n",
+			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns, ret_tohw);
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
+	    ret_tohw == 0 && pwm_check_rounding(&wf_req, wf))
+		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns,
+			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
+	return ret_tohw;
+}
+EXPORT_SYMBOL_GPL(pwm_round_waveform_might_sleep);
+
+/**
+ * pwm_get_waveform_might_sleep - Query hardware about current configuration
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @wf: output parameter
+ *
+ * Stores the current configuration of the PWM in @wf. Note this is the
+ * equivalent of pwm_get_state_hw() (and not pwm_get_state()) for pwm_waveform.
+ */
+int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	char wfhw[WFHWSIZE];
+	int err;
+
+	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	err = __pwm_read_waveform(chip, pwm, &wfhw);
+	if (err)
+		return err;
+
+	return __pwm_round_waveform_fromhw(chip, pwm, &wfhw, wf);
+}
+EXPORT_SYMBOL_GPL(pwm_get_waveform_might_sleep);
+
+/* Called with the pwmchip lock held */
+static int __pwm_set_waveform(struct pwm_device *pwm,
+			      const struct pwm_waveform *wf,
+			      bool exact)
+{
+	struct pwm_chip *chip = pwm->chip;
+	const struct pwm_ops *ops = chip->ops;
+	char wfhw[WFHWSIZE];
+	struct pwm_waveform wf_rounded;
+	int err;
+
+	BUG_ON(WFHWSIZE < ops->sizeof_wfhw);
+
+	if (!pwm_wf_valid(wf))
+		return -EINVAL;
+
+	err = __pwm_round_waveform_tohw(chip, pwm, wf, &wfhw);
+	if (err)
+		return err;
+
+	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length_ns) {
+		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+		if (err)
+			return err;
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm_check_rounding(wf, &wf_rounded))
+			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
+
+		if (exact && pwmwfcmp(wf, &wf_rounded)) {
+			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
+				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns);
+
+			return 1;
+		}
+	}
+
+	err = __pwm_write_waveform(chip, pwm, &wfhw);
+	if (err)
+		return err;
+
+	/* update .state */
+	pwm_wf2state(wf, &pwm->state);
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length_ns) {
+		struct pwm_waveform wf_set;
+
+		err = __pwm_read_waveform(chip, pwm, &wfhw);
+		if (err)
+			/* maybe ignore? */
+			return err;
+
+		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_set);
+		if (err)
+			/* maybe ignore? */
+			return err;
+
+		if (pwmwfcmp(&wf_set, &wf_rounded) != 0)
+			dev_err(&chip->dev,
+				"Unexpected setting: requested %llu/%llu [+%llu], expected %llu/%llu [+%llu], set %llu/%llu [+%llu]\n",
+				wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+				wf_rounded.duty_length_ns, wf_rounded.period_length_ns, wf_rounded.duty_offset_ns,
+				wf_set.duty_length_ns, wf_set.period_length_ns, wf_set.duty_offset_ns);
+	}
+	return 0;
+}
+
+/**
+ * pwm_set_waveform_might_sleep - Apply a new waveform
+ * Cannot be used in atomic context.
+ * @pwm: PWM device
+ * @wf: The waveform to apply
+ * @exact: If true no rounding is allowed
+ *
+ * Typically a requested waveform cannot be implemented exactly, e.g. because
+ * you requested .period_length_ns = 100 ns, but the hardware can only set
+ * periods that are a multiple of 8.5 ns. With that hardware passing exact =
+ * true results in pwm_set_waveform_might_sleep() failing and returning 1. If
+ * exact = false you get a period of 93.5 ns (i.e. the biggest period not bigger
+ * than the requested value).
+ * Note that even with exact = true, some rounding by less than 1 is
+ * possible/needed. In the above example requesting .period_length_ns = 94 and
+ * exact = true, you get the hardware configured with period = 93.5 ns.
+ */
+int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
+				 const struct pwm_waveform *wf, bool exact)
+{
+	struct pwm_chip *chip = pwm->chip;
+	int err;
+
+	might_sleep();
+
+	guard(pwmchip)(chip);
+
+	if (!chip->operational)
+		return -ENODEV;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && chip->atomic) {
+		/*
+		 * Catch any drivers that have been marked as atomic but
+		 * that will sleep anyway.
+		 */
+		non_block_start();
+		err = __pwm_set_waveform(pwm, wf, exact);
+		non_block_end();
+	} else {
+		err = __pwm_set_waveform(pwm, wf, exact);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(pwm_set_waveform_might_sleep);
+
 static void pwm_apply_debug(struct pwm_device *pwm,
 			    const struct pwm_state *state)
 {
diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 6a26a5210dab..40cef0bc0de7 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -358,7 +358,11 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
 }
 
 #if IS_ENABLED(CONFIG_PWM)
-/* PWM user APIs */
+
+/* PWM consumer APIs */
+int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
+int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf);
+int pwm_set_waveform_might_sleep(struct pwm_device *pwm, const struct pwm_waveform *wf, bool exact);
 int pwm_apply_might_sleep(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_apply_atomic(struct pwm_device *pwm, const struct pwm_state *state);
 int pwm_adjust_config(struct pwm_device *pwm);
-- 
2.45.2


