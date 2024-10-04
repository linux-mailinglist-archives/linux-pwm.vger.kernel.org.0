Return-Path: <linux-pwm+bounces-3464-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22839905B0
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E038DB20FC9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F621B445;
	Fri,  4 Oct 2024 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="EqEO9+iM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000B121948A;
	Fri,  4 Oct 2024 14:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051178; cv=none; b=k8oyFZQAGDbiTQYzMgtrgEqmP8yC/3h62Y1gOh05GpBoj6cHeVXv0BXf4qikB+RhqCSGHkUtOYu+zYd1ESAUzFwGhJUELxgsDFR2FhWsOeP8lCHbdjrZQktIfc9qLqUFpd63FbMm2xonoy924XUMVt8Wyb3wcJeRtHRHbhOzVTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051178; c=relaxed/simple;
	bh=pzW7iuyzRD2K759N01E5Jaz26IcNvpUm4uAbf2rWQLw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHb2wBQZaU80sIeWhA0kOsAPOAscmBWJNCVnFv08q1MX02nqNzSJX5Uvf3tDJNefmA3eW/W7dPlDwBzxH7PEmdIw2IWuT7NMGDwR2L9FnUzyULlnYoYIE6gurE+ydA/A6ia7wjwVHaUoJAzSMUcvIgCWOVAPxVom066nWrEikOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=EqEO9+iM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CRWL0018542;
	Fri, 4 Oct 2024 10:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hDxri
	lQhpy2H1zj6HuSbX6K/M4nBLm9dU04rOyXlAyM=; b=EqEO9+iMmQ2GBJyyxxNuS
	cphRf+gBMmDX20GnMTosQ3tZp7kiJYVhcbCSTvVxqzM/LUJ/5PlbEkUPUmnY8kZT
	BQC62/37uY3NUniuoNsNtrlpcAD0fOesWJ+gAqfE3lNtooOP770FR18RqMkNO8Dq
	lIZ59gGXJesgE9xhnsboTZzXy7mTWOpnNh/XcqV0qAYGinKbsuS/QHdAJo4UCt4U
	eO0R3z79aJThFXj++6qqBMpcBBtXoct7be75sdXVxRtxpIVO3Y1cK+m889as0lQs
	b3Rwm3ad+zd4c7IQN/7Qs44w5+/hqQIDKPMq1egUXSjbISaO7wYzIwy21y6K+yb1
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 422043kx44-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:12:33 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 494ECVnd002721
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 10:12:31 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Oct 2024 10:12:31 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Oct 2024 10:12:31 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Oct 2024 10:12:31 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 494EAps6001773;
	Fri, 4 Oct 2024 10:12:21 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Mike
 Looijmans" <mike.looijmans@topic.nl>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Ivan Mikhaylov <fr0st61te@gmail.com>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        Dragos Bogdan
	<dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 6/7] iio: adc: ad485x: add ad485x driver
Date: Fri, 4 Oct 2024 17:07:55 +0300
Message-ID: <20241004140922.233939-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004140922.233939-1-antoniu.miclaus@analog.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8x-ZYWrZfhZ0ipt9tH6ssrRdXEGtxgf4
X-Proofpoint-GUID: 8x-ZYWrZfhZ0ipt9tH6ssrRdXEGtxgf4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040099

Add support for the AD485X DAS familiy.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - update headers and include the missing ones, order them alphabetically.
 - use clamp()
 - use units macros where applies
 - convert int to unsigned variables where applies.
 - add trailing commas where applies.
 - return FIELD_GET directly.
 - shrink function header to one line where it fits.
 - update scale table values arrangement - pow-of-two per line
 - rename j to have a proper meaning.
 - invert if (st->offsets[chan->channel] != val) and drop next lines indentation.
 - drop whitespace from * val = ... (altough checkpatch complains about it)
 - drop comma in the terminator lines for ext_info.
 - fix inconsistency between chip_info structures.
 - use devm_mutex_init
 - return -ENOENT on max_cnt check.
 - check both val and val2 for negative before converting to unsigned.
 - remove val2 where not used.
 - use dev_info() instead of dev_warn()
 - add spaces after { and before } in ad485x_scale_table

 drivers/iio/adc/Kconfig  |   12 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad485x.c | 1094 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 1107 insertions(+)
 create mode 100644 drivers/iio/adc/ad485x.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index f60fe85a30d5..83f55229d731 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -36,6 +36,18 @@ config AD4130
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4130.
 
