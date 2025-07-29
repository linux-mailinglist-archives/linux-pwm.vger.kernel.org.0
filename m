Return-Path: <linux-pwm+bounces-6908-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA59B14C55
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 12:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461D2545E77
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Jul 2025 10:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622DC28BAB9;
	Tue, 29 Jul 2025 10:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Wb/bGXJO"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FB728B401
	for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 10:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753785402; cv=none; b=WdzzJgu+UeOJjjznEYyXZOIPTxQ3kzmNyvBIxPnGKCUtovt8p/r2aAt/6PeRySEHcvrU+bAlzWE8ufaHRpvpkhRjI1HMgxEwEkvQFBZMknEP2z8pofsizwQHUihCjThTviGV4AgJOeUGx/5NtocBltRBTzjOsMp0Atg/V+zgbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753785402; c=relaxed/simple;
	bh=8SgViRt/rg/dYGQ12Q07Sv043x5SZDkHh/R0OGzTYEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JcfZJd7POxNoxMK5SGXVPMNd84fLn6jij1ouMfNrj8JqoyTfkWDtdSws4yNm+IzJO0xaCaurUFzEkBBCyUOJOKHx3w996S2BC61MyxKU5hsmJDtYrXZOoCWAYDP0LT99k8UEzo4TelPvtZO5H3QpRgX2SHMnSNSA28DO87RqiTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Wb/bGXJO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-451d3f72391so50059815e9.3
        for <linux-pwm@vger.kernel.org>; Tue, 29 Jul 2025 03:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753785398; x=1754390198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uEiED8GGvScDQ4pdNirKSqFAan2eh/uwLFtQfQ9k+BI=;
        b=Wb/bGXJOoatWy8OEJwrqjaHJPqPhMSOWFlF8EGGZtA4QpwQkbeXrniD5w/+5fKlGNR
         sJKP8ECwJt5EDSo2VEyWjFwwc/9eSuEy8LlH72wvJjWk7GayZ3dSXHv3SFKo2KUqUlrZ
         e7V2NsbsBh7WXFxX9pem42LUMR3Rm9BZw7rCxn4HDf4KlP1Rw91Dgvkj3pjYbyk23/x7
         DnCXBB7th4qvmbR1oaI3BwOjUnD4z65ZIlmv1xuu/Cf0Gc7qMI3a3JSHK2PTU0+RJjuS
         BpgxlpOfMvrQmL5pwgbOZJHKOZArebXZ2ZytpXpW1OJ+cNFqXcndSUnhbKzDabHXQu8D
         R5gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753785398; x=1754390198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uEiED8GGvScDQ4pdNirKSqFAan2eh/uwLFtQfQ9k+BI=;
        b=hG36fGiRv7xcpwan6rGiwyttPTHGaDxVePTsk3g6XQiuM1rxTKiBKoF+eFvRku075O
         IFxI/7YwcLjRpffiW1EzjPfZxmi/E/Bhqzs5XCHYPHMe1iafvrarImlCdEgYvugNUwb7
         PKf1IGUYUxxkTwk9tmYkxs2r7WUZiHxviTj8GrT2FLEUxEw3zcMoR/1/Z0WzOBqmbhsU
         cC4OzPDRqpaaRX8MIDAztBiIZmRYF/zFz5ayNZKoVBKlf9OymjuY2WKRdD9E1CQL1/Em
         wbeT9XeMMKWIA6S7xAt2TCtyIhBdBuPgc/5hoWojOFHC12hA7TwliN/Oi5kO+5eyqBUm
         gR0g==
X-Gm-Message-State: AOJu0YwPKOpgk2a111d+GqkVFAhABdrw1x0W0VXR4XFDNKIfwbebxsH2
	OsxomoQQPUxiqgdxNnqHez0BKGOmXngPNIfbf0O8UoBzVodKAmd0cX+CAChAMlRsx/Cb40yxyEj
	B5kDr
