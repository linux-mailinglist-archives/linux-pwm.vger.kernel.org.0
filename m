Return-Path: <linux-pwm+bounces-4733-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F169CA1D42A
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:11:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134FC7A339C
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD521FECC6;
	Mon, 27 Jan 2025 10:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dUbTdb2E"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960A21FE45A;
	Mon, 27 Jan 2025 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972659; cv=none; b=h4oUFjk8d7mZpkjH0VfbspPoaaBJkWXQHdczzzpn2bsjbzTv12I6ycZ4+3oy2jmyq54suMX1R4EwssK+RqiHYHJKrieRPThtJNH3mGhnMXVVRxkiyRp5zpri27BGFyWyulbTxlsSsRKm0IV7piJOCStMGKSr4F3QmPcvvf+NOHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972659; c=relaxed/simple;
	bh=VEbjChGMkQlzoTh4rtP4vO3TispppwR1ZIzCMteI2sM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oa15lKiL7Xoha+Z85IeFhbGkQZyzAj2JiKxnkO2JTxJjPgzs19HkkEbYUhjNTzs9p8NOTUBY1p8Og56Qm0pcZVAavTPupcuugscdxBcTA+TOpOoTMsPvUtjKPctlBXGCWv9R5nsFvkLj5aMk865wYMbxbCoMR3PhOUTOYLH7Jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dUbTdb2E; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9bkQh005532;
	Mon, 27 Jan 2025 05:10:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=EvjEl
	YnXyCQraXu3x2dnYWL+uJFTddGblvjs15Vhg6Y=; b=dUbTdb2E875TY9VuLjPNK
	3g7YRn526r66ZISrnuVQxqpSBoqDH52BwIl/VTDvRuCoh0KpJ/2P81dpIbvv1RX8
	wYtHhhL4sowjCnS7xrHDtYImEbfweHSI+eZqKas0wiNHpfFr4ir+v7dnd8C0DmeH
	rCiKB7ovWVNl9nbF84I1a1kePRsS4neXaae2+DmhSpbf7mV8mEyOQBgERQ7tLU6U
	84QfxbeBFIpMCe7JtFSmhLKa/zyZ+DHjazQX981sAd+CPcqUuPj0EHwil88nSdMr
	93tNfL4bbyzBCndzKjmcVn6/03ojHO8yt9Hw4pOP1hrVg0SXYBZVZebGc0dPUadf
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e2n116qu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 05:10:42 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RAAfo0013638
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 05:10:41 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 05:10:40 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 05:10:40 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RAATiE016396;
	Mon, 27 Jan 2025 05:10:36 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v6 2/3] iio: frequency: adf4371: add refin mode
Date: Mon, 27 Jan 2025 12:10:22 +0200
Message-ID: <20250127101026.5320-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127101026.5320-1-antoniu.miclaus@analog.com>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: ClQjilNDDdVfiBs88A9Ep9vkdA9Xmwht
X-Proofpoint-ORIG-GUID: ClQjilNDDdVfiBs88A9Ep9vkdA9Xmwht
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270081

Add support for single-ended/differential reference input mode.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 drivers/iio/frequency/adf4371.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index d752507e0c98..205dfd341489 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -42,6 +42,10 @@
 #define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
 #define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
 
+/* ADF4371_REG22 */
+#define ADF4371_REFIN_MODE_MASK		BIT(6)
+#define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK, x)
+
 /* ADF4371_REG24 */
 #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
 #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
@@ -70,6 +74,7 @@
 
 #define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
 #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
+#define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
 
 /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
 #define ADF4371_MODULUS1		33554432ULL
@@ -176,6 +181,7 @@ struct adf4371_state {
 	unsigned int mod2;
 	unsigned int rf_div_sel;
 	unsigned int ref_div_factor;
+	bool ref_diff_en;
 	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -505,6 +511,17 @@ static int adf4371_setup(struct adf4371_state *st)
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
@@ -574,10 +591,16 @@ static int adf4371_probe(struct spi_device *spi)
 	indio_dev->channels = st->chip_info->channels;
 	indio_dev->num_channels = st->chip_info->num_channels;
 
-	clkin = devm_clk_get_enabled(&spi->dev, "clkin");
-	if (IS_ERR(clkin))
-		return dev_err_probe(&spi->dev, PTR_ERR(clkin),
-				     "Failed to get clkin\n");
+	st->ref_diff_en = false;
+
+	st->clkin = devm_clk_get_enabled(&spi->dev, "clkin");
+	if (IS_ERR(st->clkin)) {
+		st->clkin = devm_clk_get_enabled(&spi->dev, "clkin-diff");
+		if (IS_ERR(st->clkin))
+			return dev_err_probe(&spi->dev, PTR_ERR(clkin),
+				     "Failed to get clkin/clkin-diff\n");
+		st->ref_diff_en = true;
+	}
 
 	st->clkin_freq = clk_get_rate(clkin);
 
-- 
2.48.1


