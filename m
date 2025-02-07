Return-Path: <linux-pwm+bounces-4817-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2C8A2C4DB
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1C5C7A75EB
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C0D1FC7D8;
	Fri,  7 Feb 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wINoH2GM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD541F4198;
	Fri,  7 Feb 2025 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937405; cv=none; b=TBfexhSlzOEQxRfea2emLL6/+Zcl9G+Yv4+WuTO3Z+8Rmu5jj+yFvbOKCuYrBuIknY4DXSJ/biQUg/cmN+PWEhHRQFBgkKzGOOKPZ3PeZfT0Ozpv5CBjO6mXBGiuLlvyEiCuxydFLhhgDG/+y0PsUw8mW+HgRw/y5G2ebSmuxd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937405; c=relaxed/simple;
	bh=ikasaZT8doqH3bEoZsGSlU7+Gxxo8dbKQl+MkeTO9Rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uS0PxVKnPJ/tlNq9sZ9C/BiGA03GCHYs8K15rgFj2LEggVWcw2PmjArNjFCnjxWvh6hqT0oCR6yZzK4usUlC2eq+u5dJv331ZG0mnu13+ztZvUAW71DiP4miFqM36aXFHj9rdsIQuK+DvNHp5weSepFtQxyL9CRRIh1ZqY1mX3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wINoH2GM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517D7huK009148;
	Fri, 7 Feb 2025 09:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FVv1y
	e8XRq0PJ/aEyxTpMuukZfJg/9QvKJCooMJdaYs=; b=wINoH2GMFG806K1Mbc3KO
	Xuq7UZ/G69BajwfIwqKRMa+mcAzwxoAAkDzVGmvw4iMiH1aCIfCac3DhBzRxcdaf
	9Fehx3pr09uthUU5c9ngGOsChDWwV9yhqqTzqDKtoChgB0Z0QovegX9Rjg1Z4VoQ
	D2dVq4yyQUIIsiHZBviqlcO3saMILVH8GaIMJVJJIDRELLKeZpPjMOsEsXYTtRQm
	+Hc4wTNv+vzMIDNQC21RWPZLYHpaOS8l23RSuU3couJbWVjNGXLnlWLKRpHbH4rA
	0cvupult8ypqIEaKh1O3i3J7A7ovv1X5UOo8ftzV+PpdbPdSftJ88s11x1bo1B4O
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44njsq0799-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:10:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 517E9xwF008526
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:59 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:59 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:58 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:58 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4t015095;
	Fri, 7 Feb 2025 09:09:51 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v12 7/9] iio: adc: adi-axi-adc: add oversampling
Date: Fri, 7 Feb 2025 16:09:16 +0200
Message-ID: <20250207140918.7814-8-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Bdgi0qt2 c=1 sm=1 tr=0 ts=67a61438 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=WWjZrUSA4sH6CW72oAUA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: SU97IFRppfw2CSINHMvnDyXyJEFa75UA
X-Proofpoint-GUID: SU97IFRppfw2CSINHMvnDyXyJEFa75UA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v12.
 drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 272d82c6e887..872ff51e08a7 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -46,6 +46,7 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AD485X_PACKET_FORMAT_20BIT		0x0
 #define   AD485X_PACKET_FORMAT_24BIT		0x1
@@ -363,6 +364,28 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
 				  FIELD_PREP(AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
 }
 
+static int axi_adc_oversampling_ratio_set(struct iio_backend *back,
+					  unsigned int ratio)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+
+	/* The current state of the function enables or disables the
+	 * oversampling in REG_CNTRL_3 register. A ratio equal to 1 implies no
+	 * oversampling, while a value greater than 1 implies oversampling being
+	 * enabled.
+	 */
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
@@ -428,6 +451,7 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.data_size_set = axi_adc_data_size_set,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