X-Gm-Gg: ASbGncvCl4pq5B7O6L03D8udNhFXPitZuB5b2se149vP/+3f3o+W3WQIJDTMQSHtk8d
	0gIXF0sqR3Fd7AEyf9gJ4FRheZzt/Ij1f9dGuz4QvsLyWI+ZrkaWiVMO8Uy9seUZDunT70EIata
	m5RoRmDRw/P8aWsLEigi2s3LSN43dHWbCGEy++rSQkg8cMx/aZgJHLu8kGeIk7EAA4qtz+ShJHp
	hIfajOUkMwJIPxR9Af/mqrMdNivwE/TkHnCP1KH+faYGyPBSgI9r4QZOIMwSz9eX0K16MGpRL2P
	skMobjKU/XekrbBVpaygkyQzRZppFhNzC/PGyK9xwG7or0vM6W/V9eLTXLqVqynkvb2j6pxlWH/
	YVEWe/Vwiw9Gq1L04WC+BUYUctvZYkpHHSUZYDIGYFdsIE//b/QHkqbYIT9pj2BVFbeoCSYhRNJ
	A=
X-Google-Smtp-Source: AGHT+IFf8Hzl3zLHh4WUfvZW0IgHqfWFb7jfiHvMFPiClvMOX1fd580vq9CmSQs+m5pcyA/37+laUQ==
X-Received: by 2002:a05:600c:4e0c:b0:44a:b478:1387 with SMTP id 5b1f17b1804b1-45882a37dc7mr83918765e9.17.1753785397897;
        Tue, 29 Jul 2025 03:36:37 -0700 (PDT)
