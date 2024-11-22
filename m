Return-Path: <linux-pwm+bounces-4117-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C79D5E1A
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 12:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8B21B2229E
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 11:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B81DDA3E;
	Fri, 22 Nov 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qIHKOly+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B02110A3E;
	Fri, 22 Nov 2024 11:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275189; cv=none; b=ATR9TPpblQgZ0mv4Wz9TR0PBw0UJmeWXnC07T0BDTEutXLhU2ApARxDNLcFhviUZxFKt/5vAidWFozLV77x4gHyqZsXfxuOv3fnNJJu2AcY8lxQ7bzXH2CUvjqZyWVGN4MkaZCvCGCKTlqFgvx3K/Me0F+dZW/4SujRJ9uWgW/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275189; c=relaxed/simple;
	bh=5+fSa8A8qCcFrjh+ml+7X18cLR161OGeZHL6oHQGkCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNn1u6tQajypJUa4k0ElNKBvpFdidyyYFJZo/7S7DnEicIZ2nYsixyhLCBnLL3FuSsTWMgDm4Skl5wmqR0lrsJ4Vq8H9fs311YGrQ6F3wvlrXN1ut7g0QYWG+ivdsPI9rYRxdftpFib929/1fi+vexxbDkCM3pyn09tfFb6rxYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qIHKOly+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM7XIu1016463;
	Fri, 22 Nov 2024 06:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cjgm1
	YWWHcKG7zB/59DmBjIGwBuw/9gSJ4mRUI6bPTc=; b=qIHKOly+9CMbfhbtMh580
	6vdXZSB5DSgXdTuHdUmroVK1+oipwYH3d4xpY+F19DKA/4/jNFUXQ+bn0vxgnNlk
	pOdxzU4BHNUHuB54PuD49pfQbuNs1inwfR3Wl/hl8vYX08Jwd4CmeDbd3HA//WgT
	eQ5lXBpidigbVBgYSBkpKdd8O+E8WWJwO3+3HReI528Tb6n+P9qetesGLTw3DBVH
	BR6UTtQ6Vtuxja2mNdMQGm9N72v+vW3/u3y5j2oGNlNEAiULO3fzzOqBAFVN47VF
	KLD5yXAZxMTVMfDmw9yKRizmevczvshKCdnamlxr04J/gSIMcbXg7hj6O3MKPoxO
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 432h1kj673-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:32:53 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4AMBWqj1044209
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Nov 2024 06:32:52 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 22 Nov
 2024 06:32:51 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 22 Nov 2024 06:32:51 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AMBWhjI011707;
	Fri, 22 Nov 2024 06:32:48 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/2] iio: frequency: adf4371: add ref doubler and div2
Date: Fri, 22 Nov 2024 13:32:14 +0200
Message-ID: <20241122113226.49346-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241122113226.49346-1-antoniu.miclaus@analog.com>
References: <20241122113226.49346-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: HeTr84pVKyRpMuzmIc7ZHKwNy-0ul_SA
X-Proofpoint-ORIG-GUID: HeTr84pVKyRpMuzmIc7ZHKwNy-0ul_SA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220098

Add support for the reference doubler and the reference divide by 2
clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4371.c | 37 +++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index b27088464826..02d42652dfdd 100644
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
 
@@ -497,22 +508,44 @@ static int adf4371_setup(struct adf4371_state *st)
 			return ret;
 	}
 
+	if (device_property_read_bool(&st->spi->dev,
+				      "adi,reference-doubler-enable"))
+		st->ref_doubler_en = true;
+
+	if (device_property_read_bool(&st->spi->dev,
+				      "adi,reference-div2-enable"))
+		st->ref_div2_en = true;
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


