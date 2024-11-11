Return-Path: <linux-pwm+bounces-4062-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF419C3E30
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A05B1F22440
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938FB1A01C6;
	Mon, 11 Nov 2024 12:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="h0XllezJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D389719F43A;
	Mon, 11 Nov 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327164; cv=none; b=nCM3DeBXxZ3vWkdzmVZ5FVmyi1RpadICyARYv8OMconvGofuZNwvVjfnTzCMnS09mlY/GcGWc8hmIDeQyJ+fhbW3uLXY3yWawXyVx/S0WspPwJwtNtFh0D8Wh1SFJPhN0i585mUevWYF9lWKT/w37d5UuLgBROj4/6mG5WueBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327164; c=relaxed/simple;
	bh=hIH4g7vtbcaiO1ff16pbuv9V3C3QeYBWvvZrP5PKy/E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbjXqCv9bnHaGcZxX8FWIbxGjf4n9dwYg+pRe+6aPlv0O/Fm+kDThjPpZW0hJG68Hy1FXeBOFD4Kzy0W1JFD1kznrgd1PHNpkjVYt6NNNI0d7gpc9xplO/7ymdNo8yplYBTFQYY8u35eVxC8xf6UZsy37b8Im3KMrCMYV74a9kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=h0XllezJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9Lc3v010981;
	Mon, 11 Nov 2024 07:12:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=6lHPq
	vVGQSfpDB/3mAV1lW7mSJFE+XaV0+QGim0bzW8=; b=h0XllezJ06dqsi983aF9j
	Nlgt1qD5c+2AeosV2XPsvhMbfXRgCLZG1EtH8O8OKGu3Rh6SSADKe9nueZGf0RdN
	c2gy9vkTCwbjXdkiVdivj5nRq6QFp0vcFOzuJl3ZNzqlHMgQwmjw35OOSchEv4UF
	9a+U48cbQ8VGepgHLcdCTr4SZS0TXnzWtimEijYTQ99PG+QOSfEsHkYVhQqUivi+
	nYJ5EyQ2jB/+9tO7cyUcnCgWzp10fR8Pk9HSutSDK1PTESoNy0mEAkRZ/UM3nXJN
	9WXCftxLTcgAOBceHDsVqKdSI7zV2tv1vYNSlri1nx43FKf3tyI85Yp3PkOscllO
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42t2f6ydwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCbgx031082
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Nov
 2024 07:12:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:37 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEO010000;
	Mon, 11 Nov 2024 07:12:29 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 5/8] iio: adc: adi-axi-adc: set data format
Date: Mon, 11 Nov 2024 14:12:00 +0200
Message-ID: <20241111121203.3699-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111121203.3699-1-antoniu.miclaus@analog.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: opuzkDFlOqjSGolxDG6TW9RUqO8KNnIM
X-Proofpoint-GUID: opuzkDFlOqjSGolxDG6TW9RUqO8KNnIM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101

Add support for selecting the data format within the AXI ADC ip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - use switch case
 - add macro definition for packet format mask and sizes 
 drivers/iio/adc/adi-axi-adc.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index f6475bc93796..9bf967d5b730 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -45,6 +45,12 @@
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
+#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
+#define   AD485X_PACKET_FORMAT_20BIT		0x0
+#define   AD485X_PACKET_FORMAT_24BIT		0x1
+#define   AD485X_PACKET_FORMAT_32BIT		0x2
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -312,6 +318,29 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
 	return 0;
 }
 
+static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+
+	switch (size) {
+	case 20:
+		val = AD485X_PACKET_FORMAT_20BIT;
+		break;
+	case 24:
+		val = AD485X_PACKET_FORMAT_24BIT;
+		break;
+	case 32:
+		val = AD485X_PACKET_FORMAT_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				  AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -360,6 +389,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.data_size_set = axi_adc_data_size_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.47.0


