Return-Path: <linux-pwm+bounces-2803-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FE9312E7
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 13:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB37E280F16
	for <lists+linux-pwm@lfdr.de>; Mon, 15 Jul 2024 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C80D16CD36;
	Mon, 15 Jul 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="R9b6d76N"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6B418732B
	for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 11:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042209; cv=none; b=QPOO0KithEFSvAdjqsIOwgng1mTGr0//CvKwYcos0liVHuWPjlH4YcbI9UD27nxT4HloE8xy5bv0KvJa76b/TjLZ4GrqXErynN+9rs8crznt7xQnoyd7gmQt8ntKmrUNIZ3TWxdJJCYsMe4jnybN16/PVNEWu8TZ5othM+kXtTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042209; c=relaxed/simple;
	bh=a+6ibJgFsqFde6Mwrmxbi/10kOZJAuzYL0+hOYtBgU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tapiqw4zfQbTqBMHydpxphYcPMEr7Raq9fRZ/tCUva4ZrxQMOSwA1dVnrQJYJruzJxvKa0i0bzJQLLyrNj5M1JbnME6xG53aAzJNdpaAeiyfyY6hfwa2UFu8sf6v6L5ZiB4FmrXBG5gsavF6d7h01O4VUwLJ8wwzVtH5pTVu9Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=R9b6d76N; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so27618755e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 15 Jul 2024 04:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1721042206; x=1721647006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sqxmrsBVJDntU5uaYO3uqnHUdQ7RoeaDF5TLV6cCWs=;
        b=R9b6d76N3Uc+/IVvPExqGIv2Dw2kKr9WDsU5pE1xI1Gb2rvIVpeBUn5yKImFFp+u9G
         I9f9ilLj2yI2F9rgcvc1Qreaq3pDLrK9XCwGMYhVRHB7qhjx/Cu6yrGB61lXZUX5hi6i
         vq0etJyDhhohHuYFJ6jcRgEEfR2HrHjs7Dc8yH2frhlfJ4RNY2QQLwNZ7Fue+A9A4KPR
         HEtRDPpWDAjLxX5btwzA8+NxQd0fgK0pkxHSyR8lNafyeoAe/a1rwkQytTf5UT3f1KpE
         m+sPFyvV7LlBqOWL0OlLriVcIVrPqEi1IAVIKrHDdCGS4MVa9rEYaIQJauem8UsVsyxj
         aQ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042206; x=1721647006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sqxmrsBVJDntU5uaYO3uqnHUdQ7RoeaDF5TLV6cCWs=;
        b=bzlF+n70l5yWa5VDPN2tIxJhe96pNhx1e3dTMoUfzZwDvr57KEvls74CD8WepEqJl2
         bbuGTx394NpW+7QIM6YbVrUxLmk5cHhgVljIX4Bnw/nOxPHzvAusTHbEcbPzv/+HjEJm
         +eFrRHKAF7j4Cb2zTRI3sfXanDmj+rV5ZCk3y5jqqP6I9KKBXTaWceBxHo6Mmc+kK6UC
         fmnomJGt5Ragc3qweOfUKKE49MC0ulFm2qggWuU7pJBgErWDGyN+MFqkAN4sEEPT7xPy
         PERLvuLZmToK08Dy9nOu0e9iK8slw2D9UQ3U752lWMqDlsTB8Ov8mEARCd0O7Rj6sEt2
         Jlzw==
X-Gm-Message-State: AOJu0YxwxQ6R2DXZDtW6wlGwzhqhB1NnA9k7MK9sM+vn630/uvb9D7aY
	g/cGanV6ZwjJC+dRuEDCAT6lZEXz7NTUeaSY6s3BIk5q+tW1B6RQg05cckUOK1Pxqv/vs4NCABc
	n
X-Google-Smtp-Source: AGHT+IE8lLmUsox2LHyfR1HMLRD8ZwB1wbOIlMAneFHEdsMR21ZrgQxg/Beb0yfWRnKTXSjVaJC/tA==
X-Received: by 2002:adf:9784:0:b0:367:2945:2bfa with SMTP id ffacd0b85a97d-367cead0ff4mr11097970f8f.52.1721042205798;
        Mon, 15 Jul 2024 04:16:45 -0700 (PDT)
