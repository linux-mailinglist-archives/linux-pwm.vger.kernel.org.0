Return-Path: <linux-pwm+bounces-3650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F699EE58
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 15:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2891C20E75
	for <lists+linux-pwm@lfdr.de>; Tue, 15 Oct 2024 13:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358E71AF0CD;
	Tue, 15 Oct 2024 13:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Pcxor0aQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0D61B2192
	for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729000601; cv=none; b=u/nI8Dfk96x9FQ24oqSyv91LFWBghR3dVM5pRbX4B16sk2RlsH6TdkwzKjK5Sjz/sltEyReag8Ub//Nb/hqS70/skivr7JSqr0/bLAgTmQp4DVgX8+UxLBGUm76fZ2IyU6NVISVqGyaoF19mEevQiNlwpiXVwdweN1Sxc0znm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729000601; c=relaxed/simple;
	bh=bd+nWTyfJcwbii4A58CUizm8w3dMDkWk2+CdLjB+yGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u3b/tUmtxrDcD/grPb1JtQC5tNtTUXpunn6mTkhZFeMa6YFJ+6s65XJyGZ6Er0qO9vxEUKW1Y+AMejMFBToDgNsywGxvNMPh5eKWsEfVk17f1PcEQ62XbduxFU+cC4EjClarWB+z7D5E3QUVbdJHbA0STQ4qU07gW26z/t5Ilq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Pcxor0aQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so34866155e9.1
        for <linux-pwm@vger.kernel.org>; Tue, 15 Oct 2024 06:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729000596; x=1729605396; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KKS7B10FNwBsSHhexRWQdA1j1LuMEJVL7bASAbjk2ME=;
        b=Pcxor0aQVY5bPpHsZ1ObIx7AweYHoaeG+FpF94lg3JBo5ax6nYZNBeShkSlA1I3mCl
         6O533/dimHCYRlw7jYBHHnsqwLQ4UO13vIMPPerXMDhfxJlg6FkPnLfYRGmmC15QKfox
         qxY9DEjhrIOy9FPevprZjvkG+Lu/upv/ne0JRwkcvkiN4NwVKdrsGi1c+Lr1uSA/2KyF
         IDl3k6AylZxPZtwiVXaiGHPvNyUy0SZ5NIIeKstbhdw65DCvwZXNLSALm4lgOg/0MmBe
         aN73+Pq4odSwtZmeYCvK4BHTC1nHVXvyEGu74HVbia0PanaX7pDD1UCbD2RAjqFdyssn
         AQmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729000596; x=1729605396;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KKS7B10FNwBsSHhexRWQdA1j1LuMEJVL7bASAbjk2ME=;
        b=FtTkmj9wYbI7GZgxMOa/YR3UOlkHUOJBb7ggsJwTb7NVYz/WraYC/xrL+K7R/ljWyX
         yffSCSD26XkEIjS8RSQ5SAQXicyCgx1jZKPPLL6b/lDv/q4Qdtp8GpZ5fZjlYebtEgkA
         mWXF4nFMu1ShfoxfD1qgV6teTSLwcj4P+kcSWmZ2mlNxZQf/HAxV3hUWPvPT87P66O0c
         Pd6S6v9MHdHy9N9V4fvec78Pgi53Ckw4rJYVg2kAH1DtDgSNhDW0hCwfnej+MMnB1aPr
         PsHlORgY9vnWko32PmCOa+unLKm7lmf29Usg01qCzIsZ+Bxc0VuLYDw49yY61r9reyoD
         IAJQ==
X-Gm-Message-State: AOJu0YyO1odq9dw9O+N1VD0MrWlOEP2mI/KmoWCyA/jzg/oJfRcF1H7T
	/Fv/gNxCHRnVP2hxgYkw49k9XfASyq/+DCJDSpfToVmZK779Om9TIBKCFj8ZYEc=
X-Google-Smtp-Source: AGHT+IEBRPWh4WaHUL1fzOUqJq2sNAoGnCnbVu5ytpPYpIo+QrCHM8Zr1G2TyYRjysHdnE9r7I7YNQ==
X-Received: by 2002:a5d:5103:0:b0:37d:5251:e5ad with SMTP id ffacd0b85a97d-37d862663f8mr589851f8f.2.1729000596040;
        Tue, 15 Oct 2024 06:56:36 -0700 (PDT)
