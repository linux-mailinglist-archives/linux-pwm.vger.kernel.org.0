Return-Path: <linux-pwm+bounces-7406-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A489DBC54FD
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48643E38BA
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8189B2874F1;
	Wed,  8 Oct 2025 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ux6K8PR+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B10286420;
	Wed,  8 Oct 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931505; cv=none; b=rMfUzgBlrqGSp2WM7ErsgyjJY/r1L9qfLATA2/3yjiJ7fHt1AUV7kA1Dzubo8TLkm+j4WXQk8VRhtvD7VVx/phaW8WKwH6d7zE+v6ysj8YyVUsT+q35iA7Xc4CGBupRPhQi72hqXwtZX9XUJCbgLqr/zqezPU5o4g84V0THLXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931505; c=relaxed/simple;
	bh=VROJrv5MkKxmLnJ3y6XPzbj97aoVQ90BbOzNJfm3BxA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVtKIrImtvxnC5b8BD5wHZlESgXLNxHMBgQLfVoV9gGkBJ3KSnfcS69TWQxVRtAm1l3qu3bKrQw/Lvvt2K89sBiT5nYVSmV+NCB5G3BFH97pFTvJjqBwIVWJgybMuvUzm+Sra5eifaK6ZuXLs+CQKPMGqMOZRBblx5LqCBx4m50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ux6K8PR+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598Brr9t001000;
	Wed, 8 Oct 2025 09:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YZKes
	R8t0pyJzF6KbUn4NbSoZJzBmPnxnEkvhM8GoN4=; b=ux6K8PR+vnWl6AyTafgG2
	K52KcURtC6ILaDnirTwphje4I6UKkBi4SDJAMFps3ZCxOwvHi3EmlvNsQVgq11KH
	ef7ZUaueJLZSRISW3R3cYnPnyB0zObZzZA/f6JP4UrmkNzmqAgBkf9Bmvmztw4Jo
	EAoYoyuuJC5s56IN+GXImLntUDji3KDqMRREDUVgPCKfFonbbTWIhHktk1+CuCpF
	WDWTBzBURUGVbfut19k/5I9ZDm3ohP4XXYMrA0udj90+pYyIPA4fnXKdlVQkSIVc
	L8nxooOX6t3EHzJ9i2r7bfjwdmJQcoSBn3peWvXFs5M7xHTmNx6//ZNMhWB99Rl6
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 49nkc6srds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:51:37 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598DpaLj034818
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:51:36 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:51:36 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:51:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:51:35 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DpLEB023170;
	Wed, 8 Oct 2025 09:51:23 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        "Trevor Gamblin" <tgamblin@baylibre.com>,
        Axel Haslam <ahaslam@baylibre.com>
Subject: [PATCH v4 6/8] iio: adc: ad4030: Add SPI offload support
Date: Wed, 8 Oct 2025 10:51:20 -0300
Message-ID: <2bde211f1bc730ee147c9540b88339a93b2983e6.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: mKAyVBKftDJm7CCayNvP0JnXuncsRQmq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDA0NyBTYWx0ZWRfX4b7Yyuim5T/A
 QWRL7NFE80mRuVD6WBaR3mnOa1pG4RFxIsJjuOLRg9U9Oa9gbxRHCXp6mYGfIDjBx2WNdS+fidh
 AJOhkTWaopNz4mt4ZY9sXony9BmjN4pds7wCQtRV/vP/3O20MbaYK6rrDuhSZy+VeRnte4MMBl1
 Q29fcKcicpFBVGdW8BRIhoUZV6Wv4exZnZIG+MKuAtwTVbgXQhM4g0i4jJwgWkrBV5lgnzVaEXh
 SOJ4wnCfT+ofkf5gotD3NxXNdHg6lI6A3tBwPnNb//bf1u1P69gCCfitNwz6ao72Uzdf1qdUIz1
 92iRLzigPQBWb2oOl54azzQrsa0pcY5o8xwEEhv2H4moq8zF3qsFSmAVQWSlGGwHcGtUDV4+ASA
 ZiOxl3zjedwyRXQ19oYhBSefSXuQaw==
