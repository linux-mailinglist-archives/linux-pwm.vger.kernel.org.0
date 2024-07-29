Return-Path: <linux-pwm+bounces-2926-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 820E693F852
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 16:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209DB283B1D
	for <lists+linux-pwm@lfdr.de>; Mon, 29 Jul 2024 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58E7155A59;
	Mon, 29 Jul 2024 14:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OlbakB8f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129C155A58
	for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722263716; cv=none; b=mZtnQ2reFDAQzSZsQihFsydZSd6BYQ3Gczm/MYhzgQG1QeHIGBVgL/+YnzAlounAtRgau/z2kOHIFeZPa8lmmAuvmzswyOBw49pl5lGM9qGczCC2gAzXaOpkQ6DUhzwAUvZ0Y1HNd3yjS1QGSb9VcaGuiFOZHcXsZqaj5IVwVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722263716; c=relaxed/simple;
	bh=NSSmYuFik1RNMaX/b0qg9v0ZOSqNyaU9oWMhz1GZ80M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lAWXB6QJxLFeHw14/te8IWbpdw4rgsxpBpg4/AlawUIx+5I8hic/NRuIAxtFYTgZPvGB28RSAxhiLlohq7Yj3GVlDO1StQgVKBoISB/hq+OSOHI+sbJzgihUfL8O+ET+A3csFBGkP7bL0cwOVryz8uT4H9QrPiv7xxdaA3Ia/CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OlbakB8f; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42819654737so12124135e9.1
        for <linux-pwm@vger.kernel.org>; Mon, 29 Jul 2024 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722263713; x=1722868513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9treUPuX3jNmcVNf9Xy0X4Wi1t56xuaDc+VIUwuIks=;
        b=OlbakB8fy1GegjPqiputxgfb9iqMQguWhlLPHyIDfNdFkW91qgTE5UtPnldICWOk+4
         mVKKn+yQea0d0afRVfug38QT8lTd2dMSqWhrn20HLROomlC200j3wX95bJjSx9cLU8ve
         OOwba5fJBpqFs++0S2m/wP0VnZ9DOjEr7gxVtG+/C6ppxNXAn1HDIQvcqLUPY3FiUnpz
         HKlv0UJWuiF90yKldGwYy8xbatFUFy22/l7/2XbKC0VpvFAkLO2WRyEj647nMv95mpF4
         OE8pgGR8NwwMeS92APpDdleGGhemUy/prs0QxdaP9Y/Kfj9G62hPVRYuPyjfTwx/JmL+
         5sOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722263713; x=1722868513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u9treUPuX3jNmcVNf9Xy0X4Wi1t56xuaDc+VIUwuIks=;
        b=nGHpNIlVL2AYwUJV/wQMKnoVYZIp5bA9qMtwnGAu9W6/XPKs9k+TpnuTLX09hmM2HW
         ctSzQGWKcQR1TxdpmHx+Y9k6/QP0j5AcsRUHsXxCYKO1u5OzhtjlHbbz1WBbagzLfN2F
         sE3qTv+Dc0uhdRVnDKQDg2nHSpEMdWXP17b31YKu8ccQE51Qpb4yeAOy08pyFmGubzUI
         Nxs4xxxMSnkd4ZFtAX8FQhPP8OAwZIeOM9rKAI7YBJDLUTuou9PctOMbuk6ntwDMyfzP
         X1p4AWaSU2kOCMXXg7mLBgKsExGwvfadmbc2yBue2NcsHMrtuR5JJgT/go4mRXGX48d/
         LLDQ==
X-Gm-Message-State: AOJu0YwtwmBZUvFE8elRiZEM72LAgDvk3hTMXrEmUuWF4xXexS9PNY4p
	tegj5tkY+VM8yF3UzEV7UogJpSfW+bVKpuNhElpvv5mD4wpD2LP3gXSiGQipToahNyy8PzCzQCB
	2
X-Google-Smtp-Source: AGHT+IFcPVC9U5eA5l7U8iZ35TmvMA+oSGF6fD0vB41zp41BuC2Xf7yE8mM9+Y1fyk1z+eehk2JmmQ==
X-Received: by 2002:a05:600c:1390:b0:426:5e91:3ff1 with SMTP id 5b1f17b1804b1-42811dcd2f9mr51586095e9.24.1722263713359;
        Mon, 29 Jul 2024 07:35:13 -0700 (PDT)
Received: from localhost ([2a02:8071:b783:6940:59dd:510e:47d0:643f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4281d805323sm33478625e9.41.2024.07.29.07.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 07:35:13 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: Trevor Gamblin <tgamblin@baylibre.com>
Subject: [PATCH v3 4/8] pwm: Provide new consumer API functions for waveforms
Date: Mon, 29 Jul 2024 16:34:20 +0200
Message-ID:  <015a5fbd5cf449bcb2d8fdf2305d7b6bf7109844.1722261050.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
References: <cover.1722261050.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=7930; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=NSSmYuFik1RNMaX/b0qg9v0ZOSqNyaU9oWMhz1GZ80M=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmp6h2AKPXXPg+K+qzaGPP0q4xP2JxJzqMc77tX yRF18SX0F2JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZqeodgAKCRCPgPtYfRL+ TvK0CACVvQCBddK+HZSs7Pkwj4qhV+LanHnGj7gG6mBMv0v3NHWDwLrBR8VgS2MkE7FqCb6GXlw Y5OQgaoUhLY2EPKZ0fcxCX4r4BXlNZWb2TN1mfdaX4dhyGTehe1I6++41DerQn4SOMk+GFQ04Sx 8k5gdTOcSq0ANCyvSD+ljd9LCzHqNMjtt+1y7wuBm8p4wmgnY5kXfvSbVLVTgY/JRjsNdFIUYJ8 IohdN1YZ7HqgMuKS4hJqRnj7jEtSObzl257MqOq0ZYJRKb9beJiuK/NyNGk0MCWcQILV/vmGcFY x2L1b4oQHsDNFtBWSpUC/Ds1g42yTF0TVyNlyu+ilwJZ4mOe
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
index a8a0c12fef83..41e620944375 100644
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
+			wf_req.duty_length_ns, wf_req.period_length_ns, wf_req.duty_offset_ns,
+			wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
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
2.43.0


