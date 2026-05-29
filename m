Return-Path: <linux-pwm+bounces-9204-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFvJN1tnGWpKwQgAu9opvQ
	(envelope-from <linux-pwm+bounces-9204-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:15:55 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C82B6009E8
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 12:15:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EFE23018742
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9093C73EC;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU5iM0i6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CB3BD64C;
	Fri, 29 May 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049704; cv=none; b=XvmfWA6aUCCk4JKje+pNqX8wdzUlLB8aXTquzJyG+QYESrr3mLurJcgPbjqrM09prMD5RIkqCx/MaWIZ2edkVwmCtzSlAahZOZbrw/4y6LIlaNMDx03N0XikSAEq8cLYymUll00rb5izprxStA4+388+BNKR4go58Cs8QnQe9IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049704; c=relaxed/simple;
	bh=3mr94U3Kc7j+0VCeTGsX8smi60IbPeSEJI36LzGuw8E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NpCiL+L8t0u41jnXJCNwastpLWkvRvz30rmdTf3w3YpP9rxRlQ6I/7s49n9mBDuQ6kv2pRM8WCYbtIt2jf1h37kpZxBScsfHyt5IA15ZxvDguz1RmPoY6R9AsONAzRr4p8q+n5kC07VuoPkzOa/u3PN4Ug7na9TchCjK75rPs9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU5iM0i6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6F44C2BCFF;
	Fri, 29 May 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780049703;
	bh=3mr94U3Kc7j+0VCeTGsX8smi60IbPeSEJI36LzGuw8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jU5iM0i6xOprRLLur5PncGva+0P5elZ2zHFffLy9JdaVPmZWQQ6E5NrMQLHrHiTiY
	 xVa+GzLAsw8Mdm3tQwuUqFBVVkmqajgJD4N5DuuHM1kmob9/iZitWKXXJU+TGykzdw
	 lYUPwagPpODYPE4zRVLNBeqAK78pmSVBIvkQaOddQrSAdaLLr1LHJi2lpSq0xRMy9t
	 iNRQlRBgvB55lodk+mXoPghFsJBWQ9UrhODNAMMzrPG3JC3umC8LOincTxssVp7vKb
	 MX4U7PV+IuR1AbVwXxqt0wNghhvopVTelDRHUxcKdbvgEWxtIkfuVgTwnI1bjVIztG
	 rh4gICQ2aLZoQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE73CD6E43;
	Fri, 29 May 2026 10:15:03 +0000 (UTC)
From: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Date: Fri, 29 May 2026 13:15:02 +0300
Subject: [PATCH v14 3/6] iio: adc: ad4691: add triggered buffer support
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-ad4692-multichannel-sar-adc-driver-v14-3-e93c2747dc1f@analog.com>
References: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
In-Reply-To: <20260529-ad4692-multichannel-sar-adc-driver-v14-0-e93c2747dc1f@analog.com>
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
 Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
 Radu Sabau <radu.sabau@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780049701; l=24059;
 i=radu.sabau@analog.com; s=20260220; h=from:subject:message-id;
 bh=4tSedZ7qTXPsiMa5CaEyyx4MW56Yj5PLKDnrxbWJY3A=;
 b=0lFMTkdTKbQz/x+9mtdQgtcc8B6lf0qV3f97RjGDosa49PO2bwiR+xhnPfghql4mlcGjIg3qw
 kwF9J95si82C7JiT7xb/OPhpjIMTMtF/8BWjt3ObHD1FETyzFjtwBRy
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9204-lists,linux-pwm=lfdr.de,radu.sabau.analog.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[metafoo.de,analog.com,kernel.org,baylibre.com,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,linux-pwm@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	HAS_REPLYTO(0.00)[radu.sabau@analog.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:replyto,analog.com:mid,analog.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C82B6009E8
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
one big-endian 16-bit (__be16) slot per active channel, densely packed
in scan_index order, followed by a timestamp.

The CNV Burst Mode sampling frequency (PWM period) is exposed as a
buffer-level attribute via IIO_DEVICE_ATTR.

Signed-off-by: Radu Sabau <radu.sabau@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +
 drivers/iio/adc/ad4691.c | 574 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 572 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index c9aca0d08e41..1d7afde108c0 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -148,6 +148,8 @@ config AD4691
 	tristate "Analog Devices AD4691 Family ADC Driver"
 	depends on SPI
 	depends on REGULATOR || COMPILE_TEST
+	select IIO_BUFFER
+	select IIO_TRIGGERED_BUFFER
 	select REGMAP
 	help
 	  Say yes here to build support for Analog Devices AD4691 Family MuxSAR
diff --git a/drivers/iio/adc/ad4691.c b/drivers/iio/adc/ad4691.c
index e1febf80f21d..175c80129786 100644
--- a/drivers/iio/adc/ad4691.c
+++ b/drivers/iio/adc/ad4691.c
@@ -11,19 +11,29 @@
 #include <linux/dev_printk.h>
 #include <linux/device/devres.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/kstrtox.h>
 #include <linux/limits.h>
 #include <linux/math.h>
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
+#include <linux/string.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
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
@@ -57,6 +67,7 @@
 
 #define AD4691_NOOP				0x00
 #define AD4691_ADC_CHAN(ch)			((0x10 + (ch)) << 3)
+#define AD4691_EXIT_COMMAND			0x5000
 
 #define AD4691_OSC_EN_REG			0x180
 #define AD4691_STATE_RESET_REG			0x181
@@ -120,8 +131,12 @@ struct ad4691_chip_info {
 		.info_mask_shared_by_all_available =			\
 				      BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 		.channel = ch,						\
+		.scan_index = ch,					\
 		.scan_type = {						\
+			.format = 'u',					\
 			.realbits = 16,					\
+			.storagebits = 16,				\
+			.endianness = IIO_BE,				\
 		},							\
 	}
 
@@ -142,6 +157,7 @@ static const struct iio_chan_spec ad4691_channels[] = {
 	AD4691_CHANNEL(13),
 	AD4691_CHANNEL(14),
 	AD4691_CHANNEL(15),
+	IIO_CHAN_SOFT_TIMESTAMP(16),
 };
 
 static const struct iio_chan_spec ad4693_channels[] = {
@@ -153,6 +169,7 @@ static const struct iio_chan_spec ad4693_channels[] = {
 	AD4691_CHANNEL(5),
 	AD4691_CHANNEL(6),
 	AD4691_CHANNEL(7),
+	IIO_CHAN_SOFT_TIMESTAMP(8),
 };
 
 static const struct ad4691_channel_info ad4691_sw_info = {
@@ -189,6 +206,8 @@ static const int ad4691_osc_freqs_Hz[] = {
 	[0xF] = 1250,
 };
 
+static const char * const ad4691_gp_names[] = { "gp0", "gp1", "gp2", "gp3" };
+
 static const struct ad4691_chip_info ad4691_chip_info = {
 	.name = "ad4691",
 	.max_rate = 500 * HZ_PER_KHZ,
@@ -218,8 +237,13 @@ struct ad4691_state {
 	struct regmap *regmap;
 	struct spi_device *spi;
 
+	struct pwm_device *conv_trigger;
+	int irq;
 	int vref_uV;
+	u32 cnv_period_ns;
 
+	bool manual_mode;
+	bool irq_enabled;
 	bool refbuf_en;
 	bool ldo_en;
 	/*
@@ -227,8 +251,56 @@ struct ad4691_state {
 	 * atomicity of consecutive SPI operations.
 	 */
 	struct mutex lock;
+	/*
+	 * Per-buffer-enable lifetime resources:
+	 * Manual Mode - a pre-built SPI message that clocks out N+1
+	 *		 transfers in one go.
+	 * CNV Burst Mode - a pre-built SPI message that clocks out 2*N
+	 *		    transfers in one go.
+	 */
+	struct spi_message scan_msg;
+	/*
+	 * max 16 + 1 NOOP (manual) or 2*16 + 1 state-reset (CNV burst).
+	 */
+	struct spi_transfer scan_xfers[34];
+	/*
+	 * CNV burst: 16 AVG_IN addresses = 16.  Manual: 16 channel cmds +
+	 * 1 NOOP = 17.  Stored as native u16; put_unaligned_be16() fills each
+	 * slot so the SPI controller (bits_per_word=8) sends bytes MSB-first.
+	 */
+	u16 scan_tx[17] __aligned(IIO_DMA_MINALIGN);
+	/*
+	 * CNV burst state-reset: 4-byte write [addr_hi, addr_lo,
+	 * STATE_RESET_ALL, OSC_EN=1]. CS is asserted throughout, so
+	 * ADDR_DESCENDING writes byte[3]=1 to OSC_EN_REG (0x180) as a
+	 * deliberate side-write, keeping the oscillator enabled. Shared
+	 * with the offload path (mutually exclusive at probe).
+	 */
+	u8 scan_tx_reset[4] __aligned(IIO_DMA_MINALIGN);
+	/*
+	 * Scan buffer: one BE16 slot per active channel, plus timestamp.
+	 * DMA-aligned because scan_xfers point rx_buf directly into vals[].
+	 */
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, vals, 16);
 };
 
+/*
+ * Configure the given GP pin (0-3) as DATA_READY output.
+ * GP0/GP1 → GPIO_MODE1_REG, GP2/GP3 → GPIO_MODE2_REG.
+ * Even pins occupy bits [3:0], odd pins bits [7:4].
+ */
+static int ad4691_gpio_setup(struct ad4691_state *st, unsigned int gp_num)
+{
+	unsigned int bit_off = gp_num % 2;
+	unsigned int reg_off = gp_num / 2;
+	unsigned int shift = 4 * bit_off;
+
+	return regmap_update_bits(st->regmap,
+				  AD4691_GPIO_MODE1_REG + reg_off,
+				  AD4691_GP_MODE_MASK << shift,
+				  AD4691_GP_MODE_DATA_READY << shift);
+}
+
 static int ad4691_reg_read(void *context, unsigned int reg, unsigned int *val)
 {
 	struct spi_device *spi = context;
@@ -539,13 +611,411 @@ static int ad4691_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	return regmap_write(st->regmap, reg, writeval);
 }
 
-static const struct iio_info ad4691_info = {
+static int ad4691_set_pwm_freq(struct ad4691_state *st, unsigned int freq)
+{
+	if (!freq)
+		return -EINVAL;
+
+	st->cnv_period_ns = DIV_ROUND_UP(NSEC_PER_SEC, freq);
+	return 0;
+}
+
+static int ad4691_sampling_enable(struct ad4691_state *st, bool enable)
+{
+	struct pwm_state conv_state = {
+		.period     = st->cnv_period_ns,
+		.duty_cycle = AD4691_CNV_DUTY_CYCLE_NS,
+		.polarity   = PWM_POLARITY_NORMAL,
+		.enabled    = enable,
+	};
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
+	ret = regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
+				 AD4691_ADC_MODE_MASK, AD4691_CNV_BURST_MODE);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4691_STATE_RESET_REG,
+			    AD4691_STATE_RESET_ALL);
+}
+
+static int ad4691_transfer(struct ad4691_state *st, u16 cmd)
+{
+	u8 buf[2];
+
+	put_unaligned_be16(cmd, buf);
+
+	return spi_write(st->spi, buf, sizeof(buf));
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
+		return ad4691_transfer(st, AD4691_EXIT_COMMAND);
+
+	return regmap_update_bits(st->regmap, AD4691_ADC_SETUP,
+				  AD4691_ADC_MODE_MASK, AD4691_AUTONOMOUS_MODE);
+}
+
+static int ad4691_manual_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int k, i;
+	int ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
+
+	spi_message_init(&st->scan_msg);
+
+	k = 0;
+	iio_for_each_active_channel(indio_dev, i) {
+		/*
+		 * Channel-select command occupies the first (high) byte of the
+		 * 16-bit DIN frame; the second byte is a don't-care zero pad.
+		 * put_unaligned_be16() writes [cmd, 0x00] in memory so the
+		 * SPI controller sends the command byte first on the wire.
+		 */
+		put_unaligned_be16((u16)(AD4691_ADC_CHAN(i) << 8), &st->scan_tx[k]);
+		st->scan_xfers[k].tx_buf = &st->scan_tx[k];
+		/*
+		 * The pipeline means xfer[0] receives the residual from the
+		 * previous sequence, not a valid sample. Discard it (rx_buf=NULL)
+		 * to avoid aliasing vals[0] across two concurrent DMA mappings.
+		 * xfer[1] (or the NOOP when only one channel is active) writes
+		 * the real ch[0] result to vals[0]. Subsequent transfers write
+		 * into vals[k-1] so each result lands at the next dense slot.
+		 */
+		st->scan_xfers[k].rx_buf = (k == 0) ? NULL : &st->vals[k - 1];
+		st->scan_xfers[k].len = sizeof(*st->scan_tx);
+		st->scan_xfers[k].cs_change = 1;
+		st->scan_xfers[k].cs_change_delay.value = AD4691_CNV_HIGH_TIME_NS;
+		st->scan_xfers[k].cs_change_delay.unit = SPI_DELAY_UNIT_NSECS;
+		spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+		k++;
+	}
+
+	/* Final NOOP transfer retrieves the last channel's result. */
+	st->scan_xfers[k].tx_buf = &st->scan_tx[k]; /* scan_tx[k] == 0 == NOOP */
+	st->scan_xfers[k].rx_buf = &st->vals[k - 1];
+	st->scan_xfers[k].len = sizeof(*st->scan_tx);
+	spi_message_add_tail(&st->scan_xfers[k], &st->scan_msg);
+
+	ret = spi_optimize_message(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret) {
+		spi_unoptimize_message(&st->scan_msg);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int ad4691_manual_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_manual_buffer_setup_ops = {
+	.preenable = ad4691_manual_buffer_preenable,
+	.postdisable = ad4691_manual_buffer_postdisable,
+};
+
+static int ad4691_cnv_burst_buffer_preenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int acc_mask, std_seq_config;
+	unsigned int k, i;
+	int ret;
+
+	memset(st->scan_xfers, 0, sizeof(st->scan_xfers));
+	memset(st->scan_tx, 0, sizeof(st->scan_tx));
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
+		put_unaligned_be16(0x8000 | AD4691_AVG_IN(i), &st->scan_tx[k]);
+		st->scan_xfers[2 * k].tx_buf = &st->scan_tx[k];
+		st->scan_xfers[2 * k].len = sizeof(*st->scan_tx);
+		spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+		st->scan_xfers[2 * k + 1].rx_buf = &st->vals[k];
+		st->scan_xfers[2 * k + 1].len = sizeof(*st->scan_tx);
+		st->scan_xfers[2 * k + 1].cs_change = 1;
+		spi_message_add_tail(&st->scan_xfers[2 * k + 1], &st->scan_msg);
+		k++;
+	}
+
+	/*
+	 * Append a 4-byte state-reset transfer [addr_hi, addr_lo,
+	 * STATE_RESET_ALL, OSC_EN=1]. CS is asserted throughout, so
+	 * ADDR_DESCENDING writes byte[3]=1 to OSC_EN_REG (0x180) as a
+	 * deliberate side-write, keeping the oscillator enabled.
+	 * STATE_RESET_ALL starts the next burst; the hardware does not
+	 * accumulate new conversions until after a STATE_RESET pulse, so
+	 * no in-progress data is lost.  No cs_change here — CS must
+	 * deassert normally at end of message to frame the next command.
+	 */
+	put_unaligned_be16(AD4691_STATE_RESET_REG, st->scan_tx_reset);
+	st->scan_tx_reset[2] = AD4691_STATE_RESET_ALL;
+	st->scan_tx_reset[3] = 1;
+	st->scan_xfers[2 * k].tx_buf = st->scan_tx_reset;
+	st->scan_xfers[2 * k].len = sizeof(st->scan_tx_reset);
+	spi_message_add_tail(&st->scan_xfers[2 * k], &st->scan_msg);
+
+	ret = spi_optimize_message(st->spi, &st->scan_msg);
+	if (ret)
+		return ret;
+
+	std_seq_config = bitmap_read(indio_dev->active_scan_mask, 0,
+				     iio_get_masklength(indio_dev)) & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_STD_SEQ_CONFIG, std_seq_config);
+	if (ret)
+		goto err_unoptimize;
+
+	acc_mask = ~std_seq_config & GENMASK(15, 0);
+	ret = regmap_write(st->regmap, AD4691_ACC_MASK_REG, acc_mask);
+	if (ret)
+		goto err_unoptimize;
+
+	ret = ad4691_enter_conversion_mode(st);
+	if (ret)
+		goto err_unoptimize;
+
+	return 0;
+
+err_unoptimize:
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static int ad4691_cnv_burst_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	/*
+	 * Start the PWM and unmask the IRQ here in postenable, not in
+	 * preenable. The IIO core attaches the trigger poll function between
+	 * preenable and postenable; enabling sampling or unmasking the IRQ
+	 * before that point risks a DATA_READY assertion landing before the
+	 * poll function is registered. iio_trigger_poll() would drop the
+	 * event, disable_irq_nosync() would fire, and enable_irq() would
+	 * never be called, leaving the IRQ permanently masked.
+	 */
+	ret = ad4691_sampling_enable(st, true);
+	if (ret)
+		return ret;
+
+	enable_irq(st->irq);
+	st->irq_enabled = true;
+	return 0;
+}
+
+static int ad4691_cnv_burst_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	if (st->irq_enabled) {
+		disable_irq(st->irq);
+		st->irq_enabled = false;
+	}
+	return ad4691_sampling_enable(st, false);
+}
+
+static int ad4691_cnv_burst_buffer_postdisable(struct iio_dev *indio_dev)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = ad4691_exit_conversion_mode(st);
+	spi_unoptimize_message(&st->scan_msg);
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4691_cnv_burst_buffer_setup_ops = {
+	.preenable = ad4691_cnv_burst_buffer_preenable,
+	.postenable = ad4691_cnv_burst_buffer_postenable,
+	.predisable = ad4691_cnv_burst_buffer_predisable,
+	.postdisable = ad4691_cnv_burst_buffer_postdisable,
+};
+
+static ssize_t sampling_frequency_show(struct device *dev,
+				       struct device_attribute *attr,
+				       char *buf)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	return sysfs_emit(buf, "%lu\n", NSEC_PER_SEC / st->cnv_period_ns);
+}
+
+static ssize_t sampling_frequency_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4691_state *st = iio_priv(indio_dev);
+	unsigned int freq;
+	int ret;
+
+	ret = kstrtouint(buf, 10, &freq);
+	if (ret)
+		return ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = ad4691_set_pwm_freq(st, freq);
+	if (ret)
+		return ret;
+
+	return len;
+}
+
+static IIO_DEVICE_ATTR_RW(sampling_frequency, 0);
+
+static const struct iio_dev_attr *ad4691_buffer_attrs[] = {
+	&iio_dev_attr_sampling_frequency,
+	NULL
+};
+
+static irqreturn_t ad4691_irq(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+	struct ad4691_state *st = iio_priv(indio_dev);
+
+	/*
+	 * Disable the IRQ before calling iio_trigger_poll(). The IRQ is
+	 * re-enabled via the trigger .reenable callback, which the IIO core
+	 * calls inside iio_trigger_notify_done() once use_count reaches zero.
+	 * Re-enabling here (before notify_done) would race: a DATA_READY
+	 * between enable_irq() and notify_done() calls iio_trigger_poll()
+	 * while use_count > 0, dropping the event and permanently masking
+	 * the IRQ.
+	 */
+	disable_irq_nosync(st->irq);
+	iio_trigger_poll(indio_dev->trig);
+
+	return IRQ_HANDLED;
+}
+
+static void ad4691_trigger_reenable(struct iio_trigger *trig)
+{
+	struct ad4691_state *st = iio_trigger_get_drvdata(trig);
+
+	enable_irq(st->irq);
+}
+
+static const struct iio_trigger_ops ad4691_trigger_ops = {
+	.reenable = ad4691_trigger_reenable,
+	.validate_device = iio_trigger_validate_own_device,
+};
+
+static void ad4691_read_scan(struct iio_dev *indio_dev, s64 ts)
+{
+	struct ad4691_state *st = iio_priv(indio_dev);
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = spi_sync(st->spi, &st->scan_msg);
+	if (ret) {
+		dev_err_ratelimited(regmap_get_device(st->regmap),
+				    "SPI scan failed: %d\n", ret);
+		return;
+	}
+
+	/*
+	 * rx_buf pointers in scan_xfers point directly into scan.vals, so no
+	 * copy is needed. The scan_msg already includes a STATE_RESET at the
+	 * end (appended in preenable), so no explicit reset is needed here.
+	 */
+	iio_push_to_buffers_with_ts(indio_dev, st->vals, sizeof(st->vals), ts);
+}
+
+static irqreturn_t ad4691_trigger_handler(int irq, void *p)
+{
+	struct iio_poll_func *pf = p;
+	struct iio_dev *indio_dev = pf->indio_dev;
+
+	ad4691_read_scan(indio_dev, pf->timestamp);
+	iio_trigger_notify_done(indio_dev->trig);
+	return IRQ_HANDLED;
+}
+
+/*
+ * CNV burst mode: only allow our own trigger (driven by DATA_READY IRQ).
+ * Manual mode: external triggers (e.g. iio-trig-hrtimer) must be allowed
+ * because manual mode has no DATA_READY IRQ to fire the internal trigger.
+ * iio_trigger_ops.validate_device = iio_trigger_validate_own_device is
+ * correct in both modes — it prevents other devices from hijacking our
+ * internal trigger; the distinction here is only for iio_info.validate_trigger.
+ */
+static const struct iio_info ad4691_cnv_burst_info = {
+	.read_raw = ad4691_read_raw,
+	.write_raw = ad4691_write_raw,
+	.read_avail = ad4691_read_avail,
+	.debugfs_reg_access = ad4691_reg_access,
+	.validate_trigger = iio_validate_own_trigger,
+};
+
+static const struct iio_info ad4691_manual_info = {
 	.read_raw = ad4691_read_raw,
 	.write_raw = ad4691_write_raw,
 	.read_avail = ad4691_read_avail,
 	.debugfs_reg_access = ad4691_reg_access,
 };
 
