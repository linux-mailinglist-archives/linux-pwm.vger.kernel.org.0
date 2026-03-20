Return-Path: <linux-pwm+bounces-8294-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0AHcGr4pvWkG7QIAu9opvQ
	(envelope-from <linux-pwm+bounces-8294-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:04:30 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DACDB2D941D
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 12:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 93D8A3030758
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Mar 2026 11:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8C6398905;
	Fri, 20 Mar 2026 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXoou8fk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53EB395DB5;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774004639; cv=none; b=t9wLLaR/xA3rE337lQuCG9A17qlWgAd7/ER4/L7ofjqLoXIeuBA1wYUTuhxHZPmpAvrxdgua754uZU9WvpVMQWMEhn9fPxZX/Pq1ckWdL3RtAT0iQ8/K5qdkG3r1+A2UcQZtfD0O7PwXcpPSin2uwShin+N1LVsMnLtJpHtduSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774004639; c=relaxed/simple;
	bh=EwoCFBJ5cyStyDXFYeoZWtaltfXA3XNeJLdoeTIZRBI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5gqrHBWcYaZG8j8NBnQE+EGz/LeIAZ+2I3GgySchCMe6ZfO0AcylnG9YQj0X55mvhK+Om9MqHtW7DOwFcKJFHHnU5KS+gGnz61a9KdlSTl1kbw1T9e6dL/aPG85lFNQsNy5KcuLnoJRlYivd8hZPtmhdxrdIpm8gW8cAIBt8cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXoou8fk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 96662C2BCB5;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774004639;
	bh=EwoCFBJ5cyStyDXFYeoZWtaltfXA3XNeJLdoeTIZRBI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=EXoou8fkA7iol83YT61O3sWOseOqCg1NHIRcgj15SefjqM9OA7vd77E5DNWr0SijU
	 5WtfgYePPghXNnVeCDRUaESvUSVskDhZ3Jn/2Zj9odJML/PBTYmO6GWbkJQHz+2faU
	 wtTUYmU4YWfnXByw+sENk5JEF5kYBq9HTpDtcjkY5hkkBPZIHd+9iVkdLPGk64z1b0
	 +ggNphKgopNSLz9tXIhn2bn0YsVLYGdQ9Rt91cEpSNGFJDun1dGq4t/SKSUf8a7SUF
	 F1eH0C2pm5AaVxycY7Xbnqc/R8hm6X+bMvoWtKqqex2JSjMk2fhLKMWOGubxL8YNZc
	 slCAePUS9YLog==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9E9108B8F5;
	Fri, 20 Mar 2026 11:03:59 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 20 Mar 2026 13:03:57 +0200
Subject: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
References: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
In-Reply-To: <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774004636; l=25341;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=V0ridDLzIVUpiT+dRc8jjxqO3UbSh6vnB8zfwRF82rk=;
 b=mlRqH4z1AlC7JgVKpEEfEjH9VVob+TElgMOV+JrnRvWEpMrfs3TpQCLNp0ees3DzRvqP7Bvsj
 dusr2RBADfvBXUJo9mFtkCoA3pHmXMQ55I74c7uxNOjYh+bNPMVLRpZ
X-Developer-Key: i=radu.sabau@analog.com; a=ed25519;
 pk=lDPQHgn9jTdt0vo58Na9lLxLaE2mb330if71Cn+EvFU=
X-Endpoint-Received: by B4 Relay for radu.sabau@analog.com/20260220 with
 auth_id=642
X-Original-From: Radu Sabau <radu.sabau@analog.com>
Reply-To: radu.sabau@analog.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8294-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:email,analog.com:replyto,analog.com:mid]
X-Rspamd-Queue-Id: DACDB2D941D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Radu Sabau <radu.sabau@analog.com>

Add buffered capture support using the IIO triggered buffer framework.

