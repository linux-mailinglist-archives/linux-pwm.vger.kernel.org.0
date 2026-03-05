Return-Path: <linux-pwm+bounces-8189-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMJXGs51qWl77wAAu9opvQ
	(envelope-from <linux-pwm+bounces-8189-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:23:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EB82118E4
	for <lists+linux-pwm@lfdr.de>; Thu, 05 Mar 2026 13:23:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 641B030172E4
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Mar 2026 12:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197EE39E199;
	Thu,  5 Mar 2026 12:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvdAk9US"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBC39C65B;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772713415; cv=none; b=XED6/T2LM+3T6N8QQNK55t9fgGTA5xpT70dueEe4EuAGJ/wvs36gdwhwtJmiOdgdkWvkJkQVVgnuo2tHNhaYsISvY6xO40+gXs0IRhX+vwOvmp3ICIoliMPUbrf3iBkTQfvIJb5XOlUD9isnLiUwgAwSJy7th0ZLjGy9PH5j3i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772713415; c=relaxed/simple;
	bh=ToV/Hpupn/875tGIVeR2aJoXP72Fruda01TvefbQ94w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDI9OftZsek9o8ZmngXzy6TtTqx7/SvHQEQX7rzTElDJe3HYoBXThnrHuGfMOLY2ktTOqf0Hwz/pWuXHCS+1VcUOXBKgdTdJ0rpaqm9/q1s+QVRBHWJKmyYzdT2sFxz8kDK+QzNsUicUJQViDWb7bih5bJfvWRj5iaBqi0Q/u58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvdAk9US; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70EDEC2BCB2;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772713415;
	bh=ToV/Hpupn/875tGIVeR2aJoXP72Fruda01TvefbQ94w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=QvdAk9USDxxhhj0r+hCo5JcjC+PARN2duf0LnNe46w7wsdMTbs9Zp1YbU1AZx5+Yu
	 xITLNTNTvYM01Zb/xu6zb8PLY8PjtberuENwU+sYSVBaSoIMSKWKuy1PmDMu5+MMA0
	 iLmBbZuJ1k3ASpQHYM9SyLoyNDIrxUspyzVkjAAmvfmWaw3GB6/NGRg7dWZL/QgnNq
	 2VoqVntKvrE/QRHplY70UIkHrFpHr/eyd8MQjD1xKxIgxjTvL0PDXahUfj24IiOUfG
	 VCP1oNI90yvOWqUbHLGR5G/bNrKbyQaJ3neUw8LddDkEomYRZfHttVl4iW0DvOfbBA
	 okesqtZss0mgA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 620D9F30959;
	Thu,  5 Mar 2026 12:23:35 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Thu, 05 Mar 2026 14:23:29 +0200
Subject: [PATCH 3/4] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260305-ad4692-multichannel-sar-adc-driver-v1-3-336229a8dcc7@analog.com>
References: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
In-Reply-To: <20260305-ad4692-multichannel-sar-adc-driver-v1-0-336229a8dcc7@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772713413; l=12862;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=ljLdjl7LKh8bWVM9PqQW0wndeElVvojPks9hWMLcmBg=;
 b=oFwWvou/67Hi/3HgCN2YTbMr8UyIeJdiG39EcCty4hSiHVEV28SgiavIXMzglfipeNw1DXbEZ
 CvBuKgoMDSAAiDzjcEtmq2kV28XJ4cqkUh56QyhT9CKZXz3dVpAqwFd
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Rspamd-Queue-Id: 50EB82118E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8189-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Radu Sabau <radu.sabau@analog.com>

Add buffered capture support using the IIO triggered buffer framework.

For CNV Clock, CNV Burst, Autonomous and SPI Burst modes the GP0 pin
is configured as DATA_READY output and an interrupt is registered on
its falling edge. Each interrupt fires the trigger, which reads
accumulated results from the internal accumulator registers via regmap.

For Manual Mode (pipelined SPI protocol) there is no DATA_READY
signal, so an hrtimer-based IIO trigger is used instead. The timer
period is derived from the requested sampling frequency and validated
against the minimum SPI transfer time for the active channel count.
The trigger handler walks the active scan mask issuing one 3-byte SPI
transfer per channel (selecting the next channel while reading the
previous result) and pushes samples to the IIO buffer.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 316 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 318 insertions(+)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3685a03aa8dc..d498f16c0816 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -142,6 +142,8 @@ config AD4170_4
 config AD4691
 	tristate "Analog Devices AD4691 Family ADC Driver"
 	depends on SPI
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index dee8bc312d44..ab48f336e46c 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -10,6 +10,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/math.h>
@@ -24,8 +25,13 @@
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
+
 #include <dt-bindings/iio/adc/adi,ad4691.h>
 
 #define AD4691_NUM_REGULATORS			1
@@ -42,6 +48,7 @@
  *        = spi_hz / (36 * (num_channels + 1))
  */
 #define AD4691_MANUAL_MODE_STD_FREQ(x, y)	((y) / (36 * ((x) + 1)))
+#define AD4691_BITS_PER_XFER			24
 #define AD4691_CNV_DUTY_CYCLE_NS		380
 #define AD4691_MAX_CONV_PERIOD_US		800
 
@@ -287,6 +294,8 @@ struct ad4691_state {
 
 	struct regulator_bulk_data	regulators[AD4691_NUM_REGULATORS];
 
+	struct iio_trigger		*trig;
+
 	enum ad4691_adc_mode		adc_mode;
 
 	int				vref;
@@ -297,6 +306,8 @@ struct ad4691_state {
 	 */
 	struct mutex			lock;
 
+	/* hrtimer for MANUAL_MODE triggered buffer (non-offload) */
+	struct hrtimer			sampling_timer;
 	ktime_t				sampling_period;
 
 	/* DMA (thus cache coherency maintenance) may require the
@@ -306,6 +317,11 @@ struct ad4691_state {
 	 */
 	unsigned char rx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
 	unsigned char tx_data[ALIGN(3, sizeof(s64)) + sizeof(s64)]	__aligned(IIO_DMA_MINALIGN);
+	/* Scan buffer for triggered buffer push (one sample + timestamp) */
+	struct {
+		u32 val;
+		s64 ts __aligned(8);
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
 static void ad4691_disable_regulators(void *data)
@@ -949,6 +965,233 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return ret;
 }
 
+static int ad4691_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int n_active = hweight_long(*indio_dev->active_scan_mask);
+	int ret;
+
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		u64 min_period_ns;
+
+		/* N+1 transfers needed for N channels, with 50% overhead */
+		min_period_ns = div64_u64((u64)(n_active + 1) * AD4691_BITS_PER_XFER *
+					  NSEC_PER_SEC * 3,
+					  st->spi->max_speed_hz * 2);
+
+		if (ktime_to_ns(st->sampling_period) < min_period_ns) {
+			dev_err(&st->spi->dev,
+				"Sampling period %lld ns too short for %d channels. Min: %llu ns\n",
+				ktime_to_ns(st->sampling_period), n_active,
+				min_period_ns);
+			return -EINVAL;
+		}
+
+		hrtimer_start(&st->sampling_timer, st->sampling_period,
+			      HRTIMER_MODE_REL);
+		return 0;
+	}
+
+	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			   AD4691_STATE_RESET_ALL);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK1_REG,
+				 ~(*indio_dev->active_scan_mask) & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK2_REG,
+				 ~(*indio_dev->active_scan_mask >> 8) & 0xFF);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+				*indio_dev->active_scan_mask);
+	if (ret)
+		return ret;
+
+	if (st->adc_mode == AD4691_AUTONOMOUS_MODE)
+		ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_ADC_BUSY);
+	else
+		ret = regmap_write(st->regmap, AD4691_GPIO_MODE1_REG, AD4691_DATA_READY);
+	if (ret)
+		return ret;
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_BURST_MODE:
+		/*
+		 * Recompute the PWM period now that the active channel count is
+		 * known. The period must cover one full burst cycle: oscillator
+		 * conversion time (tOSC * (n+1)) plus all SPI transfer time.
+		 */
+		st->cnv_period = ad4691_cnv_burst_period_ns(st, n_active, false);
+		fallthrough;
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+	case AD4691_CNV_CLOCK_MODE:
+		return ad4691_sampling_enable(st, true);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int ad4691_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (st->adc_mode) {
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_CNV_CLOCK_MODE:
+		ret = ad4691_sampling_enable(st, false);
+		if (ret)
+			return ret;
+		break;
+	case AD4691_MANUAL_MODE:
+		hrtimer_cancel_wait_running(&st->sampling_timer);
+		return 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   AD4691_SEQ_ALL_CHANNELS_OFF);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			    AD4691_STATE_RESET_ALL);
+}
+
+static const struct iio_buffer_setup_ops ad4691_buffer_setup_ops = {
+	.postenable = &ad4691_buffer_postenable,
+	.postdisable = &ad4691_buffer_postdisable,
+};
+
+static irqreturn_t ad4691_irq(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	/*
+	 * DATA_READY has asserted: stop conversions before reading so the
+	 * accumulator does not continue sampling while the trigger handler
+	 * processes the data. Then fire the IIO trigger to push the sample
+	 * to the buffer.
+	 *
+	 * In direct (read_raw) mode the buffer is not enabled; read_raw uses
+	 * a timed delay and stops conversions itself, so skip the trigger poll.
+	 */
+	ad4691_sampling_enable(st, false);
+
+	if (iio_buffer_enabled(indio_dev))
+		iio_trigger_poll(st->trig);
+
+	return IRQ_HANDLED;
+}
+
+static enum hrtimer_restart ad4691_sampling_timer_handler(struct hrtimer *timer)
+{
+	struct ad4691_state *st = container_of(timer, struct ad4691_state,
+					       sampling_timer);
+
+	iio_trigger_poll(st->trig);
+	hrtimer_forward_now(timer, st->sampling_period);
+
+	return HRTIMER_RESTART;
+}
+
+static const struct iio_trigger_ops ad4691_trigger_ops = {
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static irqreturn_t ad4691_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret, i;
+
+	mutex_lock(&st->lock);
+
+	if (st->adc_mode == AD4691_MANUAL_MODE) {
+		unsigned int prev_val;
+		int prev_chan = -1;
+
+		/*
+		 * MANUAL_MODE with CNV tied to CS: each transfer triggers a
+		 * conversion AND returns the previous conversion's result.
+		 * First transfer returns garbage, so we do N+1 transfers for
+		 * N channels.
+		 */
+		iio_for_each_active_channel(indio_dev, i) {
+			ret = ad4691_transfer(st, AD4691_ADC_CHAN(i), &val);
+			if (ret)
+				goto done;
+
+			/* Push previous channel's data (skip first - garbage) */
+			if (prev_chan >= 0) {
+				st->scan.val = prev_val;
+				iio_push_to_buffers_with_ts(indio_dev,
+					&st->scan, sizeof(st->scan),
+					iio_get_time_ns(indio_dev));
+			}
+			prev_val = val;
+			prev_chan = i;
+		}
+
+		/* Final NOOP transfer to get last channel's data */
+		ret = ad4691_transfer(st, AD4691_NOOP, &val);
+		if (ret)
+			goto done;
+
+		st->scan.val = val;
+		iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+					    iio_get_time_ns(indio_dev));
+		goto done;
+	}
+
+	for (i = 0; i < st->chip->num_channels; i++) {
+		if (BIT(i) & *indio_dev->active_scan_mask) {
+			ret = regmap_read(st->regmap, AD4691_AVG_IN(i), &val);
+			if (ret)
+				goto done;
+
+			st->scan.val = val;
+			iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+						    iio_get_time_ns(indio_dev));
+		}
+	}
+
+	regmap_write(st->regmap, AD4691_STATE_RESET_REG, AD4691_STATE_RESET_ALL);
+
+	/* START next conversion. */
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		ad4691_sampling_enable(st, true);
+		break;
+	case AD4691_MANUAL_MODE:
+	default:
+		break;
+	}
+
+	iio_trigger_notify_done(indio_dev->trig);
+	mutex_unlock(&st->lock);
+	return IRQ_HANDLED;
+done:
+	mutex_unlock(&st->lock);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad4691_info = {
 	.read_raw = &ad4691_read_raw,
 	.read_avail = &ad4691_read_avail,
@@ -1121,6 +1364,75 @@ static void ad4691_setup_channels(struct iio_dev *indio_dev,
 	indio_dev->num_channels = st->chip->num_channels;
 }
 
+static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
+					 struct ad4691_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int irq, ret;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					  indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return dev_err_probe(dev, -ENOMEM,
+				     "Failed to allocate IIO trigger\n");
+
+	st->trig->ops = &ad4691_trigger_ops;
+	iio_trigger_set_drvdata(st->trig, st);
+
+	ret = devm_iio_trigger_register(dev, st->trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
+
+	indio_dev->trig = iio_trigger_get(st->trig);
+
+	switch (st->adc_mode) {
+	case AD4691_CNV_CLOCK_MODE:
+	case AD4691_CNV_BURST_MODE:
+	case AD4691_AUTONOMOUS_MODE:
+	case AD4691_SPI_BURST_MODE:
+		/*
+		 * DATA_READY asserts at end-of-conversion (or when the
+		 * accumulator fills in AUTONOMOUS_MODE). The IRQ handler stops
+		 * conversions and fires the IIO trigger so the trigger handler
+		 * can read and push the sample to the buffer.
+		 */
+		irq = fwnode_irq_get_byname(dev_fwnode(dev), "DRDY");
+		if (irq <= 0)
+			return dev_err_probe(dev, irq ? irq : -ENOENT,
+					     "failed to get DRDY interrupt\n");
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&ad4691_irq,
+						IRQF_ONESHOT | IRQF_TRIGGER_FALLING,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "request irq %d failed\n", irq);
+		break;
+	case AD4691_MANUAL_MODE:
+		/*
+		 * No DATA_READY signal in MANUAL_MODE; CNV is tied to CS so
+		 * conversions start with each SPI transfer. Use an hrtimer to
+		 * schedule periodic reads.
+		 */
+		hrtimer_setup(&st->sampling_timer, ad4691_sampling_timer_handler,
+			      CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		st->sampling_period = ns_to_ktime(DIV_ROUND_CLOSEST_ULL(
+			NSEC_PER_SEC,
+			AD4691_MANUAL_MODE_STD_FREQ(st->chip->num_channels,
+						    st->spi->max_speed_hz)));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return devm_iio_triggered_buffer_setup(dev, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ad4691_trigger_handler,
+					       &ad4691_buffer_setup_ops);
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1169,6 +1481,10 @@ static int ad4691_probe(struct spi_device *spi)
 
 	ad4691_setup_channels(indio_dev, st);
 
+	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0



