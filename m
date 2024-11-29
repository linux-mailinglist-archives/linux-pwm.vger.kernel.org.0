Return-Path: <linux-pwm+bounces-4161-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3429DE996
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:34:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 575A5163748
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 15:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BEF188A0D;
	Fri, 29 Nov 2024 15:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YoNe9kCj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4E14B06E;
	Fri, 29 Nov 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894469; cv=none; b=DvZ0YxlmXhTSw8DZqEp8uFLc+dlgLK45LIiYrTCFXm81g1L0ch+DpA5739hJeLPxbW8znbWsfDjt4FR8paflunZTc6R46cAJiUTK3rCQFf7yTKTgUv8WQOaK7y/orHOaODHnwT6Ilyk/KnF+f6M6uyP0Wo2dGEvImvfoOR8CNfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894469; c=relaxed/simple;
	bh=kWpPxi2mkGZL2hk8+KyLPj7wCs8qHhe6lA8YTp8wobE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KwlUx/scAIHR40+016+8JaKWxceYW9XmOqZ9esp/l+9qbXZ73jOvlVJRK2JahYJMGKWsNB6nEU0RmvIsqX6h8TcRrGY+yE5sX0LBs8xLC+xJHxC26s+Vr1VWAopxT/oJqwRtFmHgx9NC+BcokuxOOmEymkyP8VgpV2/q3DphL5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YoNe9kCj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDV8ME027546;
	Fri, 29 Nov 2024 10:34:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=aZinm
	uPvlS5RtpQ2w3BxLeKN39WG+S8zBoQAOWsKxx4=; b=YoNe9kCj24HfFKvYofEX2
	hDWDUu1v3Rcg9lwdTVIz55RnTnjJE8ke44Soz/Db48z65vaFxdt5NKu6Pss/PA/l
	OXHt8YIoW/uzra4dqH2GjTMXrWQEzmmkClyUMumnIqciZnoext7dXB/nfRi6PP8R
	Ir0F9ObTZoXHZtBbveCWvWZfxwhN8Q248QfBSX138fSBzdqfH3rT0pubmxcIGbqZ
	c06I/zI3vKHtGg1JlMypOUIhE0IeE6RMVmuAhmARRRrFmlS1Cb8kveIInSEo2S7j
	IWYwmqWsrYPAgv424KMVk5QSQgaWeGTGuGcz4ujQyP6cgYpVac97zeom4CrgcFMR
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 437ejk0f3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 10:34:24 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATFYNOd008712
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 10:34:23 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:23 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:22 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 10:34:22 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATFY6dl001089;
	Fri, 29 Nov 2024 10:34:17 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/2] iio: frequency: adf4371: add ref doubler and div2
Date: Fri, 29 Nov 2024 17:33:53 +0200
Message-ID: <20241129153356.63547-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129153356.63547-1-antoniu.miclaus@analog.com>
References: <20241129153356.63547-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Ys0KFjRSj0kEOs01lYA74dUrgUG9DAIE
X-Proofpoint-ORIG-GUID: Ys0KFjRSj0kEOs01lYA74dUrgUG9DAIE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290126

Add support for the reference doubler and the reference divide by 2
clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/iio/frequency/adf4371.c | 34 +++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index b27088464826..b643a08f06ed 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -41,6 +41,12 @@
 #define ADF4371_MOD2WORD_MSK		GENMASK(5, 0)
 #define ADF4371_MOD2WORD(x)		FIELD_PREP(ADF4371_MOD2WORD_MSK, x)
 
+/* ADF4371_REG22 */
+#define ADF4371_REF_DOUB_MASK		BIT(5)
+#define ADF4371_REF_DOUB(x)		FIELD_PREP(ADF4371_REF_DOUB_MASK, x)
+#define ADF4371_RDIV2_MASK		BIT(4)
+#define ADF4371_RDIV2(x)		FIELD_PREP(ADF4371_RDIV2_MASK, x)
+
 /* ADF4371_REG24 */
 #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
 #define ADF4371_RF_DIV_SEL(x)		FIELD_PREP(ADF4371_RF_DIV_SEL_MSK, x)
@@ -70,6 +76,9 @@
 #define ADF4371_MAX_FREQ_PFD		250000000UL /* Hz */
 #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
 
+#define ADF4371_MIN_CLKIN_DOUB_FREQ	10000000ULL /* Hz */
+#define ADF4371_MAX_CLKIN_DOUB_FREQ	125000000ULL /* Hz */
+
 /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
 #define ADF4371_MODULUS1		33554432ULL
 /* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
@@ -175,6 +184,8 @@ struct adf4371_state {
 	unsigned int mod2;
 	unsigned int rf_div_sel;
 	unsigned int ref_div_factor;
+	bool ref_doubler_en;
+	bool ref_div2_en;
 	u8 buf[10] __aligned(IIO_DMA_MINALIGN);
 };
 
@@ -476,6 +487,7 @@ static int adf4371_setup(struct adf4371_state *st)
 {
 	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
 	unsigned int vco_band_div, tmp;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* Perform a software reset */
@@ -497,22 +509,40 @@ static int adf4371_setup(struct adf4371_state *st)
 			return ret;
 	}
 
+	st->ref_doubler_en = device_property_read_bool(dev, "adi,reference-doubler-enable");
+
+	st->ref_div2_en = device_property_read_bool(dev, "adi,reference-div2-enable");
+
 	/* Set address in ascending order, so the bulk_write() will work */
 	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x0),
 				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
 				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
 	if (ret < 0)
 		return ret;
+
+	if (st->ref_doubler_en &&
+	    (st->clkin_freq > ADF4371_MAX_CLKIN_DOUB_FREQ ||
+	     st->clkin_freq < ADF4371_MIN_CLKIN_DOUB_FREQ))
+		st->ref_doubler_en = false;
+
+	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
+				 ADF4371_REF_DOUB_MASK |
+				 ADF4371_RDIV2_MASK,
+				 ADF4371_REF_DOUB(st->ref_doubler_en) |
+				 ADF4371_RDIV2(st->ref_div2_en));
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Calculate and maximize PFD frequency
 	 * fPFD = REFIN × ((1 + D)/(R × (1 + T)))
 	 * Where D is the REFIN doubler bit, T is the reference divide by 2,
 	 * R is the reference division factor
-	 * TODO: it is assumed D and T equal 0.
 	 */
 	do {
 		st->ref_div_factor++;
-		st->fpfd = st->clkin_freq / st->ref_div_factor;
+		st->fpfd = (st->clkin_freq * (st->ref_doubler_en ? 2 : 1)) /
+			   (st->ref_div_factor * (st->ref_div2_en ? 2 : 1));
 	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
 
 	/* Calculate Timeouts */
-- 
2.47.1


