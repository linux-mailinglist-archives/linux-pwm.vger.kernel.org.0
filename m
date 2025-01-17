Return-Path: <linux-pwm+bounces-4648-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C3A1501F
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBC0E7A37C8
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA5D1FFC73;
	Fri, 17 Jan 2025 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rqDIq7qn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BF91FF61B;
	Fri, 17 Jan 2025 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119249; cv=none; b=Ebe84XtPw2/JgbDK7IUCSOxf65dSardPOLdMaJ6AZ15UxFmzu9iCI0y0zl0rqjP2M40Hj4OZH07jewb+fkVbK9MWp+CoekrTLuQ22t2yX5s/X3O3XPmH9UCSaAuhUT0T02z7P+MCF6jWcS9pDEk6wM9/oHDvm+ZVAltIOHktfas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119249; c=relaxed/simple;
	bh=Q5Fqzes5YMepQZq5xoFOu8k4cUl+9RQhGCxcy6Ai8fQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vq4s+xlPJv+qMcUJtKvhibPiUgBltFYRZ7lrY9ASCfQBEhki0lDNOlVzET48jesB7jmP6rrpkVpR2rsU+cjCUJbJNJWT4nCXjrsR4itZzyqQtb5e7NGqY9TN2VLT4rwYO2Bgal413lQhiYIF9OYl2W7wRSqlsnN3b83ItkF51OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rqDIq7qn; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H90AA2025639;
	Fri, 17 Jan 2025 08:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=F9UVj
	c0CF6s4nDGRJmM2WAQ8EHaOL+/f8DeHyiSMiq0=; b=rqDIq7qn3i/r23vC3W09M
	aBSs/NDXuYuLQkecu/xeVAJ4YI9tfYs4pmWGMBhf+Zzs7kmEZ1A1TQ7XqZVqQVk1
	vUlaGxunqHRlD8u9GHo8vpV++sgl5ueAEayJgt0npUkI/GroJbWxeaO4YigLOVQE
	G6tCgh5mJ5tNIQWYB4vtRJAqyJQiCyyDaCL/9WPRv/hfIyP+s3608w1qSKhoLolD
	S7RZyialNhmDaH7KP+lHXNxLoYB6H7Pr6IE8+RRq3LkDJVFE1YdiHcc+KHEDfSCo
	fiSyP/M2W7ivbCuXc0Ys5YBPVS1c2TvDeay3Hy0BS5xrH+CQnEMir0mtfNMOMHhM
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 447m6nryjh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:07:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50HD7MbN027809
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 08:07:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 17 Jan
 2025 08:07:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 17 Jan 2025 08:07:22 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50HD764m013564;
	Fri, 17 Jan 2025 08:07:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v10 4/8] iio: adc: adi-axi-adc: add interface type
Date: Fri, 17 Jan 2025 15:06:58 +0200
Message-ID: <20250117130702.22588-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: Hl5LaaTo1Y5R3jwTGGHRI1e80GIyV6RC
X-Proofpoint-ORIG-GUID: Hl5LaaTo1Y5R3jwTGGHRI1e80GIyV6RC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170106

Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
IP.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v10.
 drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f8..d2e1dc63775c 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -39,6 +39,9 @@
 #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
 #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
 
+#define ADI_AXI_ADC_REG_CONFIG			0x000c
+#define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
+
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -290,6 +293,25 @@ static int axi_adc_chan_disable(struct iio_backend *back, unsigned int chan)
 				 ADI_AXI_REG_CHAN_CTRL_ENABLE);
 }
 
+static int axi_adc_interface_type_get(struct iio_backend *back,
+				      enum iio_backend_interface_type *type)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)
+		*type = IIO_BACKEND_INTERFACE_SERIAL_CMOS;
+	else
+		*type = IIO_BACKEND_INTERFACE_SERIAL_LVDS;
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -337,6 +359,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


