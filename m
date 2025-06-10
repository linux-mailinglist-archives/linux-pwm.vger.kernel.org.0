Return-Path: <linux-pwm+bounces-6268-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF144AD2ED6
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4E53AA6E5
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D6328001A;
	Tue, 10 Jun 2025 07:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GD7gULYd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057622206BB;
	Tue, 10 Jun 2025 07:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540931; cv=none; b=nFpzHidTm+E73qO44h9mQvja/g3tqBKzwFEQseDhmMgwexTHsdUNbRNCCoZVf+ePHauU11O7uUNTykRYcCS9Sl8jugZ9lZt1lSi0Gvd6rIuIKszWJhPFagyT/SeYBylNBCrj0z2914RmCJYkEXUk+n+lHG+I1LzH7JELI8y73LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540931; c=relaxed/simple;
	bh=i0pnK2upq34spPsr7tqHTfnCvIIXQXxDLrEbaLwdRIE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Nm+m/J2pXorpPfl5921gPN9OBoAOaPa5Pgv+Raw0NtBucAiiiyTNK0+h0qnRvW9RsnLMvnJbSBZ4irCbaaW2QecKkU56LpqRWavzr8x5rmQn8ifwVtbI3pcKpZkC/lOcK+AGtebkQecarFnXjglt1upGEQ2aJJ9P0yPnrqYiOg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GD7gULYd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A7LvV1027953;
	Tue, 10 Jun 2025 03:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SRXRC
	CyCRxIiTIx/757L72mrpYSXoLuQlWNEqBlIzYA=; b=GD7gULYdYHwKFRduEbfZ/
	zQRZ2kOj0q8WC4059QJQAq6wznJAq6awxyDJYqg8PbzIUrWtPNlK1yJ3ns1Grq22
	30z+ac6wly+QwbHTaPDZpy7xpzJWIxF/TCWzcumzwc/h0sAXBTUnKbezWfa46dMb
	kthuIhmhfE9/Xu4UyMzmHSMn3tp1IznH/+NIjOVfBO5VAZdKerZDRie7EUsXFZU5
	gj670gi6fv9kpYt7G/vE5YsiOHwAr66/KuFoq0pKOJS71xgcki98a5XRiDvZZoIL
	lZDwERl9G+bQdxeq2AASYCEu6bDw5Y7Qyy6IBzPhIzeodJEypslR5Sdqh/s5hgqE
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 475u346d0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 55A7ZDRX013965
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:13 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMk002608;
	Tue, 10 Jun 2025 03:35:05 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:39 +0200
Subject: [PATCH v3 6/8] iio: adc: Add offload support for ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-6-cf1e44c516d4@analog.com>
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
        Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=11707;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=i0pnK2upq34spPsr7tqHTfnCvIIXQXxDLrEbaLwdRIE=;
 b=Rg0itiD/eulVab8Z7Dy2tZi0FJpZ8+Fg5CTIP2NyHh7b1EdqjnPQDEEMQ5jF9kFeCnuy3BW5s
 wri4VLpF0YbA+JJo1uu7JLyy44ia4T5daC4RjojXRUy7KBqd6m/OkMy
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R74DGcRX c=1 sm=1 tr=0 ts=6847e032 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=9AuMBu_mA1_DZbfGTuoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: gJ0fUKD_gIniHevtMjs0MT07qIiyaA2j
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX1RcwwynuK/Hr
 W3ezT/9piSwEeigQxm0FyoJZiuhBl6fyvRuI5jiWPxnPmUtdBOYv2uyh0fPTCC33Fl354617DDs
 1rZA5HoOfnwa3tdO3yLCsGaV1XxAHkqlOY1DCWtfOIdvHlFTnKAdREtBvM6Isp+S6hFu2mHjEgV
 9GclhgHpGplIa0TsIqCd9xO6U8/YgsVFBgpQhzPYPYBTWTZUqkVaRxkGuG1+ajhqme+fOUiFUk4
 2TgpSbFsVHyH51JGIH/X9e7orI+uIpW/rEQl9nyF+ggao2i1iJfeuOD0U/6PvUddEI3V5LfOJ2i
 6oZCYYfdXRV+nAWuDNB8Wq0sGsSqtWfC7u8/UDpTgUHjKgSaOLtrBGe3Y1Kxrx6Z7E7VlCn+hFL
 s4YwOxDkQL5ws20w1PWvdmGvlnZnymrr6O+ro0y55e+507d8TT8FlkvC2XUB3K336SSdng8f