Received: from localhost (p200300f65f06ab0400000000000001b9.dip0.t-ipconnect.de. [2003:f6:5f06:ab04::1b9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4588e5e4aeasm21870085e9.29.2025.07.29.03.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 03:36:37 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: linux-pwm@vger.kernel.org
Cc: David Jander <david@protonic.nl>,
	Clemens Gruber <clemens.gruber@pqgruber.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] pwm: pca9586: Convert to waveform API
Date: Tue, 29 Jul 2025 12:36:04 +0200
Message-ID:  <1927d115ae6797858e6c4537971dacf1d563854f.1753784092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
References: <cover.1753784092.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=13712; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=8SgViRt/rg/dYGQ12Q07Sv043x5SZDkHh/R0OGzTYEo=; b=owGbwMvMwMXY3/A7olbonx/jabUkhoyOJXIN+zKXyb2yD3JkvsTUEWOXIJLD9S7vkGFl3tXC/ oy9Ie86GY1ZGBi5GGTFFFnsG9dkWlXJRXau/XcZZhArE8gUBi5OAZhIYCz7P5uWqCJHGXH/fsFt LCvmJLl09tx14neL1roas/qIRrjtbrUihgC5drZFvQUac+TTGG5+f2JwJqTj+Lxg7z/XDZ5xcS9 WrH/Xr2V9mFEm9dtH5i2XS3aszrM5aif5Yuv/RcmLL1wr3CzBffbxVLYvU5erXdlfqrFeVGzx8e db3C7cTtNsM9i6Nsy17YWS/CWj3tC/WibmW6QYxMsm/guw8l/Bc/vO1Jmef3PKwvvEYyxfF9S2e i3Z7t60lkuuLTe1NP+/BJP1/Mz//B/jXf2//Xdcu9uEfcP/qVZdwcsfh/Xxf0qKecLySmq/mYzZ 80tVUoYzXnXnelicW6Nr5izI90I2Wja+tDFMliHs8x0A
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

This allows to expose the duty_offset feature that the chip supports, and
so also emit inverted polarity waveforms. The conversion from a waveform to
hardware settings (and vice versa) is aligned to the usual rounding rules
silencing warnings with PWM_DEBUG.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/pwm/pwm-pca9685.c | 347 ++++++++++++++++++++------------------
 1 file changed, 185 insertions(+), 162 deletions(-)

diff --git a/drivers/pwm/pwm-pca9685.c b/drivers/pwm/pwm-pca9685.c
index 3f04defd3718..107bebec3546 100644
--- a/drivers/pwm/pwm-pca9685.c
+++ b/drivers/pwm/pwm-pca9685.c
@@ -49,7 +49,14 @@
 #define PCA9685_PRESCALE_MAX	0xFF	/* => min. frequency of 24 Hz */
 
 #define PCA9685_COUNTER_RANGE	4096
-#define PCA9685_OSC_CLOCK_MHZ	25	/* Internal oscillator with 25 MHz */
+#define PCA9685_OSC_CLOCK_HZ	25000000	/* Internal oscillator with 25 MHz */
+
+/*
+ * The time value of one counter tick. Note that NSEC_PER_SEC is an integer
+ * multiple of PCA9685_OSC_CLOCK_HZ, so there is no rounding involved and we're
+ * not loosing precision due to the early division.
+ */
+#define PCA9685_QUANTUM_NS(_prescale)	((NSEC_PER_SEC / PCA9685_OSC_CLOCK_HZ) * (_prescale + 1))
 
 #define PCA9685_NUMREGS		0xFF
 #define PCA9685_MAXCHAN		0x10
@@ -141,202 +148,215 @@ static int pca9685_write_4reg(struct pwm_chip *chip, unsigned int reg, u8 val[4]
 	return err;
 }
 
-/* Helper function to set the duty cycle ratio to duty/4096 (e.g. duty=2048 -> 50%) */
-static void pca9685_pwm_set_duty(struct pwm_chip *chip, int channel, unsigned int duty)
+static int pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
 {
-	struct pwm_device *pwm = &chip->pwms[channel];
-	unsigned int on, off;
-
-	if (duty == 0) {
-		/* Set the full OFF bit, which has the highest precedence */
-		pca9685_write_reg(chip, REG_OFF_H(channel), LED_FULL);
-		return;
-	} else if (duty >= PCA9685_COUNTER_RANGE) {
-		/* Set the full ON bit and clear the full OFF bit */
-		pca9685_write_4reg(chip, REG_ON_L(channel), (u8[4]){ 0, LED_FULL, 0, 0 });
-		return;
-	}
-
-	if (pwm->state.usage_power && channel < PCA9685_MAXCHAN) {
-		/*
-		 * If usage_power is set, the pca9685 driver will phase shift
-		 * the individual channels relative to their channel number.
-		 * This improves EMI because the enabled channels no longer
-		 * turn on at the same time, while still maintaining the
-		 * configured duty cycle / power output.
-		 */
-		on = channel * PCA9685_COUNTER_RANGE / PCA9685_MAXCHAN;
-	} else
-		on = 0;
-
-	off = (on + duty) % PCA9685_COUNTER_RANGE;
-
-	/* implicitly clear full ON and full OFF bit */
-	pca9685_write_4reg(chip, REG_ON_L(channel),
-			   (u8[4]){ on & 0xff, (on >> 8) & 0xf, off & 0xff, (off >> 8) & 0xf });
-}
-
-static unsigned int pca9685_pwm_get_duty(struct pwm_chip *chip, int channel)
-{
-	struct pwm_device *pwm = &chip->pwms[channel];
-	unsigned int off = 0, on = 0, val = 0;
-
-	if (WARN_ON(channel >= PCA9685_MAXCHAN)) {
-		/* HW does not support reading state of "all LEDs" channel */
-		return 0;
-	}
-
-	pca9685_read_reg(chip, LED_N_OFF_H(channel), &off);
-	if (off & LED_FULL) {
-		/* Full OFF bit is set */
-		return 0;
-	}
-
-	pca9685_read_reg(chip, LED_N_ON_H(channel), &on);
-	if (on & LED_FULL) {
-		/* Full ON bit is set */
-		return PCA9685_COUNTER_RANGE;
-	}
-
-	pca9685_read_reg(chip, LED_N_OFF_L(channel), &val);
-	off = ((off & 0xf) << 8) | (val & 0xff);
-	if (!pwm->state.usage_power)
-		return off;
-
-	/* Read ON register to calculate duty cycle of staggered output */
-	if (pca9685_read_reg(chip, LED_N_ON_L(channel), &val)) {
-		/* Reset val to 0 in case reading LED_N_ON_L failed */
-		val = 0;
-	}
-	on = ((on & 0xf) << 8) | (val & 0xff);
-	return (off - on) & (PCA9685_COUNTER_RANGE - 1);
-}
-
-static void pca9685_set_sleep_mode(struct pwm_chip *chip, bool enable)
-{
-	struct device *dev = pwmchip_parent(chip);
 	struct pca9685 *pca = to_pca(chip);
-	int err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
-				     MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
-	if (err) {
-		dev_err(dev, "regmap_update_bits of register 0x%x failed: %pe\n",
-			PCA9685_MODE1, ERR_PTR(err));
-		return;
-	}
+	int err;
+
+	err = regmap_update_bits(pca->regmap, PCA9685_MODE1,
+				 MODE1_SLEEP, enable ? MODE1_SLEEP : 0);
+	if (err)
+		return err;
 
 	if (!enable) {
 		/* Wait 500us for the oscillator to be back up */
 		udelay(500);
 	}
+
+	return 0;
 }
 
-static int __pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			       const struct pwm_state *state)
+struct pca9685_waveform {
+	u8 onoff[4];
+	u8 prescale;
+};
+
+static int pca9685_round_waveform_tohw(struct pwm_chip *chip, struct pwm_device *pwm, const struct pwm_waveform *wf, void *_wfhw)
 {
+	struct pca9685_waveform *wfhw = _wfhw;
 	struct pca9685 *pca = to_pca(chip);
-	unsigned long long duty, prescale;
-	unsigned int val = 0;
+	unsigned int best_prescale;
+	u8 prescale;
+	unsigned int period_ns, duty;
+	int ret_tohw = 0;
 
-	if (state->polarity != PWM_POLARITY_NORMAL)
-		return -EINVAL;
+	if (!wf->period_length_ns) {
+		*wfhw = (typeof(*wfhw)){
+			.onoff = { 0, 0, 0, LED_FULL, },
+			.prescale = 0,
+		};
 
-	prescale = DIV_ROUND_CLOSEST_ULL(PCA9685_OSC_CLOCK_MHZ * state->period,
-					 PCA9685_COUNTER_RANGE * 1000) - 1;
-	if (prescale < PCA9685_PRESCALE_MIN || prescale > PCA9685_PRESCALE_MAX) {
-		dev_err(pwmchip_parent(chip), "pwm not changed: period out of bounds!\n");
-		return -EINVAL;
-	}
+		dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] -> [%hhx %hhx %hhx %hhx] PSC:%hhx\n",
+			pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+			wfhw->onoff[0], wfhw->onoff[1], wfhw->onoff[2], wfhw->onoff[3], wfhw->prescale);
 
