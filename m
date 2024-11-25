Return-Path: <linux-pwm+bounces-4145-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E989D8521
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 13:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9756BB439A0
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 11:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AB019F120;
	Mon, 25 Nov 2024 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zxmjjv1A"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D084199956;
	Mon, 25 Nov 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534036; cv=none; b=LQ7p0mmzGEvRDSGWTjrBg8vBqneuCFMi1Wgsy3aZ0EPdSWf5dhFKZTP5ynjo7BwxHjRalpqLDi73tUDLstEpAlRgRvJtisNfSepLhyVVY6ZrmovV3880ZSZ1eAM6sHM0vJ0zbVinJjV4hN4Grv9o3HPCqrkSH+vzghXa00caTiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534036; c=relaxed/simple;
	bh=yqstnjrt42P+hAEkFuh7ldMv05C/7jVeTbBm3kpX3SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cx+NopkMRR7YpMDoyuFvBrhc+Z8s9YqbYEJoVXnXx9D2MlECwG5CM90wxM671fcoNH79P90QpPv1tt9AsM2TaVzKVDdqYLt+eUTU3FKRPDbfMuZn9mBGtG8pv4D8xAdbxzZraZ0zetsNdP5SyRNYuw6VLV2x+HHlQwJaM3h77X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zxmjjv1A; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP988sf014757;
	Mon, 25 Nov 2024 06:27:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hFzIi
	r85npFsPy+19jboytsiLG3hCFkL3xdc6nTtocI=; b=zxmjjv1AxVrBnwtlbuzRY
	nAnGwWCaCzNby4kj+vfurXj37ASKQynRCJ7M9w7PSTWFhidR/+NB60T5IThrce+d
	Y70xq/S6kZkFnPUKxJhC40oGbIagDRUkaTIbzoRWYyt2XSPxaHHZycsfhGgeGhKW
	ppSrp7OKus+CLa+UoPwrfykIce5icZCxmYVH0sjInjyYwEpCh1//uuxDtM0sp7rH
	VovTc9kkHia3SNHN2xCG2rmIgk51jAkoaC9lWtmyGOhrlQlmp7P9a7WIY4EphwIB
	wqcV/uv78I9LkkUx911iA/b2xBEW1ZVXGPrul80lbZM1TQ51+PgP1m9C8kpPGPfx
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd0hmc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:27:00 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4APBQxUs035539
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 06:26:59 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 06:26:59 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 06:26:59 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 06:26:59 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APBQnwf016096;
	Mon, 25 Nov 2024 06:26:55 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/2] iio: frequency: adf4371: add ref doubler and div2
Date: Mon, 25 Nov 2024 13:26:41 +0200
Message-ID: <20241125112643.10459-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125112643.10459-1-antoniu.miclaus@analog.com>
References: <20241125112643.10459-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: CL46mR-MHzS0bDxRrYYJ7d1PCHqGEizs
X-Proofpoint-ORIG-GUID: CL46mR-MHzS0bDxRrYYJ7d1PCHqGEizs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250098

Add support for the reference doubler and the reference divide by 2
clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - assign directly `device_property_read_bool`
 - use struct device *dev = &st->spi->dev;
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
2.47.0