X-Proofpoint-ORIG-GUID: mKAyVBKftDJm7CCayNvP0JnXuncsRQmq
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=68e66c69 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=9Nk0bTxa6Lcm4eBWZcIA:9
 a=IawgGOuG5U0WyFbmm1f5:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510080047

AD4030 and similar ADCs can capture data at sample rates up to 2 mega
samples per second (MSPS). Not all SPI controllers are able to achieve such
high throughputs and even when the controller is fast enough to run
transfers at the required speed, it may be costly to the CPU to handle
transfer data at such high sample rates. Add SPI offload support for AD4030
and similar ADCs to enable data capture at maximum sample rates.

Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
Co-developed-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Axel Haslam <ahaslam@baylibre.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v3 -> v4
- Applied code adjustments suggested to SPI offload patch.
- Only select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM).

 drivers/iio/adc/Kconfig  |   3 +
 drivers/iio/adc/ad4030.c | 504 +++++++++++++++++++++++++++++++++++----
 2 files changed, 465 insertions(+), 42 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 58a14e6833f6..1ed091b6731a 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -62,7 +62,10 @@ config AD4030
 	depends on GPIOLIB
 	select REGMAP
 	select IIO_BUFFER
+	select IIO_BUFFER_DMA
+	select IIO_BUFFER_DMAENGINE
 	select IIO_TRIGGERED_BUFFER
+	select SPI_OFFLOAD_TRIGGER_PWM if (SPI_OFFLOAD && PWM)
 	help
 	  Say yes here to build support for Analog Devices AD4030 and AD4630 high speed
 	  SPI analog to digital converters (ADC).
diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index b2847fd90271..bbadcda8df77 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -14,15 +14,25 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
+#include <linux/dmaengine.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/limits.h>
+#include <linux/log2.h>
+#include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/pwm.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/spi/offload/consumer.h>
 #include <linux/spi/spi.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
+#include <linux/types.h>
 
 #define AD4030_REG_INTERFACE_CONFIG_A			0x00
 #define     AD4030_REG_INTERFACE_CONFIG_A_SW_RESET	(BIT(0) | BIT(7))
@@ -111,6 +121,8 @@
 #define AD4632_TCYC_NS			2000
 #define AD4632_TCYC_ADJUSTED_NS		(AD4632_TCYC_NS - AD4030_TCNVL_NS)
 #define AD4030_TRESET_COM_DELAY_MS	750