Received: from [127.0.1.1] (frhb82016ds.ikexpress.com. [185.246.87.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4313f56f241sm18848295e9.22.2024.10.15.06.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 06:56:35 -0700 (PDT)
From: Guillaume Stols <gstols@baylibre.com>
Date: Tue, 15 Oct 2024 13:56:17 +0000
Subject: [PATCH v5 4/8] iio: adc: ad7606: Add PWM support for conversion
 trigger
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241015-ad7606_add_iio_backend_support-v5-4-654faf1ae08c@baylibre.com>
References: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
In-Reply-To: <20241015-ad7606_add_iio_backend_support-v5-0-654faf1ae08c@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Hennerich <michael.hennerich@analog.com>, 
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, 
 aardelean@baylibre.com, dlechner@baylibre.com, jstephan@baylibre.com, 
 nuno.sa@analog.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Guillaume Stols <gstols@baylibre.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729000592; l=8616;
 i=gstols@baylibre.com; s=20240417; h=from:subject:message-id;
 bh=bd+nWTyfJcwbii4A58CUizm8w3dMDkWk2+CdLjB+yGU=;
 b=PvXMUBVdGsZy045vMiACl3bL1rju7K2bDU3f4FQ2Q9dsFs5BGOOOeQHqRJKxDvnWZyacO3udq
 WDfbrDfJoMzC/TbjvV3Z7evxYSlx+PVwOj/nRfHiAiBazkg6aZtlfM0
X-Developer-Key: i=gstols@baylibre.com; a=ed25519;
 pk=XvMm5WHuV67sGYOJZqIYzXndbaJOlNd8Q6li6vnb4Cs=

Until now, the conversion were triggered by setting high the GPIO
connected to the convst pin. This commit gives the possibility to
connect the convst pin to a PWM.
Connecting a PWM allows to have a better control on the samplerate,
but it must be handled with care, as it is completely decorrelated of
the driver's busy pin handling.
Hence it is not recommended to be used "as is" but must be exploited
in conjunction with IIO backend, and for now only a mock functionality
is enabled, i.e PWM never swings, but is used as a GPIO, i.e duty_cycle
== period equals high state, duty_cycle == 0 equals low state.

This mock functionality will be disabled after the IIO backend usecase
is introduced.

Signed-off-by: Guillaume Stols <gstols@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 147 ++++++++++++++++++++++++++++++++++++++++++++---
 drivers/iio/adc/ad7606.h |   2 +
 2 files changed, 142 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 71362eafe838..dd4e0c6fce3e 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -13,10 +13,12 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regulator/consumer.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/units.h>
 #include <linux/util_macros.h>
 
 #include <linux/iio/buffer.h>
@@ -299,6 +301,73 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad7606_pwm_set_high(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+	int ret;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+
+	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+	/* sleep 2 µS to let finish the current pulse */
+	fsleep(2);
+
+	return ret;
+}
+
+static int ad7606_pwm_set_low(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+	int ret;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	cnvst_pwm_state.enabled = true;
+	cnvst_pwm_state.duty_cycle = 0;
+
+	ret = pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+	/* sleep 2 µS to let finish the current pulse */
+	fsleep(2);
+
+	return ret;
+}
+
+static bool ad7606_pwm_is_swinging(struct ad7606_state *st)
+{
+	struct pwm_state cnvst_pwm_state;
+
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+
+	return cnvst_pwm_state.duty_cycle != cnvst_pwm_state.period &&
+	       cnvst_pwm_state.duty_cycle != 0;
+}
+
+static int ad7606_set_sampling_freq(struct ad7606_state *st, unsigned long freq)
+{
+	struct pwm_state cnvst_pwm_state;
+	bool is_swinging = ad7606_pwm_is_swinging(st);
+	bool is_high;
+
+	if (freq == 0)
+		return -EINVAL;
+
+	/* Retrieve the previous state. */
+	pwm_get_state(st->cnvst_pwm, &cnvst_pwm_state);
+	is_high = cnvst_pwm_state.duty_cycle == cnvst_pwm_state.period;
+
+	cnvst_pwm_state.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	cnvst_pwm_state.polarity = PWM_POLARITY_NORMAL;
+	if (is_high)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period;
+	else if (is_swinging)
+		cnvst_pwm_state.duty_cycle = cnvst_pwm_state.period / 2;
+	else
+		cnvst_pwm_state.duty_cycle = 0;
+
+	return pwm_apply_might_sleep(st->cnvst_pwm, &cnvst_pwm_state);
+}
+
 static int ad7606_read_samples(struct ad7606_state *st)
 {
 	unsigned int num = st->chip_info->num_channels - 1;
@@ -324,7 +393,13 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
 error_ret:
 	iio_trigger_notify_done(indio_dev->trig);
 	/* The rising edge of the CONVST signal starts a new conversion. */
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst) {
+		gpiod_set_value(st->gpio_convst, 1);
+	} else {
+		ret = ad7606_pwm_set_high(st)
+		if (ret < 0)
+			dev_err(st->dev, "Could not set PWM to high.");
+	}
 
 	return IRQ_HANDLED;
 }
@@ -337,7 +412,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	const struct iio_chan_spec *chan;
 	int ret;
 
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst) {
+		gpiod_set_value(st->gpio_convst, 1);
+	} else {
+		ret = ad7606_pwm_set_high(st);
+		if (ret < 0)
+			return ret;
+	}
 	ret = wait_for_completion_timeout(&st->completion,
 					  msecs_to_jiffies(1000));
 	if (!ret) {
@@ -363,6 +444,11 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
 	}
 
 error_ret:
