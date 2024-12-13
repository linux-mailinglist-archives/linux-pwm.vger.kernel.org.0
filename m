Return-Path: <linux-pwm+bounces-4337-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF4E9F128A
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 17:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A0FD168D4A
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 16:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B701EC01B;
	Fri, 13 Dec 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rFxgOzvK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307701E8854;
	Fri, 13 Dec 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108314; cv=none; b=fIwvEvFkjmst4fnnWzgVYVC6/UCUori00KjN1g4tJErvluuc9Rkk000600mvFHvmWRuylTs04PpZZgt9UW0Vihrob0SQx9RXKBysFR9tN7SNjfsDI/iqspxdVt5UsvNY29EtIFCDod8uM4TDT3jHYmcNUiEuWkfv/2CA/JKOiDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108314; c=relaxed/simple;
	bh=CTJgn01sYmirQD3iBPRAOP/1H2OScgBbgP9jPMpqHVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lgUBf21MUmgxoGOs/1uhMoDBgBu9Ak3rmj6+IDPI0zLyj8PxHAiUcUAZmvi8NOXskqmYC/+N2UwXD3rTp8URZ81TtU7vpIRqoOzhCDvbj/8C/KiZECaEd00bOyIeODGXOWRmjGDciuFvnO2p7Ub/FHhch4h/QoNE1Y1ApJIHEmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rFxgOzvK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDD7Yuv018158;
	Fri, 13 Dec 2024 11:45:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PTB59
	s9QQc6PHARxhTKeA+Ig1Qt8VIwocxFXWaVVSzw=; b=rFxgOzvKCFCuNeX/y6wV+
	2+Vvwk3mT3DCIGmAHDHYrCAaUs52pNOQDXAPSWX+UeSsaMOm4YYTUN2tsaQR70HI
	q1ALMCoQTP+b/XihslzIefDmVh7hfER2yjbewYDMdxnQbeFtO1Q1dCnuSe4/9TDR
	IwXqdA1pQa1J/pVZJuqbeFpK5DuUedJAyZtkz24tMptTGywfTuireliSJxhcjXRx
	lOJeQvFMvSZ05OZsPwR+HI2UKCw4BuKJT7ZFey5diCpIC8n6Jg77udkpWJPrQp+6
	Bzgs7VHheUTl2TG0Zg2ElRgR8RM4lOTsWsr10ZWV61Szxpt59WcZg90zdQ2+oURM
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43gnhm8vy8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGj8Uu030803
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:08 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 11:45:08 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:08 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcG025509;
	Fri, 13 Dec 2024 11:45:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v8 6/8] iio: adc: adi-axi-adc: add oversampling
Date: Fri, 13 Dec 2024 18:44:43 +0200
Message-ID: <20241213164445.23195-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213164445.23195-1-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yz-xHW_VzpdZq8An5uKjM_xEMgLh75yp
X-Proofpoint-GUID: yz-xHW_VzpdZq8An5uKjM_xEMgLh75yp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 adultscore=0 impostorscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 mlxlogscore=994 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412130117

Add support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v8:
 - use oversampling ratio set.
 drivers/iio/adc/adi-axi-adc.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 9a3968769512..24d530789e4c 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -46,6 +46,7 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK	BIT(2)
 #define   AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AD485X_PACKET_FORMAT_20BIT		0x0
 #define   AD485X_PACKET_FORMAT_24BIT		0x1
@@ -357,6 +358,23 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
 				  FIELD_PREP(AD485X_CNTRL_3_CUSTOM_CTRL_PACKET_FORMAT_MSK, val));
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
+					 AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK);
+	default:
+		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				       AD485X_CNTRL_3_CUSTOM_CTRL_OS_EN_MSK);
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
2.47.1


