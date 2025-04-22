Return-Path: <linux-pwm+bounces-5655-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBA6A967C4
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D31AB16D29B
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923E027F743;
	Tue, 22 Apr 2025 11:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fLg5fbxe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC927F4F4;
	Tue, 22 Apr 2025 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321748; cv=none; b=LfUtZvXx46obiO8rsGnfZljcav8OjKPHEcWAwluL+IC0fH6As0tjXTf9C3Fl9uWviOgcPTytMh0TruzvkQeZfEqcKhkkDQxYsNdLPXWWBKv/dmJWyc/jPlBjTURB3VLRxJ1oF+Y7eQfyhIREElvgqfNT3jCpEv3D+1YApXIBeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321748; c=relaxed/simple;
	bh=K7JLIEnlHd7CNNSx9ePnmyljb9yiC3gssm9WKJzSCHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=OSRWpLjAKUZgdWH4v2qRhHH5Rzf6tHBqSFnzoWTS39QKpyscPQjTv2E1ZNzJyTcvCf1jtVa5SMfJwPXKtJZex7Pha7shoGPuVekPVyV3FpVKzRlz4sqAPgR8LbuN3eg5TrWrtCu1n+2449Pfg5jHSyZU/ZXAc3WJE1DgJR2Wnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fLg5fbxe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MBCH8i026301;
	Tue, 22 Apr 2025 07:35:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Fn/Kp
	Yn3kbdXSSrfdMoKuKRzO8mK51xUucwNMJ5EM+8=; b=fLg5fbxeyVGyqs6f6SAKs
	CYIVZ0NO1Wb9KXXecdXIUFG0IFKkdWrpGu61WNuWkfaWzBS9zqDDXXMT/fxdLvDO
	BplJ03hXheNOJ+7eqh9DOdAwPDPFEpwi96IUHVlZbuKFMACvjEAjOP0XvcCtsK3x
	32a/XkzyrULkOTu1/lW6A0Na7acLw79eqrSAH9vwcZsR7HRI0g1sl3HCKHv8vSr0
	emVCVYJaANv837d6xnT4QHtcdgRsNtcPtFzzB+wnKNPNJ1Su+3j3RsjRFZMJAoxQ
	ADJFpHLVKevYhYdsbp7KYXeK+wu0cDJSDvHHc8pO+KFNz+k//IVW3cGwUtriGi8F
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4648r6et60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZR23050191
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:27 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 07:35:27 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 22 Apr 2025 07:35:27 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:27 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qs024350;
	Tue, 22 Apr 2025 07:35:20 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 22 Apr 2025 13:34:50 +0200
Subject: [PATCH v2 5/5] iio: adc: add support for ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250422-iio-driver-ad4052-v2-5-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
In-Reply-To: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        "Andy
 Shevchenko" <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=42151;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=K7JLIEnlHd7CNNSx9ePnmyljb9yiC3gssm9WKJzSCHY=;
 b=AfXtVZgCMFXQp+pJlMeox6HxDdW62qrJ/KPwFVY2gGm9o/ht7XB3+rRO9FcqqkH9KYavwGjwO
 32ptq9V7tZ5DTAWs9o36BOO3wZxlQABrsSji2CY+9LMmlWizHJEoLaU
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: JNUunqnmcRxN1eKvbZzkr0tDJkNG21vT
X-Proofpoint-ORIG-GUID: JNUunqnmcRxN1eKvbZzkr0tDJkNG21vT
X-Authority-Analysis: v=2.4 cv=d6z1yQjE c=1 sm=1 tr=0 ts=68077f01 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=rtu05Q2co9eftUu8wvQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 mlxlogscore=999 impostorscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504220087

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit,
successive approximation register (SAR) analog-to-digital converter (ADC)
that enables low-power, high-density data acquisition solutions without
sacrificing precision.
This ADC offers a unique balance of performance and power efficiency,
plus innovative features for seamlessly switching between high-resolution
and low-power modes tailored to the immediate needs of the system.
The AD4052/AD4058/AD4050/AD4056 are ideal for battery-powered,
compact data acquisition and edge sensing applications.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   14 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4052.c | 1425 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1441 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04aa8db44bee418382a2e74cb6b1d03a810bd781..56adb540fa172d5729735acbeaee6c576132cddd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1335,6 +1335,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
 F:	Documentation/iio/ad4052.rst
+F:	drivers/iio/adc/ad4052.c
 
 ANALOG DEVICES INC AD4130 DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index ad06cf5567851ee71f1211ec69d59fd5c1857ee5..68f8ce91320ea6db9377b3442408598a863ab428 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -55,6 +55,20 @@ config AD4030
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4030.
 
