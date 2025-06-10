Return-Path: <linux-pwm+bounces-6274-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 763EDAD2EF9
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07A2C3A5190
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BD2283689;
	Tue, 10 Jun 2025 07:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WxlO+A3H"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3624128150E;
	Tue, 10 Jun 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540935; cv=none; b=R5ioruTWYk97GLMX5Jp/hMat8/sEZyjiehfAhWjUyevgNVd31wz2P9gyb9iJI/Ch/VL3jpksEoQ5xLSUrVTWJup983F6Fg+RKN/EXbp0ym6v4tVb0x1taaxA9DH6BY9qdFksq65NCFCg3vC/4krRmFTT/HJoEsy9cQEDKoc+W1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540935; c=relaxed/simple;
	bh=67vqsQFKrx+1Cvq6u0R9aLnvPfGFMBTPpy5ZRrwcVdo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Bu5be/pnfVShLhgitLZOLEJI0o2euwDCLs6xTrxy2qQEAZk+8Ig0YIl/cXKJcA0ZiTy0KcrhB61DraOy85CDplJtHiDVuJQlBElzY0DqOnt3naolqUGuOZu2o8qSCivIxhHl/ubMkwTG884nUqwG1eCqcmnweIPTALhugFeNfVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WxlO+A3H; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6g8Bw023177;
	Tue, 10 Jun 2025 03:35:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PdiwW
	te0EQfXZhMDSFids8Uilx5wSOu5fIwj73rqFe0=; b=WxlO+A3H5jgXlhLj3K0U3
	qYPCp4BDFGXS2m9sVzvI9J+B3qgswO92lA0tDepgr57Lj57vaJdhcdyzAxkrDpMx
	0z0Jvq/IXJeqwnOvi48jKqexilMLVAdw4jhHhmkcXLsKerXanQfzPHIJ387VTGMJ
	cou0mAqx6kcUIscSaa1oC6Z7Nbs71b8hgx+hvi94DSW5iMKOtBS/qtQb2sDNn1Oq
	jDFBkGkoEPeYRdpRwa4VRTatWkKw/kI+BUpt46bL2hDaj1CqgKTA9xAkV6ARLGKr
	AVPQTqJPJANWROVh3UrkHSdMWQ1cq3m85szUQ1Ai3yd8ZbXjkN4DOtNU6K+PjhZs
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 476fc30bm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:18 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7ZHeK056193
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:17 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:17 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMm002608;
	Tue, 10 Jun 2025 03:35:08 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:41 +0200
Subject: [PATCH v3 8/8] iio: adc: Add events support to ad4052
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-8-cf1e44c516d4@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=14324;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=67vqsQFKrx+1Cvq6u0R9aLnvPfGFMBTPpy5ZRrwcVdo=;
 b=r1eUQMrtq0Ig2WfeFCktd3ICTFupK/fokJk7mNgVZmsy4tnRNY5su5brytsanCBUnV+9o3mBu
 mX35kDrGZ+oAsEHO6Y1U2HFO5RoDBULTIgtZLXOodwRXjyBKqThziIX
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Q_qD2OjAl66vdp0xwe2bECq9tlrKjF9d
X-Proofpoint-ORIG-GUID: Q_qD2OjAl66vdp0xwe2bECq9tlrKjF9d
X-Authority-Analysis: v=2.4 cv=LtaSymdc c=1 sm=1 tr=0 ts=6847e036 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=gAnH3GRIAAAA:8 a=U75sXf5VTUVOPaN5l64A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX9vMwO2rdf8Ij
 z1a6rGTzhv/VUNDPx0xXecu4//5RNXcSV0ufodU4Vf/uQHCsxoxiKgLaygrPPnWaib4QpNlt86h
 U0W55rQALaxURNUbTH1rtyg9rM0zr2a+DJ6luIXVYu0NL/uwitq3wEtLYcv427A9g0FHq/4uNrv
 TaQznLZ3pTlFutmHoD+n0EIhvMt4Zt+9W36UyBnSOAPXQAVP+hnppyuq0AFB66drn3GJrKdaEhR
 pYvlCAnq46aPI6I0PZY2a7DXQLYAcu/DrtmGHfDkxBKwuLfeTYlLn+tBI/pCGk6Qg8aVSnQg7F+
 ICfMVfcqPuOH/mn6IRs4spotaEY0SRu9CBFmnu9R6s2J90QmKfAMcSyrBVWxEpCthz6RU7rByrz
 hA2nIi2remoAsQcDMPnFlC/J8SbeiNA2YJ/+thT7jWlPPjFS3z2fxDAjzniktP1jqmtWQ2CT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100056

