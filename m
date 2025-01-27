Return-Path: <linux-pwm+bounces-4741-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FCA0A1D4FD
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:58:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5AB1163CC8
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 361171FF61B;
	Mon, 27 Jan 2025 10:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="B0B1zFGb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D71FF1D6;
	Mon, 27 Jan 2025 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737975476; cv=none; b=u8cJ3KwNfVmSI38NsxSbX5Iz0L9qH+FJj5jU0wbCLe5jeH08mY1kU3Ytcr/8pf8joN6YkaIleOF3vPt010GymaH0cZysSAitUjBynMkJqqynzcHDUa45wpl7jmGvQYRNe4q3+bSfdpy3QGYoBV3QxjylzmnvOqBbu22sPGd6gEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737975476; c=relaxed/simple;
	bh=ssp79vkuQ87yMGyz1vbPas2XVevenGph77AP+5ZXM7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P0g0hVdtOD9SRuR5SaoHq/0BpTaecuCH11+iUO+HQGT/mqghwMuiVoZplhvEDd6RaVE38wfudwjd+iym8Ls38PkvN+sJKAKksgxdICKgte2Cj38qkNL1swckW9/sOg0nsebOgRM7bG6+5KWsHKbZdTMxTadc7jO9E2fCZfZrAvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=B0B1zFGb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9bkXg005532;
	Mon, 27 Jan 2025 05:57:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=JVFmE
	4l7RdgK7LcOyiNVLYL/s3DTLZShSTBwl72Tbb4=; b=B0B1zFGb0SoyogJuj606R
	RP7z5Po/bl2+Jdwl9LnTxcy+amc31ag9i5B3xRl8IetYuJ1DQGZfFfWQM/bLTnl9
	yszmjyfqn431DZg/f1PVkfBp/CoKI3B00KKCTzkZIYGgM220NUjj65NKDZIm0uVm
	Yl/eM75vBl06Voc3n8Apa+rGQPkUqPDBZaVTPMNmmWKqLfpC/ChBkYFgCGP/AMF7
	86E4r1RwXXM4ewgTo79mHyWzprqehZJoCw/m9xeG6FwssRDaKefpd+5OzKzPO1D6
	sZIAvJ3dqSmW+Tsa0GpItJLjjd2jE25xc9LXWs5kh8uyM0aTAix1Me6vJH9PTPxK
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e2n11bgh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 05:57:51 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RAvoug001784
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 05:57:50 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 05:57:50 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 05:57:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 05:57:49 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RAvUTB018078;
	Mon, 27 Jan 2025 05:57:42 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v11 5/8] iio: adc: adi-axi-adc: set data format
Date: Mon, 27 Jan 2025 12:57:23 +0200
Message-ID: <20250127105726.6314-6-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: V3-UJ-KbqzmcSvMD72sI3cuqLMHiibXr
X-Proofpoint-ORIG-GUID: V3-UJ-KbqzmcSvMD72sI3cuqLMHiibXr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270088

Add support for selecting the data format within the AXI ADC ip.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v11.
 drivers/iio/adc/adi-axi-adc.c | 46 +++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index d2e1dc63775c..3c213ca5ff8e 100644
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
 
@@ -312,6 +318,45 @@ static int axi_adc_interface_type_get(struct iio_backend *back,
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
@@ -360,6 +405,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
+	.data_size_set = axi_adc_data_size_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