-	if (!state->enabled) {
-		pca9685_pwm_set_duty(chip, pwm->hwpwm, 0);
 		return 0;
 	}
 
-	pca9685_read_reg(chip, PCA9685_PRESCALE, &val);
-	if (prescale != val) {
-		if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
-			dev_err(pwmchip_parent(chip),
-				"pwm not changed: periods of enabled pwms must match!\n");
-			return -EBUSY;
+	if (wf->period_length_ns >= PCA9685_COUNTER_RANGE * PCA9685_QUANTUM_NS(255)) {
+		best_prescale = 255;
+	} else if (wf->period_length_ns < PCA9685_COUNTER_RANGE * PCA9685_QUANTUM_NS(3)) {
+		best_prescale = 3;
+		ret_tohw = 1;
+	} else {
+		best_prescale = (unsigned int)wf->period_length_ns / (PCA9685_COUNTER_RANGE * (NSEC_PER_SEC / PCA9685_OSC_CLOCK_HZ)) - 1;
+	}
+
+	guard(mutex)(&pca->lock);
+
+	if (!pca9685_prescaler_can_change(pca, pwm->hwpwm)) {
+		unsigned int current_prescale;
+		int ret;
+
+		ret = regmap_read(pca->regmap, PCA9685_PRESCALE, &current_prescale);
+		if (ret)
+			return ret;
+
+		if (current_prescale > best_prescale)
+			ret_tohw = 1;
+
+		prescale = current_prescale;
+	} else {
+		prescale = best_prescale;
+	}
+
+	period_ns = PCA9685_COUNTER_RANGE * PCA9685_QUANTUM_NS(prescale);
+
+	duty = (unsigned)min_t(u64, wf->duty_length_ns, period_ns) / PCA9685_QUANTUM_NS(prescale);
+
+	if (duty < PCA9685_COUNTER_RANGE) {
+		unsigned int on, off;
+
+		on = (unsigned)min_t(u64, wf->duty_offset_ns, period_ns) / PCA9685_QUANTUM_NS(prescale);
+		off = (on + duty) % PCA9685_COUNTER_RANGE;
+
+		/*
+		 * With a zero duty cycle, it doesn't matter if period was
+		 * rounded up
+		 */
+		if (!duty)
+			ret_tohw = 0;
+
+		*wfhw = (typeof(*wfhw)){
+			.onoff = { on & 0xff, (on >> 8) & 0xf, off & 0xff, (off >> 8) & 0xf },
+			.prescale = prescale,
+		};
+	} else {
+		*wfhw = (typeof(*wfhw)){
+			.onoff = { 0, LED_FULL, 0, 0, },
+			.prescale = prescale,
+		};
+	}
+
+	dev_dbg(&chip->dev, "pwm#%u: %lld/%lld [+%lld] -> %s[%hhx %hhx %hhx %hhx] PSC:%hhx\n",
+		pwm->hwpwm, wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns,
+		ret_tohw ? "#" : "", wfhw->onoff[0], wfhw->onoff[1], wfhw->onoff[2], wfhw->onoff[3], wfhw->prescale);
+
+	return ret_tohw;
+}
+
+static int pca9685_round_waveform_fromhw(struct pwm_chip *chip, struct pwm_device *pwm,
+					 const void *_wfhw, struct pwm_waveform *wf)
+{
+	const struct pca9685_waveform *wfhw = _wfhw;
+	struct pca9685 *pca = to_pca(chip);
+	unsigned int prescale;
+
+	if (wfhw->prescale)
+		prescale = wfhw->prescale;
+	else
+		scoped_guard(mutex, &pca->lock) {
+			int ret;
+
+			ret = regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
+			if (ret)
+				return ret;
 		}
 
-		/*
-		 * Putting the chip briefly into SLEEP mode
-		 * at this point won't interfere with the
-		 * pm_runtime framework, because the pm_runtime
-		 * state is guaranteed active here.
-		 */
-		/* Put chip into sleep mode */
-		pca9685_set_sleep_mode(chip, true);
+	wf->period_length_ns = PCA9685_COUNTER_RANGE * PCA9685_QUANTUM_NS(prescale);
 
-		/* Change the chip-wide output frequency */
-		pca9685_write_reg(chip, PCA9685_PRESCALE, prescale);
+	if (wfhw->onoff[3] & LED_FULL) {
+		wf->duty_length_ns = 0;
+		wf->duty_offset_ns = 0;
+	} else if (wfhw->onoff[1] & LED_FULL) {
+		wf->duty_length_ns = wf->period_length_ns;
+		wf->duty_offset_ns = 0;
+	} else {
+		unsigned int on = wfhw->onoff[0] | (wfhw->onoff[1] & 0xf) << 8;
+		unsigned int off = wfhw->onoff[2] | (wfhw->onoff[3] & 0xf) << 8;
 
-		/* Wake the chip up */
-		pca9685_set_sleep_mode(chip, false);
+		wf->duty_length_ns = (off - on) % PCA9685_COUNTER_RANGE * PCA9685_QUANTUM_NS(prescale);
+		wf->duty_offset_ns = on * PCA9685_QUANTUM_NS(prescale);
 	}
 
-	duty = PCA9685_COUNTER_RANGE * state->duty_cycle;
-	duty = DIV_ROUND_UP_ULL(duty, state->period);
-	pca9685_pwm_set_duty(chip, pwm->hwpwm, duty);
+	dev_dbg(&chip->dev, "pwm#%u: [%hhx %hhx %hhx %hhx] PSC:%hhx -> %lld/%lld [+%lld]\n",
+		pwm->hwpwm,
+		wfhw->onoff[0], wfhw->onoff[1], wfhw->onoff[2], wfhw->onoff[3], wfhw->prescale,
+		wf->duty_length_ns, wf->period_length_ns, wf->duty_offset_ns);
+
 	return 0;
 }
 