+config AD4052
+	tristate "Analog Devices AD4052 Driver"
+	depends on SPI
+	select SPI_OFFLOAD
+	select IIO_BUFFER
+	select IIO_BUFFER_DMAENGINE
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD4052 SPI analog
+	  to digital converters (ADC).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called ad4052.
+
 config AD4130
 	tristate "Analog Device AD4130 ADC Driver"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 07d4b832c42e6352f2a4c956295308f007af0f45..edc0d1809f0cf9fcd65ee2cf72218d0dc3ecacbf 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
+obj-$(CONFIG_AD4052) += ad4052.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
 obj-$(CONFIG_AD4851) += ad4851.o
diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
new file mode 100644
index 0000000000000000000000000000000000000000..f412f0884bab4f500091f6c7ca761967c8f6e3b6
--- /dev/null
+++ b/drivers/iio/adc/ad4052.c
@@ -0,0 +1,1425 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD4052 SPI ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
+
+#define AD4052_REG_INTERFACE_CONFIG_A		0x00
+#define AD4052_REG_DEVICE_CONFIG		0x02
+#define AD4052_REG_PROD_ID_1			0x05
+#define AD4052_REG_DEVICE_GRADE			0x06
+#define AD4052_REG_SCRATCH_PAD			0x0A
+#define AD4052_REG_VENDOR_H			0x0D
+#define AD4052_REG_STREAM_MODE			0x0E
+#define AD4052_REG_INTERFACE_STATUS		0x11
+#define AD4052_REG_MODE_SET			0x20
+#define AD4052_REG_ADC_MODES			0x21
+#define AD4052_REG_AVG_CONFIG			0x23
+#define AD4052_REG_GP_CONF			0x24
+#define AD4052_REG_INTR_CONF			0x25
+#define AD4052_REG_TIMER_CONFIG			0x27
+#define AD4052_REG_MAX_LIMIT			0x29
+#define AD4052_REG_MIN_LIMIT			0x2B
+#define AD4052_REG_MAX_HYST			0x2C
+#define AD4052_REG_MIN_HYST			0x2D
+#define AD4052_REG_MON_VAL			0x2F
+#define AD4052_REG_FUSE_CRC			0x40
+#define AD4052_REG_DEVICE_STATUS		0x41
+#define AD4052_REG_MIN_SAMPLE			0x45
+#define AD4052_MAX_REG				0x45
+#define AD4052_ADC_MODES_MODE_MSK		GENMASK(1, 0)
+#define AD4052_GP_CONF_MODE_MSK_0		GENMASK(2, 0)
+#define AD4052_GP_CONF_MODE_MSK_1		GENMASK(6, 4)
+#define AD4052_INTR_CONF_EN_MSK_0		GENMASK(1, 0)
+#define AD4052_INTR_CONF_EN_MSK_1		GENMASK(5, 4)
+#define AD4052_MODE_SET_ENTER_ADC		BIT(0)
+#define AD4052_ADC_MODES_DATA_FORMAT		BIT(7)
+#define AD4052_DEVICE_CONFIG_POWER_MODE_MSK	GENMASK(1, 0)
+#define AD4052_DEVICE_CONFIG_LOW_POWER_MODE	3
+#define AD4052_DEVICE_STATUS_DEVICE_RESET	BIT(6)
+#define AD4052_TIMER_CONFIG_FS_MASK		GENMASK(7, 4)
+#define AD4052_TIMER_CONFIG_300KSPS		0x2
+
+#define AD4052_SPI_VENDOR	0x0456
+
+#define AD4050_MAX_AVG		0x7
+#define AD4052_MAX_AVG		0xB
+#define AD4052_MAX_RATE(x)	((x) == AD4052_500KSPS ? 500000 : 2000000)
+#define AD4052_FS_OFFSET(g)	((g) == AD4052_500KSPS ? 2 : 0)
+#define AD4052_FS(g)		((&ad4052_conversion_freqs[AD4052_FS_OFFSET(g)]))
+#define AD4052_FS_LEN(g)	(ARRAY_SIZE(ad4052_conversion_freqs) - (AD4052_FS_OFFSET(g)))
+#define AD4052_T_CNVH_NS	10
+
+enum ad4052_grade {
+	AD4052_2MSPS,
+	AD4052_500KSPS,
+};
+
+enum ad4052_operation_mode {
+	AD4052_SAMPLE_MODE = 0,
+	AD4052_BURST_AVERAGING_MODE = 1,
+	AD4052_MONITOR_MODE = 3,
+};
+
+enum ad4052_gp_mode {
+	AD4052_GP_DISABLED,
+	AD4052_GP_INTR,
+	AD4052_GP_DRDY,
+};
+
+enum ad4052_interrupt_en {
+	AD4052_INTR_EN_NEITHER,
+	AD4052_INTR_EN_MIN,
+	AD4052_INTR_EN_MAX,
+	AD4052_INTR_EN_EITHER,
+};
+
+struct ad4052_chip_info {
+	const struct iio_chan_spec channels[1];
+	const struct iio_chan_spec offload_channels[1];
+	const char *name;
+	u16 prod_id;
+	u8 max_avg;
+};
+
+enum {
+	AD4052_SCAN_TYPE_SAMPLE,
+	AD4052_SCAN_TYPE_BURST_AVG,
+	AD4052_SCAN_TYPE_OFFLOAD_SAMPLE,
+	AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG,
+};
+
+static const struct iio_scan_type ad4052_scan_type_12_s[] = {
+	[AD4052_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+static const struct iio_scan_type ad4052_scan_type_16_s[] = {
+	[AD4052_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 16,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG] = {
+		.sign = 's',
+		.realbits = 24,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+};
+
+struct ad4052_state {
+	const struct ad4052_bus_ops *ops;
+	const struct ad4052_chip_info *chip;
+	enum ad4052_operation_mode mode;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
+	struct spi_device *spi;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
+	struct pwm_device *cnv_pwm;
+	struct spi_transfer xfer;
+	struct spi_message msg;
+	struct gpio_desc *cnv_gp;
+	struct completion completion;
+	struct regmap *regmap;
+	u16 oversampling_frequency;
+	u16 events_frequency;
+	bool wait_event;
+	int gp1_irq;
+	u8 data_format;
+	u8 grade;
+	union {
+		__be16 d16;
+		__be32 d32;
+	} __aligned(IIO_DMA_MINALIGN);
+	u8 buf_reset_pattern[18];
+};
+
+static const struct regmap_range ad4052_regmap_rd_ranges[] = {
+	regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_GRADE),
+	regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_INTERFACE_STATUS),
+	regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
+	regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_MIN_SAMPLE),
+};
+
+static const struct regmap_access_table ad4052_regmap_rd_table = {
+	.yes_ranges = ad4052_regmap_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_rd_ranges),
+};
+
+static const struct regmap_range ad4052_regmap_wr_ranges[] = {
+	regmap_reg_range(AD4052_REG_INTERFACE_CONFIG_A, AD4052_REG_DEVICE_CONFIG),
+	regmap_reg_range(AD4052_REG_SCRATCH_PAD, AD4052_REG_SCRATCH_PAD),
+	regmap_reg_range(AD4052_REG_STREAM_MODE, AD4052_REG_INTERFACE_STATUS),
+	regmap_reg_range(AD4052_REG_MODE_SET, AD4052_REG_MON_VAL),
+	regmap_reg_range(AD4052_REG_FUSE_CRC, AD4052_REG_DEVICE_STATUS),
+};
+
+static const struct regmap_access_table ad4052_regmap_wr_table = {
+	.yes_ranges = ad4052_regmap_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_wr_ranges),
+};
+
+static const struct iio_event_spec ad4052_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE)
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS)
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS)
+	}
+};
+
+static const char *const ad4052_conversion_freqs[] = {
+	"2000000", "1000000", "300000", "100000", "33300",
+	"10000", "3000", "500", "333", "250", "200",
+	"166", "140", "124", "111",
+};
+
+static int ad4052_conversion_frequency_set(struct ad4052_state *st, u8 val)
+{
+	val += AD4052_FS_OFFSET(st->grade);
+	return regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
+			    FIELD_PREP(AD4052_TIMER_CONFIG_FS_MASK, val));
+}
+
+static int ad4052_oversampling_frequency_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	return st->oversampling_frequency - AD4052_FS_OFFSET(st->grade);
+}
+
+static int ad4052_oversampling_frequency_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	val += AD4052_FS_OFFSET(st->grade);
+	st->oversampling_frequency = val;
+
+	iio_device_release_direct(indio_dev);
+	return 0;
+}
+
+static ssize_t ad4052_events_frequency_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sprintf(buf, "%s\n", ad4052_conversion_freqs[st->events_frequency]);
+}
+
+static ssize_t ad4052_events_frequency_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf,
+					     size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	ret = __sysfs_match_string(AD4052_FS(st->grade),
+				   AD4052_FS_LEN(st->grade), buf);
+	if (ret >= 0)
+		st->events_frequency = ret;
+
+	iio_device_release_direct(indio_dev);
+
+	return ret < 0 ? ret : len;
+}
+
+static ssize_t ad4052_events_frequency_available_show(struct device *dev,
+						      struct device_attribute *attr,
+						      char *buf)
+{
+	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
+	int len = 0;
+
+	for (u8 i = AD4052_FS_OFFSET(st->grade);
+	     i < AD4052_FS_LEN(st->grade); i++)
+		len += sprintf(buf + len, "%s ", ad4052_conversion_freqs[i]);
+
+	return sprintf(buf + len, "\n") + len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644,
+		       ad4052_events_frequency_show,
+		       ad4052_events_frequency_store, 0);
+
+static IIO_DEVICE_ATTR(sampling_frequency_available, 0444,
+		       ad4052_events_frequency_available_show,
+		       NULL, 0);
+
+static struct attribute *ad4052_event_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL,
+};
+
+static const struct attribute_group ad4052_event_attribute_group = {
+	.attrs = ad4052_event_attributes,
+};
+
+static const struct iio_enum AD4052_500KSPS_conversion_freq_enum = {
+	.items = AD4052_FS(AD4052_500KSPS),
+	.num_items = AD4052_FS_LEN(AD4052_500KSPS),
+	.set = ad4052_oversampling_frequency_set,
+	.get = ad4052_oversampling_frequency_get,
+};
+
+static const struct iio_enum AD4052_2MSPS_conversion_freq_enum = {
+	.items = AD4052_FS(AD4052_2MSPS),
+	.num_items = AD4052_FS_LEN(AD4052_2MSPS),
+	.set = ad4052_oversampling_frequency_set,
+	.get = ad4052_oversampling_frequency_get,
+};
+
+#define AD4052_EXT_INFO(grade)						\
+static struct iio_chan_spec_ext_info grade##_ext_info[] = {		\
+	IIO_ENUM("oversampling_frequency", IIO_SHARED_BY_ALL,		\
+		 &grade##_conversion_freq_enum),			\
+	IIO_ENUM_AVAILABLE("oversampling_frequency", IIO_SHARED_BY_ALL,	\
+			   &grade##_conversion_freq_enum),		\
+	{ }								\
+}
+
+AD4052_EXT_INFO(AD4052_2MSPS);
+AD4052_EXT_INFO(AD4052_500KSPS);
+
+#define AD4052_CHAN(bits, grade) {							\
+	.type = IIO_VOLTAGE,								\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+#define AD4052_OFFLOAD_CHAN(bits, grade) {						\
+	.type = IIO_VOLTAGE,								\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+static const struct ad4052_chip_info ad4050_chip_info = {
+	.name = "ad4050",
+	.channels = { AD4052_CHAN(12, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_2MSPS) },
+	.prod_id = 0x70,
+	.max_avg = AD4050_MAX_AVG,
+};
+
+static const struct ad4052_chip_info ad4052_chip_info = {
+	.name = "ad4052",
+	.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_2MSPS) },
+	.prod_id = 0x72,
+	.max_avg = AD4052_MAX_AVG,
+};
+
+static const struct ad4052_chip_info ad4056_chip_info = {
+	.name = "ad4056",
+	.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_500KSPS) },
+	.prod_id = 0x76,
+	.max_avg = AD4050_MAX_AVG,
+};
+
+static const struct ad4052_chip_info ad4058_chip_info = {
+	.name = "ad4058",
+	.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_500KSPS) },
+	.prod_id = 0x78,
+	.max_avg = AD4052_MAX_AVG,
+};
+
+static void ad4052_update_xfer_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	if (IS_ERR(scan_type))
+		return;
+
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
+}
+
+static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	xfer = &st->offload_xfer;
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->len = BITS_TO_BYTES(scan_type->storagebits);
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return spi_optimize_message(st->spi, &st->offload_msg);
+}
+
+static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if ((val) < 1 || (val) > BIT(st->chip->max_avg + 1))
+		return -EINVAL;
+
+	/* 1 disables oversampling */
+	if (val == 1) {
+		st->mode = AD4052_SAMPLE_MODE;
+	} else {
+		val = ilog2(val);
+		st->mode = AD4052_BURST_AVERAGING_MODE;
+		ret = regmap_write(st->regmap, AD4052_REG_AVG_CONFIG, val - 1);
+		if (ret)
+			return ret;
+	}
+
+	ad4052_update_xfer_raw(indio_dev, chan);
+
+	return 0;
+}
+
+static int ad4052_get_oversampling_ratio(struct ad4052_state *st,
+					 unsigned int *val)
+{
+	int ret;
+
+	if (st->mode == AD4052_SAMPLE_MODE) {
+		*val = 1;
+		return 0;
+	}
+
+	ret = regmap_read(st->regmap, AD4052_REG_AVG_CONFIG, val);
+	if (ret)
+		return ret;
+
+	*val = BIT(*val + 1);
+
+	return 0;
+}
+
+static int ad4052_check_ids(struct ad4052_state *st)
+{
+	int ret;
+	u16 val;
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_PROD_ID_1, &st->d16,
+			       sizeof(st->d16));
+	if (ret)
+		return ret;
+
+	val = be16_to_cpu(st->d16);
+	if (val != st->chip->prod_id)
+		dev_info(&st->spi->dev,
+			 "Production ID x%x does not match known values", val);
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_VENDOR_H, &st->d16,
+			       sizeof(st->d16));
+	if (ret)
+		return ret;
+
+	val = be16_to_cpu(st->d16);
+	if (val != AD4052_SPI_VENDOR)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int ad4052_exit_command(struct ad4052_state *st)
+{
+	struct spi_device *spi = st->spi;
+	const u8 val = 0xA8;
+
+	return spi_write(spi, &val, 1);
+}
+
+static int ad4052_set_operation_mode(struct ad4052_state *st,
+				     enum ad4052_operation_mode mode)
+{
+	int ret;
+
+	if (mode == AD4052_BURST_AVERAGING_MODE) {
+		ret = ad4052_conversion_frequency_set(st, st->oversampling_frequency);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_ADC_MODES,
+				 AD4052_ADC_MODES_MODE_MSK, mode);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4052_REG_MODE_SET,
+			    AD4052_MODE_SET_ENTER_ADC);
+}
+
+static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
+{
+	struct pwm_state pwm_st;
+
+	if (freq <= 0 || freq > AD4052_MAX_RATE(st->grade))
+		return -EINVAL;
+
+	pwm_get_state(st->cnv_pwm, &pwm_st);
+	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	return pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
+}
+
+static int ad4052_soft_reset(struct ad4052_state *st)
+{
+	int ret;
+
+	memset(st->buf_reset_pattern, 0xFF, sizeof(st->buf_reset_pattern));
+	for (int i = 0; i < 3; i++)
+		st->buf_reset_pattern[6 * (i + 1) - 1] = 0xFE;
+
+	ret = spi_write(st->spi, st->buf_reset_pattern,
+			sizeof(st->buf_reset_pattern));
+	if (ret)
+		return ret;
+
+	/* Wait AD4052 reset delay */
+	fsleep(5000);
+
+	return 0;
+}
+
+static int ad4052_setup(struct iio_dev *indio_dev,
+			struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	u8 val = FIELD_PREP(AD4052_GP_CONF_MODE_MSK_0, AD4052_GP_INTR) |
+		 FIELD_PREP(AD4052_GP_CONF_MODE_MSK_1, AD4052_GP_DRDY);
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONF,
+				 AD4052_GP_CONF_MODE_MSK_1 | AD4052_GP_CONF_MODE_MSK_0,
+				 val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(AD4052_INTR_CONF_EN_MSK_0, (AD4052_INTR_EN_EITHER)) |
+	      FIELD_PREP(AD4052_INTR_CONF_EN_MSK_1, (AD4052_INTR_EN_NEITHER));
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_INTR_CONF,
+				 AD4052_INTR_CONF_EN_MSK_0 | AD4052_INTR_CONF_EN_MSK_1,
+				 val);
+	if (ret)
+		return ret;
+
+	val = 0;
+	if (scan_type->sign == 's')
+		val |= AD4052_ADC_MODES_DATA_FORMAT;
+
+	st->data_format = val;
+
+	if (st->grade == AD4052_500KSPS) {
+		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
+				   FIELD_PREP(AD4052_TIMER_CONFIG_FS_MASK,
+					      AD4052_TIMER_CONFIG_300KSPS));
+		if (ret)
+			return ret;
+	}
+
+	return regmap_write(st->regmap, AD4052_REG_ADC_MODES, val);
+}
+
+static irqreturn_t ad4052_irq_handler_thresh(int irq, void *private)
+{
+	struct iio_dev *indio_dev = private;
+
+	iio_push_event(indio_dev,
+		       IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE, 0,
+					    IIO_EV_TYPE_THRESH,
+					    IIO_EV_DIR_EITHER),
+		       iio_get_time_ns(indio_dev));
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
+{
+	struct ad4052_state *st = private;
+
+	complete(&st->completion);
+
+	return IRQ_HANDLED;
+}
+
+static int ad4052_request_irq(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret = 0;
+
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp0");
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;
+
+	ret = devm_request_threaded_irq(dev, ret, NULL,
+					ad4052_irq_handler_thresh,
+					IRQF_ONESHOT, indio_dev->name,
+					indio_dev);
+	if (ret)
+		return ret;
+
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
+	if (ret <= 0)
+		return ret ? ret : -EINVAL;
+
+	st->gp1_irq = ret;
+	return devm_request_threaded_irq(dev, ret, NULL,
+					 ad4052_irq_handler_drdy,
+					 IRQF_ONESHOT, indio_dev->name,
+					 st);
+}
+
+static const int ad4052_oversampling_avail[] = {
+	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096,
+};
+
+static int ad4052_read_avail(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, const int **vals,
+			     int *type, int *len, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		*vals = ad4052_oversampling_avail;
+		*len = ARRAY_SIZE(ad4052_oversampling_avail);
+		*type = IIO_VAL_INT;
+
+		return IIO_AVAIL_LIST;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+	struct spi_transfer t_cnv = {
+		.len = 0
+	};
+
+	reinit_completion(&st->completion);
+
+	if (st->cnv_gp) {
+		gpiod_set_value_cansleep(st->cnv_gp, 1);
+		gpiod_set_value_cansleep(st->cnv_gp, 0);
+	} else {
+		ret = spi_sync_transfer(spi, &t_cnv, 1);
+		if (ret)
+			return ret;
+	}
+	/*
+	 * Single sample read should be used only for oversampling and
+	 * sampling frequency pairs that take less than 1 sec.
+	 */
+	ret = wait_for_completion_timeout(&st->completion,
+					  msecs_to_jiffies(1000));
+	if (!ret)
+		return -ETIMEDOUT;
+
+	ret = spi_sync_transfer(spi, &st->xfer, 1);
+	if (ret)
+		return ret;
+
+	if (st->xfer.len == 2) {
+		*val = be16_to_cpu(st->d16);
+		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
+			*val = sign_extend32(*val, 15);
+	} else {
+		*val = be32_to_cpu(st->d32);
+		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
+			*val = sign_extend32(*val, 23);
+	}
+
+	return ret;
+}
+
+static int ad4052_read_chan_raw(struct iio_dev *indio_dev, int *val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_error;
+
+	ret = __ad4052_read_chan_raw(st, val);
+	if (ret)
+		goto out_error;
+
+	ret = ad4052_exit_command(st);
+
+out_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+	return ret;
+}
+
+static int ad4052_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long mask)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct pwm_state pwm_st;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		ret = ad4052_read_chan_raw(indio_dev, val);
+		if (ret)
+			goto out_release;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ad4052_get_oversampling_ratio(st, val);
+		if (ret)
+			goto out_release;
+		ret = IIO_VAL_INT;
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = pwm_get_state_hw(st->cnv_pwm, &pwm_st);
+		if (ret)
+			goto out_release;
+
+		if (!pwm_st.enabled)
+			pwm_get_state(st->cnv_pwm, &pwm_st);
+
+		*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, pwm_st.period);
+
+		ret = IIO_VAL_INT;
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		ret = ad4052_set_oversampling_ratio(indio_dev, chan, val);
+		break;
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		ret = ad4052_set_sampling_freq(st, val);
+		break;
+	default:
+		ret = -EINVAL;
+	}
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_monitor_mode_enable(struct ad4052_state *st)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_conversion_frequency_set(st, st->events_frequency);
+	if (ret)
+		goto out_error;
+
+	ret = ad4052_set_operation_mode(st, AD4052_MONITOR_MODE);
+	if (ret)
+		goto out_error;
+
+	return ret;
+out_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+	return ret;
+}
+
+static int ad4052_monitor_mode_disable(struct ad4052_state *st)
+{
+	int ret;
+
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	ret = ad4052_exit_command(st);
+
+	if (ret)
+		pm_runtime_resume_and_get(&st->spi->dev);
+
+	return ret;
+}
+
+static int ad4052_read_event_config(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	return st->wait_event;
+}
+
+static int ad4052_write_event_config(struct iio_dev *indio_dev,
+				     const struct iio_chan_spec *chan,
+				     enum iio_event_type type,
+				     enum iio_event_direction dir,
+				     bool state)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret = -EBUSY;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event == state) {
+		iio_device_release_direct(indio_dev);
+		return 0;
+	}
+
+	if (state)
+		ret = ad4052_monitor_mode_enable(st);
+	else
+		ret = ad4052_monitor_mode_disable(st);
+
+	if (!ret)
+		st->wait_event = state;
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_read_event_value(struct iio_dev *indio_dev,
+				   const struct iio_chan_spec *chan,
+				   enum iio_event_type type,
+				   enum iio_event_direction dir,
+				   enum iio_event_info info, int *val,
+				   int *val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	u8 reg, size = 1;
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = AD4052_REG_MAX_LIMIT;
+		else
+			reg = AD4052_REG_MIN_LIMIT;
+		size = 2;
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		if (dir == IIO_EV_DIR_RISING)
+			reg = AD4052_REG_MAX_HYST;
+		else
+			reg = AD4052_REG_MIN_HYST;
+		break;
+	default:
+		ret = -EINVAL;
+		goto out_release;
+	}
+
+	ret = regmap_bulk_read(st->regmap, reg, &st->d32, size);
+	if (ret)
+		goto out_release;
+
+	if (reg == AD4052_REG_MAX_LIMIT || reg == AD4052_REG_MIN_LIMIT) {
+		*val = be16_to_cpu(st->d16);
+		if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT)
+			*val = sign_extend32(*val, 11);
+	} else {
+		*val = be32_to_cpu(st->d32);
+	}
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : IIO_VAL_INT;
+}
+
+static int ad4052_write_event_value(struct iio_dev *indio_dev,
+				    const struct iio_chan_spec *chan,
+				    enum iio_event_type type,
+				    enum iio_event_direction dir,
+				    enum iio_event_info info, int val,
+				    int val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret = -EINVAL;
+	u8 reg, size = 1;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			if (st->data_format & AD4052_ADC_MODES_DATA_FORMAT) {
+				if (val > 2047 || val < -2048)
+					goto out_release;
+			} else if (val > 4095 || val < 0) {
+				goto out_release;
+			}
+			if (dir == IIO_EV_DIR_RISING)
+				reg = AD4052_REG_MAX_LIMIT;
+			else
+				reg = AD4052_REG_MIN_LIMIT;
+			size = 2;
+			st->d16 = cpu_to_be16(val);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			if (val & BIT(7))
+				goto out_release;
+			if (dir == IIO_EV_DIR_RISING)
+				reg = AD4052_REG_MAX_HYST;
+			else
+				reg = AD4052_REG_MIN_HYST;
+			st->d16 = cpu_to_be16(val >> 8);
+			break;
+		default:
+			goto out_release;
+		}
+		break;
+	default:
+		goto out_release;
+	}
+
+	ret = regmap_bulk_write(st->regmap, reg, &st->d16, size);
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	int ret;
+
+	if (st->wait_event)
+		return -EBUSY;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_error;
+
+	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
+	if (ret)
+		goto out_error;
+
+	/* SPI Offload handles the data ready irq */
+	disable_irq(st->gp1_irq);
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+	if (ret)
+		goto out_offload_error;
+
+	ret = pwm_enable(st->cnv_pwm);
+	if (ret)
+		goto out_pwm_error;
+
+	return 0;
+
+out_pwm_error:
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+out_offload_error:
+	enable_irq(st->gp1_irq);
+	spi_unoptimize_message(&st->offload_msg);
+	ad4052_exit_command(st);
+out_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static int ad4052_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	pwm_disable(st->cnv_pwm);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+	enable_irq(st->gp1_irq);
+
+	ret = ad4052_exit_command(st);
+
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4052_buffer_setup_ops = {
+	.postenable = &ad4052_buffer_postenable,
+	.predisable = &ad4052_buffer_predisable,
+};
+
+static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
+				     unsigned int writeval, unsigned int *readval)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		iio_device_release_direct(indio_dev);
+		return -EBUSY;
+	}
+
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	if (iio_buffer_enabled(indio_dev))
+		return st->mode == AD4052_BURST_AVERAGING_MODE ?
+				   AD4052_SCAN_TYPE_OFFLOAD_BURST_AVG :
+				   AD4052_SCAN_TYPE_OFFLOAD_SAMPLE;
+
+	return st->mode == AD4052_BURST_AVERAGING_MODE ?
+			   AD4052_SCAN_TYPE_BURST_AVG :
+			   AD4052_SCAN_TYPE_SAMPLE;
+}
+
+static const struct iio_info ad4052_info = {
+	.read_raw = ad4052_read_raw,
+	.write_raw = ad4052_write_raw,
+	.read_avail = ad4052_read_avail,
+	.read_event_config = &ad4052_read_event_config,
+	.write_event_config = &ad4052_write_event_config,
+	.read_event_value = &ad4052_read_event_value,
+	.write_event_value = &ad4052_write_event_value,
+	.event_attrs = &ad4052_event_attribute_group,
+	.get_current_scan_type = &ad4052_get_current_scan_type,
+	.debugfs_reg_access = &ad4052_debugfs_reg_access,
+};
+
+static const struct regmap_config ad4052_regmap_config = {
+	.name = "ad4052",
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = AD4052_MAX_REG,
+	.rd_table = &ad4052_regmap_rd_table,
+	.wr_table = &ad4052_regmap_wr_table,
+	.read_flag_mask = BIT(7),
+	.can_sleep = true,
+};
+
+static const struct spi_offload_config ad4052_offload_config = {
+	.capability_flags = SPI_OFFLOAD_CAP_TRIGGER |
+			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
+};
+
+static void ad4052_pwm_disable(void *pwm)
+{
+	pwm_disable(pwm);
+}
+
+static bool ad4052_offload_trigger_match(struct spi_offload_trigger *trigger,
+					 enum spi_offload_trigger_type type,
+					 u64 *args, u32 nargs)
+{
+	return type == SPI_OFFLOAD_TRIGGER_DATA_READY;
+}
+
+static const struct spi_offload_trigger_ops ad4052_offload_trigger_ops = {
+	.match = ad4052_offload_trigger_match,
+};
+
+static int ad4052_request_offload(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	struct dma_chan *rx_dma;
+	struct spi_offload_trigger_info trigger_info = {
+		.fwnode = dev_fwnode(dev),
+		.ops = &ad4052_offload_trigger_ops,
+		.priv = st,
+	};
+	struct pwm_state pwm_st;
+	int ret;
+
+	indio_dev->setup_ops = &ad4052_buffer_setup_ops;
+
+	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to register offload trigger\n");
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(st->offload_trigger))
+		return PTR_ERR(st->offload_trigger);
+
+	st->cnv_pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm),
+				     "failed to get CNV PWM\n");
+
+	pwm_init_state(st->cnv_pwm, &pwm_st);
+
+	pwm_st.enabled = false;
+	pwm_st.duty_cycle = AD4052_T_CNVH_NS * 2;
+	pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC,
+					 AD4052_MAX_RATE(st->grade));
+
+	ret = pwm_apply_might_sleep(st->cnv_pwm, &pwm_st);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to apply CNV PWM\n");
+
+	ret = devm_add_action_or_reset(dev, ad4052_pwm_disable, st->cnv_pwm);
+	if (ret)
+		return ret;
+
+	rx_dma = devm_spi_offload_rx_stream_request_dma_chan(dev, st->offload);
+	if (IS_ERR(rx_dma))
+		return PTR_ERR(rx_dma);
+
+	return devm_iio_dmaengine_buffer_setup_with_handle(dev, indio_dev, rx_dma,
+							   IIO_BUFFER_DIRECTION_IN);
+}
+
+static int ad4052_probe(struct spi_device *spi)
+{
+	const struct ad4052_chip_info *chip;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4052_state *st;
+	int ret = 0;
+
+	chip = spi_get_device_match_data(spi);
+	if (!chip)
+		return dev_err_probe(dev, -ENODEV,
+				     "Could not find chip info data\n");
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+	spi_set_drvdata(spi, st);
+	init_completion(&st->completion);
+
+	st->regmap = devm_regmap_init_spi(spi, &ad4052_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	st->mode = AD4052_SAMPLE_MODE;
+	st->wait_event = false;
+	st->chip = chip;
+	st->grade = chip->prod_id <= 0x75 ? AD4052_2MSPS : AD4052_500KSPS;
+	st->oversampling_frequency = AD4052_FS_OFFSET(st->grade);
+	st->events_frequency = AD4052_FS_OFFSET(st->grade);
+
+	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gp))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
+				     "Failed to get cnv gpio\n");
+
+	indio_dev->modes = INDIO_BUFFER_HARDWARE | INDIO_DIRECT_MODE;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad4052_info;
+	indio_dev->name = chip->name;
+
+	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
+	if (IS_ERR(st->offload))
+		return PTR_ERR(st->offload);
+
+	if (ret && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "Failed to get offload\n");
+
+	if (ret == -ENODEV) {
+		st->offload_trigger = NULL;
+		indio_dev->channels = chip->channels;
+	} else {
+		indio_dev->channels = chip->offload_channels;
+		ret = ad4052_request_offload(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure offload\n");
+	}
+
+	st->xfer.rx_buf = &st->d32;
+
+	ret = ad4052_soft_reset(st);
+	if (ret)
+		return dev_err_probe(dev, ret, "AD4052 failed to soft reset\n");
+
+	ret = ad4052_check_ids(st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "AD4052 fields assertions failed\n");
+
+	ret = ad4052_setup(indio_dev, indio_dev->channels);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
+			   AD4052_DEVICE_STATUS_DEVICE_RESET);
+	if (ret)
+		return ret;
+
+	ret = ad4052_request_irq(indio_dev);
+	if (ret)
+		return ret;
+
+	ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
+
+	pm_runtime_set_active(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to enable pm_runtime\n");
+
+	pm_runtime_set_autosuspend_delay(dev, 1000);
+	pm_runtime_use_autosuspend(dev);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static int ad4052_runtime_suspend(struct device *dev)
+{
+	struct ad4052_state *st = dev_get_drvdata(dev);
+
+	return regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
+			    FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK,
+				       AD4052_DEVICE_CONFIG_LOW_POWER_MODE));
+}
+
+static int ad4052_runtime_resume(struct device *dev)
+{
+	struct ad4052_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_CONFIG,
+			   FIELD_PREP(AD4052_DEVICE_CONFIG_POWER_MODE_MSK, 0));
+	return ret;
+}
+
+static DEFINE_RUNTIME_DEV_PM_OPS(ad4052_pm_ops, ad4052_runtime_suspend,
+				 ad4052_runtime_resume, NULL);
+
+static const struct spi_device_id ad4052_id_table[] = {
+	{"ad4050", (kernel_ulong_t)&ad4050_chip_info },
+	{"ad4052", (kernel_ulong_t)&ad4052_chip_info },
+	{"ad4056", (kernel_ulong_t)&ad4056_chip_info },
+	{"ad4058", (kernel_ulong_t)&ad4058_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4052_id_table);
+
+static const struct of_device_id ad4052_of_match[] = {
+	{ .compatible = "adi,ad4050", .data = &ad4050_chip_info },
+	{ .compatible = "adi,ad4052", .data = &ad4052_chip_info },
+	{ .compatible = "adi,ad4056", .data = &ad4056_chip_info },
+	{ .compatible = "adi,ad4058", .data = &ad4058_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad4052_of_match);
+
+static struct spi_driver ad4052_driver = {
+	.driver = {
+		.name = "ad4052",
+		.of_match_table = ad4052_of_match,
+		.pm = pm_ptr(&ad4052_pm_ops),
+	},
+	.probe = ad4052_probe,
+	.id_table = ad4052_id_table,
+};
+module_spi_driver(ad4052_driver);
+
+MODULE_AUTHOR("Jorge Marques <jorge.marques@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD4052");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("IIO_DMAENGINE_BUFFER");

-- 
2.49.0


