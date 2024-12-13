Return-Path: <linux-pwm+bounces-4334-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B88D99F127E
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7ED4164374
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 16:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD361E633C;
	Fri, 13 Dec 2024 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kb5Iax3o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F7D1E3DE7;
	Fri, 13 Dec 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108312; cv=none; b=VujlATWbXbWMk9fn1SpDf72cIx9Hh0/5jSDPIiCgRNf8X7DAfMRUqNYI7oj2TFvGLBAgskCSVASDQXqLBqIENBFw/xz8j3yAJYmEUyDOYv1O0Azu54SxPs4U9SPaSa4jYX+ZKsx8AwsDIVzXE72V3LJbQkiojukvlTdQcpaVFHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108312; c=relaxed/simple;
	bh=eMG2BjpStBQZ6kNfGHttkYbd8b6oyDb+ilkSNk4X0Oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nhonNHwAvDS3kJSrTfFA94+tW20OWqTV2BeUjySIIH5yvRYqCLRtnz3L3Rxxhj09p5dLp7JuTkV3zazVo02UyQQWqTxXP/tJgK3IfqcaufCiQ8eAYSU7Ws8CEtqnDuVbbNGyWpYXm9XSXd5oZl1XtG91XyyfMSuBcZykidpqW0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kb5Iax3o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDF29j5023473;
	Fri, 13 Dec 2024 11:45:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YZ3ys
	QFRIhbcxVdMEXlJv4yJrar4AQC7nyQoS9vYpaU=; b=kb5Iax3oJrkACiCZ9P76q
	JSDPRuB0PRbeAoQCaHUjq97OS/JZ/zz9wiQT8vXra3UBdvNKkZymD2zRVzCRwnWT
	+sEZ/p2bSC2GAWwoIyMwKCdlHLjCeDjDX/rGMl0AItvIOYgTb9pAQao8nyetpKbV
	+D+HThMZdj2ela+ItGoHQx+la2Vph6sXEUfdFMyQOya6wWjA6mK40zBWzucpCJal
	nNfykLd8gIPsDdh7MOSz35A8syLDVS+kbSLw1Gt6EmVKCzPDe65fVvkChqvtUwYW
	/EkPutccxrEfESMyZZ1GEkGmOlIW49XDovwIGceO3qCD5U1/3ioYJPojLjEEhzI/
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gju79jq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGj6kB030718
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 11:45:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:05 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcE025509;
	Fri, 13 Dec 2024 11:45:00 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v8 4/8] iio: adc: adi-axi-adc: add interface type
Date: Fri, 13 Dec 2024 18:44:41 +0200
Message-ID: <20241213164445.23195-4-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: oH_OvZqDM1z0W3y9DXvThyXnTubGdy65
X-Proofpoint-ORIG-GUID: oH_OvZqDM1z0W3y9DXvThyXnTubGdy65
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
IP.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v8.
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
2.47.1