+static int ad4691_pwm_setup(struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+
+	st->conv_trigger = devm_pwm_get(dev, "cnv");
+	if (IS_ERR(st->conv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->conv_trigger),
+				     "Failed to get CNV PWM\n");
+
+	return ad4691_set_pwm_freq(st, st->info->max_rate);
+}
+
 static int ad4691_regulator_setup(struct ad4691_state *st)
 {
 	struct device *dev = regmap_get_device(st->regmap);
@@ -649,6 +1119,22 @@ static int ad4691_config(struct ad4691_state *st)
 	unsigned int val;
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
@@ -702,6 +1188,86 @@ static int ad4691_config(struct ad4691_state *st)
 	return 0;
 }
 
+static int ad4691_setup_triggered_buffer(struct iio_dev *indio_dev,
+					 struct ad4691_state *st)
+{
+	struct device *dev = regmap_get_device(st->regmap);
+	struct iio_trigger *trig;
+	unsigned int i;
+	int irq, ret;
+
+	indio_dev->channels = st->info->sw_info->channels;
+	indio_dev->num_channels = st->info->sw_info->num_channels;
+	indio_dev->info = st->manual_mode ? &ad4691_manual_info : &ad4691_cnv_burst_info;
+
+	/*
+	 * Manual mode relies on an external trigger (e.g. iio-trig-hrtimer);
+	 * no internal trigger is needed or registered.
+	 */
+	if (st->manual_mode)
+		return devm_iio_triggered_buffer_setup(dev, indio_dev,
+						       iio_pollfunc_store_time,
+						       ad4691_trigger_handler,
+						       &ad4691_manual_buffer_setup_ops);
+
+	/*
+	 * CNV burst mode: allocate an internal trigger driven by the
+	 * DATA_READY IRQ on the GP pin.
+	 */
+	trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
+				      iio_device_id(indio_dev));
+	if (!trig)
+		return -ENOMEM;
+
+	trig->ops = &ad4691_trigger_ops;
+	iio_trigger_set_drvdata(trig, st);
+
+	ret = devm_iio_trigger_register(dev, trig);
+	if (ret)
+		return dev_err_probe(dev, ret, "IIO trigger register failed\n");
+
+	indio_dev->trig = iio_trigger_get(trig);
+
+	/*
+	 * The GP pin named in interrupt-names asserts at end-of-conversion.
+	 * The IRQ handler fires the IIO trigger so the trigger handler can
+	 * read and push the sample to the buffer. The IRQ is kept disabled
+	 * until the buffer is enabled.
+	 */
+	irq = -ENXIO;
+	for (i = 0; i < ARRAY_SIZE(ad4691_gp_names); i++) {
+		irq = fwnode_irq_get_byname(dev_fwnode(dev),
+					    ad4691_gp_names[i]);
+		if (irq > 0 || irq == -EPROBE_DEFER)
+			break;
+	}
+	if (irq < 0)
+		return dev_err_probe(dev, irq, "failed to get GP interrupt\n");
+
+	st->irq = irq;
+
+	ret = ad4691_gpio_setup(st, i);
+	if (ret)
+		return ret;
+
+	/*
+	 * The handler only calls disable_irq_nosync() and iio_trigger_poll(),
+	 * both safe in hardirq context, so register as a hard IRQ handler.
+	 * IRQF_NO_AUTOEN keeps it disabled until the buffer is enabled.
+	 */
+	ret = devm_request_irq(dev, irq, ad4691_irq, IRQF_NO_AUTOEN,
+			       indio_dev->name, indio_dev);
+	if (ret)
+		return ret;
+
+	return devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
+						   iio_pollfunc_store_time,
+						   ad4691_trigger_handler,
+						   IIO_BUFFER_DIRECTION_IN,
+						   &ad4691_cnv_burst_buffer_setup_ops,
+						   ad4691_buffer_attrs);
+}
+
 static int ad4691_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -741,11 +1307,11 @@ static int ad4691_probe(struct spi_device *spi)
 		return ret;
 
 	indio_dev->name = st->info->name;
-	indio_dev->info = &ad4691_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	indio_dev->channels = st->info->sw_info->channels;
-	indio_dev->num_channels = st->info->sw_info->num_channels;
+	ret = ad4691_setup_triggered_buffer(indio_dev, st);
+	if (ret)
+		return ret;
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.43.0



