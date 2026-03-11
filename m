Return-Path: <linux-pwm+bounces-8225-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNR9A3C2sGlvmQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8225-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:25:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 80393259C33
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20B0531508D8
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 00:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190A0342523;
	Wed, 11 Mar 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sIeuCJn/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7386A33EAE4;
	Wed, 11 Mar 2026 00:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188643; cv=none; b=iQ/ZUBBzYoOqWKBGtOV/0X0GOAFF6lfT7f+yN+93dlqaPobasatGl64PnKJv8wpCLUYgLnEi+9sUm9vFjx+KPdvSGzmK7SFyWeYVOQ9P6DAF6tmn7G0fMVfZto8YvkdyCRW5NsUi19SfLSJNXsGTF+SatgA3WwvTVZ2wncksNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188643; c=relaxed/simple;
	bh=f0DynJCWrILkqkA4VZlrEhsLI8lgtotpyew8gR/dgi8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VyNHuPRMwcisqc4SVtW8i9ECpTc1hQvT/EogHVmF0NzB/4tHdSuX2gR1zMzXe+H533wVG3BfP29NUI4KLDOTF3c6/64CV4KTqi6lNDPbJjMYP8JMRUPXLeV1gJX0WJVKqYMn0NIr4w/k/7n7dkjvdPz1MqdQ9gExyjMOBZnRsak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sIeuCJn/; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AI9TPH4161659;
	Tue, 10 Mar 2026 20:23:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zJGee
	0gw2SZ6oW1xrBNCMjSY31skQcHf5Fh/IQW9LA8=; b=sIeuCJn/CHNYFCV79xiSg
	srY/G00jBCHiyB7rSH4kvuEt9q9qqHUGv+i1iZ6716pM4tMk0ciMRd2IHOvtd8Pc
	QVhGSOMfEzvZ0AkTWTnkAOl29gJFwK6dLf2W5gHzA+HhTgL2Z7tH0JHmzwfZXdtz
	wo9WFPBA7ZpThmimCpCw+9dg71l3X3lh4Wo5fUlLe5M3/lV2TBjXlUeoa6L1Qlff
	lCBZAtBK2FgSLN5I6CfBRu47q0RBs3JABM5UdqOzLTOePlf7xJT352KT1jgc2FfG
	W8Nu1vyc9JIvK2WQ2yCeREhWHQnz1unQjeMUe7iu8yjxYMA8CaxHgq6l35lQ5YeV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cs37dv2p9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:23:45 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62B0NiKv036274
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Mar 2026 20:23:44 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Mar 2026 20:23:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Mar 2026 20:23:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Mar 2026 20:23:44 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.140])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62B0NJkP015383;
	Tue, 10 Mar 2026 20:23:35 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 11 Mar 2026 08:23:18 +0800