The AD4052 family supports autonomous monitoring readings for threshold
crossings. Add support for catching the GPIO interrupt and expose as an IIO
event. The device allows to set either, rising and falling directions. Only
either threshold crossing is implemented.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/adc/ad4052.c | 369 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 369 insertions(+)

diff --git a/drivers/iio/adc/ad4052.c b/drivers/iio/adc/ad4052.c
index 7d32dc4701ddb0204b5505a650ce7caafc2cb5ed..ff52ff002bfe0ee413ae352b0c1854798b8e89f8 100644
--- a/drivers/iio/adc/ad4052.c
+++ b/drivers/iio/adc/ad4052.c
@@ -13,6 +13,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer-dmaengine.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 #include <linux/interrupt.h>
@@ -69,6 +70,8 @@
 #define AD4052_REG_MON_VAL				0x2F
 #define AD4052_REG_FUSE_CRC				0x40
 #define AD4052_REG_DEVICE_STATUS			0x41
+#define     AD4052_REG_DEVICE_STATUS_MIN_FLAG		BIT(2)
+#define     AD4052_REG_DEVICE_STATUS_MAX_FLAG		BIT(3)
 #define     AD4052_REG_DEVICE_STATUS_DEVICE_RDY		BIT(7)
 #define     AD4052_REG_DEVICE_STATUS_DEVICE_RESET	BIT(6)
 #define AD4052_REG_MIN_SAMPLE				0x45
@@ -173,6 +176,8 @@ struct ad4052_state {
 	struct completion completion;
 	struct regmap *regmap;
 	u16 oversampling_frequency;
+	u16 events_frequency;
+	bool wait_event;
 	int gp1_irq;
 	int vio_uv;
 	int vref_uv;
@@ -259,6 +264,26 @@ static const struct regmap_access_table ad4052_regmap_wr_table = {
 	.n_yes_ranges = ARRAY_SIZE(ad4052_regmap_wr_ranges),
 };
 
+static const struct iio_event_spec ad4052_events[] = {
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_EITHER,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_ENABLE),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_RISING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+	{
+		.type = IIO_EV_TYPE_THRESH,
+		.dir = IIO_EV_DIR_FALLING,
+		.mask_shared_by_all = BIT(IIO_EV_INFO_VALUE) |
+				      BIT(IIO_EV_INFO_HYSTERESIS),
+	},
+};
+
 static const char *const ad4052_conversion_freqs[] = {
 	"2000000", "1000000", "300000", "100000",	/*  0 -  3 */
 	"33300", "10000", "3000", "500",		/*  4 -  7 */
@@ -328,6 +353,8 @@ AD4052_EXT_INFO(AD4052_500KSPS);
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
 	.has_ext_scan_type = 1,								\
 	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
 	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
@@ -344,6 +371,8 @@ AD4052_EXT_INFO(AD4052_500KSPS);
 	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),	\
 	.indexed = 1,									\
 	.channel = 0,									\
