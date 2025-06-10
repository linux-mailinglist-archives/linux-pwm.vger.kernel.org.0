Return-Path: <linux-pwm+bounces-6272-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86607AD2EEE
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE63B3549
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DAB2820AD;
	Tue, 10 Jun 2025 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GL0D/Cfb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E5327FD6D;
	Tue, 10 Jun 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540933; cv=none; b=q8gG+T3QKhWT0Sa8ssjelCtSYsD6/Y52FAtGw8LwT3TBq2tjl1ezcyz5GtcjBWg2ArGzgFm5vnGDJcJNdnL51XEkWfdpl9Z3nU/y35Xf5kKIwZxPCxQP2W6NcpcW1SB3d/lwnGOUhyQxO8+zp2Dfy4lSWMuH2SAVBEePvN0rlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540933; c=relaxed/simple;
	bh=nsbwDEaQ87jz0r+Yd4hkac1GFqRNS+p42A3OZyXjPYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Z6LoG37Yyoe0GQ3lADNNRN4JxGY9igXScS6M2vwoiGavwoOQPLMb6zNrReT4JrZT/L771Rzn4tHCAM5Zl0eGsOV6niTTZD2Kfx3Ga35votqg0RN6M4qXqR6UtXmkqQPFELkF/Zy5eTIPZONf6SsLRrh2C9L96tTXb/FT4UE6D4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GL0D/Cfb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6uqt8002452;
	Tue, 10 Jun 2025 03:35:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Cae0R
	Co1qhmFd+xNGtbB8cx0+A7LtIgEx5zWn9pulf4=; b=GL0D/CfbUjzclqp/6OKDN
	jlu4gliWaz0UeiRMDJ0nDliVEnHiLZ8rMNwgEQa1pvuuRb4Q0u4zjdCZ6g61JkCn
	/weQLbPiPqm0fRyZ9agL8/kgxZLZUaxyzz5DrNokRoKJcF7K1V8TTm4MBh0Vi/QU
	D2zUZyF11/gUxPfwNPYizYsorQartbEym/STRUdDiWrGrZkO125X2Vu2dkKUzekW
	GtYkUufbWBwtG8yRKflxGQ73QTCCl4WZS/CKFjo74+UO7cxUww2fIbZ/X0LJjWY8
	bXnMKgte/S/583gEZw04ycOnkJTJvQn5AdMStVcOz0MslXY1K5XK0A5E/JD+w3Ig
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 476fvkr7ph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z7Ri056149
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:07 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:35:07 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 10 Jun 2025 03:35:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:07 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMi002608;
	Tue, 10 Jun 2025 03:35:01 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:37 +0200
Subject: [PATCH v3 4/8] iio: adc: Add support for ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20250610-iio-driver-ad4052-v3-4-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
In-Reply-To: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=34100;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=nsbwDEaQ87jz0r+Yd4hkac1GFqRNS+p42A3OZyXjPYU=;
 b=qghtBMWbcr9XUWTUcrrrUPv3orUefwP6ZfjTZsyubusQcoUdGW3HvnyZW5zpjuoWIx+L2nWAl
 aMe0hskF7/KDpQ67z378rrN9hHhnanqLrTVZi4kRD7YN+o8n6xmTDp2
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX51vzcpzv9HKe
 9GsHbdCWnkXASPXRq8z8iE5sORGFKmn0PRktSPMhJAiDTBSveVhUG3vYQLCFyKv8Ay1jv7OvfiQ
 6Fj+hekMaNu9GIa7porozyBSqgWWD49wnG5uK0IN7sDaUghOz1z6uTenlYnOOHnZMmqXUjBrD/f
 Fiaur9i5KlfpH4hJGW6hdfKzypb/qC6w+3DTpiOTiMtCCrVwdwa+ej6AkFcr9BBIYlvEWMEu8cY
 cphmD43W8101yOK2mrpIrc9UCdTKTcTodngWhtqfJCgvU5m9EuJjS0lQynnGnpE8j1FT3JHbKAL
 cE6lggd7PlddahTd0YU8Ntxwgd7CLLKkMs+8RiUbiKo5UvZEQ59eiMOkvPNsNUaDa/gV83WtjK6
 xlXzNcwwPnLAdu60jTqm9DsaTyFhrlbTL0MLRBxD7+pIy9QFkpysPKSq6DEKZ4G3AeycnluN