CNV Burst Mode: the GP pin identified by interrupt-names in the device
tree is configured as DATA_READY output. The IRQ handler stops
conversions and fires the IIO trigger; the trigger handler executes a
pre-built SPI message that reads all active channels from the AVG_IN
accumulator registers and then resets accumulator state and restarts
conversions for the next cycle.

Manual Mode: CNV is tied to SPI CS so each transfer simultaneously
reads the previous result and starts the next conversion (pipelined
N+1 scheme). At preenable time a pre-built, optimised SPI message of
N+1 transfers is constructed (N channel reads plus one NOOP to drain
the pipeline). The trigger handler executes the message in a single
spi_sync() call and collects the results. An external trigger (e.g.
iio-trig-hrtimer) is required to drive the trigger at the desired
sample rate.

Both modes share the same trigger handler and push a complete scan —
one u16 slot per channel at its scan_index position, followed by a
timestamp — to the IIO buffer via iio_push_to_buffers_with_ts().

The CNV Burst Mode sampling frequency (PWM period) is exposed as a
buffer-level attribute via IIO_DEVICE_ATTR.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 584 +++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 571 insertions(+), 15 deletions(-)

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
index 5e02eb44ca44..db776de32846 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -9,9 +9,12 @@
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
@@ -19,7 +22,12 @@
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
+#include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
+#include <linux/iio/triggered_buffer.h>
+#include <linux/iio/trigger_consumer.h>
 
 #define AD4691_VREF_uV_MIN			2400000
 #define AD4691_VREF_uV_MAX			5250000
@@ -28,6 +36,8 @@
 #define AD4691_VREF_3P3_uV_MAX			3750000
 #define AD4691_VREF_4P096_uV_MAX		4500000
 
+#define AD4691_CNV_DUTY_CYCLE_NS		380
+
 #define AD4691_SPI_CONFIG_A_REG			0x000
 #define AD4691_SW_RESET				(BIT(7) | BIT(0))
 
@@ -35,6 +45,7 @@
 #define AD4691_CLAMP_STATUS1_REG		0x01A
 #define AD4691_CLAMP_STATUS2_REG		0x01B
 #define AD4691_DEVICE_SETUP			0x020
+#define AD4691_MANUAL_MODE			BIT(2)
 #define AD4691_LDO_EN				BIT(4)
 #define AD4691_REF_CTRL				0x021
 #define AD4691_REF_CTRL_MASK			GENMASK(4, 2)
@@ -42,21 +53,29 @@
 #define AD4691_OSC_FREQ_REG			0x023
 #define AD4691_OSC_FREQ_MASK			GENMASK(3, 0)
 #define AD4691_STD_SEQ_CONFIG			0x025
+#define AD4691_SEQ_ALL_CHANNELS_OFF		0x00
 #define AD4691_SPARE_CONTROL			0x02A
 
+#define AD4691_NOOP				0x00
+#define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+
 #define AD4691_OSC_EN_REG			0x180
 #define AD4691_STATE_RESET_REG			0x181
 #define AD4691_STATE_RESET_ALL			0x01
 #define AD4691_ADC_SETUP			0x182
-#define AD4691_AUTONOMOUS_MODE_VAL		0x02
+#define AD4691_CNV_BURST_MODE			0x01
+#define AD4691_AUTONOMOUS_MODE			0x02
 /*
  * ACC_MASK_REG covers both mask bytes via ADDR_DESCENDING SPI: writing a
  * 16-bit BE value to 0x185 auto-decrements to 0x184 for the second byte.
  */
 #define AD4691_ACC_MASK_REG			0x185
 #define AD4691_ACC_COUNT_LIMIT(n)		(0x186 + (n))
+#define AD4691_ACC_COUNT_VAL			0x1
 #define AD4691_GPIO_MODE1_REG			0x196
 #define AD4691_GPIO_MODE2_REG			0x197