+/* Datasheet says 9.8ns, so use the closest integer value */
+#define AD4030_TQUIET_CNV_DELAY_NS	10
 
 enum ad4030_out_mode {
 	AD4030_OUT_DATA_MD_DIFF,
@@ -136,11 +148,13 @@ struct ad4030_chip_info {
 	const char *name;
 	const unsigned long *available_masks;
 	const struct iio_chan_spec channels[AD4030_MAX_IIO_CHANNEL_NB];
+	const struct iio_chan_spec offload_channels[AD4030_MAX_IIO_CHANNEL_NB];
 	u8 grade;
 	u8 precision_bits;
 	/* Number of hardware channels */
 	int num_voltage_inputs;
 	unsigned int tcyc_ns;
+	unsigned int max_sample_rate_hz;
 };
 
 struct ad4030_state {
@@ -153,6 +167,14 @@ struct ad4030_state {
 	int offset_avail[3];
 	unsigned int avg_log2;
 	enum ad4030_out_mode mode;
+	/* Offload sampling */
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_offload_trigger_config offload_trigger_config;
+	struct pwm_device *cnv_trigger;
+	struct pwm_waveform cnv_wf;
 
 	/*
 	 * DMA (thus cache coherency maintenance) requires the transfer buffers
@@ -209,8 +231,9 @@ struct ad4030_state {
  * - voltage0-voltage1
  * - voltage2-voltage3
  */
-#define AD4030_CHAN_DIFF(_idx, _scan_type) {				\
+#define __AD4030_CHAN_DIFF(_idx, _scan_type, _offload) {		\
 	.info_mask_shared_by_all =					\
+		(_offload ? BIT(IIO_CHAN_INFO_SAMP_FREQ) : 0) |		\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
 	.info_mask_shared_by_all_available =				\
 		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),			\
@@ -232,6 +255,12 @@ struct ad4030_state {
 	.num_ext_scan_type = ARRAY_SIZE(_scan_type),			\
 }
 
+#define AD4030_CHAN_DIFF(_idx, _scan_type)				\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 0)
+
+#define AD4030_OFFLOAD_CHAN_DIFF(_idx, _scan_type)			\
+	__AD4030_CHAN_DIFF(_idx, _scan_type, 1)
+
 static const int ad4030_average_modes[] = {
 	BIT(0),					/* No averaging/oversampling */
 	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
@@ -240,6 +269,11 @@ static const int ad4030_average_modes[] = {
 	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
 };
 
+static const struct spi_offload_config ad4030_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
 static int ad4030_enter_config_mode(struct ad4030_state *st)
 {
 	st->tx_data[0] = AD4030_REG_ACCESS;
@@ -453,6 +487,107 @@ static int ad4030_get_chan_calibbias(struct iio_dev *indio_dev,
 	}
 }
 
+static void ad4030_get_sampling_freq(struct ad4030_state *st, int *freq)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+
+	/*
+	 * Conversion data is fetched from the device when the offload transfer
+	 * is triggered. Thus, provide the SPI offload trigger frequency as the
+	 * sampling frequency.
+	 */
+	*freq = config->periodic.frequency_hz;
+}
+
+static int ad4030_update_conversion_rate(struct ad4030_state *st,
+					 unsigned int freq, unsigned int avg_log2)
+{
+	struct spi_offload_trigger_config *config = &st->offload_trigger_config;
+	struct pwm_waveform cnv_wf = { };
+	u64 target = AD4030_TCNVH_NS;
+	u64 offload_period_ns;
+	u64 offload_offset_ns;
+	int ret;
+
+	/*
+	 * When averaging/oversampling over N samples, we fire the offload
+	 * trigger once at every N pulses of the CNV signal. Conversely, the CNV
+	 * signal needs to be N times faster than the offload trigger. Take that
+	 * into account to correctly re-evaluate both the PWM waveform connected
+	 * to CNV and the SPI offload trigger.
+	 */
+	freq <<= avg_log2;
+
+	cnv_wf.period_length_ns = DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq);
+	/*
+	 * The datasheet lists a minimum time of 9.8 ns, but no maximum. If the
+	 * rounded PWM's value is less than 10, increase the target value by 10
+	 * and attempt to round the waveform again, until the value is at least
+	 * 10 ns. Use a separate variable to represent the target in case the
+	 * rounding is severe enough to keep putting the first few results under
+	 * the minimum 10ns condition checked by the while loop.
+	 */
+	do {
+		cnv_wf.duty_length_ns = target;
+		ret = pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
+		if (ret)
+			return ret;
+		target += AD4030_TCNVH_NS;
+	} while (cnv_wf.duty_length_ns < AD4030_TCNVH_NS);
+
+	if (!in_range(cnv_wf.period_length_ns, AD4030_TCYC_NS, INT_MAX))
+		return -EINVAL;
+
+	offload_period_ns = cnv_wf.period_length_ns;
+	/*
+	 * Make the offload trigger period be N times longer than the CNV PWM
+	 * period when averaging over N samples.
+	 */
+	offload_period_ns <<= avg_log2;
+
+	config->periodic.frequency_hz = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
+							 offload_period_ns);
+
+	/*
+	 * The hardware does the capture on zone 2 (when SPI trigger PWM
+	 * is used). This means that the SPI trigger signal should happen at
+	 * tsync + tquiet_con_delay being tsync the conversion signal period
+	 * and tquiet_con_delay 9.8ns. Hence set the PWM phase accordingly.
+	 *
+	 * The PWM waveform API only supports nanosecond resolution right now,
+	 * so round this setting to the closest available value.
+	 */
+	offload_offset_ns = AD4030_TQUIET_CNV_DELAY_NS;
+	do {
+		config->periodic.offset_ns = offload_offset_ns;
+		ret = spi_offload_trigger_validate(st->offload_trigger, config);
+		if (ret)
+			return ret;
+		offload_offset_ns += AD4030_TQUIET_CNV_DELAY_NS;
+	} while (config->periodic.offset_ns < AD4030_TQUIET_CNV_DELAY_NS);
+
+	st->cnv_wf = cnv_wf;
+
+	return 0;
+}
+
+static int ad4030_set_sampling_freq(struct iio_dev *indio_dev, int freq)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	/*
+	 * We have no control over the sampling frequency without SPI offload
+	 * triggering.
+	 */
+	if (!st->offload_trigger)
+		return -ENODEV;
+
+	if (!in_range(freq, 1, st->chip->max_sample_rate_hz))
+		return -EINVAL;
+
+	return ad4030_update_conversion_rate(st, freq, st->avg_log2);
+}
+
 static int ad4030_set_chan_calibscale(struct iio_dev *indio_dev,
 				      struct iio_chan_spec const *chan,
 				      int gain_int,
@@ -507,27 +642,6 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 				 st->tx_data, AD4030_REG_OFFSET_BYTES_NB);
 }
 