Received: from localhost (p50915eb1.dip0.t-ipconnect.de. [80.145.94.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3e27sm6117044f8f.15.2024.07.15.04.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:16:45 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v2 4/8] pwm: Provide new consumer API functions for waveforms
Date: Mon, 15 Jul 2024 13:16:09 +0200
Message-ID:  <8db2c6f239b9e101f85d556d9e203935c2da2570.1721040875.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7785; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=a+6ibJgFsqFde6Mwrmxbi/10kOZJAuzYL0+hOYtBgU0=; b=owGbwMvMwMXY3/A7olbonx/jabUkhrSprIyf1HYr3g+XLT/Aw/A/tdrnB7uqlnvupw7Zmg8VF bHpXnGdjMYsDIxcDLJiiiz2jWsyrarkIjvX/rsMM4iVCWQKAxenAEyk1Z39n7aB+as611XcjSx3 kowPCFzOKqqqOGoud8h80f0JHWxhd/jutT+eKLctiSn1WuRurs/GfusfP7Ku0eV9cup23uWszu/ pawKy+8/s11Ask+b5tWT2R/ujzZYv+AwDNS9o6WzvPNZj8tDF/Zsd48eoD6UCr79sMDwnVubK9P Yw9xoxhe3bV3O4aD+qcV73Jiot0Uk3Wd7ktfy7o5vzJtdYPKidqy+w44GnxHnV5k9Bp+9lia0sN J/LWldlymudcvP3v3PB3dfX3a+9tJHjgfOjb3YsDqt9n5kd+7zjdHTLzp/OVlaiPYu0V3Zkfhe6 9jf43QPbJxYvX3twcOqLp0i+nxU20zn2QcRXuTafLXa8AA==
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Provide API functions for consumers to work with waveforms.

Note that one relevant difference between pwm_get_state() and
pwm_get_waveform*() is that the latter yields the actually configured
hardware state, while the former yields the last state passed to
pwm_apply*() and so doesn't account for hardware specific rounding.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/core.c  | 201 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pwm.h |   6 +-
 2 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
index 1f52cabe0131..4dcb7ec4223f 100644
--- a/drivers/pwm/core.c
+++ b/drivers/pwm/core.c
@@ -49,6 +49,30 @@ static void pwmchip_unlock(struct pwm_chip *chip)
 
 DEFINE_GUARD(pwmchip, struct pwm_chip *, pwmchip_lock(_T), pwmchip_unlock(_T))
 
+static bool pwm_wf_valid(const struct pwm_waveform *wf)
+{
+	/*
+	 * For now restrict waveforms to period_length <= S64_MAX to provide
+	 * some space for future extensions. One possibility is to simplify
+	 * representing waveforms with inverted polarity using negative values
+	 * somehow.
+	 */
+	if (wf->period_length > S64_MAX)
+		return false;
+
+	if (wf->duty_length > wf->period_length)
+		return false;
+
+	/*
+	 * .duty_offset is supposed to be smaller than .period_length, apart
+	 * from the corner case .duty_offset = 0 + .period = 0.
+	 */
+	if (wf->duty_offset && wf->duty_offset >= wf->period_length)
+		return false;
+
+	return true;
+}
+
 static void pwm_wf2state(const struct pwm_waveform *wf, struct pwm_state *state)
 {
 	if (wf->period_length) {
@@ -95,6 +119,29 @@ static void pwm_state2wf(const struct pwm_state *state, struct pwm_waveform *wf)
 	}
 }
 
+static int pwmwfcmp(const struct pwm_waveform *a, const struct pwm_waveform *b)
+{
+	if (a->period_length > b->period_length)
+		return 1;
+
+	if (a->period_length < b->period_length)
+		return -1;
+
+	if (a->duty_length > b->duty_length)
+		return 1;
+
+	if (a->duty_length < b->duty_length)
+		return -1;
+
+	if (a->duty_offset > b->duty_offset)
+		return 1;
+
+	if (a->duty_offset < b->duty_offset)
+		return -1;
+
+	return 0;
+}
+
 static int pwm_check_rounding(const struct pwm_waveform *wf,
 			      const struct pwm_waveform *wf_rounded)
 {
@@ -145,6 +192,160 @@ static int __pwm_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, c
 
 #define WFHWSIZE 20
 
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
+	ret_fromhw = __pwm_round_waveform_fromhw(chip, pwm, wfhw, wf);
+	if (ret_fromhw < 0)
+		return ret_fromhw;
+
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) &&
+	    ret_tohw == 0 && pwm_check_rounding(&wf_req, wf))
+		dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+			wf_req.duty_length, wf_req.period_length, wf_req.duty_offset,
+			wf->duty_length, wf->period_length, wf->duty_offset);
+
+	return ret_tohw;
+}
+
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
+	if ((IS_ENABLED(CONFIG_PWM_DEBUG) || exact) && wf->period_length) {
+		err = __pwm_round_waveform_fromhw(chip, pwm, &wfhw, &wf_rounded);
+		if (err)
+			return err;
+
+		if (IS_ENABLED(CONFIG_PWM_DEBUG) && pwm_check_rounding(wf, &wf_rounded))
+			dev_err(&chip->dev, "Wrong rounding: requested %llu/%llu [+%llu], result %llu/%llu [+%llu]\n",
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
+
+		if (exact && pwmwfcmp(wf, &wf_rounded)) {
+			dev_dbg(&chip->dev, "Requested no rounding, but %llu/%llu [+%llu] -> %llu/%llu [+%llu]\n",
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset);
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
+	if (IS_ENABLED(CONFIG_PWM_DEBUG) && ops->read_waveform && wf->period_length) {
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
+				wf->duty_length, wf->period_length, wf->duty_offset,
+				wf_rounded.duty_length, wf_rounded.period_length, wf_rounded.duty_offset,
+				wf_set.duty_length, wf_set.period_length, wf_set.duty_offset);
+	}
+	return 0;
+}
+
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
+        if (!chip->operational)
+                return -ENODEV;
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
index 2a1f1f25a56c..2d1f36a84f1e 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -357,7 +357,11 @@ static inline void pwmchip_set_drvdata(struct pwm_chip *chip, void *data)
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
2.43.0


