Return-Path: <linux-pwm+bounces-4899-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2E7A35EDE
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 14:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5997E3AAA95
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 13:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB7B264FB0;
	Fri, 14 Feb 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iH6thZ9q"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88F264A6A;
	Fri, 14 Feb 2025 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539225; cv=none; b=CyZFdzZShOW6gweORVWG4m/DHa/G1MXwWXpW2gGgappvVXPUKWpIi/nn+/l2rib7xQjDKZIdTYYWyo0chfH1lpzfR9rWStvBUVF3dqs6/bNoDVpmsQmf4FtQd20nFUnnx1yWOhjOKhUFhes0WPB1ZsPRFCW4KuYhx93dBc7178U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539225; c=relaxed/simple;
	bh=My8YuqVgFaCoWYYMgfUcEEIBYjqdKp28VjGIqOMcbb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIqP93IDGSLQmFit0E1AWfwntyThAgwgp1y/W8V5/cgTYOnaHcmMHXjPCLewr+5k5hSc/8U5YfblKU2JqaOZ3NvTY83VDUEc1dWOG8BmG6k0mkExO3AQyyOxw3nCRrmWuEEmGlRPd9PQ5BN7+9izEYtnd8nwO9JSj6U9oHjVTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iH6thZ9q; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E8I4Y5024957;
	Fri, 14 Feb 2025 08:20:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=L0054
	nxtphUDoAZ0iBLEojCpaD07yNpS8x0Qw4ItxcM=; b=iH6thZ9qMSl5wT0LFHoxv
	RZfn6ixZU6p0nHXuvOgscnarWNAeCnzLXu2JoMlqDlnlRH7eBhMk8hhxqEineaTv
	ex6UnMtVF/6W1pBgLEK7Sv83WufA8dOnzmhG98ubKaMlJGPsdNz5x24o0tV6fQdr
	udYMpOMTBGx/zCK551+0b85NZ4XNYQIThlpUP1ogWzYbOdeuY3/PhK+LvQW2yGr5
	aziy9JXXzY13eKxBBlFt+76OmTYrq1OjtwK4Xjfo+PekdjbfIWfoNpWWKAwd61gz
	8+UJ+AfY3eVRhSPoVDwmJbHyvtKh09TMnDKzdayt7K+ZDL6/Uky79g1qnzGxJlB/
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44swyda6fc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:20:20 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51EDKJBt018386
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 08:20:19 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Feb 2025 08:20:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.172])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51EDJuUX020604;
	Fri, 14 Feb 2025 08:20:11 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v13 7/9] iio: adc: adi-axi-adc: add oversampling
Date: Fri, 14 Feb 2025 15:19:53 +0200
Message-ID: <20250214131955.31973-8-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214131955.31973-1-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Pc4Fhjhd c=1 sm=1 tr=0 ts=67af4314 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=_WB4bKVAekkD4qbO-8cA:9 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: zdpMRkPd-cV-kJ468yj5fkZ2xYgn18e8
X-Proofpoint-GUID: zdpMRkPd-cV-kJ468yj5fkZ2xYgn18e8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

Add support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v13:
 - add AXI_ prefix for macro definitions
 - add _ad485x_ in function header
 drivers/iio/adc/adi-axi-adc.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index dbd11c2ecf76..05e1262befb1 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -46,6 +46,7 @@
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
 #define ADI_AXI_ADC_REG_CNTRL_3			0x004c
+#define   AXI_AD485X_CNTRL_3_OS_EN_MSK		BIT(2)
 #define   AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK	GENMASK(1, 0)
 #define   AXI_AD485X_PACKET_FORMAT_20BIT	0x0
 #define   AXI_AD485X_PACKET_FORMAT_24BIT	0x1
@@ -365,6 +366,28 @@ static int axi_adc_ad485x_data_size_set(struct iio_backend *back,
 				  FIELD_PREP(AXI_AD485X_CNTRL_3_PACKET_FORMAT_MSK, val));
 }
 
+static int axi_adc_ad485x_oversampling_ratio_set(struct iio_backend *back,
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
+					 AXI_AD485X_CNTRL_3_OS_EN_MSK);
+	default:
+		return regmap_set_bits(st->regmap, ADI_AXI_ADC_REG_CNTRL_3,
+				       AXI_AD485X_CNTRL_3_OS_EN_MSK);
+	}
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -430,6 +453,7 @@ static const struct iio_backend_ops adi_ad485x_ops = {
 	.chan_status = axi_adc_chan_status,
 	.interface_type_get = axi_adc_interface_type_get,
 	.data_size_set = axi_adc_ad485x_data_size_set,
+	.oversampling_ratio_set = axi_adc_ad485x_oversampling_ratio_set,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