-static int pca9685_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
-			     const struct pwm_state *state)
+static int pca9685_read_waveform(struct pwm_chip *chip, struct pwm_device *pwm, void *_wfhw)
 {
+	struct pca9685_waveform *wfhw = _wfhw;
 	struct pca9685 *pca = to_pca(chip);
+	unsigned int prescale;
 	int ret;
 
-	mutex_lock(&pca->lock);
-	ret = __pca9685_pwm_apply(chip, pwm, state);
-	if (ret == 0) {
-		if (state->enabled)
-			set_bit(pwm->hwpwm, pca->pwms_enabled);
-		else
-			clear_bit(pwm->hwpwm, pca->pwms_enabled);
-	}
-	mutex_unlock(&pca->lock);
+	guard(mutex)(&pca->lock);
 
-	return ret;
-}
+	ret = regmap_bulk_read(pca->regmap, REG_ON_L(pwm->hwpwm), &wfhw->onoff, 4);
+	if (ret)
+		return ret;
 
-static int pca9685_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
-				 struct pwm_state *state)
-{
-	unsigned long long duty;
-	unsigned int val = 0;
+	ret = regmap_read(pca->regmap, PCA9685_PRESCALE, &prescale);
+	if (ret)
+		return ret;
 
-	/* Calculate (chip-wide) period from prescale value */
-	pca9685_read_reg(chip, PCA9685_PRESCALE, &val);
-	/*
-	 * PCA9685_OSC_CLOCK_MHZ is 25, i.e. an integer divider of 1000.
-	 * The following calculation is therefore only a multiplication
-	 * and we are not losing precision.
-	 */
-	state->period = (PCA9685_COUNTER_RANGE * 1000 / PCA9685_OSC_CLOCK_MHZ) *
-			(val + 1);
-
-	/* The (per-channel) polarity is fixed */
-	state->polarity = PWM_POLARITY_NORMAL;
-
-	if (pwm->hwpwm >= PCA9685_MAXCHAN) {
-		/*
-		 * The "all LEDs" channel does not support HW readout
-		 * Return 0 and disabled for backwards compatibility
-		 */
-		state->duty_cycle = 0;
-		state->enabled = false;
-		return 0;
-	}
-
-	state->enabled = true;
-	duty = pca9685_pwm_get_duty(chip, pwm->hwpwm);
-	state->duty_cycle = DIV_ROUND_DOWN_ULL(duty * state->period, PCA9685_COUNTER_RANGE);
+	wfhw->prescale = prescale;
 
 	return 0;
 }
 