Subject: [PATCH v2 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260311-dev_ad5706r-v2-2-f367063dbd1b@analog.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
In-Reply-To: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        "Alexis Czezar
 Torreno" <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773188600; l=7636;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=f0DynJCWrILkqkA4VZlrEhsLI8lgtotpyew8gR/dgi8=;
 b=VBuhIpQRhXWw+f+gAUwynRCGkrntF9ZxJBfTV8QKIBPoeFLjKAx1fe9/+KzJDwgQxNZbFwoMx
 23pm5yPt60HDCINdzqLXzR/xFt4lJkLz03XMR3VdsNJ7krBG0+zO10j
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwMSBTYWx0ZWRfX6q1XugWHs6Co
 gQwzWoDCj5euBEH0HUqPUPVrgs/Sv8AlbjzUqXxWUTJWl+vVDy36tEt5iod0uz8FkR2R/cBaiPy
 ClbxU2MEGVq836kMRvSa2yPxabYMTodoT2uM4q+HgkWVJABtbcD0PohsJxe04/ZqYzijJR+O9bJ
 Jxw3t0BlWURIVjTXpYYupb5LicvgZYeGzoDymP6kXqF9o7M9HTb1uk9Zj16eHY2mqaYaanG/e88
 CoLmAIeX/BxpneCkHNZOS42R1WGlXRckBK1svQueG2n5TUx8dLOi2OicYOEQIunfRUqbuLviRib
 ZtdYCSCAwBkikZzBfdIlg3aurZab8mtIrRe1tAe+o6+LAsNbFuTWtkxcbDYP5G9W1OtaAw2Zl/L
 7VustHiTI6Zqq4qBijalGFT0q1rGn2fldRJTn08vk4quXFRwIZ4rJWFNz22MEITM4kvP6k8EncH
 dSHl7H8lp8e4iQLQWxA==
X-Authority-Analysis: v=2.4 cv=JJo2csKb c=1 sm=1 tr=0 ts=69b0b611 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=aUtKnKsgCkawLZ2Al5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Zse_rzVFHghtOQEjfnvnR6LZqcSavfTi
X-Proofpoint-ORIG-GUID: Zse_rzVFHghtOQEjfnvnR6LZqcSavfTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110001
X-Rspamd-Queue-Id: 80393259C33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8225-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,analog.com:dkim,analog.com:email,analog.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

Add support for the Analog Devices AD5706R, a 4-channel 16-bit
current output digital-to-analog converter with SPI interface.

Features:
  - 4 independent DAC channels
  - Hardware and software LDAC trigger
  - Configurable output range
  - PWM-based LDAC control
  - Dither and toggle modes
  - Dynamically configurable SPI speed

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>

---
Changes since v1:
  - Removed PWM, GPIO, clock generator, debugfs, regmap, IIO_BUFFER
  - Removed all custom ext_info sysfs attributes
  - Simplified to basic raw read/write and read-only scale
  - SPI read/write can handle multibyte registers
---
---
 drivers/iio/dac/Kconfig   |  10 +++
 drivers/iio/dac/Makefile  |   1 +
 drivers/iio/dac/ad5706r.c | 208 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 219 insertions(+)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index db9f5c711b3df90641f017652fbbef594cc1627d..8ccbdf6dfbca8640a47bf05b4afc6b4bf90a7e26 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -178,6 +178,16 @@ config AD5624R_SPI
 	  Say yes here to build support for Analog Devices AD5624R, AD5644R and
 	  AD5664R converters (DAC). This driver uses the common SPI interface.
 
+config AD5706R
+	tristate "Analog Devices AD5706R DAC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices AD5706R 4-channel,
+	  16-bit current output DAC.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5706r.
+
 config AD9739A
 	tristate "Analog Devices AD9739A RF DAC spi driver"
 	depends on SPI
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index 2a80bbf4e80ad557da79ed916027cedff286984b..0034317984985035f7987a744899924bfd4612e3 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_AD5449) += ad5449.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
+obj-$(CONFIG_AD5706R) += ad5706r.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5758) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c
new file mode 100644
index 0000000000000000000000000000000000000000..204d29f6495da167e922e5c9c5a2c4ff5c650693
--- /dev/null
+++ b/drivers/iio/dac/ad5706r.c
@@ -0,0 +1,208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AD5706R 16-bit Current Output Digital to Analog Converter
+ *
+ * Copyright 2026 Analog Devices Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/spi/spi.h>
+
+/* SPI frame layout */
+#define AD5706R_RD_MASK			BIT(15)
+#define AD5706R_ADDR_MASK		GENMASK(11, 0)
+
+/* Registers */
+#define AD5706R_REG_DAC_INPUT_A_CH(x)		(0x60 + ((x) * 2))
+#define AD5706R_REG_DAC_DATA_READBACK_CH(x)	(0x68 + ((x) * 2))
+
+#define AD5706R_DAC_RESOLUTION		16
+#define AD5706R_DAC_MAX_CODE		BIT(AD5706R_DAC_RESOLUTION)  /* 65536 */
+#define AD5706R_MULTIBYTE_REG_START	0x14
+#define AD5706R_MULTIBYTE_REG_END	0x71
+#define AD5706R_SINGLE_BYTE_LEN		1
+#define AD5706R_DOUBLE_BYTE_LEN		2
+
+struct ad5706r_state {
+	struct spi_device *spi;
+	struct mutex lock; /* Protects SPI transfers */
+
+	__be32 tx_buf __aligned(ARCH_DMA_MINALIGN);
+	__be16 rx_buf;
+};
+
+static int ad5706r_reg_len(unsigned int reg)
+{
+	if (reg >= AD5706R_MULTIBYTE_REG_START && reg <= AD5706R_MULTIBYTE_REG_END)
+		return AD5706R_DOUBLE_BYTE_LEN;
+
+	return AD5706R_SINGLE_BYTE_LEN;
+}
+
+static int ad5706r_spi_write(struct ad5706r_state *st, u16 reg, u16 val)
+{
+	unsigned int num_bytes = ad5706r_reg_len(reg);
+
+	struct spi_transfer xfer = {
+		.tx_buf = &st->tx_buf,
+		.len = num_bytes + 2,
+	};
+
+	st->tx_buf = cpu_to_be32((((u32)reg) << 16) |
+			((u32)val << (16 - (num_bytes * 8))));
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+}
+
+static int ad5706r_spi_read(struct ad5706r_state *st, u16 reg, u16 *val)
+{
+	unsigned int num_bytes = ad5706r_reg_len(reg);
+	u16 cmd;
+	int ret;
+
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &st->tx_buf,
+			.len = 2,
+		},
+		{
+			.rx_buf = &st->rx_buf,
+			.len = num_bytes,
+		},
+	};
+
+	cmd = AD5706R_RD_MASK | (reg & AD5706R_ADDR_MASK);
+	st->tx_buf = cpu_to_be32((u32)cmd << 16);
+
+	ret = spi_sync_transfer(st->spi, xfer, ARRAY_SIZE(xfer));
+	if (ret)
+		return ret;
+
+	*val = be16_to_cpu(st->rx_buf) >> (16 - (num_bytes * 8));
+
+	return 0;
+}
+
+static int ad5706r_read_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int *val,
+			    int *val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+	u16 reg_val;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		scoped_guard(mutex, &st->lock) {
+			ret = ad5706r_spi_read(st, AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
+					       &reg_val);
+
+			if (ret)
+				return ret;
+
+			*val = reg_val;
+		}
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		*val = 50;
+		*val2 = AD5706R_DAC_RESOLUTION;
+		return IIO_VAL_FRACTIONAL_LOG2;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5706r_write_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int val,
+			     int val2, long mask)
+{
+	struct ad5706r_state *st = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val >= AD5706R_DAC_MAX_CODE)
+			return -EINVAL;
+
+		guard(mutex)(&st->lock);
+		return ad5706r_spi_write(st,
+					 AD5706R_REG_DAC_INPUT_A_CH(chan->channel),
+					 val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info ad5706r_info = {
+	.read_raw = ad5706r_read_raw,
+	.write_raw = ad5706r_write_raw,
+};
+
+#define AD5706R_CHAN(_channel) {				\
+	.type = IIO_CURRENT,					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),	\
+	.output = 1,						\
+	.indexed = 1,						\
+	.channel = _channel,					\
+}
+
+static const struct iio_chan_spec ad5706r_channels[] = {
+	AD5706R_CHAN(0),
+	AD5706R_CHAN(1),
+	AD5706R_CHAN(2),
+	AD5706R_CHAN(3),
+};
+
+static int ad5706r_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct ad5706r_state *st;
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
+	indio_dev->name = "ad5706r";
+	indio_dev->info = &ad5706r_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->channels = ad5706r_channels;
+	indio_dev->num_channels = ARRAY_SIZE(ad5706r_channels);
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct of_device_id ad5706r_of_match[] = {
+	{ .compatible = "adi,ad5706r" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, ad5706r_of_match);
+
+static const struct spi_device_id ad5706r_id[] = {
+	{ "ad5706r", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad5706r_id);
+
+static struct spi_driver ad5706r_driver = {
+	.driver = {
+		.name = "ad5706r",
+		.of_match_table = ad5706r_of_match,
+	},
+	.probe = ad5706r_probe,
+	.id_table = ad5706r_id,
+};
+module_spi_driver(ad5706r_driver);
+
+MODULE_AUTHOR("Alexis Czezar Torreno <alexisczezar.torreno@analog.com>");
+MODULE_DESCRIPTION("AD5706R 16-bit Current Output DAC driver");
+MODULE_LICENSE("GPL");

-- 
2.34.1