+config AD485X
+	tristate "Analog Device AD485x DAS Driver"
+	depends on SPI
+	select REGMAP_SPI
+	select IIO_BACKEND
+	help
+	  Say yes here to build support for Analog Devices AD485x high speed
+	  data acquisition system (DAS).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad485x.
+
 config AD7091R
 	tristate
 
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index d370e066544e..26c1670c8913 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4130) += ad4130.o
+obj-$(CONFIG_AD485X) += ad485x.o
 obj-$(CONFIG_AD7091R) += ad7091r-base.o
 obj-$(CONFIG_AD7091R5) += ad7091r5.o
 obj-$(CONFIG_AD7091R8) += ad7091r8.o
diff --git a/drivers/iio/adc/ad485x.c b/drivers/iio/adc/ad485x.c
new file mode 100644
index 000000000000..faa10d56a791
--- /dev/null
+++ b/drivers/iio/adc/ad485x.c
@@ -0,0 +1,1094 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Analog Devices AD485x DAS driver
+ *
+ * Copyright 2024 Analog Devices Inc.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+#include <linux/units.h>
+
+#include <linux/iio/backend.h>
+#include <linux/iio/iio.h>
+
+#include <asm/unaligned.h>
+
+#define AD485X_REG_INTERFACE_CONFIG_A	0x00
+#define AD485X_REG_INTERFACE_CONFIG_B	0x01
+#define AD485X_REG_PRODUCT_ID_L		0x04
+#define AD485X_REG_PRODUCT_ID_H		0x05
+#define AD485X_REG_DEVICE_CTRL		0x25
+#define AD485X_REG_PACKET		0x26
+
+#define AD485X_REG_CH_CONFIG_BASE	0x2A
+#define AD485X_REG_CHX_SOFTSPAN(ch)	((0x12 * (ch)) + AD485X_REG_CH_CONFIG_BASE)
+#define AD485X_REG_CHX_OFFSET(ch)	(AD485X_REG_CHX_SOFTSPAN(ch) + 0x01)
+#define AD485X_REG_CHX_OFFSET_LSB(ch)	AD485X_REG_CHX_OFFSET(ch)
+#define AD485X_REG_CHX_OFFSET_MID(ch)	(AD485X_REG_CHX_OFFSET_LSB(ch) + 0x01)
+#define AD485X_REG_CHX_OFFSET_MSB(ch)	(AD485X_REG_CHX_OFFSET_MID(ch) + 0x01)
+#define AD485X_REG_CHX_GAIN(ch)		(AD485X_REG_CHX_OFFSET(ch) + 0x03)
+#define AD485X_REG_CHX_GAIN_LSB(ch)	AD485X_REG_CHX_GAIN(ch)
+#define AD485X_REG_CHX_GAIN_MSB(ch)	(AD485X_REG_CHX_GAIN(ch) + 0x01)
+#define AD485X_REG_CHX_PHASE(ch)	(AD485X_REG_CHX_GAIN(ch) + 0x02)
+#define AD485X_REG_CHX_PHASE_LSB(ch)	AD485X_REG_CHX_PHASE(ch)
+#define AD485X_REG_CHX_PHASE_MSB(ch)	(AD485X_REG_CHX_PHASE_LSB(ch) + 0x01)
+
+#define AD485X_REG_TESTPAT_0(c)		(0x38 + (c) * 0x12)
+#define AD485X_REG_TESTPAT_1(c)		(0x39 + (c) * 0x12)
+#define AD485X_REG_TESTPAT_2(c)		(0x3A + (c) * 0x12)
+#define AD485X_REG_TESTPAT_3(c)		(0x3B + (c) * 0x12)
+
+#define AD485X_SW_RESET			(BIT(7) | BIT(0))
+#define AD485X_SDO_ENABLE		BIT(4)
+#define AD485X_SINGLE_INSTRUCTION	BIT(7)
+#define AD485X_ECHO_CLOCK_MODE		BIT(0)
+
+#define AD485X_PACKET_FORMAT_0		0
+#define AD485X_PACKET_FORMAT_1		1
+#define AD485X_PACKET_FORMAT_MASK	GENMASK(1, 0)
+#define AD485X_OS_EN			BIT(7)
+
+#define AD485X_TEST_PAT			BIT(2)
+
+#define AD4858_PACKET_SIZE_20		0
+#define AD4858_PACKET_SIZE_24		1
+#define AD4858_PACKET_SIZE_32		2
+
+#define AD4857_PACKET_SIZE_16		0
+#define AD4857_PACKET_SIZE_24		1
+
+#define AD485X_TESTPAT_0_DEFAULT	0x2A
+#define AD485X_TESTPAT_1_DEFAULT	0x3C
+#define AD485X_TESTPAT_2_DEFAULT	0xCE
+#define AD485X_TESTPAT_3_DEFAULT(c)	(0x0A + (0x10 * (c)))
+
+#define AD485X_SOFTSPAN_0V_2V5		0
+#define AD485X_SOFTSPAN_N2V5_2V5	1
+#define AD485X_SOFTSPAN_0V_5V		2
+#define AD485X_SOFTSPAN_N5V_5V		3
+#define AD485X_SOFTSPAN_0V_6V25		4
+#define AD485X_SOFTSPAN_N6V25_6V25	5
+#define AD485X_SOFTSPAN_0V_10V		6
+#define AD485X_SOFTSPAN_N10V_10V	7
+#define AD485X_SOFTSPAN_0V_12V5		8
+#define AD485X_SOFTSPAN_N12V5_12V5	9
+#define AD485X_SOFTSPAN_0V_20V		10
+#define AD485X_SOFTSPAN_N20V_20V	11
+#define AD485X_SOFTSPAN_0V_25V		12
+#define AD485X_SOFTSPAN_N25V_25V	13
+#define AD485X_SOFTSPAN_0V_40V		14
+#define AD485X_SOFTSPAN_N40V_40V	15
+
+#define AD485X_MAX_LANES		8
+#define AD485X_MAX_IODELAY		32
+
+#define AD485X_T_CNVH_NS		40
+
+#define AD4858_PROD_ID			0x60
+#define AD4857_PROD_ID			0x61
+#define AD4856_PROD_ID			0x62
+#define AD4855_PROD_ID			0x63
+#define AD4854_PROD_ID			0x64
+#define AD4853_PROD_ID			0x65
+#define AD4852_PROD_ID			0x66
+#define AD4851_PROD_ID			0x67
+#define AD4858I_PROD_ID			0x6F
+
+struct ad485x_chip_info {
+	const char *name;
+	unsigned int product_id;
+	const unsigned int (*scale_table)[2];
+	int num_scales;
+	const int *offset_table;
+	int num_offset;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned long throughput;
+	unsigned int resolution;
+};
+
+struct ad485x_state {
+	struct spi_device *spi;
+	struct pwm_device *cnv;
+	struct iio_backend *back;
+	/*
+	 * Synchronize access to members the of driver state, and ensure
+	 * atomicity of consecutive regmap operations.
+	 */
+	struct mutex lock;
+	struct regmap *regmap;
+	const struct ad485x_chip_info *info;
+	struct gpio_desc *pd_gpio;
+	unsigned long sampling_freq;
+	unsigned int (*scales)[2];
+	int *offsets;
+};
+
+static int ad485x_reg_access(struct iio_dev *indio_dev,
+			     unsigned int reg,
+			     unsigned int writeval,
+			     unsigned int *readval)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+
+	if (readval)
+		return regmap_read(st->regmap, reg, readval);
+
+	return regmap_write(st->regmap, reg, writeval);
+}
+
+static int ad485x_set_sampling_freq(struct ad485x_state *st, unsigned int freq)
+{
+	struct pwm_state cnv_state = {
+		.duty_cycle = AD485X_T_CNVH_NS,
+		.enabled = true,
+	};
+	int ret;
+
+	freq = clamp(freq, 0, st->info->throughput);
+
+	cnv_state.period = DIV_ROUND_CLOSEST_ULL(GIGA, freq);
+
+	ret = pwm_apply_might_sleep(st->cnv, &cnv_state);
+	if (ret)
+		return ret;
+
+	st->sampling_freq = freq;
+
+	return 0;
+}
+
+static int ad485x_setup(struct ad485x_state *st)
+{
+	unsigned int product_id;
+	int ret;
+
+	ret = ad485x_set_sampling_freq(st, HZ_PER_MHZ);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
+			   AD485X_SW_RESET);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_B,
+			   AD485X_SINGLE_INSTRUCTION);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD485X_REG_INTERFACE_CONFIG_A,
+			   AD485X_SDO_ENABLE);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD485X_REG_PRODUCT_ID_L, &product_id);
+	if (ret)
+		return ret;
+
+	if (product_id != st->info->product_id)
+		dev_info(&st->spi->dev, "Unknown product ID: 0x%02X\n",
+			 product_id);
+
+	ret = regmap_write(st->regmap, AD485X_REG_DEVICE_CTRL,
+			   AD485X_ECHO_CLOCK_MODE);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD485X_REG_PACKET, 0);
+}
+
+static int ad485x_find_opt(bool *field, u32 size, u32 *ret_start)
+{
+	unsigned int i, cnt = 0, max_cnt = 0, max_start = 0;
+	int start;
+
+	for (i = 0, start = -1; i < size; i++) {
+		if (field[i] == 0) {
+			if (start == -1)
+				start = i;
+			cnt++;
+		} else {
+			if (cnt > max_cnt) {
+				max_cnt = cnt;
+				max_start = start;
+			}
+			start = -1;
+			cnt = 0;
+		}
+	}
+
+	if (cnt > max_cnt) {
+		max_cnt = cnt;
+		max_start = start;
+	}
+
+	if (!max_cnt)
+		return -ENOENT;
+
+	*ret_start = max_start;
+
+	return max_cnt;
+}
+
+static int ad485x_calibrate(struct ad485x_state *st)
+{
+	unsigned int opt_delay, lane_num, delay, i, s, c;
+	enum iio_backend_interface_type interface_type;
+	bool pn_status[AD485X_MAX_LANES][AD485X_MAX_IODELAY];
+	int ret;
+
+	ret = iio_backend_interface_type_get(st->back, &interface_type);
+	if (ret)
+		return ret;
+
+	if (interface_type == IIO_BACKEND_INTERFACE_CMOS)
+		lane_num = st->info->num_channels;
+	else
+		lane_num = 1;
+
+	if (st->info->resolution == 16) {
+		ret = iio_backend_data_size_set(st->back, 24);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD485X_REG_PACKET,
+				   AD485X_TEST_PAT | AD4857_PACKET_SIZE_24);
+		if (ret)
+			return ret;
+	} else {
+		ret = iio_backend_data_size_set(st->back, 32);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD485X_REG_PACKET,
+				   AD485X_TEST_PAT | AD4858_PACKET_SIZE_32);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < st->info->num_channels; i++) {
+		ret = regmap_write(st->regmap, AD485X_REG_TESTPAT_0(i),
+				   AD485X_TESTPAT_0_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD485X_REG_TESTPAT_1(i),
+				   AD485X_TESTPAT_1_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD485X_REG_TESTPAT_2(i),
+				   AD485X_TESTPAT_2_DEFAULT);
+		if (ret)
+			return ret;
+
+		ret = regmap_write(st->regmap, AD485X_REG_TESTPAT_3(i),
+				   AD485X_TESTPAT_3_DEFAULT(i));
+		if (ret)
+			return ret;
+
+		ret = iio_backend_chan_enable(st->back, i);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < lane_num; i++) {
+		for (delay = 0; delay < AD485X_MAX_IODELAY; delay++) {
+			ret = iio_backend_iodelay_set(st->back, i, delay);
+			if (ret)
+				return ret;
+			ret = iio_backend_chan_status(st->back, i,
+						      &pn_status[i][delay]);
+			if (ret)
+				return ret;
+		}
+	}
+
+	for (i = 0; i < lane_num; i++) {
+		c = ad485x_find_opt(&pn_status[i][0], AD485X_MAX_IODELAY, &s);
+		if (c < 0)
+			return c;
+
+		opt_delay = s + c / 2;
+		ret = iio_backend_iodelay_set(st->back, i, opt_delay);
+		if (ret)
+			return ret;
+	}
+
+	for (i = 0; i < st->info->num_channels; i++) {
+		ret = iio_backend_chan_disable(st->back, i);
+		if (ret)
+			return ret;
+	}
+
+	ret = iio_backend_data_size_set(st->back, 20);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD485X_REG_PACKET, 0);
+}
+
+static const char *const ad4858_packet_fmts[] = {
+	"20-bit", "24-bit", "32-bit",
+};
+
+static const char *const ad4857_packet_fmts[] = {
+	"16-bit", "24-bit",
+};
+
+static int ad485x_set_packet_format(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    unsigned int format)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+	unsigned int val;
+	int ret;
+
+	if (chan->scan_type.realbits == 20)
+		switch (format) {
+		case 0:
+			val = 20;
+			break;
+		case 1:
+			val = 24;
+			break;
+		case 2:
+			val = 32;
+			break;
+		default:
+			return -EINVAL;
+		}
+	else if (chan->scan_type.realbits == 16)
+		switch (format) {
+		case 0:
+			val = 16;
+			break;
+		case 1:
+			val = 24;
+			break;
+		default:
+			return -EINVAL;
+		}
+	else
+		return -EINVAL;
+
+	ret = iio_backend_data_size_set(st->back, val);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD485X_REG_PACKET,
+				  AD485X_PACKET_FORMAT_MASK, format);
+}
+
+static int ad485x_get_packet_format(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+	unsigned int format;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD485X_REG_PACKET, &format);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD485X_PACKET_FORMAT_MASK, format);
+}
+
+static const struct iio_enum ad4858_packet_fmt = {
+	.items = ad4858_packet_fmts,
+	.num_items = ARRAY_SIZE(ad4858_packet_fmts),
+	.set = ad485x_set_packet_format,
+	.get = ad485x_get_packet_format,
+};
+
+static const struct iio_enum ad4857_packet_fmt = {
+	.items = ad4857_packet_fmts,
+	.num_items = ARRAY_SIZE(ad4857_packet_fmts),
+	.set = ad485x_set_packet_format,
+	.get = ad485x_get_packet_format,
+};
+
+static int ad485x_get_calibscale(struct ad485x_state *st, int ch, int *val, int *val2)
+{
+	unsigned int reg_val;
+	int gain;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
+			  &reg_val);
+	if (ret)
+		return ret;
+
+	gain = (reg_val & 0xFF) << 8;
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
+			  &reg_val);
+	if (ret)
+		return ret;
+
+	gain |= reg_val & 0xFF;
+
+	*val = gain;
+	*val2 = 32768;
+
+	return IIO_VAL_FRACTIONAL;
+}
+
+static int ad485x_set_calibscale(struct ad485x_state *st, int ch, int val,
+				 int val2)
+{
+	unsigned long long gain;
+	unsigned int reg_val;
+	int ret;
+
+	if (val < 0 || val2 < 0)
+		return -EINVAL;
+
+	gain = val * MICRO + val2;
+	gain = DIV_U64_ROUND_CLOSEST(gain * 32768, MICRO);
+
+	reg_val = gain;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_write(st->regmap, AD485X_REG_CHX_GAIN_MSB(ch),
+			   reg_val >> 8);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD485X_REG_CHX_GAIN_LSB(ch),
+			    reg_val & 0xFF);
+}
+
+static int ad485x_get_calibbias(struct ad485x_state *st, int ch, int *val)
+{
+	unsigned int lsb, mid, msb;
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch),
+			  &msb);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch),
+			  &mid);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch),
+			  &lsb);
+	if (ret)
+		return ret;
+
+	if (st->info->resolution == 16) {
+		*val = msb << 8;
+		*val |= mid;
+		*val = sign_extend32(*val, 15);
+	} else {
+		*val = msb << 12;
+		*val |= mid << 4;
+		*val |= lsb >> 4;
+		*val = sign_extend32(*val, 19);
+	}
+
+	return IIO_VAL_INT;
+}
+
+static int ad485x_set_calibbias(struct ad485x_state *st, int ch, int val)
+{
+	u8 buf[3] = { 0 };
+	int ret;
+
+	if (val < 0)
+		return -EINVAL;
+
+	if (st->info->resolution == 16)
+		put_unaligned_be16(val, buf);
+	else
+		put_unaligned_be24(val << 4, buf);
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_LSB(ch), buf[2]);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MID(ch), buf[1]);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD485X_REG_CHX_OFFSET_MSB(ch), buf[0]);
+}
+
+static const unsigned int ad485x_scale_table[][2] = {
+	{ 2500, 0x0 },
+	{ 5000, 0x1 },
+	{ 5000, 0x2 },
+	{ 10000, 0x3 },
+	{ 6250, 0x04 },
+	{ 12500, 0x5 },
+	{ 10000, 0x6 },
+	{ 20000, 0x7 },
+	{ 12500, 0x8 },
+	{ 25000, 0x9 },
+	{ 20000, 0xA },
+	{ 40000, 0xB },
+	{ 25000, 0xC },
+	{ 50000, 0xD },
+	{ 40000, 0xE },
+	{ 80000, 0xF },
+};
+
+static const int ad4857_offset_table[] = {
+	0, -32768,
+};
+
+static const int ad4858_offset_table[] = {
+	0, -524288,
+};
+
+static const unsigned int ad485x_scale_avail[] = {
+	2500, 5000, 10000, 6250, 12500, 20000, 25000, 40000, 50000, 80000,
+};
+
+static void __ad485x_get_scale(struct ad485x_state *st, int scale_tbl,
+			       unsigned int *val, unsigned int *val2)
+{
+	const struct ad485x_chip_info *info = st->info;
+	const struct iio_chan_spec *chan = &info->channels[0];
+	unsigned int tmp;
+
+	tmp = (scale_tbl * 1000000ULL) >> chan->scan_type.realbits;
+	*val = tmp / 1000000;
+	*val2 = tmp % 1000000;
+}
+
+static int ad485x_set_scale(struct ad485x_state *st,
+			    const struct iio_chan_spec *chan, int val, int val2)
+{
+	const struct ad485x_chip_info *info = st->info;
+	unsigned int scale_val[2];
+	unsigned int i;
+	bool single_ended = false;
+
+	for (i = 0; i < info->num_scales; i++) {
+		__ad485x_get_scale(st, info->scale_table[i][0],
+				   &scale_val[0], &scale_val[1]);
+		if (scale_val[0] != val || scale_val[1] != val2)
+			continue;
+
+		/*
+		 * Adjust the softspan value (differential or single ended)
+		 * based on the scale value selected and current offset of
+		 * the channel.
+		 *
+		 * If the offset is 0 then continue iterations until finding
+		 * the next matching scale value which always corresponds to
+		 * the single ended mode.
+		 */
+		if (!st->offsets[chan->channel] && !single_ended) {
+			single_ended = true;
+			continue;
+		}
+
+		return regmap_write(st->regmap,
+				    AD485X_REG_CHX_SOFTSPAN(chan->channel),
+				    info->scale_table[i][1]);
+	}
+
+	return -EINVAL;
+}
+
+static int ad485x_get_scale(struct ad485x_state *st,
+			    const struct iio_chan_spec *chan, int *val,
+			    int *val2)
+{
+	const struct ad485x_chip_info *info = st->info;
+	unsigned int i, softspan_val;
+	int ret;
+
+	ret = regmap_read(st->regmap, AD485X_REG_CHX_SOFTSPAN(chan->channel),
+			  &softspan_val);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < info->num_scales; i++) {
+		if (softspan_val == info->scale_table[i][1])
+			break;
+	}
+
+	if (i == info->num_scales)
+		return -EIO;
+
+	__ad485x_get_scale(st, info->scale_table[i][0], val, val2);
+
+	return IIO_VAL_INT_PLUS_MICRO;
+}
+
+static int ad485x_set_offset(struct ad485x_state *st,
+			     const struct iio_chan_spec *chan, int val)
+{
+	guard(mutex)(&st->lock);
+
+	if (val != st->offsets[chan->channel])
+		return 0;
+
+	st->offsets[chan->channel] = val;
+	/* Restore to the default range if offset changes */
+	if (st->offsets[chan->channel])
+		return regmap_write(st->regmap,
+					AD485X_REG_CHX_SOFTSPAN(chan->channel),
+					AD485X_SOFTSPAN_N40V_40V);
+	return regmap_write(st->regmap,
+				AD485X_REG_CHX_SOFTSPAN(chan->channel),
+				AD485X_SOFTSPAN_0V_40V);
+}
+
+static int ad485x_scale_offset_fill(struct ad485x_state *st)
+{
+	unsigned int i, val1, val2;
+
+	st->offsets = devm_kcalloc(&st->spi->dev, st->info->num_channels,
+				   sizeof(*st->offsets), GFP_KERNEL);
+	if (!st->offsets)
+		return -ENOMEM;
+
+	st->scales = devm_kmalloc_array(&st->spi->dev, ARRAY_SIZE(ad485x_scale_avail),
+					sizeof(*st->scales), GFP_KERNEL);
+	if (!st->scales)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(ad485x_scale_avail); i++) {
+		__ad485x_get_scale(st, ad485x_scale_avail[i], &val1, &val2);
+		st->scales[i][0] = val1;
+		st->scales[i][1] = val2;
+	}
+
+	return 0;
+}
+
+static int ad485x_read_raw(struct iio_dev *indio_dev,
+			   const struct iio_chan_spec *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		*val = st->sampling_freq;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad485x_get_calibscale(st, chan->channel, val, val2);
+	case IIO_CHAN_INFO_SCALE:
+		return ad485x_get_scale(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad485x_get_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_OFFSET:
+		scoped_guard(mutex, &st->lock)
+			*val = st->offsets[chan->channel];
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad485x_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad485x_set_sampling_freq(st, val);
+	case IIO_CHAN_INFO_SCALE:
+		return ad485x_set_scale(st, chan, val, val2);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad485x_set_calibscale(st, chan->channel, val, val2);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		return ad485x_set_calibbias(st, chan->channel, val);
+	case IIO_CHAN_INFO_OFFSET:
+		return ad485x_set_offset(st, chan, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad485x_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+	unsigned int c;
+	int ret;
+
+	for (c = 0; c < st->info->num_channels; c++) {
+		if (test_bit(c, scan_mask))
+			ret = iio_backend_chan_enable(st->back, c);
+		else
+			ret = iio_backend_chan_disable(st->back, c);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad485x_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     const int **vals, int *type, int *length,
+			     long mask)
+{
+	struct ad485x_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_SCALE:
+		*vals = (const int *)st->scales;
+		*type = IIO_VAL_INT_PLUS_MICRO;
+		/* Values are stored in a 2D matrix */
+		*length = ARRAY_SIZE(ad485x_scale_avail) * 2;
+		return IIO_AVAIL_LIST;
+	case IIO_CHAN_INFO_OFFSET:
+		*vals = st->info->offset_table;
+		*type = IIO_VAL_INT;
+		*length = st->info->num_offset;
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define AD485X_IIO_CHANNEL(index, real, storage, info)			\
+{									\
+	.type = IIO_VOLTAGE,						\
+	.ext_info = info,						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE) |		\
+		BIT(IIO_CHAN_INFO_CALIBBIAS) |				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
+	.info_mask_shared_by_type_available =				\
+		BIT(IIO_CHAN_INFO_SCALE) |				\
+		BIT(IIO_CHAN_INFO_OFFSET),				\
+	.indexed = 1,							\
+	.channel = index,						\
+	.scan_index = index,						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = real,					\
+		.storagebits = storage,					\
+	},								\
+}
+
+static struct iio_chan_spec_ext_info ad4858_ext_info[] = {
+	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
+	IIO_ENUM_AVAILABLE("packet_format",
+			   IIO_SHARED_BY_ALL, &ad4858_packet_fmt),
+	{}
+};
+
+static struct iio_chan_spec_ext_info ad4857_ext_info[] = {
+	IIO_ENUM("packet_format", IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
+	IIO_ENUM_AVAILABLE("packet_format",
+			   IIO_SHARED_BY_ALL, &ad4857_packet_fmt),
+	{}
+};
+
+static const struct iio_chan_spec ad4858_channels[] = {
+	AD485X_IIO_CHANNEL(0, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(1, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(2, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(3, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(4, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(5, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(6, 20, 32, ad4858_ext_info),
+	AD485X_IIO_CHANNEL(7, 20, 32, ad4858_ext_info),
+};
+
+static const struct iio_chan_spec ad4857_channels[] = {
+	AD485X_IIO_CHANNEL(0, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(1, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(2, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(3, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(4, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(5, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(6, 16, 16, ad4857_ext_info),
+	AD485X_IIO_CHANNEL(7, 16, 16, ad4857_ext_info),
+};
+
+static const struct ad485x_chip_info ad4858_info = {
+	.name = "ad4858",
+	.product_id = AD4858_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4858_offset_table,
+	.num_offset = ARRAY_SIZE(ad4858_offset_table),
+	.channels = ad4858_channels,
+	.num_channels = ARRAY_SIZE(ad4858_channels),
+	.throughput = 1 * MEGA,
+	.resolution = 20,
+};
+
+static const struct ad485x_chip_info ad4857_info = {
+	.name = "ad4857",
+	.product_id = AD4857_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4857_offset_table,
+	.num_offset = ARRAY_SIZE(ad4857_offset_table),
+	.channels = ad4857_channels,
+	.num_channels = ARRAY_SIZE(ad4857_channels),
+	.throughput = 1 * MEGA,
+	.resolution = 16,
+};
+
+static const struct ad485x_chip_info ad4856_info = {
+	.name = "ad4856",
+	.product_id = AD4856_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4858_offset_table,
+	.num_offset = ARRAY_SIZE(ad4858_offset_table),
+	.channels = ad4858_channels,
+	.num_channels = ARRAY_SIZE(ad4858_channels),
+	.throughput = 250 * KILO,
+	.resolution = 20,
+};
+
+static const struct ad485x_chip_info ad4855_info = {
+	.name = "ad4855",
+	.product_id = AD4855_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4857_offset_table,
+	.num_offset = ARRAY_SIZE(ad4857_offset_table),
+	.channels = ad4857_channels,
+	.num_channels = ARRAY_SIZE(ad4857_channels),
+	.throughput = 250 * KILO,
+	.resolution = 16,
+};
+
+static const struct ad485x_chip_info ad4854_info = {
+	.name = "ad4854",
+	.product_id = AD4854_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4858_offset_table,
+	.num_offset = ARRAY_SIZE(ad4858_offset_table),
+	.channels = ad4858_channels,
+	.num_channels = ARRAY_SIZE(ad4858_channels),
+	.throughput = 1 * MEGA,
+	.resolution = 20,
+};
+
+static const struct ad485x_chip_info ad4853_info = {
+	.name = "ad4853",
+	.product_id = AD4853_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4857_offset_table,
+	.num_offset = ARRAY_SIZE(ad4857_offset_table),
+	.channels = ad4857_channels,
+	.num_channels = ARRAY_SIZE(ad4857_channels),
+	.throughput = 1 * MEGA,
+	.resolution = 16,
+};
+
+static const struct ad485x_chip_info ad4852_info = {
+	.name = "ad4852",
+	.product_id = AD4852_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4858_offset_table,
+	.num_offset = ARRAY_SIZE(ad4858_offset_table),
+	.channels = ad4858_channels,
+	.num_channels = ARRAY_SIZE(ad4858_channels),
+	.throughput = 250 * KILO,
+	.resolution = 20,
+};
+
+static const struct ad485x_chip_info ad4851_info = {
+	.name = "ad4851",
+	.product_id = AD4851_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4857_offset_table,
+	.num_offset = ARRAY_SIZE(ad4857_offset_table),
+	.channels = ad4857_channels,
+	.num_channels = ARRAY_SIZE(ad4857_channels),
+	.throughput = 250 * KILO,
+	.resolution = 16,
+};
+
+static const struct ad485x_chip_info ad4858i_info = {
+	.name = "ad4858i",
+	.product_id = AD4858I_PROD_ID,
+	.scale_table = ad485x_scale_table,
+	.num_scales = ARRAY_SIZE(ad485x_scale_table),
+	.offset_table = ad4858_offset_table,
+	.num_offset = ARRAY_SIZE(ad4858_offset_table),
+	.channels = ad4858_channels,
+	.num_channels = ARRAY_SIZE(ad4858_channels),
+	.throughput = 1 * MEGA,
+	.resolution = 20,
+};
+
+static const struct iio_info ad485x_info = {
+	.debugfs_reg_access = ad485x_reg_access,
+	.read_raw = ad485x_read_raw,
+	.write_raw = ad485x_write_raw,
+	.update_scan_mode = ad485x_update_scan_mode,
+	.read_avail = ad485x_read_avail,
+};
+
+static const struct regmap_config regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+};
+
+static const char * const ad485x_power_supplies[] = {
+	"vcc",	"vdd", "vee", "vio",
+};
+
+static int ad485x_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad485x_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	ret = devm_mutex_init(&spi->dev, &st->lock);
+	if (ret)
+		return ret;
+
+	ret = devm_regulator_bulk_get_enable(&spi->dev,
+					     ARRAY_SIZE(ad485x_power_supplies),
+					     ad485x_power_supplies);
+	if (ret)
+		return dev_err_probe(&spi->dev, ret,
+				     "failed to get and enable supplies\n");
+
+	ret = devm_regulator_get_enable_optional(&spi->dev, "vddh");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get vddh voltage\n");
+
+	ret = devm_regulator_get_enable_optional(&spi->dev, "vddl");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(&spi->dev, ret, "failed to get vddl voltage\n");
+
+	st->pd_gpio = devm_gpiod_get_optional(&spi->dev, "pd", GPIOD_OUT_LOW);
+	if (IS_ERR(st->pd_gpio))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->pd_gpio),
+				     "Error on requesting pd GPIO\n");
+
+	st->cnv = devm_pwm_get(&spi->dev, NULL);
+	if (IS_ERR(st->cnv))
+		return PTR_ERR(st->cnv);
+
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
+	st->regmap = devm_regmap_init_spi(spi, &regmap_config);
+	if (IS_ERR(st->regmap))
+		return PTR_ERR(st->regmap);
+
+	ret = ad485x_scale_offset_fill(st);
+	if (ret)
+		return ret;
+
+	ret = ad485x_setup(st);
+	if (ret)
+		return ret;
+
+	indio_dev->name = st->info->name;
+	indio_dev->channels = st->info->channels;
+	indio_dev->num_channels = st->info->num_channels;
+	indio_dev->info = &ad485x_info;
+
+	st->back = devm_iio_backend_get(&spi->dev, NULL);
+	if (IS_ERR(st->back))
+		return PTR_ERR(st->back);
+
+	ret = devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_iio_backend_enable(&spi->dev, st->back);
+	if (ret)
+		return ret;
+
+	ret = ad485x_calibrate(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad485x_of_match[] = {
+	{ .compatible = "adi,ad4858", .data = &ad4858_info, },
+	{ .compatible = "adi,ad4857", .data = &ad4857_info, },
+	{ .compatible = "adi,ad4856", .data = &ad4856_info, },
+	{ .compatible = "adi,ad4855", .data = &ad4855_info, },
+	{ .compatible = "adi,ad4854", .data = &ad4854_info, },
+	{ .compatible = "adi,ad4853", .data = &ad4853_info, },
+	{ .compatible = "adi,ad4852", .data = &ad4852_info, },
+	{ .compatible = "adi,ad4851", .data = &ad4851_info, },
+	{ .compatible = "adi,ad4858i", .data = &ad4858i_info, },
+	{}
+};
+
+static const struct spi_device_id ad485x_spi_id[] = {
+	{ "ad4858", (kernel_ulong_t)&ad4858_info },
+	{ "ad4857", (kernel_ulong_t)&ad4857_info },
+	{ "ad4856", (kernel_ulong_t)&ad4856_info },
+	{ "ad4855", (kernel_ulong_t)&ad4855_info },
+	{ "ad4854", (kernel_ulong_t)&ad4854_info },
+	{ "ad4853", (kernel_ulong_t)&ad4853_info },
+	{ "ad4852", (kernel_ulong_t)&ad4852_info },
+	{ "ad4851", (kernel_ulong_t)&ad4851_info },
+	{ "ad4858i", (kernel_ulong_t)&ad4858i_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad485x_spi_id);
+
+static struct spi_driver ad485x_driver = {
+	.probe = ad485x_probe,
+	.driver = {
+		.name   = "ad485x",
+		.of_match_table = ad485x_of_match,
+	},
+	.id_table = ad485x_spi_id,
+};
+module_spi_driver(ad485x_driver);
+
+MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
+MODULE_AUTHOR("Dragos Bogdan <dragos.bogdan@analog.com>");
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD485x DAS driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(IIO_BACKEND);
-- 
2.46.2