X-Proofpoint-GUID: gJ0fUKD_gIniHevtMjs0MT07qIiyaA2j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 lowpriorityscore=0 phishscore=0 mlxscore=0 adultscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506100056

Support SPI offload with appropriate FPGA firmware. Since the SPI-Engine
offload module always sends 32-bit data to the DMA engine, the
scantype.storagebytes is set to 32-bit and the SPI transfer length is
based on the scantype.realbits. This combination allows to optimize the
SPI to transfer only 2 or 3 bytes (depending on the granularity and
mode), while the number of samples are computed correctly by tools on
top of the iio scantype.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4052.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 242 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
index 842f5972a1c58701addf5243e7b87da9c26c773f..7d32dc4701ddb0204b5505a650ce7caafc2cb5ed 100644
--- a/drivers/iio/adc/ad4052.c
+++ b/drivers/iio/adc/ad4052.c
@@ -11,6 +11,8 @@
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/iio/buffer.h>
+#include <linux/iio/buffer-dmaengine.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
@@ -23,6 +25,8 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/spi/offload/consumer.h>
+#include <linux/spi/offload/provider.h>
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/units.h>
@@ -111,6 +115,7 @@ enum ad4052_interrupt_en {
 
 struct ad4052_chip_info {
 	const struct iio_chan_spec channels[1];
+	const struct iio_chan_spec offload_channels[1];
 	const char *name;
 	u16 prod_id;
 	u8 max_avg;
@@ -156,7 +161,11 @@ struct ad4052_state {
 	const struct ad4052_bus_ops *ops;
 	const struct ad4052_chip_info *chip;
 	enum ad4052_operation_mode mode;
+	struct spi_offload *offload;
+	struct spi_offload_trigger *offload_trigger;
 	struct spi_device *spi;
+	struct spi_transfer offload_xfer;
+	struct spi_message offload_msg;
 	struct pwm_device *cnv_pwm;
 	struct pwm_state pwm_st;
 	struct spi_transfer xfer;
@@ -344,6 +353,7 @@ AD4052_EXT_INFO(AD4052_500KSPS);
 static const struct ad4052_chip_info ad4050_chip_info = {
 	.name = "ad4050",
 	.channels = { AD4052_CHAN(12, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_2MSPS) },
 	.prod_id = 0x70,
 	.max_avg = AD4050_MAX_AVG,
 	.grade = AD4052_2MSPS,
@@ -352,6 +362,7 @@ static const struct ad4052_chip_info ad4050_chip_info = {
 static const struct ad4052_chip_info ad4052_chip_info = {
 	.name = "ad4052",
 	.channels = { AD4052_CHAN(16, AD4052_2MSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_2MSPS) },
 	.prod_id = 0x72,
 	.max_avg = AD4052_MAX_AVG,
 	.grade = AD4052_2MSPS,
@@ -360,6 +371,7 @@ static const struct ad4052_chip_info ad4052_chip_info = {
 static const struct ad4052_chip_info ad4056_chip_info = {
 	.name = "ad4056",
 	.channels = { AD4052_CHAN(12, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(12, AD4052_500KSPS) },
 	.prod_id = 0x76,
 	.max_avg = AD4050_MAX_AVG,
 	.grade = AD4052_500KSPS,
@@ -368,6 +380,7 @@ static const struct ad4052_chip_info ad4056_chip_info = {
 static const struct ad4052_chip_info ad4058_chip_info = {
 	.name = "ad4058",
 	.channels = { AD4052_CHAN(16, AD4052_500KSPS) },
+	.offload_channels = { AD4052_OFFLOAD_CHAN(16, AD4052_500KSPS) },
 	.prod_id = 0x78,
 	.max_avg = AD4052_MAX_AVG,
 	.grade = AD4052_500KSPS,
@@ -392,6 +405,28 @@ static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
 	return 0;
 }
 
+static int ad4052_update_xfer_offload(struct iio_dev *indio_dev,
+				      struct iio_chan_spec const *chan)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	const struct iio_scan_type *scan_type;
+	struct spi_transfer *xfer = &st->offload_xfer;
+
+	scan_type = iio_get_current_scan_type(indio_dev, chan);
+	if (IS_ERR(scan_type))
+		return PTR_ERR(scan_type);
+
+	xfer->bits_per_word = scan_type->realbits;
+	xfer->offload_flags = SPI_OFFLOAD_XFER_RX_STREAM;
+	xfer->len = scan_type->realbits == 24 ? 4 : 2;
+	xfer->speed_hz = AD4052_SPI_MAX_ADC_XFER_SPEED(st->vio_uv);
+
+	spi_message_init_with_transfers(&st->offload_msg, &st->offload_xfer, 1);
+	st->offload_msg.offload = st->offload;
+
+	return 0;
+}
+
 static int ad4052_set_oversampling_ratio(struct iio_dev *indio_dev,
 					 const struct iio_chan_spec *chan,
 					 unsigned int val)
@@ -838,6 +873,87 @@ static int ad4052_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
+static int ad4052_offload_buffer_postenable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct spi_offload_trigger_config config = {
+		.type = SPI_OFFLOAD_TRIGGER_DATA_READY,
+	};
+	int ret;
+
+	ret = pm_runtime_resume_and_get(&st->spi->dev);
+	if (ret)
+		return ret;
+
+	ret = ad4052_set_operation_mode(st, st->mode);
+	if (ret)
+		goto out_mode_error;
+
+	ret = ad4052_update_xfer_offload(indio_dev, indio_dev->channels);
+	if (ret)
+		goto out_xfer_error;
+
+	ret = spi_optimize_message(st->spi, &st->offload_msg);
+	if (ret)
+		goto out_xfer_error;
+
+	/* SPI Offload handles the data ready irq */
+	if (st->gp1_irq)
+		disable_irq(st->gp1_irq);
+
+	ret = spi_offload_trigger_enable(st->offload, st->offload_trigger,
+					 &config);
+	if (ret)
+		goto out_offload_error;
+
+	st->pwm_st.enabled = true;
+	ret = pwm_apply_might_sleep(st->cnv_pwm, &st->pwm_st);
+	if (ret)
+		goto out_pwm_error;
+
+	return 0;
+
+out_pwm_error:
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+out_offload_error:
+	if (st->gp1_irq)
+		enable_irq(st->gp1_irq);
+	spi_unoptimize_message(&st->offload_msg);
+out_xfer_error:
+	ad4052_exit_command(st);
+out_mode_error:
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static int ad4052_offload_buffer_predisable(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	int ret;
+
+	st->pwm_st.enabled = false;
+	pwm_apply_might_sleep(st->cnv_pwm, &st->pwm_st);
+
+	spi_offload_trigger_disable(st->offload, st->offload_trigger);
+	spi_unoptimize_message(&st->offload_msg);
+
+	ret = ad4052_exit_command(st);
+
+	if (st->gp1_irq)
+		enable_irq(st->gp1_irq);
+	pm_runtime_mark_last_busy(&st->spi->dev);
+	pm_runtime_put_autosuspend(&st->spi->dev);
+
+	return ret;
+}
+
+static const struct iio_buffer_setup_ops ad4052_buffer_offload_setup_ops = {
+	.postenable = &ad4052_offload_buffer_postenable,
+	.predisable = &ad4052_offload_buffer_predisable,
+};
+
 static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 				     unsigned int writeval, unsigned int *readval)
 {
@@ -884,9 +1000,82 @@ static const struct regmap_config ad4052_regmap_config = {
 	.can_sleep = true,
 };
 
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
+	int ret;
+
+	indio_dev->setup_ops = &ad4052_buffer_offload_setup_ops;
+
+	ret = devm_spi_offload_trigger_register(dev, &trigger_info);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to register offload trigger\n");
+
+	st->offload_trigger = devm_spi_offload_trigger_get(dev, st->offload,
+							   SPI_OFFLOAD_TRIGGER_DATA_READY);
+	if (IS_ERR(st->offload_trigger))
+		return PTR_ERR(st->offload_trigger);
+
+	st->cnv_pwm = devm_pwm_get(dev, NULL);
+	if (IS_ERR(st->cnv_pwm))
+		return dev_err_probe(dev, PTR_ERR(st->cnv_pwm), "failed to get CNV PWM\n");
+
+	pwm_init_state(st->cnv_pwm, &st->pwm_st);
+
+	st->pwm_st.enabled = false;
+	st->pwm_st.duty_cycle = AD4052_T_CNVH_NS * 2;
+	st->pwm_st.period = DIV_ROUND_UP_ULL(NSEC_PER_SEC, AD4052_MAX_RATE(st->chip->grade));
+
+	ret = pwm_apply_might_sleep(st->cnv_pwm, &st->pwm_st);
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
 static int __ad4052_validate_trigger_sources(struct of_phandle_args *trigger_sources)
 {
 	switch (trigger_sources->args[1]) {
+	case AD4052_TRIGGER_PIN_GP0:
+		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_EITHER_THRESH ?
+		       0 : -EINVAL;
 	case AD4052_TRIGGER_PIN_GP1:
 		return trigger_sources->args[0] == AD4052_TRIGGER_EVENT_DATA_READY ?
 		       0 : -EINVAL;
@@ -903,14 +1092,45 @@ static int ad4052_validate_trigger_sources(struct iio_dev *indio_dev)
 	int ret;
 
 	np = st->spi->dev.of_node;
+	for (u8 i = 0; i < 2; i++) {
+		ret = of_parse_phandle_with_args(np, "trigger-sources",
+						 "#trigger-source-cells", i,
+						 &trigger_sources);
+		if (ret)
+			return ret;
+
+		ret = __ad4052_validate_trigger_sources(&trigger_sources);
+		of_node_put(trigger_sources.np);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
+static int ad4052_validate_parent_trigger_sources(struct iio_dev *indio_dev)
+{
+	struct ad4052_state *st = iio_priv(indio_dev);
+	struct of_phandle_args trigger_sources;
+	struct device_node *np;
+	int ret;
+
+	np = of_get_parent(st->spi->dev.of_node);
+	if (!np)
+		return -ENODEV;
+
 	ret = of_parse_phandle_with_args(np, "trigger-sources",
 					 "#trigger-source-cells", 0,
 					 &trigger_sources);
 	if (ret)
-		return ret;
+		goto out_error;
 
-	ret = __ad4052_validate_trigger_sources(&trigger_sources);
+	if (trigger_sources.args[0] != AD4052_TRIGGER_EVENT_DATA_READY ||
+	    trigger_sources.args[1] != AD4052_TRIGGER_PIN_GP1)
+		ret = -EINVAL;
 	of_node_put(trigger_sources.np);
+out_error:
+	of_node_put(np);
 	return ret;
 }
 
@@ -986,6 +1206,26 @@ static int ad4052_probe(struct spi_device *spi)
 	indio_dev->info = &ad4052_info;
 	indio_dev->name = chip->name;
 
+	st->offload = devm_spi_offload_get(dev, spi, &ad4052_offload_config);
+	ret = PTR_ERR_OR_ZERO(st->offload);
+
+	if (ret == -ENODEV) {
+		st->offload_trigger = NULL;
+		indio_dev->channels = chip->channels;
+	} else if (!ret) {
+		indio_dev->channels = chip->offload_channels;
+		ret = ad4052_request_offload(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to configure offload\n");
+		ret = ad4052_validate_parent_trigger_sources(indio_dev);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to validate parent trigger sources\n");
+	} else {
+		return dev_err_probe(dev, ret, "Failed to get offload\n");
+	}
+
 	ret = ad4052_validate_trigger_sources(indio_dev);
 	if (ret)
 		return dev_err_probe(dev, ret,

-- 
2.49.0


