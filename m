Return-Path: <linux-pwm+bounces-3301-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8107C97D334
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 11:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67401C22A81
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Sep 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E81422BD;
	Fri, 20 Sep 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KvjgHGfT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D213D635
	for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726822726; cv=none; b=MVrZF4CWDDNN0O01EjnRZeG6w2FOfkpFVU/3J06tVk8P74AicR6XEphDVU89LScTQIABAHU2eoGCFxKta2GWClnnji9Ju79njL1Gtaw7SBx2XZ904rKTrBUIMkgI9slFbLf54qUNyJ9ZngNJYc0h09uoXwnfkJj6FFIgFxN2uG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726822726; c=relaxed/simple;
	bh=FOs+TxxOJvVcikDA+Nu6AC1fuZ227y3c9xZUpQL2W78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeP6f5L8x8eccuDBgRjoNGEjuNPWgeczLmd4PYz8HE7yl4dbqlOvmWOUNe75cJtWuO6X1j7vg/BWjxv9qlUty71zgdRDhlW9qj42n5jWt76cLJ6ecBIzYEPjYLgtPrfhmIh2E1BEPFvgGG+4/iyKFhb5GhP0cX58LUuZ9zJyD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KvjgHGfT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42cb6f3a5bcso21474655e9.2
        for <linux-pwm@vger.kernel.org>; Fri, 20 Sep 2024 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726822720; x=1727427520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oHrTaaOEGxTihHY+oSP5WaD76T/0e6fhH7kCYlTZGmM=;
        b=KvjgHGfTZOnCe1epKAZfGPh6jPTb0HgS+kWXzBM2/3kcHYV54p0VBBNnU5of+z9wsj
         5dE4z1eumDDDX8GW5CTG9nIn9eG7ga1C5OTKR6wRpMrSaYx2YR0CaynYl2azZZ66LM4c
         pcomSBSx1G5Zpefja04PQpHKQrPt4GVTdJIZBIqrboCVRbvdO7tRlv2r+0ity+uEvtOA
         FBhU4P70ZtZ65hswfzFsIqnmBYQwdAqntMN6XPJv+Wc+G9H/Dm5sSrqVu2l6ALMUqKTE
         GhZkjGWE3EbqqsbwHLw5BikxjbAguY0aUeQoEfw8vCVrS/HmfmQU5Ft+QjrG6Gx4JNrC
         Ajsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726822720; x=1727427520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oHrTaaOEGxTihHY+oSP5WaD76T/0e6fhH7kCYlTZGmM=;
        b=Hbc/2/Ixrj+wCs7zNU7ppMKT4tUdxechZCT2wTery01lJE8qT+/EshgCNIiehuZJo/
         ehsdGqVLS/nQ/uUIoNEZqombNL0mNNBdjJ8AT5CBDqcys9IUaGXg0va7LhWB6vl7MhSC
         qWS/e4OSXYHUM9N4eeedFV8dkdJeNeEN1V8ix7HkpmnLYccoRp+AWlvkxQsuhkHBqlvu
         D+FP/voYnSuDCgg8E7HdpmHsDpEaSsu1K4sLKe7lrfaYESAi88VRew4dTtcafOT9P45L
         /cX4fmQShEzEaWUPO+a+QWAyHI9KvEHKwyIVhSAcUEULmgEp7IoFzfk9TY4iomKBVJUX
         wEmA==
X-Gm-Message-State: AOJu0YwiXDkWR7yci+G2mOC6Qcl8MDro8fDrEz+5TQ9UNd1BceHHYXjz
	ZVa4sGO1TYzTZM07RK4nynnhwdipjqXWMH9lr/sPnvdqDQyHpLlw7plXfxNsND67+p9aFUQs46I
	l
X-Google-Smtp-Source: AGHT+IHdzqCXiGA9nRxVOClTg3ydZxFalwK/sO5L2hGpdwA6a/y8YAcOz3IkjEbjo5c4rhpEc1tUwg==
X-Received: by 2002:a05:600c:1da9:b0:42c:b950:6821 with SMTP id 5b1f17b1804b1-42e7ac4c065mr19362115e9.19.1726822719877;
        Fri, 20 Sep 2024 01:58:39 -0700 (PDT)
Received: from localhost (p200300f65f01db004d6a46a6454a1385.dip0.t-ipconnect.de. [2003:f6:5f01:db00:4d6a:46a6:454a:1385])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7805193sm16937638f8f.98.2024.09.20.01.58.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 01:58:39 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>,
	David Lechner <dlechner@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 3/8] pwm: Provide new consumer API functions for waveforms
Date: Fri, 20 Sep 2024 10:57:59 +0200
Message-ID:  <6c97d27682853f603e18e9196043886dd671845d.1726819463.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
References: <cover.1726819463.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10840; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=FOs+TxxOJvVcikDA+Nu6AC1fuZ227y3c9xZUpQL2W78=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm7TkdNPK3s9AuwYRB8KYijLj2sLg9WN1hN6k5T cspea5UHw+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZu05HQAKCRCPgPtYfRL+ Th1KB/9766+fV/PZTfv3KqRljihTABa1+8ysNBlvX8mo3I+4BW+8drtVGFbqvW0yulqVeXLEIge e+ui/f8t1ZqD+48Uw6cD+67zhOAyccoD7TnOjqIYs6FW/VVulSL9sxfgB8XkQ9/BD1dG0JIO03C Lkb4GRv9aQXdUfdFpXZF+pB+zn4WIN11oxLpv4luLx9FGqQGtzZISwYLGKTF8o33V1lUIk7v93C aeU/sd+BZJZjxfc9uZAA0gZOiOnI19yu2RWAlUuZ05JViuDBWaYBzCnNPMTmTvrMoMlhgoIhbpK QjStU9QU80ZZOYuMSjjsdNPrXUQauc1pIhSTtUTO99nyWFiF
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
index e3e26aafa461..1cefc6e9c10d 100644
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
+	 * from the corner case .duty_offset_ns == 0 && .period_length_ns == 0.
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
index d8cfe1c9b19d..c3d9ddeafa65 100644
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


