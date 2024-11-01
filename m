Return-Path: <linux-pwm+bounces-3996-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B1F9B9038
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 12:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90ACC1F21C52
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 11:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1716B19CC02;
	Fri,  1 Nov 2024 11:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="fSpEtmhu"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C76F19923A;
	Fri,  1 Nov 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460287; cv=none; b=jgTrdc7WDjw0DozEf1Dsd3Y9V5+gTdlnayO9qowhjz+tQVNJPX1j9sZ6a9doYwDFjUdpD7JiYRFHo6lrY2k43SFSLqHyUYrW3dE6QnY7VrI1LoAHt6/6RpRWu78QCi9xEZrAhTPlqToI4GGBQviKgIECaVyDzVLVbF9geFKLoyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460287; c=relaxed/simple;
	bh=W9hwjDIneb6GS2guLgwj8fRVfCtsrCar5ddiaI2lUIY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EJNz2riA+YbTN26/xMKjhpCG1t8hFN1w9cK67EveTFHyWEsZc2EOczOSM/cgQGPpn4Y5Zvy8jNpoD6GlwKyzsYumjUyPIxVXGjvXIXh7+BRdFv7F3mOqbpsmXtbhaZgj0UXM1Swu50JnV6qIl/kzrcBOU63jvh35cHxJcF6h0TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=fSpEtmhu; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1BIBj2006064;
	Fri, 1 Nov 2024 07:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=J5Vp2
	lLjyE7GbZEbqi4YGXeEzJ8aWFnZ+WWy+FzM5e4=; b=fSpEtmhuDstFBY1uOhX+M
	xBgti4ekV+3jU3afgMN5yLDlnNle9vM/hcJo/TlyRSD4FpvR/k+0fN6ZMFFQQAhP
	a+EHXS5qbT6jYvVvyJ2azaYExhfZipa2J40cd4saUWc6g4z5nS2eUE2a1lsvW1oy
	OsF2JUdR+TT3XERFXzxbQnkvNN+W3eZPsu5PRmY7FyYWWpHGNWDVN2EYjs886vlH
	TkoTv9M+DMueEfUw5LXOIAsAZXl14f1urYbnGeWC52TXj+uf+4imUDrDEtgRDv4V
	JOXFnQwTnlCEqI+DDiADL2nCx3ornu26hx5gmvn0+2irFdcjZyqJzNdKv4lOn6/g
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42k6yveu1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 07:24:41 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A1BOegK038447
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 07:24:40 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 1 Nov 2024
 07:24:40 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 07:24:39 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.114])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A1BOP8m016631;
	Fri, 1 Nov 2024 07:24:34 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 4/6] iio: adc: adi-axi-adc: set data format
Date: Fri, 1 Nov 2024 13:23:56 +0200
Message-ID: <20241101112358.22996-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101112358.22996-1-antoniu.miclaus@analog.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Yo3F4Z0KUozWP8hEF6adziUNQRsv0AIC
X-Proofpoint-GUID: Yo3F4Z0KUozWP8hEF6adziUNQRsv0AIC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010082

Add support for selecting the data format within the AXI ADC ip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/adc/adi-axi-adc.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index f6475bc93796..6f658d9b4c9d 100644
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
 
@@ -312,6 +315,24 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
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
@@ -360,6 +381,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.data_size_set = axi_adc_data_size_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.47.0