+#define AD4691_GP_MODE_MASK			GENMASK(3, 0)
+#define AD4691_GP_MODE_DATA_READY		0x06
 #define AD4691_GPIO_READ			0x1A0
 #define AD4691_ACC_STATUS_FULL1_REG		0x1B0
 #define AD4691_ACC_STATUS_FULL2_REG		0x1B1
@@ -121,6 +140,7 @@ static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(13),
 	AD4691_CHANNEL(14),
 	AD4691_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
@@ -132,6 +152,7 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	AD4691_CHANNEL(5),
 	AD4691_CHANNEL(6),
 	AD4691_CHANNEL(7),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 /*
@@ -189,16 +210,63 @@ static const struct ad4691_chip_info ad4694_chip_info = {
 struct ad4691_state {
 	const struct ad4691_chip_info	*info;
 	struct regmap			*regmap;
+
+	struct pwm_device		*conv_trigger;
+	struct iio_trigger		*trig;
+	int				irq;
+
+	bool				manual_mode;
+
 	int				vref_uV;
 	bool				refbuf_en;
 	bool				ldo_en;
+	u32				cnv_period_ns;
 	/*
 	 * Synchronize access to members of the driver state, and ensure
 	 * atomicity of consecutive SPI operations.
 	 */
 	struct mutex			lock;
+	/*
+	 * Per-buffer-enabl ree lifetimesources:
+	 * Manual Mode - a pre-built SPI message that clocks out N+1
+	 *		 transfers in one go.
+	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
+	 *		    transfers in one go.
+	 */
+	void				*scan_devm_group;
+	struct spi_message		scan_msg;
+	struct spi_transfer		*scan_xfers;
+	__be16				*scan_tx;
+	__be16				*scan_rx;
+	/* Scan buffer: one slot per channel (u16) plus timestamp */
+	struct {
+		u16 vals[16];
+		s64 ts __aligned(8);
+	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+/*
+ * Configure the given GP pin (0-3) as DATA_READY output.
+ * GP0/GP1 → GPIO_MODE1_REG, GP2/GP3 → GPIO_MODE2_REG.
+ * Even pins occupy bits [3:0], odd pins bits [7:4].
+ */
+static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
+{
+	unsigned int shift = 4 * (gp_num % 2);
+
+	return regmap_update_bits(st->regmap,
+				  AD4691_GPIO_MODE1_REG + gp_num / 2,
+				  AD4691_GP_MODE_MASK << shift,
+				  AD4691_GP_MODE_DATA_READY << shift);
+}
+
+static void ad4691_disable_pwm(void *data)
+{
+	struct pwm_state state = { .enabled = false };
+
+	pwm_apply_might_sleep(data, &state);
+}
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -341,14 +409,16 @@ static int ad4691_get_sampling_freq(struct ad4691_state *st, int *val)
 static int ad4691_set_sampling_freq(struct iio_dev *indio_dev, int freq)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int start = (st->info->max_rate == HZ_PER_MHZ) ? 0 : 1;
 	unsigned int i;
 
+	if (freq > st->info->max_rate)
+		return -EINVAL;
+
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	for (i = start; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
+	for (i = 0; i < ARRAY_SIZE(ad4691_osc_freqs); i++) {
 		if ((int)ad4691_osc_freqs[i] == freq)
 			return regmap_update_bits(st->regmap, AD4691_OSC_FREQ_REG,
 						  AD4691_OSC_FREQ_MASK, i);
@@ -363,7 +433,10 @@ static int ad4691_read_avail(struct iio_dev *indio_dev,
 			     int *length, long mask)
 {
 	struct ad4691_state *st = iio_priv(indio_dev);
-	unsigned int start = (st->info->max_rate == HZ_PER_MHZ) ? 0 : 1;
+	unsigned int start;
+
+	/* Skip frequencies that exceed this chip's maximum rate. */
+	start = (ad4691_osc_freqs[0] > st->info->max_rate) ? 1 : 0;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
@@ -386,8 +459,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	/*
-	 * Use AUTONOMOUS mode for single-shot reads. The chip always
-	 * operates in AUTONOMOUS mode in this driver revision.
+	 * Use AUTONOMOUS mode for single-shot reads.
 	 */
 	ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
 			   AD4691_STATE_RESET_ALL);
@@ -417,8 +489,7 @@ static int ad4691_single_shot_read(struct iio_dev *indio_dev,
 	 * conversion to complete.
 	 */
 	fsleep(DIV_ROUND_UP(2 * USEC_PER_SEC,
-			    ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK,
-						       reg_val)]));
+		ad4691_osc_freqs[FIELD_GET(AD4691_OSC_FREQ_MASK, reg_val)]));
 
 	ret = regmap_write(st->regmap, AD4691_OSC_EN_REG, 0);
 	if (ret)
