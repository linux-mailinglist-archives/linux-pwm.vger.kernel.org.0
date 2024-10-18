Return-Path: <linux-pwm+bounces-3711-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 193069A3BD4
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC39E1F2167D
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5211E202F60;
	Fri, 18 Oct 2024 10:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Py8jmRhv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B827B201258;
	Fri, 18 Oct 2024 10:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248203; cv=none; b=OKirTyeY2/DoyxV/oioV6uBsYknpvqo9xEoBOW6MDgeYPh5Zbi4mhR4fJdOhGXce2m4oD6ziueqen4UHV3Fdpu3BEs8GfG+z4o4J/8VUw/xwghFrp4WbM51TXQSNtE0oQUltut/HR+qrvsrAsIZEMPdntoElOrRAsImwPO9oqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248203; c=relaxed/simple;
	bh=64WYzmPwIVAKYe67JAEtl6QuKM/AAeKWf+GW1pXZhKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwTsrUqOa+NdQ1J/aktQBO8pXn65OSD01taD4AUU7i4bkyidIMeBa5QLZC1YUX+3w2OkG0BiIphf8FY6XUb+HT+cxQ0XV6+jhW/ic4gBgfuPzIOe69FE4BM45aKbt5Dzqa6t1WDx3b+mUNNSUVEz4GeNqVQOrv6Ax5LuUuu6T9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Py8jmRhv; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49I8h4M6018215;
	Fri, 18 Oct 2024 06:43:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SaPXF
	sO7Kbl/uLYgnsUtIWXV6GBWw2SwrS0O50t4izI=; b=Py8jmRhvFtzw2cl/Us/9+
	29Dd4K+6+0bXNaAH8Tf1045TKqlOIrj8vm9QPYjYyGYUEh0n4Vgf9xvptBCXpuGj
	37UJ6KNyGAj5cSPf6dcY54oEXB9ZAz0Aw0gasfMtLcE8DJd4jnh5m7okxsOTzthi
	1baDp2hbfGpx2MHKLbaS4EKTdJhO3t+oGYLtgCUv95Zt/Zrkqa5Sh7mUBMw0Mio9
	UxZOQxZytmINY5I+mrAbhnyb5A8YXDcFFrY6ArjUodEDWQcHkhWuyuO30+mxpBUa
	SknDDChmFj6tA8nuikXie02LGgB4Cj1bcaY84+6tH5cXMMgQhdbO+Sfm2wVxyPnx
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42bmdjret6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 06:43:19 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49IAhIGD002022
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Oct 2024 06:43:18 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Oct 2024 06:43:18 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 18 Oct 2024 06:43:17 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Oct 2024 06:43:17 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49IAh2iN028631;
	Fri, 18 Oct 2024 06:43:12 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <nuno.sa@analog.com>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 4/6] iio: adc: adi-axi-adc: set data format
Date: Fri, 18 Oct 2024 13:42:08 +0300
Message-ID: <20241018104210.51659-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018104210.51659-1-antoniu.miclaus@analog.com>
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: aqXYwtVevsbTB7dI-R55kDzCu3VZZ_Kd
X-Proofpoint-ORIG-GUID: aqXYwtVevsbTB7dI-R55kDzCu3VZZ_Kd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410180069

Add support for selecting the data format within the AXI ADC ip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - update indentation to match the rest of the driver.
 - shrink axi_adc_data_size_set in one line.
 drivers/iio/adc/adi-axi-adc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index ff48f26e02a3..57e56dbccc9a 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -45,6 +45,9 @@
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
+#define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   ADI_AXI_ADC_CNTRL_3_CUSTOM_CTRL_MSK	GENMASK(7, 0)
+
 #define ADI_AXI_ADC_REG_DRP_STATUS		0x0074
 #define   ADI_AXI_ADC_DRP_LOCKED		BIT(17)
 
@@ -271,6 +274,24 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
 	return 0;
 }
 
+static int axi_adc_data_size_set(struct iio_backend *back, ssize_t size)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+
+	if (size <= 20)
+		val = 0;
+	else if (size <= 24)
+		val = 1;
+	else if (size <= 32)
+		val = 3;
+	else
+		return -EINVAL;
+
+	return regmap_update_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				  ADI_AXI_ADC_CNTRL_3_CUSTOM_CONTROL_MSK, val);
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -308,6 +329,7 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.data_size_set = axi_adc_data_size_set,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)
-- 
2.46.2


