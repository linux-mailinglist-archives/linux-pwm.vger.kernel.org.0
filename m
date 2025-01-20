Return-Path: <linux-pwm+bounces-4683-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0E2A16BA9
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 12:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FF41883F7A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 11:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2D1DF983;
	Mon, 20 Jan 2025 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Nxdhj50k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33551DF256;
	Mon, 20 Jan 2025 11:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372886; cv=none; b=TwN4nrVa5Z2+hv+FAZvpik4IJOwnLKOImyHYxwYUtvH9xBwmv3TyrnCA/eJr+rubAnpX3dDFwtxLZupdZBCCk9fN9st1mO9nfJy61jFmqgrC/H/zDkWwRB8wtGEWcyo47oo1sgsrrl9aE8/fGeiYWWhGXnSZA69kuyWFqfwbdVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372886; c=relaxed/simple;
	bh=P5c80eGx5/5MCgfCdSGcqhRe7K09vr50zQvxwJVTvPI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BSUYbo+fpyDf15loWcM2cwebXdhVknMMHzTHt39J8DONjCz7dSzatlaRO7isesm8KuvJKeJUjv8APw021OE31ejZp2kafu3L4QVbtxQ7zL8FWsUG8sHpERtV80XZ8K6T9HpDTxh1qkrhfnJ8hJbJ0YRCjQX184ZB/HMJViZMdvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Nxdhj50k; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9ldRU009358;
	Mon, 20 Jan 2025 06:34:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1M6Ks
	A6CmeokaaBTsJpORh2J42WqBydGxWSFtG9261I=; b=Nxdhj50kLuiTxvTjHYCC8
	9kmNU603cY3tZmLHIFib2TaGs9j8cWcQpaH9Xy0SaIIpIInME4cesaLFsfPMBNNx
	RGeFyO3TZQBeBWPARL6eOr6/9cCabl7hwB9pttl8HxanQ6k+daHclm9zBAJXG/L0
	f9T083B+kO0eM8UgNz12ZvhLDr9TO6Xq5qHGOX+SEwE6yjuKswZN54Bqmq9iBECi
	dJwNsjw+XrM6Bp0b1DorkXcNSOfXSDFMKZ2BanaZBlazp1jZ857X+PLNlrcC/gr2
	EfDl1dYpVveGt+zoZ9Z8kE/U1L1AeAiLf8C54VrkW1BKvCNyZVXxOSlqwZKad8lV
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 449g3ehfcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:34:30 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50KBYSTv001545
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jan 2025 06:34:28 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:28 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:28 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 20 Jan 2025 06:34:28 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50KBYEp1007657;
	Mon, 20 Jan 2025 06:34:25 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v5 2/3] iio: frequency: adf4371: add refin mode
Date: Mon, 20 Jan 2025 13:34:03 +0200
Message-ID: <20250120113408.24395-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120113408.24395-1-antoniu.miclaus@analog.com>
References: <20250120113408.24395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: qD9lpI4OQArFYRsdTZKs0bPsT1ibLRVi
X-Proofpoint-GUID: qD9lpI4OQArFYRsdTZKs0bPsT1ibLRVi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096

Add support for single-ended/differential reference input mode.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/frequency/adf4371.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index b27088464826..50450e7b5464 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -41,6 +41,10 @@
 #define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
 #define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
 
+/* ADF4371_REG22 */
+#define ADF4371_REFIN_MODE_MASK		BIT(6)
+#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK, x)
+
 /* ADF4371_REG24 */
 #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
 #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
@@ -69,6 +73,7 @@
 
 #define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
 #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
+#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
 
 /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
 #define ADF4371_MODULUS1		33554432ULL
@@ -175,6 +180,7 @@ struct adf4371_state {
 	unsigned int mod2;
 	unsigned int rf_div_sel;
 	unsigned int ref_div_factor;
+	bool ref_diff_en;
 	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -503,6 +509,17 @@ static int adf4371_setup(struct adf4371_state *st)
 				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
 	if (ret < 0)
 		return ret;
+
+	if ((st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN) ||
+	    (!st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
+		return -EINVAL;
+
+	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
+				 ADF4371_REFIN_MODE_MASK,
+				 ADF4371_REFIN_MODE(st->ref_diff_en));
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Calculate and maximize PFD frequency
 	 * fPFD = REFIN × ((1 + D)/(R × (1 + T)))
@@ -572,9 +589,16 @@ static int adf4371_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
+	st->ref_diff_en = false;
+
 	st->clkin = devm_clk_get_enabled(&spi->dev, "clkin");
-	if (IS_ERR(st->clkin))
-		return PTR_ERR(st->clkin);
+	if (IS_ERR(st->clkin)) {
+		st->clkin = devm_clk_get_enabled(&spi->dev, "clkin-diff");
+		if (IS_ERR(st->clkin))
+			return PTR_ERR(st->clkin);
+
+		st->ref_diff_en = true;
+	}
 
 	st->clkin_freq = clk_get_rate(st->clkin);
 
-- 
2.48.1