+	if (!st->gpio_convst) {
+		ret = ad7606_pwm_set_low(st);
+		if (ret < 0)
+			return ret;
+	}
 	gpiod_set_value(st->gpio_convst, 0);
 
 	return ret;
@@ -662,8 +748,9 @@ static int ad7606_request_gpios(struct ad7606_state *st)
 {
 	struct device *dev = st->dev;
 
-	st->gpio_convst = devm_gpiod_get(dev, "adi,conversion-start",
-					 GPIOD_OUT_LOW);
+	st->gpio_convst = devm_gpiod_get_optional(dev, "adi,conversion-start",
+						  GPIOD_OUT_LOW);
+
 	if (IS_ERR(st->gpio_convst))
 		return PTR_ERR(st->gpio_convst);
 
@@ -705,14 +792,24 @@ static irqreturn_t ad7606_interrupt(int irq, void *dev_id)
 {
 	struct iio_dev *indio_dev = dev_id;
 	struct ad7606_state *st = iio_priv(indio_dev);
+	int ret;
 
 	if (iio_buffer_enabled(indio_dev)) {
-		gpiod_set_value(st->gpio_convst, 0);
+		if (st->gpio_convst) {
+			gpiod_set_value(st->gpio_convst, 0);
+		} else {
+			ret = ad7606_pwm_set_low(st);
+			if (ret < 0) {
+				dev_err(st->dev, "PWM set low failed");
+				goto done;
+			}
+		}
 		iio_trigger_poll_nested(st->trig);
 	} else {
 		complete(&st->completion);
 	}
 
+done:
 	return IRQ_HANDLED;
 };
 
@@ -731,7 +828,10 @@ static int ad7606_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	gpiod_set_value(st->gpio_convst, 1);
+	if (st->gpio_convst)
+		gpiod_set_value(st->gpio_convst, 1);
+	else
+		return ad7606_pwm_set_high(st);
 
 	return 0;
 }
@@ -740,7 +840,10 @@ static int ad7606_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct ad7606_state *st = iio_priv(indio_dev);
 
-	gpiod_set_value(st->gpio_convst, 0);
+	if (st->gpio_convst)
+		gpiod_set_value(st->gpio_convst, 0);
+	else
+		return ad7606_pwm_set_low(st);
 
 	return 0;
 }
@@ -874,6 +977,11 @@ static int ad7606_chan_scales_setup(struct iio_dev *indio_dev)
 	return 0;
 }
 
+static void ad7606_pwm_disable(void *data)
+{
+	pwm_disable(data);
+}
+
 int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		 const char *name, unsigned int id,
 		 const struct ad7606_bus_ops *bops)
@@ -950,6 +1058,31 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 	if (ret)
 		return ret;
 
+	/* If convst pin is not defined, setup PWM. */
+	if (!st->gpio_convst) {
+		st->cnvst_pwm = devm_pwm_get(dev, NULL);
+		if (IS_ERR(st->cnvst_pwm))
+			return PTR_ERR(st->cnvst_pwm);
+
+		/* The PWM is initialized at 1MHz to have a fast enough GPIO emulation. */
+		ret = ad7606_set_sampling_freq(st, 1 * MEGA);
+		if (ret)
+			return ret;
+
+		ret = ad7606_pwm_set_low(st);
+		if (ret)
+			return ret;
+
+		/*
+		 * PWM is not disabled when sampling stops, but instead its duty cycle is set
+		 * to 0% to be sure we have a "low" state. After we unload the driver, let's
+		 * disable the PWM.
+		 */
+		ret = devm_add_action_or_reset(dev, ad7606_pwm_disable,
+					       st->cnvst_pwm);
+		if (ret)
+			return ret;
+	}
 	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
 					  indio_dev->name,
 					  iio_device_id(indio_dev));
diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
index fc05a4afa3b8..760cf5e2ecb6 100644
--- a/drivers/iio/adc/ad7606.h
+++ b/drivers/iio/adc/ad7606.h
@@ -115,6 +115,7 @@ struct ad7606_chan_scale {
  * @bops		bus operations (SPI or parallel)
  * @chan_scales		scale configuration for channels
  * @oversampling	oversampling selection
+ * @cnvst_pwm		pointer to the PWM device connected to the cnvst pin
  * @base_address	address from where to read data in parallel operation
  * @sw_mode_en		software mode enabled
  * @oversampling_avail	pointer to the array which stores the available
@@ -142,6 +143,7 @@ struct ad7606_state {
 	const struct ad7606_bus_ops	*bops;
 	struct ad7606_chan_scale	chan_scales[AD760X_MAX_CHANNELS];
 	unsigned int			oversampling;
+	struct pwm_device		*cnvst_pwm;
 	void __iomem			*base_address;
 	bool				sw_mode_en;
 	const unsigned int		*oversampling_avail;

-- 
2.34.1