-static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
-{
-	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
-	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
-	int ret;
-
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
-		return -EINVAL;
-
-	ret = regmap_write(st->regmap, AD4030_REG_AVG,
-			   AD4030_REG_AVG_MASK_AVG_SYNC |
-			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
-	if (ret)
-		return ret;
-
-	st->avg_log2 = avg_log2;
-
-	return 0;
-}
-
 static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 					unsigned int mask)
 {
@@ -536,11 +650,10 @@ static bool ad4030_is_common_byte_asked(struct ad4030_state *st,
 		AD4030_DUAL_COMMON_BYTE_CHANNELS_MASK);
 }
 
-static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
+static int ad4030_set_mode(struct ad4030_state *st, unsigned long mask,
+			   unsigned int avg_log2)
 {
-	struct ad4030_state *st = iio_priv(indio_dev);
-
-	if (st->avg_log2 > 0) {
+	if (avg_log2 > 0) {
 		st->mode = AD4030_OUT_DATA_MD_30_AVERAGED_DIFF;
 	} else if (ad4030_is_common_byte_asked(st, mask)) {
 		switch (st->chip->precision_bits) {
@@ -564,6 +677,49 @@ static int ad4030_set_mode(struct iio_dev *indio_dev, unsigned long mask)
 				  st->mode);
 }
 
+static int ad4030_set_avg_frame_len(struct iio_dev *dev, unsigned long mask, int avg_val)
+{
+	struct ad4030_state *st = iio_priv(dev);
+	unsigned int avg_log2 = ilog2(avg_val);
+	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	int freq;
+	int ret;
+
+	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+		return -EINVAL;
+
+	ret = ad4030_set_mode(st, mask, avg_log2);
+	if (ret)
+		return ret;
+
+	if (st->offload_trigger) {
+		/*
+		 * The sample averaging and sampling frequency configurations
+		 * are mutually dependent one from another. That's because the
+		 * effective data sample rate is fCNV / 2^N, where N is the
+		 * number of samples being averaged.
+		 *
+		 * When SPI offload is supported and we have control over the
+		 * sample rate, the conversion start signal (CNV) and the SPI
+		 * offload trigger frequencies must be re-evaluated so data is
+		 * fetched only after 'avg_val' conversions.
+		 */
+		ad4030_get_sampling_freq(st, &freq);
+		ret = ad4030_update_conversion_rate(st, freq, avg_log2);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_write(st->regmap, AD4030_REG_AVG,
+			   AD4030_REG_AVG_MASK_AVG_SYNC |
+			   FIELD_PREP(AD4030_REG_AVG_MASK_AVG_VAL, avg_log2));
+	if (ret)
+		return ret;
+
+	st->avg_log2 = avg_log2;
+	return 0;
+}
+
 /*
  * Descramble 2 32bits numbers out of a 64bits. The bits are interleaved:
  * 1 bit for first number, 1 bit for the second, and so on...
@@ -672,7 +828,7 @@ static int ad4030_single_conversion(struct iio_dev *indio_dev,
 	struct ad4030_state *st = iio_priv(indio_dev);
 	int ret;
 
-	ret = ad4030_set_mode(indio_dev, BIT(chan->scan_index));
+	ret = ad4030_set_mode(st, BIT(chan->scan_index), st->avg_log2);
 	if (ret)
 		return ret;
 
@@ -769,6 +925,13 @@ static int ad4030_read_raw_dispatch(struct iio_dev *indio_dev,
 		*val = BIT(st->avg_log2);
 		return IIO_VAL_INT;
 
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (!st->offload_trigger)
+			return -ENODEV;
+
+		ad4030_get_sampling_freq(st, val);
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -807,7 +970,10 @@ static int ad4030_write_raw_dispatch(struct iio_dev *indio_dev,
 		return ad4030_set_chan_calibbias(indio_dev, chan, val);
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		return ad4030_set_avg_frame_len(indio_dev, val);
+		return ad4030_set_avg_frame_len(indio_dev, BIT(chan->scan_index), val);
+
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4030_set_sampling_freq(indio_dev, val);
 
 	default:
 		return -EINVAL;
@@ -869,7 +1035,11 @@ static int ad4030_get_current_scan_type(const struct iio_dev *indio_dev,
 static int ad4030_update_scan_mode(struct iio_dev *indio_dev,
 				   const unsigned long *scan_mask)
 {
-	return ad4030_set_mode(indio_dev, *scan_mask);
+	struct ad4030_state *st = iio_priv(indio_dev);
+
+	//return ad4030_set_mode(st, *scan_mask, st->avg_log2);
+	//return ad4030_set_mode(iio_priv(indio_dev), &scan_mask, st->avg_log2);
+	return ad4030_set_mode(iio_priv(indio_dev), *scan_mask, st->avg_log2);
 }
 
 static const struct iio_info ad4030_iio_info = {
@@ -898,6 +1068,108 @@ static const struct iio_buffer_setup_ops ad4030_buffer_setup_ops = {
 	.validate_scan_mask = ad4030_validate_scan_mask,
 };
 
+static void ad4030_prepare_offload_msg(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	u8 offload_bpw;
+
+	if (st->mode == AD4030_OUT_DATA_MD_30_AVERAGED_DIFF) {
+		offload_bpw = 32;
+	} else {
+		offload_bpw = st->chip->precision_bits;
+		offload_bpw += (st->mode == AD4030_OUT_DATA_MD_24_DIFF_8_COM ||
+				st->mode == AD4030_OUT_DATA_MD_16_DIFF_8_COM) ? 8 : 0;
+	}
+
+	st->offload_xfer.bits_per_word = offload_bpw;
+	st->offload_xfer.len = spi_bpw_to_bytes(offload_bpw);
+	st->offload_xfer.offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+}
+
+static int ad4030_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	unsigned int reg_modes;
+	int ret, ret2;
+
+	/*
+	 * When data from 2 analog input channels is output through a single
+	 * bus line (interleaved mode (LANE_MD == 0b11)) and gets pushed through
+	 * DMA, extra hardware is required to do the de-interleaving. While we
+	 * don't support such hardware configurations, disallow interleaved mode
+	 * when using SPI offload.
+	 */
+	ret = regmap_read(st->regmap, AD4030_REG_MODES, &reg_modes);
+	if (ret)
+		return ret;
+
+	if (st->chip->num_voltage_inputs > 1 &&
+	    FIELD_GET(AD4030_REG_MODES_MASK_LANE_MODE, reg_modes) == AD4030_LANE_MD_INTERLEAVED)
+		return -EINVAL;
+
+	ret = regmap_write(st->regmap, AD4030_REG_EXIT_CFG_MODE, BIT(0));
+	if (ret)
+		return ret;
+
+	ad4030_prepare_offload_msg(indio_dev);
+	st->offload_msg.offload = st->offload;
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret)
+		goto out_reset_mode;
+
+	ret = pwm_set_waveform_might_sleep(st->cnv_trigger, &st->cnv_wf, false);
+	if (ret)
+		goto out_unoptimize;
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &st->offload_trigger_config);
+	if (ret)
+		goto out_pwm_disable;
+
+	return 0;
+
+out_pwm_disable:
+	pwm_disable(st->cnv_trigger);
+out_unoptimize:
+	spi_unoptimize_message(&st->offload_msg);
+out_reset_mode:
+	/* reenter register configuration mode */
+	ret2 = ad4030_enter_config_mode(st);
+	if (ret2)
+		dev_err(&st->spi->dev,
+			"couldn't reenter register configuration mode: %d\n",
+			ret2);
+
+	return ret;
+}
+
+static int ad4030_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4030_state *st = iio_priv(indio_dev);
+	int ret;
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+
+	pwm_disable(st->cnv_trigger);
+
+	spi_unoptimize_message(&st->offload_msg);
+
+	/* reenter register configuration mode */
+	ret = ad4030_enter_config_mode(st);
+	if (ret)
+		dev_err(&st->spi->dev,
+			"couldn't reenter register configuration mode\n");
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4030_offload_buffer_setup_ops = {
+	.postenable = &ad4030_offload_buffer_postenable,
+	.predisable = &ad4030_offload_buffer_predisable,
+	.validate_scan_mask = ad4030_validate_scan_mask,
+};
+
 static int ad4030_regulators_get(struct ad4030_state *st)
 {
 	struct device *dev = &st->spi->dev;
@@ -967,6 +1239,24 @@ static int ad4030_detect_chip_info(const struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_pwm_get(struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+
+	st->cnv_trigger = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
+				     "Failed to get CNV PWM\n");
+
+	/*
+	 * Preemptively disable the PWM, since we only want to enable it with
+	 * the buffer.
+	 */
+	pwm_disable(st->cnv_trigger);
+
+	return 0;
+}
+
 static int ad4030_config(struct ad4030_state *st)
 {
 	int ret;
@@ -994,6 +1284,31 @@ static int ad4030_config(struct ad4030_state *st)
 	return 0;
 }
 
+static int ad4030_spi_offload_setup(struct iio_dev *indio_dev,
+				    struct ad4030_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+
+	indio_dev->setup_ops = &ad4030_offload_buffer_setup_ops;
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_PERIODIC);
+	if (IS_ERR(st->offload_trigger))
+		return dev_err_probe(dev, PTR_ERR(st->offload_trigger),
+				     "failed to get offload trigger\n");
+
+	st->offload_trigger_config.type = SPI_OFFLOAD_TRIGGER_PERIODIC;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return dev_err_probe(dev, PTR_ERR(rx_dma),
+				     "failed to get offload RX DMA\n");
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
 static int ad4030_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
@@ -1045,24 +1360,61 @@ static int ad4030_probe(struct spi_device *spi)
 		return dev_err_probe(dev, PTR_ERR(st->cnv_gpio),
 				     "Failed to get cnv gpio\n");
 
-	/*
-	 * One hardware channel is split in two software channels when using
-	 * common byte mode. Add one more channel for the timestamp.
-	 */
-	indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
 	indio_dev->name = st->chip->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ad4030_iio_info;
-	indio_dev->channels = st->chip->channels;
 	indio_dev->available_scan_masks = st->chip->available_masks;
 
-	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-					      iio_pollfunc_store_time,
-					      ad4030_trigger_handler,
-					      &ad4030_buffer_setup_ops);
-	if (ret)
-		return dev_err_probe(dev, ret,
-				     "Failed to setup triggered buffer\n");
+	st->offload = devm_spi_offload_get(dev, spi, &ad4030_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get offload\n");
+
+	/* Fall back to low speed usage when no SPI offload is available. */
+	if (ret == -ENODEV) {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Add one more channel for the timestamp.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs + 1;
+		indio_dev->channels = st->chip->channels;
+
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
+						      iio_pollfunc_store_time,
+						      ad4030_trigger_handler,
+						      &ad4030_buffer_setup_ops);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup triggered buffer\n");
+	} else {
+		/*
+		 * One hardware channel is split in two software channels when
+		 * using common byte mode. Offloaded SPI transfers can't support
+		 * software timestamp so no additional timestamp channel is added.
+		 */
+		indio_dev->num_channels = 2 * st->chip->num_voltage_inputs;
+		indio_dev->channels = st->chip->offload_channels;
+		ret = ad4030_spi_offload_setup(indio_dev, st);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to setup SPI offload\n");
+
+		ret = ad4030_pwm_get(st);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get PWM: %d\n", ret);
+
+		/*
+		 * Start with a slower sampling rate so there is some room for
+		 * adjusting the sample averaging and the sampling frequency
+		 * without hitting the maximum conversion rate.
+		 */
+		ret = ad4030_update_conversion_rate(st, st->chip->max_sample_rate_hz >> 4,
+						    st->avg_log2);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to set offload samp freq\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }
@@ -1100,6 +1452,23 @@ static const struct iio_scan_type ad4030_24_scan_types[] = {
 	},
 };
 
