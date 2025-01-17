Return-Path: <linux-pwm+bounces-4649-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE971A15022
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E08911647F2
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE0E20012C;
	Fri, 17 Jan 2025 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="LdcMNyYL"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E101FFC55;
	Fri, 17 Jan 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119250; cv=none; b=QWgiYiFvAdk3Pg1Y5v7OZT+bUJlnYafKe+AagUB4c93rmyvfRMjh3qLlUi16JVcyjxDOHR9WfdQSnesMAyMW87B2Uww2xDwNTmYI4FTiMKdGZEL6j/b4Re4saK5QaHdFtHBSUTK6oI1ZeB6nrXCc4cASbq9+RHahQpsDen+2y0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119250; c=relaxed/simple;
	bh=J9Fj64Guq4vYQwAu5jLwn607LJ8srdDo1kUsvoz7MKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPUuQ1r1JD2fSE2GA8QO3w2C/Ex9YC9TIWjCUW/RoJimNOaxGFDYV/QFBacQZ+qNx9bnQ8G7etlXDfWi8aaUCR7FFyTSpRbCgECOQS9+CoSwLdAmIFKxIbY7oK/ySQ6MqkJvcRAx8F5rgjnl98zaKCDF+iJTSdED1YdWgDFOHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=LdcMNyYL; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HBDV96027922;
	Fri, 17 Jan 2025 08:07:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+w2lI
	WQl+cv6QnEaoCZm3OV4luCazw8jpdxtmhyazbY=; b=LdcMNyYLlkUOiRCgh3nmW
	T8ix16wELvduPQi6dlJoGxhsrrIdpzaU6LEhZT2Q8t8ojQ3C89/n95ZCbmwlMV/F
	yLx/vfoCHfvkRTaGwx4FeouogcLNeWmytVOjcGHgi+zitY987t8ZhV+0xMB6m4km
	F62p/tGqq2IzrdOxwNxdL3de8ptYyKUQ25reLalwAnMwVifx6MOw89mNkV34ZVhg
	e1qzQCW/5h0o7Q3yW1pm6XImJR0t9ngB2fOrZVkiEK/GYp0eM+K6hxJFFDXUZOx9
	NsUpk8ol7mC/vZ8ynWoY+Hxgcj8SfggIcrZ6vyM2f9P2EErrfvIhtg0JCG9kfXUL
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 447j7usjbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:07:26 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50HD7Pnl027826
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 08:07:25 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 17 Jan
 2025 08:07:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 17 Jan 2025 08:07:24 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50HD764o013564;
	Fri, 17 Jan 2025 08:07:19 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v10 6/8] iio: adc: adi-axi-adc: add oversampling
Date: Fri, 17 Jan 2025 15:07:00 +0200
Message-ID: <20250117130702.22588-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117130702.22588-1-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: L2ikV6L7lRuqtAY8B9Qh2FP-ttYCDOkJ
X-Proofpoint-ORIG-GUID: L2ikV6L7lRuqtAY8B9Qh2FP-ttYCDOkJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 impostorscore=0 mlxscore=0
 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170106

Add support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v10.
 drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 3c213ca5ff8e..ce88650bbb62 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -46,6 +46,7 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AD485X_PACKET_FORMAT_20BIT		0x0
 #define   AD485X_PACKET_FORMAT_24BIT		0x1
@@ -357,6 +358,23 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
 				  FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
 }
 
+static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
+					  unsigned int ratio)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	switch (ratio) {
+	case 0:
+		return -EINVAL;
+	case 1:
+		return regmap_clear_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+					 AD485X_CNTRL_3_OS_EN_MSK);
+	default:
+		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				       AD485X_CNTRL_3_OS_EN_MSK);
+	}
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -406,6 +424,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.data_size_set = axi_adc_data_size_set,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


