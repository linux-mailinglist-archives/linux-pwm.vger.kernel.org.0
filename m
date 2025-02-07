Return-Path: <linux-pwm+bounces-4816-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5708BA2C501
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5655F3A6079
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF001F942D;
	Fri,  7 Feb 2025 14:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="1Ta6C5NN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626BE1EEA20;
	Fri,  7 Feb 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937404; cv=none; b=g9rUGVcrET4qgbZB8UipNbTnjpO/eUFh16ee1N+2ImTlB6yFlJBcp4Cc2EeJQL+dbUleM4VxDNcDLtkpIoeehl7EUJ/SfW2DOLQykKRBFzje/puw+MHsB1PsnQ6sBmGmmlTjxpyJ8dXjUGiQI4699th3dWIDB6hSV3UNVNTZMmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937404; c=relaxed/simple;
	bh=rw/FD1qYUNPWWkZfKh/UXa8DmKZVg5ap8h/Yyk+uIO8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cA9tf1lJjJZKH4oF6ssB/OE32cbjdoPtKgiqNVG/vVmQHhMxd1dCfLYMb29KW4JIhk5HdUemgOQo4ktK7c8zSkLZunV6mUx2iTrMuChs2SbKDRbjBffghE9CwU3icqaEtK/7o/QCVTEhBZMzslrz9zkuvGczff1k8eO555aq8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=1Ta6C5NN; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5179KhjW022340;
	Fri, 7 Feb 2025 09:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XEvkw
	jD/b79ghrtg6FVhobImGr58jujX0CN7LSQrabM=; b=1Ta6C5NNipGOTPu9z/ueH
	5WDjHIFnrbtsNjEFF8oiZlmgugbHy4ECsPDgGO10xUhYvsTORrprbepYCqZf+9Jc
	JN0xcznhQAh/wWUwgs+k1B00A4V8gNpKEiizIzDtJSyO/htWTrleP0E2BWOh9LJ+
	bqXCaclY2LxX55LpUIBrg+RX30QxHS80KsLWIjWpf9v4zqnfPm0jTPRmfQSWCtx7
	LVhg8cBsXJqv4boqedXcArR46mGaJDJ+uf92p6KVJWKD+qwMjiOLi7VRrUvhD67i
	U6n9K72cTvYfOgCuJx529PdfxFUUcz7Fx7t9cdd92CAUIg+sbOfnxgzVj0cEtdUv
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44nff99133-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:09:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 517E9wM5056739
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:58 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:57 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4s015095;
	Fri, 7 Feb 2025 09:09:50 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v12 6/9] iio: adc: adi-axi-adc: set data format
Date: Fri, 7 Feb 2025 16:09:15 +0200
Message-ID: <20250207140918.7814-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207140918.7814-1-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Qgh8kqjyB-1VkInoHPz4UQ_FjxX4AKue
X-Proofpoint-ORIG-GUID: Qgh8kqjyB-1VkInoHPz4UQ_FjxX4AKue
X-Authority-Analysis: v=2.4 cv=Pt9pbxM3 c=1 sm=1 tr=0 ts=67a61437 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=aOhm76t3-4eR91JY8X8A:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add support for selecting the data format within the AXI ADC ip.

Add separate complatible string for the custom AD485X IP and implement
the necessary changes.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v12:
 - add separate compatible for ad485x AXI IP core.
 drivers/iio/adc/adi-axi-adc.c | 99 +++++++++++++++++++++++++++++++----
 1 file changed, 90 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index d2e1dc63775c..272d82c6e887 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -45,6 +45,12 @@
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
+#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
+#define   AD485X_PACKET_FORMAT_20BIT		0x0
+#define   AD485X_PACKET_FORMAT_24BIT		0x1
+#define   AD485X_PACKET_FORMAT_32BIT		0x2
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -83,11 +89,17 @@
 	 ADI_AXI_REG_CHAN_CTRL_FMT_EN |		\
 	 ADI_AXI_REG_CHAN_CTRL_ENABLE)
 
+struct axi_adc_info {
+	unsigned int version;
+	const struct iio_backend_info *backend_info;
+};
+
 struct adi_axi_adc_state {
 	struct regmap *regmap;
 	struct device *dev;
 	/* lock to protect multiple accesses to the device registers */
 	struct mutex lock;
+	const struct axi_adc_info *info;
 };
 
 static int axi_adc_enable(struct iio_backend *back)
@@ -312,6 +324,45 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
 	return 0;
 }
 