+static const struct iio_scan_type ad4030_24_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 24,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct iio_scan_type ad4030_16_scan_types[] = {
 	[AD4030_SCAN_TYPE_NORMAL] = {
 		.sign = 's',
@@ -1117,6 +1486,23 @@ static const struct iio_scan_type ad4030_16_scan_types[] = {
 	}
 };
 
+static const struct iio_scan_type ad4030_16_offload_scan_types[] = {
+	[AD4030_SCAN_TYPE_NORMAL] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 16,
+		.shift = 0,
+		.endianness = IIO_CPU,
+	},
+	[AD4030_SCAN_TYPE_AVG] = {
+		.sign = 's',
+		.storagebits = 32,
+		.realbits = 30,
+		.shift = 2,
+		.endianness = IIO_CPU,
+	},
+};
+
 static const struct ad4030_chip_info ad4030_24_chip_info = {
 	.name = "ad4030-24",
 	.available_masks = ad4030_channel_masks,
@@ -1125,10 +1511,15 @@ static const struct ad4030_chip_info ad4030_24_chip_info = {
 		AD4030_CHAN_CMO(1, 0),
 		IIO_CHAN_SOFT_TIMESTAMP(2),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_CHAN_CMO(1, 0),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4030_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 1,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_16_chip_info = {
@@ -1141,10 +1532,17 @@ static const struct ad4030_chip_info ad4630_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4630_24_chip_info = {
@@ -1157,10 +1555,17 @@ static const struct ad4030_chip_info ad4630_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4630_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4030_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 2 * HZ_PER_MHZ,
 };
 
 static const struct ad4030_chip_info ad4632_16_chip_info = {
@@ -1173,10 +1578,17 @@ static const struct ad4030_chip_info ad4632_16_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_16_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_16_offload_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_16_GRADE,
 	.precision_bits = 16,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct ad4030_chip_info ad4632_24_chip_info = {
@@ -1189,10 +1601,17 @@ static const struct ad4030_chip_info ad4632_24_chip_info = {
 		AD4030_CHAN_CMO(3, 1),
 		IIO_CHAN_SOFT_TIMESTAMP(4),
 	},
+	.offload_channels = {
+		AD4030_OFFLOAD_CHAN_DIFF(0, ad4030_24_offload_scan_types),
+		AD4030_OFFLOAD_CHAN_DIFF(1, ad4030_24_offload_scan_types),
+		AD4030_CHAN_CMO(2, 0),
+		AD4030_CHAN_CMO(3, 1),
+	},
 	.grade = AD4030_REG_CHIP_GRADE_AD4632_24_GRADE,
 	.precision_bits = 24,
 	.num_voltage_inputs = 2,
 	.tcyc_ns = AD4632_TCYC_ADJUSTED_NS,
+	.max_sample_rate_hz = 500 * HZ_PER_KHZ,
 };
 
 static const struct spi_device_id ad4030_id_table[] = {
@@ -1228,3 +1647,4 @@ module_spi_driver(ad4030_driver);
 MODULE_AUTHOR("Esteban Blanc <eblanc@baylibre.com>");
 MODULE_DESCRIPTION("Analog Devices AD4630 ADC family driver");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");
-- 
2.39.2