@@ -488,6 +559,374 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
+static int ad4691_set_pwm_freq(struct ad4691_state *st, int freq)
+{
+	if (!freq)
+		return -EINVAL;
+
+	st->cnv_period_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
+	return 0;
+}
+
+static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
+{
+	struct pwm_state conv_state = { };
+
+	conv_state.period = st->cnv_period_ns;
+	conv_state.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS;
+	conv_state.polarity = PWM_POLARITY_NORMAL;
+	conv_state.enabled = enable;
+
+	return pwm_apply_might_sleep(st->conv_trigger, &conv_state);
+}
+
+/*
+ * ad4691_enter_conversion_mode - Switch the chip to its buffer conversion mode.
+ *
+ * Configures the ADC hardware registers for the mode selected at probe
+ * (CNV_BURST or MANUAL). Called from buffer preenable before starting
+ * sampling. The chip is in AUTONOMOUS mode during idle (for read_raw).
+ */
+static int ad4691_enter_conversion_mode(struct ad4691_state *st)
+{
+	int ret;
+
+	if (st->manual_mode)
+		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
+					  AD4691_MANUAL_MODE, AD4691_MANUAL_MODE);
+
+	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_CNV_BURST_MODE);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			    AD4691_STATE_RESET_ALL);
+}
+
+/*
+ * ad4691_exit_conversion_mode - Return the chip to AUTONOMOUS mode.
+ *
+ * Called from buffer postdisable to restore the chip to the
+ * idle state used by read_raw. Clears the sequencer and resets state.
+ */
+static int ad4691_exit_conversion_mode(struct ad4691_state *st)
+{
+	if (st->manual_mode)
+		return regmap_update_bits(st->regmap, AD4691_DEVICE_SETUP,
+					  AD4691_MANUAL_MODE, 0);
+
+	return regmap_write(st->regmap, AD4691_ADC_SETUP,
+			    AD4691_AUTONOMOUS_MODE);
+}
+
+static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);
+	unsigned int n_xfers = n_active + 1;
+	unsigned int k, i;
+	int ret;
+
+	st->scan_devm_group = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!st->scan_devm_group)
+		return -ENOMEM;
+
+	st->scan_xfers = devm_kcalloc(dev, n_xfers, sizeof(*st->scan_xfers),
+				      GFP_KERNEL);
+	st->scan_tx = devm_kcalloc(dev, n_xfers, sizeof(*st->scan_tx),
+				   GFP_KERNEL);
+	st->scan_rx = devm_kcalloc(dev, n_xfers, sizeof(*st->scan_rx),
+				   GFP_KERNEL);
+	if (!st->scan_xfers || !st->scan_tx || !st->scan_rx) {
+		devres_release_group(dev, st->scan_devm_group);
+		return -ENOMEM;
+	}
+
+	spi_message_init(&st->scan_msg);
+
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		st->scan_tx[k] = cpu_to_be16(AD4691_ADC_CHAN(i));
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[k].rx_buf = &st->scan_rx[k];
+		st->scan_xfers[k].len = sizeof(__be16);
+		st->scan_xfers[k].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+		k++;
+	}
+
+	/* Final NOOP transfer to retrieve last channel's result. */
+	st->scan_tx[k] = cpu_to_be16(AD4691_NOOP);
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+	st->scan_xfers[k].rx_buf = &st->scan_rx[k];
+	st->scan_xfers[k].len = sizeof(__be16);
+	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+
+	devres_close_group(dev, st->scan_devm_group);
+
+	st->scan_msg.spi = spi;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret) {
+		devres_release_group(dev, st->scan_devm_group);
+		return ret;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret) {
+		spi_unoptimize_message(&st->scan_msg);
+		devres_release_group(dev, st->scan_devm_group);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad4691_manual_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	devres_release_group(dev, st->scan_devm_group);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_buffer_setup_ops = {
+	.preenable = &ad4691_manual_buffer_preenable,
+	.postdisable = &ad4691_manual_buffer_postdisable,
+};
+
+static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	struct spi_device *spi = to_spi_device(dev);
+	unsigned int n_active = hweight_long(*indio_dev->active_scan_mask);
+	unsigned int bit, k, i;
+	int ret;
+
+	st->scan_devm_group = devres_open_group(dev, NULL, GFP_KERNEL);
+	if (!st->scan_devm_group)
+		return -ENOMEM;
+
+	st->scan_xfers = devm_kcalloc(dev, 2 * n_active, sizeof(*st->scan_xfers),
+				      GFP_KERNEL);
+	st->scan_tx = devm_kcalloc(dev, n_active, sizeof(*st->scan_tx),
+				   GFP_KERNEL);
+	st->scan_rx = devm_kcalloc(dev, n_active, sizeof(*st->scan_rx),
+				   GFP_KERNEL);
+	if (!st->scan_xfers || !st->scan_tx || !st->scan_rx) {
+		devres_release_group(dev, st->scan_devm_group);
+		return -ENOMEM;
+	}
+
+	spi_message_init(&st->scan_msg);
+
+	/*
+	 * Each AVG_IN read needs two transfers: a 2-byte address write phase
+	 * followed by a 2-byte data read phase. CS toggles between channels
+	 * (cs_change=1 on the read phase of all but the last channel).
+	 */
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		st->scan_tx[k] = cpu_to_be16(0x8000 | AD4691_AVG_IN(i));
+		st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[2 * k].len = sizeof(__be16);
+		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+		st->scan_xfers[2 * k + 1].rx_buf = &st->scan_rx[k];
+		st->scan_xfers[2 * k + 1].len = sizeof(__be16);
+		if (k < n_active - 1)
+			st->scan_xfers[2 * k + 1].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+		k++;
+	}
+
+	devres_close_group(dev, st->scan_devm_group);
+
+	st->scan_msg.spi = spi;
+
+	ret = spi_optimize_message(spi, &st->scan_msg);
+	if (ret) {
+		devres_release_group(dev, st->scan_devm_group);
+		return ret;
+	}
+
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG,
+			   (u16)~(*indio_dev->active_scan_mask));
+	if (ret)
+		goto err;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   *indio_dev->active_scan_mask);
+	if (ret)
+		goto err;
+
+	iio_for_each_active_channel(indio_dev, bit) {
+		ret = regmap_write(st->regmap, AD4691_ACC_COUNT_LIMIT(bit),
+				   AD4691_ACC_COUNT_VAL);
+		if (ret)
+			goto err;
+	}
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		goto err;
+
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		goto err;
+
+	enable_irq(st->irq);
+	return 0;
+err:
+	spi_unoptimize_message(&st->scan_msg);
+	devres_release_group(dev, st->scan_devm_group);
+	return ret;
+}
+
+static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	disable_irq(st->irq);
+
+	ret = ad4691_sampling_enable(st, false);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG,
+			   AD4691_SEQ_ALL_CHANNELS_OFF);
+	if (ret)
+		return ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	devres_release_group(dev, st->scan_devm_group);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
+	.preenable = &ad4691_cnv_burst_buffer_preenable,
+	.postdisable = &ad4691_cnv_burst_buffer_postdisable,
+};
+
+static ssize_t sampling_frequency_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	if (st->manual_mode)
+		return -ENODEV;
+
+	return sysfs_emit(buf, "%u\n", (u32)(NSEC_PER_SEC / st->cnv_period_ns));
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int freq, ret;
+
+	if (st->manual_mode)
+		return -ENODEV;
+
+	ret = kstrtoint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = ad4691_set_pwm_freq(st, freq);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644,
+		       sampling_frequency_show,
+		       sampling_frequency_store, 0);
+
+static const struct iio_dev_attr *ad4691_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL,
+};
+
+static irqreturn_t ad4691_irq(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	/*
+	 * GPx has asserted: stop conversions before reading so the
+	 * accumulator does not continue sampling while the trigger handler
+	 * processes the data. Then fire the IIO trigger to push the sample
+	 * to the buffer.
+	 */
+	ad4691_sampling_enable(st, false);
+	iio_trigger_poll(st->trig);
+
+	return IRQ_HANDLED;
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
+	unsigned int i, k = 0;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = spi_sync(st->scan_msg.spi, &st->scan_msg);
+	if (ret)
+		goto done;
+
+	if (st->manual_mode) {
+		iio_for_each_active_channel(indio_dev, i) {
+			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k + 1]);
+			k++;
+		}
+	} else {
+		iio_for_each_active_channel(indio_dev, i) {
+			st->scan.vals[i] = be16_to_cpu(st->scan_rx[k]);
+			k++;
+		}
+
+		ret = regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+				   AD4691_STATE_RESET_ALL);
+		if (ret)
+			goto done;
+
+		ret = ad4691_sampling_enable(st, true);
+		if (ret)
+			goto done;
+	}
+
+	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
+				    pf->timestamp);
+
+done:
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
 static const struct iio_info ad4691_info = {
 	.read_raw = &ad4691_read_raw,
 	.write_raw = &ad4691_write_raw,
@@ -495,6 +934,25 @@ static const struct iio_info ad4691_info = {
 	.debugfs_reg_access = &ad4691_reg_access,
 };
 
+static int ad4691_pwm_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int ret;
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get cnv pwm\n");
+
+	ret = devm_add_action_or_reset(dev, ad4691_disable_pwm,
+				       st->conv_trigger);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register PWM disable action\n");
+
+	return ad4691_set_pwm_freq(st, st->info->max_rate);
+}
+
 static int ad4691_regulator_setup(struct ad4691_state *st)
 {
 	struct device *dev = regmap_get_device(st->regmap);
@@ -555,12 +1013,30 @@ static int ad4691_reset(struct ad4691_state *st)
 	return 0;
 }
 
