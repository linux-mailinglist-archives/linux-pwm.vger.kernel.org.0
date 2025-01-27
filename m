Return-Path: <linux-pwm+bounces-4740-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CFE53A1D4F9
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 290B37A27C5
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531AB1FF5FE;
	Mon, 27 Jan 2025 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kZu4tEoW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADCF1FF1CF;
	Mon, 27 Jan 2025 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975475; cv=none; b=sH0xLjMmcOh6ae/p6s02EqmRJb94sYDZk1xbGbyJExvDNhvnO5oYAOGkHpeA8njywzO3Bsv2S2vFDnDqzTf3HDZeR0D+Mohnzwv43INV7uniSgVio5YGF17v+ti8V5GApoRMI/84rn9oifDpUTrRgMHBjXThFiXe75P8lHBi/WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975475; c=relaxed/simple;
	bh=slxdLzEO8imzhAY0qCXiGRFH+HnebnedzYP/zoggsjo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NnCAxugecqh+RIlfAS4w16aeT0lYF2Vw+n0omqG64BguMjS1xPYxrB+PhQ8+5Az0IUQY8TxoR0dM+yEqd5qTzncLW1QImtI8V7H8mxpi7TgvvfvRK9MVWW5wDEAZZOahQ4WEAgXuiXBO/jFaq6eh5PsYZ7bGq9w3cERuppjhKUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kZu4tEoW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9qTZW005923;
	Mon, 27 Jan 2025 05:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=zQgRR
	G6vaAzOlZarOh6oMCpUAExDg+w5UQfaY/VDYzs=; b=kZu4tEoWo5yWDc5a3PfTB
	D8auZfquhugvxNaeJPnLwfrT6AsrVfIf2lgPCCBN14U/bYt21ofA4m6MGI74Db5p
	BGz50d3yVol9gw1sGHxvWzzV8ObQ5al+Kcd9P63hAE+BVtW4dHMbLLC+Iei4Hi12
	67vHNze0gYv9XYCEUqBtzNqZTOBscV+YtLhGL5JPYqL0L97XstcL9WZa6VGfNj8z
	r1MB/M5x3mLe1OP1nIwus684DBYaPithIcXM0kJl40BAL/8P9uktP7ttRXpS1GKp
	BcFmdIMpqAz5+YPGPJPWZygllMV1VfrJEQUnULymnYqG84d/7vFJ9ko8jYkgcYkH
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e2n11bgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 05:57:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RAvoBY001781
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 05:57:50 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 05:57:49 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 05:57:49 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RAvUTC018078;
	Mon, 27 Jan 2025 05:57:44 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v11 6/8] iio: adc: adi-axi-adc: add oversampling
Date: Mon, 27 Jan 2025 12:57:24 +0200
Message-ID: <20250127105726.6314-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127105726.6314-1-antoniu.miclaus@analog.com>
References: <20250127105726.6314-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tVc8cnldwKmdUWgvBoXrkHg_cwEc7cM5
X-Proofpoint-ORIG-GUID: tVc8cnldwKmdUWgvBoXrkHg_cwEc7cM5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270088

Add support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v11:
 - add comment.
 drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 3c213ca5ff8e..8f65f968e537 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -46,6 +46,7 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AD485X_PACKET_FORMAT_20BIT		0x0
 #define   AD485X_PACKET_FORMAT_24BIT		0x1
@@ -357,6 +358,28 @@ static int axi_adc_data_size_set(struct iio_backend *back, unsigned int size)
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
@@ -406,6 +429,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.data_size_set = axi_adc_data_size_set,
+	.oversampling_ratio_set = axi_adc_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


