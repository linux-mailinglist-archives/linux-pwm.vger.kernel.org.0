Return-Path: <linux-pwm+bounces-4060-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9799C3E27
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D0B51C21738
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397A919F41C;
	Mon, 11 Nov 2024 12:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iZvwLyeS"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299119EED0;
	Mon, 11 Nov 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327162; cv=none; b=I36P/brfWj84rCRW219gyiPCEbkNwpftKce86YgS3p7obzIhNlPf+i/YXYpwY87fZLYP+l3CC+9G4d4Rs+bt2JWQsRS1PDHW/kD2v3lDi1XtiusI26zar743iBHuVB1sKRWrweuIK1d++heQcCTGQkVGhG21TEEuCvwREWRJKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327162; c=relaxed/simple;
	bh=ayT2m+OtCZQCrcZBQM9i9bkt6WaXV9vg3qQ0BOqwLao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irLVOGQg7uuJBkPcNkHSJ1OsxelK5AeUX84umjRI9NhP2Akt20CZy8HLH0QaXsq1KykLe91ZnL6dxLApC6WMp7hT+UuBbutViO91YyaeQskQVvSypOP8Rw2T12PEI69bzRfx2yJ0itAYgWA7P32bCVwqPWwmNMLo966llOGfFds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iZvwLyeS; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB94PPW011822;
	Mon, 11 Nov 2024 07:12:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=+4Dyv
	6TvgUnMt7oame7XrSUPymSYEyjC8xcC+9wNf5Y=; b=iZvwLyeSl51lWvTcSxS+T
	KxZF+EmXMm5M5dLKxkeuDrYbr1fd7/1St9u0GEZ5E7CMr2uojRfz6cCheb9l5Q6Y
	B3S7UbRLCPy6F9e03C8Tvoafsk+zq4a/xXo/KU+UagokqifL8vnZdLW1dOtvFsVH
	a1KI6TcfArwogy/HWksSpMu6+KCcFHrbnvJkG0AA3JOGnLIjUb6T0VEUGw3xixo4
	OG9074iX+JuB/gGmNfj16GYs0MFzCLdPHq8hH8uiCacPj0TXY3BB6vOzJtgYAiUC
	jj9VLUJ3mBKq/8cyPzYqydKju5g+UEmDJbfVUcPGaKhwXaNXUFzHuHphQzGGfysC
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42t2f6ydw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCZNt031076
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:35 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:35 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEN010000;
	Mon, 11 Nov 2024 07:12:27 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 4/8] iio: adc: adi-axi-adc: add interface type
Date: Mon, 11 Nov 2024 14:11:59 +0200
Message-ID: <20241111121203.3699-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: pWKXaVCTjk0OKFFDFQApjkJ6WXDryohn
X-Proofpoint-GUID: pWKXaVCTjk0OKFFDFQApjkJ6WXDryohn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101

Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
IP.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 5c8c87eb36d1..f6475bc93796 100644
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
2.47.0