+	.event_spec = ad4052_events,							\
+	.num_event_specs = ARRAY_SIZE(ad4052_events),					\
 	.has_ext_scan_type = 1,								\
 	.ext_scan_type = ad4052_scan_type_##bits##_s,					\
 	.num_ext_scan_type = ARRAY_SIZE(ad4052_scan_type_##bits##_s),			\
@@ -386,6 +415,74 @@ static const struct ad4052_chip_info ad4058_chip_info = {
 	.grade = AD4052_500KSPS,
 };
 
+static ssize_t ad4052_events_frequency_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
+
+	return sysfs_emit(buf, "%s\n", ad4052_conversion_freqs[st->events_frequency]);
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
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	ret = __sysfs_match_string(AD4052_FS(st->chip->grade),
+				   AD4052_FS_LEN(st->chip->grade), buf);
+	if (ret < 0)
+		goto out_release;
+
+	st->events_frequency = ret;
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(sampling_frequency, 0644,
+		       ad4052_events_frequency_show,
+		       ad4052_events_frequency_store, 0);
+
+static ssize_t sampling_frequency_available_show(struct device *dev,
+						 struct device_attribute *attr,
+						 char *buf)
+{
+	struct ad4052_state *st = iio_priv(dev_to_iio_dev(dev));
+	int ret = 0;
+
+	for (u8 i = AD4052_FS_OFFSET(st->chip->grade);
+	     i < AD4052_FS_LEN(st->chip->grade); i++)
+		ret += sysfs_emit_at(buf, ret, "%s ", ad4052_conversion_freqs[i]);
+
+	ret += sysfs_emit_at(buf, ret, "\n");
+	return ret;
+}
+
+static IIO_DEVICE_ATTR_RO(sampling_frequency_available, 0);
+
+static struct attribute *ad4052_event_attributes[] = {
+	&iio_dev_attr_sampling_frequency.dev_attr.attr,
+	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
+	NULL
+};
+
+static const struct attribute_group ad4052_event_attribute_group = {
+	.attrs = ad4052_event_attributes,
+};
+
 static int ad4052_update_xfer_raw(struct iio_dev *indio_dev,
 				   struct iio_chan_spec const *chan)
 {
@@ -602,6 +699,19 @@ static int ad4052_setup(struct iio_dev *indio_dev, struct iio_chan_spec const *c
 				  val);
 }
 
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
 static irqreturn_t ad4052_irq_handler_drdy(int irq, void *private)
 {
 	struct ad4052_state *st = private;
@@ -616,6 +726,18 @@ static int ad4052_request_irq(struct iio_dev *indio_dev)
 	struct device *dev = &st->spi->dev;
 	int ret;
 
+	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp0");
+	if (ret > 0) {
+		ret = devm_request_threaded_irq(dev, ret, NULL,
+						ad4052_irq_handler_thresh,
+						IRQF_ONESHOT, indio_dev->name,
+						indio_dev);
+		if (ret)
+			return ret;
+	} else if (ret == -EPROBE_DEFER) {
+		return ret;
+	}
+
 	ret = fwnode_irq_get_byname(dev_fwnode(&st->spi->dev), "gp1");
 	if (ret > 0) {
 		ret = devm_request_threaded_irq(dev, ret, NULL,
@@ -822,6 +944,7 @@ static int ad4052_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long info)
 {
+	struct ad4052_state *st = iio_priv(indio_dev);
 	int ret;
 
 	if (info ==  IIO_CHAN_INFO_SAMP_FREQ)
@@ -831,8 +954,14 @@ static int ad4052_read_raw(struct iio_dev *indio_dev,
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
 
 	ret = ad4052_read_raw_dispatch(indio_dev, chan, val, val2, info);
+
+out_release:
 	iio_device_release_direct(indio_dev);
 	return ret ? ret : IIO_VAL_INT;
 }
@@ -867,8 +996,231 @@ static int ad4052_write_raw(struct iio_dev *indio_dev,
 
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
 
 	ret = ad4052_write_raw_dispatch(indio_dev, chan, val, val2, info);
+
+out_release:
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
+	if (ret)
+		return ret;
+	return regmap_write(st->regmap, AD4052_REG_DEVICE_STATUS,
+			    AD4052_REG_DEVICE_STATUS_MAX_FLAG |
+			    AD4052_REG_DEVICE_STATUS_MIN_FLAG);
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
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+	if (st->wait_event == state) {
+		ret = 0;
+		goto out_release;
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
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret;
+}
+
+static int __ad4052_read_event_info_value(struct ad4052_state *st,
+					   enum iio_event_direction dir, int *val)
+{
+	int ret;
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4052_REG_MAX_LIMIT;
+	else
+		reg = AD4052_REG_MIN_LIMIT;
+
+	ret = regmap_bulk_read(st->regmap, reg, &st->raw, 2);
+	if (ret)
+		return ret;
+
+	*val = sign_extend32(get_unaligned_be16(st->raw), 11);
+
+	return 0;
+}
+
+static int __ad4052_read_event_info_hysteresis(struct ad4052_state *st,
+						enum iio_event_direction dir, int *val)
+{
+	u8 reg;
+
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4052_REG_MAX_HYST;
+	else
+		reg = AD4052_REG_MIN_HYST;
+	return regmap_read(st->regmap, reg, val);
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
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	switch (info) {
+	case IIO_EV_INFO_VALUE:
+		ret = __ad4052_read_event_info_value(st, dir, val);
+		break;
+	case IIO_EV_INFO_HYSTERESIS:
+		ret = __ad4052_read_event_info_hysteresis(st, dir, val);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_release:
+	iio_device_release_direct(indio_dev);
+	return ret ? ret : IIO_VAL_INT;
+}
+
+static int __ad4052_write_event_info_value(struct ad4052_state *st,
+					   enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val > 2047 || val < -2048)
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4052_REG_MAX_LIMIT;
+	else
+		reg = AD4052_REG_MIN_LIMIT;
+	put_unaligned_be16(val, &st->raw);
+
+	return regmap_bulk_write(st->regmap, reg, &st->raw, 2);
+}
+
+static int __ad4052_write_event_info_hysteresis(struct ad4052_state *st,
+						enum iio_event_direction dir, int val)
+{
+	u8 reg;
+
+	if (val >= BIT(7))
+		return -EINVAL;
+	if (dir == IIO_EV_DIR_RISING)
+		reg = AD4052_REG_MAX_HYST;
+	else
+		reg = AD4052_REG_MIN_HYST;
+
+	return regmap_write(st->regmap, reg, val);
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
+	int ret;
+
+	if (!iio_device_claim_direct(indio_dev))
+		return -EBUSY;
+
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
+	switch (type) {
+	case IIO_EV_TYPE_THRESH:
+		switch (info) {
+		case IIO_EV_INFO_VALUE:
+			ret = __ad4052_write_event_info_value(st, dir, val);
+			break;
+		case IIO_EV_INFO_HYSTERESIS:
+			ret = __ad4052_write_event_info_hysteresis(st, dir, val);
+			break;
+		default:
+			ret = -EINVAL;
+			break;
+		}
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+out_release:
 	iio_device_release_direct(indio_dev);
 	return ret;
 }
@@ -881,6 +1233,9 @@ static int ad4052_offload_buffer_postenable(struct iio_dev *indio_dev)
 	};
 	int ret;
 
+	if (st->wait_event)
+		return -EBUSY;
+
 	ret = pm_runtime_resume_and_get(&st->spi->dev);
 	if (ret)
 		return ret;
@@ -963,10 +1318,17 @@ static int ad4052_debugfs_reg_access(struct iio_dev *indio_dev, unsigned int reg
 	if (!iio_device_claim_direct(indio_dev))
 		return -EBUSY;
 
+	if (st->wait_event) {
+		ret = -EBUSY;
+		goto out_release;
+	}
+
 	if (readval)
 		ret = regmap_read(st->regmap, reg, readval);
 	else
 		ret = regmap_write(st->regmap, reg, writeval);
+
+out_release:
 	iio_device_release_direct(indio_dev);
 	return ret;
 }
@@ -985,6 +1347,11 @@ static const struct iio_info ad4052_info = {
 	.read_raw = ad4052_read_raw,
 	.write_raw = ad4052_write_raw,
 	.read_avail = ad4052_read_avail,
+	.read_event_config = &ad4052_read_event_config,
+	.write_event_config = &ad4052_write_event_config,
+	.read_event_value = &ad4052_read_event_value,
+	.write_event_value = &ad4052_write_event_value,
+	.event_attrs = &ad4052_event_attribute_group,
 	.get_current_scan_type = &ad4052_get_current_scan_type,
 	.debugfs_reg_access = &ad4052_debugfs_reg_access,
 };
@@ -1193,8 +1560,10 @@ static int ad4052_probe(struct spi_device *spi)
 				     "Failed to initialize regmap\n");
 
 	st->mode = AD4052_SAMPLE_MODE;
+	st->wait_event = false;
 	st->chip = chip;
 	st->oversampling_frequency = AD4052_FS_OFFSET(st->chip->grade);
+	st->events_frequency = AD4052_FS_OFFSET(st->chip->grade);
 
 	st->cnv_gp = devm_gpiod_get_optional(dev, "cnv", GPIOD_OUT_LOW);
 	if (IS_ERR(st->cnv_gp))

-- 
2.49.0