X-Proofpoint-GUID: S2kr9qov3E8EEy0mgpZpfxW6k3MSA5iz
X-Authority-Analysis: v=2.4 cv=Coy/cm4D c=1 sm=1 tr=0 ts=6847e02c cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=jXmY7Cu1mi1X9cUNsCcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: S2kr9qov3E8EEy0mgpZpfxW6k3MSA5iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100056

The AD4052/AD4058/AD4050/AD4056 are versatile, 16-bit/12-bit, successive
approximation register (SAR) analog-to-digital converter (ADC) that
enables low-power, high-density data acquisition solutions without
sacrificing precision. This ADC offers a unique balance of performance
and power efficiency, plus innovative features for seamlessly switching
between high-resolution and low-power modes tailored to the immediate
needs of the system. The AD4052/AD4058/AD4050/AD4056 are ideal for
battery-powered, compact data acquisition and edge sensing applications.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 MAINTAINERS              |    1 +
 drivers/iio/adc/Kconfig  |   15 +
 drivers/iio/adc/Makefile |    1 +
 drivers/iio/adc/ad4052.c | 1083 ++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 1100 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 32afd568b68e45616c291d689a35ab905d421cd1..d83ac902e515575e1419df7505d2e8a96f69244a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1343,6 +1343,7 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4052.yaml
 F:	Documentation/iio/ad4052.rst
+F:	drivers/iio/adc/ad4052.c
 
 ANALOG DEVICES INC AD4080 DRIVER
 M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 3bd03df9a9761f20e2b1b71b51ebe43ba7f51b60..1fe14f939a4d9473b697b40f022124a2ae0b3245 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -55,6 +55,21 @@ config AD4030
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad4030.
 
+config AD4052
+	tristate "Analog Devices AD4052 Driver"
+	depends on SPI
+	depends on GPIOLIB
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
 config AD4080
 	tristate "Analog Devices AD4080 high speed ADC"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 6516ccb4d63bcfe2e2d56c39da7b906fdbe62319..dc3cd61df815fe7a7e77fad85630794b8be11f86 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_AB8500_GPADC) += ab8500-gpadc.o
 obj-$(CONFIG_AD_SIGMA_DELTA) += ad_sigma_delta.o
 obj-$(CONFIG_AD4000) += ad4000.o
 obj-$(CONFIG_AD4030) += ad4030.o
+obj-$(CONFIG_AD4052) += ad4052.o
 obj-$(CONFIG_AD4080) += ad4080.o
 obj-$(CONFIG_AD4130) += ad4130.o
 obj-$(CONFIG_AD4695) += ad4695.o
diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
new file mode 100644
index 0000000000000000000000000000000000000000..842f5972a1c58701addf5243e7b87da9c26c773f
--- /dev/null
+++ b/drivers/iio/adc/ad4052.c
@@ -0,0 +1,1083 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Analog Devices AD4052 SPI ADC driver
+ *
+ * Copyright 2025 Analog Devices Inc.
+ */
+#include <linux/array_size.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/math.h>
+#include <linux/minmax.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
+#include <linux/pwm.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/units.h>
+#include <linux/unaligned.h>
+#include <dt-bindings/iio/adc/adi,ad4052.h>
+
+#define AD4052_REG_INTERFACE_CONFIG_A			0x00
+#define AD4052_REG_DEVICE_CONFIG			0x02
+#define     AD4052_REG_DEVICE_CONFIG_POWER_MODE_MSK	GENMASK(1, 0)
+#define     AD4052_REG_DEVICE_CONFIG_LOW_POWER_MODE	3
+#define AD4052_REG_PROD_ID_1				0x05
+#define AD4052_REG_DEVICE_GRADE				0x06
+#define AD4052_REG_SCRATCH_PAD				0x0A
+#define AD4052_REG_VENDOR_H				0x0D
+#define AD4052_REG_STREAM_MODE				0x0E
+#define AD4052_REG_INTERFACE_STATUS			0x11
+#define     AD4052_REG_INTERFACE_STATUS_NOT_RDY		BIT(7)
+#define AD4052_REG_MODE_SET				0x20
+#define     AD4052_REG_MODE_SET_ENTER_ADC		BIT(0)
+#define AD4052_REG_ADC_MODES				0x21
+#define     AD4052_REG_ADC_MODES_MODE_MSK		GENMASK(1, 0)
+#define     AD4052_REG_ADC_MODES_DATA_FORMAT		BIT(7)
+#define AD4052_REG_ADC_CONFIG				0x22
+#define     AD4052_REG_ADC_CONFIG_REF_EN_MSK		BIT(5)
+#define     AD4052_REG_ADC_CONFIG_SCALE_EN_MSK		BIT(4)
+#define AD4052_REG_AVG_CONFIG				0x23
+#define AD4052_REG_GP_CONF				0x24
+#define     AD4052_REG_GP_CONF_MODE_MSK_0		GENMASK(2, 0)
+#define     AD4052_REG_GP_CONF_MODE_MSK_1		GENMASK(6, 4)
+#define AD4052_REG_INTR_CONF				0x25
+#define     AD4052_REG_INTR_CONF_EN_MSK_0		GENMASK(1, 0)
+#define     AD4052_REG_INTR_CONF_EN_MSK_1		GENMASK(5, 4)
+#define AD4052_REG_TIMER_CONFIG				0x27
+#define     AD4052_REG_TIMER_CONFIG_FS_MASK		GENMASK(7, 4)
+#define     AD4052_REG_TIMER_CONFIG_300KSPS		0x2
+#define AD4052_REG_MAX_LIMIT				0x29
+#define AD4052_REG_MIN_LIMIT				0x2B
+#define AD4052_REG_MAX_HYST				0x2C
+#define AD4052_REG_MIN_HYST				0x2D
+#define AD4052_REG_MON_VAL				0x2F
+#define AD4052_REG_FUSE_CRC				0x40
+#define AD4052_REG_DEVICE_STATUS			0x41
+#define     AD4052_REG_DEVICE_STATUS_DEVICE_RDY		BIT(7)
+#define     AD4052_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
+#define AD4052_REG_MIN_SAMPLE				0x45
+#define AD4052_MAX_REG					0x45
+
+#define AD4052_SPI_VENDOR	0x0456
+
+#define AD4050_MAX_AVG		0x7
+#define AD4052_MAX_AVG		0xB
+#define AD4052_MAX_RATE(x)	((x) == AD4052_500KSPS ? 500000 : 2000000)
+#define AD4052_FS_OFFSET(g)	((g) == AD4052_500KSPS ? 2 : 0)
+#define AD4052_FS(g)		(&ad4052_conversion_freqs[AD4052_FS_OFFSET(g)])
+#define AD4052_FS_LEN(g)	(ARRAY_SIZE(ad4052_conversion_freqs) - (AD4052_FS_OFFSET(g)))
+#define AD4052_MON_VAL_MAX_GAIN		1999970
+#define AD4052_MON_VAL_MIDDLE_POINT	0x8000
+#define AD4052_T_CNVH_NS	10
+#define AD4052_VIO_3V3		3300000
+#define AD4052_SPI_MAX_ADC_XFER_SPEED(x)	((x) >= AD4052_VIO_3V3 ? 83333333 : 58823529)
+#define AD4052_SPI_MAX_REG_XFER_SPEED		16000000
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
+	const char *name;
+	u16 prod_id;
+	u8 max_avg;
+	u8 grade;
+};
+
+enum {
+	AD4052_SCAN_TYPE_SAMPLE,
+	AD4052_SCAN_TYPE_BURST_AVG,
+};
+
+static const struct iio_scan_type ad4052_scan_type_12_s[] = {
+	[AD4052_SCAN_TYPE_SAMPLE] = {
+		.sign = 's',
+		.realbits = 16,
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
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
+		.storagebits = 32,
+		.endianness = IIO_CPU,
+	},
+	[AD4052_SCAN_TYPE_BURST_AVG] = {
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
+	struct spi_device *spi;
+	struct pwm_device *cnv_pwm;
+	struct pwm_state pwm_st;
+	struct spi_transfer xfer;
+	struct gpio_desc *cnv_gp;
+	struct completion completion;
+	struct regmap *regmap;
+	u16 oversampling_frequency;
+	int gp1_irq;
+	int vio_uv;
+	int vref_uv;
+	u8 reg_tx[3];
+	u8 reg_rx[3];
+	u8 raw[4] __aligned(IIO_DMA_MINALIGN);
+	u8 buf_reset_pattern[18];
+};
+
+static int ad4052_spi_read(void *context, const void *reg, size_t reg_size,
+			   void *val, size_t val_size)
+{
+	int ret;
+	struct ad4052_state *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->reg_tx,
+		.rx_buf = st->reg_rx,
+		.len = reg_size + val_size,
+		.speed_hz = AD4052_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	if (xfer.len > sizeof(st->reg_tx) ||
+	    xfer.len > sizeof(st->reg_rx))
+		return  -EINVAL;
+
+	memset(st->reg_tx, 0, sizeof(st->reg_tx));
+	memcpy(st->reg_tx, reg, reg_size);
+
+	ret = spi_sync_transfer(st->spi, &xfer, 1);
+	if (ret)
+		return ret;
+
+	memcpy(val, &st->reg_rx[reg_size], val_size);
+
+	return 0;
+}
+
+static int ad4052_spi_write(void *context, const void *data, size_t count)
+{
+	struct ad4052_state *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->reg_tx,
+		.len = count,
+		.speed_hz = AD4052_SPI_MAX_REG_XFER_SPEED,
+	};
+
+	if (count > sizeof(st->reg_tx))
+		return  -EINVAL;
+
+	memcpy(st->reg_tx, data, count);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+/* To limit the configuration mode access speed */
+static const struct regmap_bus ad4052_regmap_bus = {
+	.read = ad4052_spi_read,
+	.write = ad4052_spi_write,
+	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
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
+static const char *const ad4052_conversion_freqs[] = {
+	"2000000", "1000000", "300000", "100000",	/*  0 -  3 */
+	"33300", "10000", "3000", "500",		/*  4 -  7 */
+	"333", "250", "200", "166",			/*  8 - 11 */
+	"140", "124", "111",				/* 12 - 15 */
+};
+
+static int ad4052_conversion_frequency_set(struct ad4052_state *st, u8 val)
+{
+	val += AD4052_FS_OFFSET(st->chip->grade);
+	return regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
+			    FIELD_PREP(AD4052_REG_TIMER_CONFIG_FS_MASK, val));
+}
+
+static int ad4052_oversampling_frequency_get(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	return st->oversampling_frequency - AD4052_FS_OFFSET(st->chip->grade);
+}
+
+static int ad4052_oversampling_frequency_set(struct iio_dev *indio_dev,
+					     const struct iio_chan_spec *chan,
+					     unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	val += AD4052_FS_OFFSET(st->chip->grade);
+	st->oversampling_frequency = val;
+
+	return 0;
+}
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
+				    BIT(IIO_CHAN_INFO_SCALE) |				\
+				    BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+#define AD4052_OFFLOAD_CHAN(bits, grade) {						\
+	.type = IIO_VOLTAGE,								\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_RAW) |				\
+				    BIT(IIO_CHAN_INFO_SCALE) |				\
+				    BIT(IIO_CHAN_INFO_CALIBSCALE) |			\
+				    BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO) |		\
+				    BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
+	.indexed = 1,									\
+	.channel = 0,									\
+	.has_ext_scan_type = 1,								\
+	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
+	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
+	.ext_info = grade##_ext_info,							\
+}
+
+static const struct ad4052_chip_info ad4050_chip_info = {
+	.name = "ad4050",
+	.channels = { AD4052_CHAN(12, AD4052_2MSPS) },
+	.prod_id = 0x70,
+	.max_avg = AD4050_MAX_AVG,
+	.grade = AD4052_2MSPS,
+};
+
+static const struct ad4052_chip_info ad4052_chip_info = {
+	.name = "ad4052",
+	.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
+	.prod_id = 0x72,
+	.max_avg = AD4052_MAX_AVG,
+	.grade = AD4052_2MSPS,
+};
+
+static const struct ad4052_chip_info ad4056_chip_info = {
+	.name = "ad4056",
+	.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
+	.prod_id = 0x76,
+	.max_avg = AD4050_MAX_AVG,
+	.grade = AD4052_500KSPS,
+};
+
+static const struct ad4052_chip_info ad4058_chip_info = {
+	.name = "ad4058",
+	.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
+	.prod_id = 0x78,
+	.max_avg = AD4052_MAX_AVG,
+	.grade = AD4052_500KSPS,
+};
+
+static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
+				   struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	xfer->rx_buf = st->raw;
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->len = scan_type->realbits == 24 ? 4 : 2;
+	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
+
+	return 0;
+}
+
+static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
+					 const struct iio_chan_spec *chan,
+					 unsigned int val)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	if (val < 1 || val > BIT(st->chip->max_avg + 1))
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
+	return ad4052_update_xfer_raw(indio_dev, chan);
+}
+
+static int ad4052_get_oversampling_ratio(struct ad4052_state *st,
+					 unsigned int *val)
+{
+	int ret, buf;
+
+	if (st->mode == AD4052_SAMPLE_MODE) {
+		*val = 1;
+		return 0;
+	}
+
+	ret = regmap_read(st->regmap, AD4052_REG_AVG_CONFIG, &buf);
+	if (ret)
+		return ret;
+
+	*val = BIT(buf + 1);
+
+	return 0;
+}
+
+static int ad4052_check_ids(struct ad4052_state *st)
+{
+	int ret;
+	u16 val;
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_PROD_ID_1, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	val = get_unaligned_be16(st->raw);
+	if (val != st->chip->prod_id)
+		dev_warn(&st->spi->dev,
+			 "Production ID x%x does not match known values", val);
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_VENDOR_H, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	val = get_unaligned_be16(st->raw);
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
+				 AD4052_REG_ADC_MODES_MODE_MSK, mode);
+	if (ret)
+		return ret;
+
+	return regmap_write(st->regmap, AD4052_REG_MODE_SET,
+			    AD4052_REG_MODE_SET_ENTER_ADC);
+}
+
+static int ad4052_set_sampling_freq(struct ad4052_state *st, unsigned int freq)
+{
+	const u32 start = 1;
+
+	if (!in_range(freq, start, AD4052_MAX_RATE(st->chip->grade)))
+		return -EINVAL;
+
+	st->pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, freq);
+	return pwm_apply_might_sleep(st->cnv_pwm, &st->pwm_st);
+}
+
+static int ad4052_soft_reset(struct ad4052_state *st)
+{
+	int ret;
+
+	memset(st->buf_reset_pattern, 0xFF, sizeof(st->buf_reset_pattern));
+	st->buf_reset_pattern[5] = 0xFE;
+	st->buf_reset_pattern[11] = 0xFE;
+	st->buf_reset_pattern[17] = 0xFE;
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
+static int ad4052_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
+			const bool *ref_sel)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	int ret;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	u8 val = FIELD_PREP(AD4052_REG_GP_CONF_MODE_MSK_0, AD4052_GP_INTR) |
+		 FIELD_PREP(AD4052_REG_GP_CONF_MODE_MSK_1, AD4052_GP_DRDY);
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_GP_CONF,
+				 AD4052_REG_GP_CONF_MODE_MSK_1 | AD4052_REG_GP_CONF_MODE_MSK_0,
+				 val);
+	if (ret)
+		return ret;
+
+	val = FIELD_PREP(AD4052_REG_INTR_CONF_EN_MSK_0, (AD4052_INTR_EN_EITHER)) |
+	      FIELD_PREP(AD4052_REG_INTR_CONF_EN_MSK_1, (AD4052_INTR_EN_NEITHER));
+
+	if (st->chip->grade == AD4052_500KSPS) {
+		ret = regmap_write(st->regmap, AD4052_REG_TIMER_CONFIG,
+				   FIELD_PREP(AD4052_REG_TIMER_CONFIG_FS_MASK,
+					      AD4052_REG_TIMER_CONFIG_300KSPS));
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, AD4052_REG_ADC_MODES,
+				 AD4052_REG_ADC_CONFIG_REF_EN_MSK,
+				 FIELD_PREP(AD4052_REG_ADC_CONFIG_REF_EN_MSK,
+					    *ref_sel));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
+			   AD4052_REG_DEVICE_STATUS_DEVICE_RESET);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD4052_REG_INTR_CONF,
+				  AD4052_REG_INTR_CONF_EN_MSK_0 | AD4052_REG_INTR_CONF_EN_MSK_1,
+				  val);
+}
+
+static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
+{
+	struct ad4052_state *st = private;
+
+	complete(&st->completion);
+	return IRQ_HANDLED;
+}
+
+static int ad4052_request_irq(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct device *dev = &st->spi->dev;
+	int ret;
+
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
+	if (ret > 0) {
+		ret = devm_request_threaded_irq(dev, ret, NULL,
+						ad4052_irq_handler_drdy,
+						IRQF_ONESHOT, indio_dev->name,
+						st);
+		st->gp1_irq = ret;
+	} else if (ret == -EPROBE_DEFER) {
+		return ret;
+	}
+	return 0;
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
+static int ad4052_get_samp_freq(struct iio_dev *indio_dev,
+				struct iio_chan_spec const *chan,
+				int *val,
+				int *val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	*val = DIV_ROUND_UP_ULL(NSEC_PER_SEC, st->pwm_st.period);
+	return IIO_VAL_INT;
+}
+
+static int ad4052_get_chan_scale(struct iio_dev *indio_dev,
+				 struct iio_chan_spec const *chan,
+				 int *val,
+				 int *val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+
+	scan_type = iio_get_current_scan_type(indio_dev, st->chip->channels);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	*val = (st->vref_uv * 2) / MILLI;
+
+	*val2 = scan_type->realbits;
+
+	return IIO_VAL_FRACTIONAL_LOG2;
+}
+
+static int ad4052_get_chan_calibscale(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int *val,
+				      int *val2)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	u16 gain;
+	int ret;
+
+	ret = regmap_bulk_read(st->regmap, AD4052_REG_MON_VAL, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	gain = get_unaligned_be16(&st->raw);
+
+	/* From datasheet: code out = code in × mon_val/0x8000 */
+	*val = gain / AD4052_MON_VAL_MIDDLE_POINT;
+	*val2 = mul_u64_u32_div(gain % AD4052_MON_VAL_MIDDLE_POINT, NANO,
+				AD4052_MON_VAL_MIDDLE_POINT);
+
+	return IIO_VAL_INT_PLUS_NANO;
+}
+
+static int ad4052_set_chan_calibscale(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan,
+				      int gain_int,
+				      int gain_frac)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	u64 gain;
+	int ret;
+
+	if (gain_int < 0 || gain_frac < 0)
+		return -EINVAL;
+
+	gain = mul_u32_u32(gain_int, MICRO) + gain_frac;
+
+	if (gain > AD4052_MON_VAL_MAX_GAIN)
+		return -EINVAL;
+
+	put_unaligned_be16(DIV_ROUND_CLOSEST_ULL(gain * AD4052_MON_VAL_MIDDLE_POINT,
+						 MICRO),
+			   &st->raw);
+
+	ret = regmap_bulk_write(st->regmap, AD4052_REG_MON_VAL, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD4052_REG_ADC_MODES,
+				  AD4052_REG_ADC_CONFIG_SCALE_EN_MSK,
+				  FIELD_PREP(AD4052_REG_ADC_CONFIG_SCALE_EN_MSK,
+					     !(gain_int == 1 && gain_frac == 0)));
+}
+
+static int __ad4052_read_chan_raw(struct ad4052_state *st, int *val)
+{
+	struct spi_device *spi = st->spi;
+	struct spi_transfer t_cnv = {};
+	int ret;
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
+	if (st->gp1_irq) {
+		ret = wait_for_completion_timeout(&st->completion,
+						  msecs_to_jiffies(1000));
+		if (!ret)
+			return -ETIMEDOUT;
+	}
+
+	ret = spi_sync_transfer(spi, &st->xfer, 1);
+	if (ret)
+		return ret;
+
+	if (st->xfer.len == 2)
+		*val = sign_extend32(*(u16 *)(st->raw), 15);
+	else
+		*val = sign_extend32(*(u32 *)(st->raw), 23);
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
+static int ad4052_read_raw_dispatch(struct iio_dev *indio_dev,
+				    struct iio_chan_spec const *chan, int *val,
+				    int *val2, long info)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		return ad4052_read_chan_raw(indio_dev, val);
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4052_get_chan_calibscale(indio_dev, chan, val, val2);
+
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4052_get_oversampling_ratio(st, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4052_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long info)
+{
+	int ret;
+
+	if (info ==  IIO_CHAN_INFO_SAMP_FREQ)
+		return ad4052_get_samp_freq(indio_dev, chan, val, val2);
+	else if (info == IIO_CHAN_INFO_SCALE)
+		return ad4052_get_chan_scale(indio_dev, chan, val, val2);
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad4052_read_raw_dispatch(indio_dev, chan, val, val2, info);
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : IIO_VAL_INT;
+}
+
+static int ad4052_write_raw_dispatch(struct iio_dev *indio_dev,
+				     struct iio_chan_spec const *chan, int val,
+				     int val2, long info)
+{
+	switch (info) {
+	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
+		return ad4052_set_oversampling_ratio(indio_dev, chan, val);
+
+	case IIO_CHAN_INFO_CALIBSCALE:
+		return ad4052_set_chan_calibscale(indio_dev, chan, val, val2);
+
+	default:
+		return -EINVAL;
+	}
+};
+
+static int ad4052_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val,
+			    int val2, long info)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+		return ad4052_set_sampling_freq(st, val);
+	}
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	ret = ad4052_write_raw_dispatch(indio_dev, chan, val, val2, info);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
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
+	if (readval)
+		ret = regmap_read(st->regmap, reg, readval);
+	else
+		ret = regmap_write(st->regmap, reg, writeval);
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int ad4052_get_current_scan_type(const struct iio_dev *indio_dev,
+					const struct iio_chan_spec *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
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
+static int __ad4052_validate_trigger_sources(struct of_phandle_args *trigger_sources)
+{
+	switch (trigger_sources->args[1]) {
+	case AD4052_TRIGGER_PIN_GP1:
+		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_DATA_READY ?
+		       0 : -EINVAL;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad4052_validate_trigger_sources(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct of_phandle_args trigger_sources;
+	struct device_node *np;
+	int ret;
+
+	np = st->spi->dev.of_node;
+	ret = of_parse_phandle_with_args(np, "trigger-sources",
+					 "#trigger-source-cells", 0,
+					 &trigger_sources);
+	if (ret)
+		return ret;
+
+	ret = __ad4052_validate_trigger_sources(&trigger_sources);
+	of_node_put(trigger_sources.np);
+	return ret;
+}
+
+static int ad4052_regulators_get(struct ad4052_state *st, bool *ref_sel)
+{
+	struct device *dev = &st->spi->dev;
+	int uv;
+
+	st->vio_uv = devm_regulator_get_enable_read_voltage(dev, "vio");
+	if (st->vio_uv < 0)
+		return dev_err_probe(dev, st->vio_uv,
+				     "Failed to enable and read vio voltage\n");
+
+	uv = devm_regulator_get_enable_read_voltage(dev, "vdd");
+	if (uv < 0)
+		return dev_err_probe(dev, uv,
+				     "Failed to enable vdd regulator\n");
+
+	st->vref_uv = devm_regulator_get_enable_read_voltage(dev, "ref");
+	*ref_sel = st->vref_uv == -ENODEV;
+	if (st->vref_uv == -ENODEV)
+		st->vref_uv = uv;
+	else if (st->vref_uv < 0)
+		return dev_err_probe(dev, st->vref_uv,
+				     "Failed to enable and read ref voltage\n");
+	return 0;
+}
+
+static int ad4052_probe(struct spi_device *spi)
+{
+	const struct ad4052_chip_info *chip;
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad4052_state *st;
+	bool ref_sel;
+	int ret;
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
+	ret = ad4052_regulators_get(st, &ref_sel);
+	if (ret)
+		return ret;
+
+	st->regmap = devm_regmap_init(dev, &ad4052_regmap_bus, st,
+				      &ad4052_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
+
+	st->mode = AD4052_SAMPLE_MODE;
+	st->chip = chip;
+	st->oversampling_frequency = AD4052_FS_OFFSET(st->chip->grade);
+
+	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
+	if (IS_ERR(st->cnv_gp))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_gp),
+				     "Failed to get cnv gpio\n");
+
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->num_channels = 1;
+	indio_dev->info = &ad4052_info;
+	indio_dev->name = chip->name;
+
+	ret = ad4052_validate_trigger_sources(indio_dev);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to validate trigger sources\n");
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
+	ret = ad4052_setup(indio_dev, indio_dev->channels, &ref_sel);
+	if (ret)
+		return ret;
+
+	ret = ad4052_request_irq(indio_dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_update_xfer_raw(indio_dev, indio_dev->channels);
+	if (ret)
+		return ret;
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
+			    FIELD_PREP(AD4052_REG_DEVICE_CONFIG_POWER_MODE_MSK,
+				       AD4052_REG_DEVICE_CONFIG_LOW_POWER_MODE));
+}
+
+static int ad4052_runtime_resume(struct device *dev)
+{
+	struct ad4052_state *st = dev_get_drvdata(dev);
+	int ret;
+
+	ret = regmap_clear_bits(st->regmap, AD4052_REG_DEVICE_CONFIG,
+				AD4052_REG_DEVICE_CONFIG_POWER_MODE_MSK);
+
+	fsleep(4000);
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