+static int pca9685_write_waveform(struct pwm_chip *chip, struct pwm_device *pwm, const void *_wfhw)
+{
+	const struct pca9685_waveform *wfhw = _wfhw;
+	struct pca9685 *pca = to_pca(chip);
+	unsigned int current_prescale;
+	int ret;
+
+	guard(mutex)(&pca->lock);
+
+	if (wfhw->prescale) {
+		ret = regmap_read(pca->regmap, PCA9685_PRESCALE, &current_prescale);
+		if (ret)
+			return ret;
+
+		if (current_prescale != wfhw->prescale) {
+			if (!pca9685_prescaler_can_change(pca, pwm->hwpwm))
+				return -EBUSY;
+
+			/* Put chip into sleep mode */
+			ret = pca9685_set_sleep_mode(chip, true);
+			if (ret)
+				return ret;
+
+			/* Change the chip-wide output frequency */
+			ret = regmap_write(pca->regmap, PCA9685_PRESCALE, wfhw->prescale);
+			if (ret)
+				return ret;
+
+			/* Wake the chip up */
+			ret = pca9685_set_sleep_mode(chip, false);
+			if (ret)
+				return ret;
+		}
+	}
+
+	return regmap_bulk_write(pca->regmap, REG_ON_L(pwm->hwpwm), &wfhw->onoff, 4);
+}
+
 static int pca9685_pwm_request(struct pwm_chip *chip, struct pwm_device *pwm)
 {
 	struct pca9685 *pca = to_pca(chip);
@@ -365,8 +385,11 @@ static void pca9685_pwm_free(struct pwm_chip *chip, struct pwm_device *pwm)
 }
 
 static const struct pwm_ops pca9685_pwm_ops = {
-	.apply = pca9685_pwm_apply,
-	.get_state = pca9685_pwm_get_state,
+	.sizeof_wfhw = sizeof(struct pca9685_waveform),
+	.round_waveform_tohw = pca9685_round_waveform_tohw,
+	.round_waveform_fromhw = pca9685_round_waveform_fromhw,
+	.read_waveform = pca9685_read_waveform,
+	.write_waveform = pca9685_write_waveform,
 	.request = pca9685_pwm_request,
 	.free = pca9685_pwm_free,
 };
-- 
2.50.0


