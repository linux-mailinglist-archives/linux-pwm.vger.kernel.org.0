Return-Path: <linux-pwm+bounces-4561-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1C9A077C4
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 14:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82F0B7A3575
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 13:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3312821A449;
	Thu,  9 Jan 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eZ3kpZCe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5E217725;
	Thu,  9 Jan 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429858; cv=none; b=RYXtZPKdBdGiw2NiCeibXgusR9uH8kUx7dOAztcxaz0I9yaow75YtZ/ijgqsQ3hvppn5YHVVZcJjprvK4LXdzUCegYhEb0eUcLcV3UCN0VXfgysuIx1yYjI/IEw601ACW8pTT+UK/WubR/7891cIsLdw3k9HJPTO8RkxQL/JmT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429858; c=relaxed/simple;
	bh=k1qC5AWQdiLZA8zauZF3OtvU50w9GBv8AlyZzQRwc9Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G2raHLDdZU23Lv79aVeBU77J89zKYZT8o8eM2O0JD9+7SJ7EBQcsW2ZM7Xta3D/IKuelLqMaE3QTF3ENgBMWI4hU9HVclMBxnBoQAVRmyEYuMslCz01rwtC12blFzf+/5EXun6szuIHtHDUyIUochnX6wzTYhiFJVWxSo0NFBxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eZ3kpZCe; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5098K3b4014771;
	Thu, 9 Jan 2025 08:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nHOga
	btUNsFuYOBEeRmDSBZolmPdWuHfrt60hKtWMhI=; b=eZ3kpZCe42aKYTKh6e/PW
	FOubdxNycrmMnpkEw/C9RTAEASOlDb/+m9+7bZw6uNo/lE8X8Ftu/jTcHyhqnMNi
	WRqSX+4rK+r6MfOZdv75TsS3iYPiUgAoDCi3GZCgGrBudNtQfLurbqZ96nlxzyfS
	rUKDOkNzam3BgNdjHkCBIHYfcr6dHnkb9dyCxuXTHAJfDm0QR+uIwWMNQI1QgoTC
	kwx7/dc4wAzA03lGinTIpKet/WglCeL+RXG/YeZxm3YRdZlWmewBZbxz3sF7x0eK
	GmdWWopbIqcNpRgQY2nDXl4mMJaKRK+ObsXxzecdG0Z6bkvlBANMU6Iwrs/2s/kw
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4425w0te12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:37:22 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 509DbLp5010894
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jan 2025 08:37:21 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 9 Jan 2025 08:37:20 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 509Db9iZ009541;
	Thu, 9 Jan 2025 08:37:16 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/3] iio: frequency: adf4371: add refin mode
Date: Thu, 9 Jan 2025 15:37:06 +0200
Message-ID: <20250109133707.3845-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109133707.3845-1-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: UkyhlhEYLYg2uYdUFVdIzgstxpkECD3Y
X-Proofpoint-ORIG-GUID: UkyhlhEYLYg2uYdUFVdIzgstxpkECD3Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 impostorscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501090109

Add support for single-ended/differential reference input mode.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - parse input clock depending on the name and adjust the refin mode
   accordingly.
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
2.47.1