-static int ad4691_config(struct ad4691_state *st)
+static int ad4691_config(struct ad4691_state *st, u32 max_speed_hz)
 {
 	struct device *dev = regmap_get_device(st->regmap);
 	enum ad4691_ref_ctrl ref_val;
+	const char *irq_name;
+	unsigned int gp_num;
 	int ret;
 
+	/*
+	 * Determine buffer conversion mode from DT: if a PWM is provided it
+	 * drives the CNV pin (CNV_BURST_MODE); otherwise CNV is tied to CS
+	 * and each SPI transfer triggers a conversion (MANUAL_MODE).
+	 * Both modes idle in AUTONOMOUS mode so that read_raw can use the
+	 * internal oscillator without disturbing the hardware configuration.
+	 */
+	if (device_property_present(dev, "pwms")) {
+		st->manual_mode = false;
+		ret = ad4691_pwm_setup(st);
+		if (ret)
+			return ret;
+	} else {
+		st->manual_mode = true;
+	}
+
 	switch (st->vref_uV) {
 	case AD4691_VREF_uV_MIN ... AD4691_VREF_2P5_uV_MAX:
 		ref_val = AD4691_VREF_2P5;
@@ -595,17 +1071,91 @@ static int ad4691_config(struct ad4691_state *st)
 		return dev_err_probe(dev, ret, "Failed to write DEVICE_SETUP\n");
 
 	/*
-	 * Set the internal oscillator to the highest valid rate for this chip.
-	 * Index 0 (1 MHz) is valid only for AD4692/AD4694; AD4691/AD4693 start
-	 * at index 1 (500 kHz).
+	 * Set the internal oscillator to the highest rate this chip supports.
+	 * Index 0 (1 MHz) exceeds the 500 kHz max of AD4691/AD4693, so those
+	 * chips start at index 1 (500 kHz).
 	 */
 	ret = regmap_write(st->regmap, AD4691_OSC_FREQ_REG,
-			   (st->info->max_rate == HZ_PER_MHZ) ? 0 : 1);
+			   (ad4691_osc_freqs[0] > st->info->max_rate) ? 1 : 0);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to write OSC_FREQ\n");
 
 	/* Device always operates in AUTONOMOUS mode. */
-	return regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE_VAL);
+	ret = regmap_write(st->regmap, AD4691_ADC_SETUP, AD4691_AUTONOMOUS_MODE);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to write ADC_SETUp\n");
+
+	if (st->manual_mode)
+		return 0;
+
+	ret = device_property_read_string_array(dev, "interrupt-names",
+						&irq_name, 1);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "Failed to read interrupt-names\n");
+
+	if (strncmp(irq_name, "gp", 2) != 0 ||
+	    kstrtouint(irq_name + 2, 10, &gp_num) || gp_num > 3)
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid interrupt name '%s'\n", irq_name);
+
+	return ad4691_gpio_setup(st, gp_num);
+}
+
+static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
+					 struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	int irq, ret;
+
+	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
+					  indio_dev->name,
+					  iio_device_id(indio_dev));
+	if (!st->trig)
+		return -ENOMEM;
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
+	if (!st->manual_mode) {
+		/*
+		 * GP0 asserts at end-of-conversion. The IRQ handler stops
+		 * conversions and fires the IIO trigger so the trigger handler
+		 * can read and push the sample to the buffer. The IRQ is kept
+		 * disabled until the buffer is enabled.
+		 */
+		irq = fwnode_irq_get(dev_fwnode(dev), 0);
+		if (irq < 0)
+			return dev_err_probe(dev, irq,
+					     "failed to get GP interrupt\n");
+
+		st->irq = irq;
+
+		ret = devm_request_threaded_irq(dev, irq, NULL,
+						&ad4691_irq,
+						IRQF_ONESHOT | IRQF_NO_AUTOEN,
+						indio_dev->name, indio_dev);
+		if (ret)
+			return ret;
+
+		return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+							   &iio_pollfunc_store_time,
+							   &ad4691_trigger_handler,
+							   IIO_BUFFER_DIRECTION_IN,
+							   &ad4691_cnv_burst_buffer_setup_ops,
+							   ad4691_buffer_attrs);
+	}
+
+	return devm_iio_triggered_buffer_setup(dev, indio_dev,
+					       &iio_pollfunc_store_time,
+					       &ad4691_trigger_handler,
+					       &ad4691_manual_buffer_setup_ops);
 }
 
 static int ad4691_probe(struct spi_device *spi)
@@ -639,7 +1189,7 @@ static int ad4691_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad4691_config(st);
+	ret = ad4691_config(st, spi->max_speed_hz);
 	if (ret)
 		return ret;
 
@@ -650,6 +1200,10 @@ static int ad4691_probe(struct spi_device *spi)
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
 
+	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (ret)
+		return ret;
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0