+static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+
+	switch (size) {
+	/*
+	 * There are two different variants of the AXI AD485X IP block, a 16-bit
+	 * and a 20-bit variant.
+	 * The 0x0 value (AD485X_PACKET_FORMAT_20BIT) is corresponding also to
+	 * the 16-bit variant of the IP block.
+	 */
+	case 16:
+	case 20:
+		val = AD485X_PACKET_FORMAT_20BIT;
+		break;
+	case 24:
+		val = AD485X_PACKET_FORMAT_24BIT;
+		break;
+	/*
+	 * The 0x2 (AD485X_PACKET_FORMAT_32BIT) corresponds only to the 20-bit
+	 * variant of the IP block. Setting this value properly is ensured by
+	 * the upper layers of the drivers calling the axi-adc functions.
+	 * Also, for 16-bit IP block, the 0x2 (AD485X_PACKET_FORMAT_32BIT)
+	 * value is handled as maximum size available which is 24-bit for this
+	 * configuration.
+	 */
+	case 32:
+		val = AD485X_PACKET_FORMAT_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				  AD485X_CNTRL_3_PACKET_FORMAT_MSK,
+				  FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -364,14 +415,35 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
 
+static const struct iio_backend_ops adi_ad485x_ops = {
+	.enable = axi_adc_enable,
+	.disable = axi_adc_disable,
+	.data_format_set = axi_adc_data_format_set,
+	.chan_enable = axi_adc_chan_enable,
+	.chan_disable = axi_adc_chan_disable,
+	.request_buffer = axi_adc_request_buffer,
+	.free_buffer = axi_adc_free_buffer,
+	.data_sample_trigger = axi_adc_data_sample_trigger,
+	.iodelay_set = axi_adc_iodelays_set,
+	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
+	.data_size_set = axi_adc_data_size_set,
+	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
+	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
+};
+
 static const struct iio_backend_info adi_axi_adc_generic = {
 	.name = "axi-adc",
 	.ops = &adi_axi_adc_ops,
 };
 
+static const struct iio_backend_info axi_ad485x = {
+	.name = "axi-ad485x",
+	.ops = &adi_ad485x_ops,
+};
+
 static int adi_axi_adc_probe(struct platform_device *pdev)
 {
-	const unsigned int *expected_ver;
 	struct adi_axi_adc_state *st;
 	void __iomem *base;
 	unsigned int ver;
@@ -393,8 +465,8 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(st->regmap),
 				     "failed to init register map\n");
 
-	expected_ver = device_get_match_data(&pdev->dev);
-	if (!expected_ver)
+	st->info = device_get_match_data(&pdev->dev);
+	if (!st->info)
 		return -ENODEV;
 
 	clk = devm_clk_get_enabled(&pdev->dev, NULL);
@@ -414,19 +486,19 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(*expected_ver)) {
+	if (ADI_AXI_PCORE_VER_MAJOR(ver) != ADI_AXI_PCORE_VER_MAJOR(st->info->version)) {
 		dev_err(&pdev->dev,
 			"Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
-			ADI_AXI_PCORE_VER_MAJOR(*expected_ver),
-			ADI_AXI_PCORE_VER_MINOR(*expected_ver),
-			ADI_AXI_PCORE_VER_PATCH(*expected_ver),
+			ADI_AXI_PCORE_VER_MAJOR(st->info->version),
+			ADI_AXI_PCORE_VER_MINOR(st->info->version),
+			ADI_AXI_PCORE_VER_PATCH(st->info->version),
 			ADI_AXI_PCORE_VER_MAJOR(ver),
 			ADI_AXI_PCORE_VER_MINOR(ver),
 			ADI_AXI_PCORE_VER_PATCH(ver));
 		return -ENODEV;
 	}
 
-	ret = devm_iio_backend_register(&pdev->dev, &adi_axi_adc_generic, st);
+	ret = devm_iio_backend_register(&pdev->dev,  st->info->backend_info, st);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
@@ -439,11 +511,20 @@ static int adi_axi_adc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static unsigned int adi_axi_adc_10_0_a_info = ADI_AXI_PCORE_VER(10, 0, 'a');
+static const struct axi_adc_info adi_axi_adc_10_0_a_info = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &adi_axi_adc_generic,
+};
+
+static const struct axi_adc_info adi_axi_ad485x = {
+	.version = ADI_AXI_PCORE_VER(10, 0, 'a'),
+	.backend_info = &axi_ad485x,
+};
 
 /* Match table for of_platform binding */
 static const struct of_device_id adi_axi_adc_of_match[] = {
 	{ .compatible = "adi,axi-adc-10.0.a", .data = &adi_axi_adc_10_0_a_info },
+	{ .compatible = "adi,axi-ad485x", .data = &adi_axi_ad485x },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, adi_axi_adc_of_match);
-- 
2.48.1


