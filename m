Return-Path: <linux-pwm+bounces-4277-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE629E73AB
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE86528AF0C
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 15:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585BE20ADF4;
	Fri,  6 Dec 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="T+cD6eMt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8AF14F9F4;
	Fri,  6 Dec 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498570; cv=none; b=bv64f+ewj+8KiiQmgwYUo1EWw/+IGVF+YJz05nQ12UzmjUtO49Ic5cOJcKg5R/syphDyg05qO2qXmIp/5Bb4pNgxpuA1VJsUcQCaBH7zcu8NXpgNASmeta/mDGbqpzqYSwlbvevt2JG7Bx+1PP+L2NL4+WZm5qcwOndLj2e3VX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498570; c=relaxed/simple;
	bh=9PbdXBS0v5c7RlaFuFZ3/F2tacxye402rSh31n5mVf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdJTa2GwB+CecZY7sPjllxMtYGMXvMC8IsMnffjD9qSnnAtmY2ROAiZG03NxIfSjqxE0DX8DN0K+z6jzGq9rK2YZQVMaKJVJzkz+oa7wppFONkZFzd3V7ebw6Yn/S9+OD5lkhOlRhboSti8V4u0tCVizKnhAedyKAaQl3iMWrLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=T+cD6eMt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6E28Yf004484;
	Fri, 6 Dec 2024 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hUgMm
	3Q6oPkxzpLnMmpM1AW/OzDa1/Z+iIiZpjK3tTw=; b=T+cD6eMtk6NC9YttaxilN
	+M/J7ZLj6HsqlSz4j7uMXMhacIHqDw/hMYJt0bEe1jKmvsZq5kSCfhFGHKY7uacD
	mfm4VkEYZZmh7J3buewLJNGg85TEjcMMMQ5ix88eIkQ1UcGciHuHn6CVr4JqcrIb
	/yvXJ1UI++GVdFbfxpOXi51LSjtyVpaDgEHv095NA1kRrWhsUD3eIqo+hU6XNDQ2
	ShPdr80qz+EYI5A6EW4HgMv9lQWPl3GRm1LqxytNPAulf9MeViJ62AM03rAng9Wv
	dDczKBqs6EMLTgXBtCwBsInbuHjXNwBNxut14NUanJ+q1L4LtFV5uAUyrMiofBe6
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43ak0edmtw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:22:33 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B6FMWx3020892
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Dec 2024 10:22:32 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 6 Dec 2024 10:22:32 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 6 Dec 2024 10:22:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 6 Dec 2024 10:22:31 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B6FMM1c025340;
	Fri, 6 Dec 2024 10:22:27 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 2/3] iio: frequency: adf4371: add differential ref
Date: Fri, 6 Dec 2024 17:22:05 +0200
Message-ID: <20241206152207.37928-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206152207.37928-1-antoniu.miclaus@analog.com>
References: <20241206152207.37928-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: W5aEM9VN0-vLWpF6qGpDOD9PVnSQwwnZ
X-Proofpoint-ORIG-GUID: W5aEM9VN0-vLWpF6qGpDOD9PVnSQwwnZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060116

Add support for differential input reference clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4371.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index b27088464826..55bee06fb42d 100644
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
@@ -476,6 +481,7 @@ static int adf4371_setup(struct adf4371_state *st)
 {
 	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
 	unsigned int vco_band_div, tmp;
+	bool ref_diff_en;
 	int ret;
 
 	/* Perform a software reset */
@@ -497,12 +503,25 @@ static int adf4371_setup(struct adf4371_state *st)
 			return ret;
 	}
 
+	ref_diff_en = device_property_read_bool(&st->spi->dev, "adi,ref-differential-enable");
+
 	/* Set address in ascending order, so the bulk_write() will work */
 	ret = regmap_update_bits(st->regmap, ADF4371_REG(0x0),
 				 ADF4371_ADDR_ASC_MSK | ADF4371_ADDR_ASC_R_MSK,
 				 ADF4371_ADDR_ASC(1) | ADF4371_ADDR_ASC_R(1));
 	if (ret < 0)
 		return ret;
+
+	if ((ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN) ||
+	    (!ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
+		return -EINVAL;
+
+	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
+				 ADF4371_REFIN_MODE_MASK,
+				 ADF4371_REFIN_MODE(ref_diff_en));
+	if (ret < 0)
+		return ret;
+
 	/*
 	 * Calculate and maximize PFD frequency
 	 * fPFD = REFIN × ((1 + D)/(R × (1 + T)))
-- 
2.47.1


