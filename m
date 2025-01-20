Return-Path: <linux-pwm+bounces-4684-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF3A16BAC
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 12:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FD771884091
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 11:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4061E0B99;
	Mon, 20 Jan 2025 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Vw0bU7Jd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A075F1DFD80;
	Mon, 20 Jan 2025 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372888; cv=none; b=PX746BwsI0cPPAAaKcHMi0XZaK59xAbBgjypVcY26jMaZxEpuAnmI2DfV0oZVsorCnYZOh9hTHRDDvbV3n/S1xrigpOIB4lL08j9YGwu5Oofg4rr7lHw6xFZrDkKfBcQNw/gzknahBEFNowDjMZkETTPxOuVwdfX8XPtTXxDCLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372888; c=relaxed/simple;
	bh=aO+WC3B3j0oUxEYPFawrqm6fg9Ck0oLDA2Q9yrwPUn8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p11knflj4ais3YQuaRWA1dMoBWPiNnp90wfI4W1a+/fLlWiaXgqxG/2jVAEadoE6dhXYvsp6FksJ6CEFZoE2IOBPyHinuoxSC8jmzEqxry3baCusHPwan2meeIZ0cMjPQJC0gQHmwdeXqRP4rWTZwGCEPRialGr+RPuPawXbXug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Vw0bU7Jd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50K9kOrt009331;
	Mon, 20 Jan 2025 06:34:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=SK7z8
	Bb7mqOPFwks4seyfmxXc5JiJvQcd3gEDXGi0gg=; b=Vw0bU7JdNfcrJ4oB+fec0
	gLWmaQCSf54B1ZgQ60r+HZ6uYTMeYoW9jyhkuGuL6dJPd6DRoczhmaV30XUJEyP9
	ruMP76wunVHibCsU8TAyPgsO7golR4mXJLmzWG5ia/gtownOtqLWNeOadBOwXGRe
	hhC2oCNAgya1iLX10K2fi68+1ct2d1J7WtDNED4e5Tpz3c6miFUgPy8yZYsDn0Uo
	JxCXxpet1U/LIvA8vpIQxopvdS0W/7+1UsD0xJkj0epDh8zt8xngAw/ZpTZXbqJS
	MheIwcF2bkL0GFAmuKV5eeiLbOUAWSw3KSc59T2IatFcBuSKBywMh0oAZ2Doum+s
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 449g3ehfcw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:34:31 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50KBYUkX001550
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jan 2025 06:34:30 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:30 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:30 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 20 Jan 2025 06:34:30 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50KBYEp2007657;
	Mon, 20 Jan 2025 06:34:26 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno Sa <nuno.sa@analog.com>
Subject: [PATCH v5 3/3] iio: frequency: adf4371: add ref doubler
Date: Mon, 20 Jan 2025 13:34:04 +0200
Message-ID: <20250120113408.24395-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120113408.24395-1-antoniu.miclaus@analog.com>
References: <20250120113408.24395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Q6eu2DzPs265X1bGXx1bgXns0-Ia66Bv
X-Proofpoint-GUID: Q6eu2DzPs265X1bGXx1bgXns0-Ia66Bv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 priorityscore=1501 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096

Add support for the reference doubler.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 drivers/iio/frequency/adf4371.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 50450e7b5464..a57fc24a6799 100644
--- a/drivers/iio/frequency/adf4371.c
+++ b/drivers/iio/frequency/adf4371.c
@@ -44,6 +44,8 @@
 /* ADF4371_REG22 */
 #define ADF4371_REFIN_MODE_MASK		BIT(6)
 #define ADF4371_REFIN_MODE(x)		FIELD_PREP(ADF4371_REFIN_MODE_MASK, x)
+#define ADF4371_REF_DOUB_MASK		BIT(5)
+#define ADF4371_REF_DOUB(x)		FIELD_PREP(ADF4371_REF_DOUB_MASK, x)\
 
 /* ADF4371_REG24 */
 #define ADF4371_RF_DIV_SEL_MSK		GENMASK(6, 4)
@@ -75,6 +77,9 @@
 #define ADF4371_MAX_FREQ_REFIN		600000000UL /* Hz */
 #define ADF4371_MAX_FREQ_REFIN_SE	500000000UL /* Hz */
 
+#define ADF4371_MIN_CLKIN_DOUB_FREQ	10000000ULL /* Hz */
+#define ADF4371_MAX_CLKIN_DOUB_FREQ	125000000ULL /* Hz */
+
 /* MOD1 is a 24-bit primary modulus with fixed value of 2^25 */
 #define ADF4371_MODULUS1		33554432ULL
 /* MOD2 is the programmable, 14-bit auxiliary fractional modulus */
@@ -481,7 +486,7 @@ static const struct iio_info adf4371_info = {
 static int adf4371_setup(struct adf4371_state *st)
 {
 	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
-	unsigned int vco_band_div, tmp;
+	unsigned int vco_band_div, tmp, ref_doubler_en = 0;
 	int ret;
 
 	/* Perform a software reset */
@@ -514,8 +519,14 @@ static int adf4371_setup(struct adf4371_state *st)
 	    (!st->ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
 		return -EINVAL;
 
+	if (st->clkin_freq < ADF4371_MAX_CLKIN_DOUB_FREQ &&
+	    st->clkin_freq > ADF4371_MIN_CLKIN_DOUB_FREQ)
+		ref_doubler_en = 1;
+
 	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
+				 ADF4371_REF_DOUB_MASK |
 				 ADF4371_REFIN_MODE_MASK,
+				 ADF4371_REF_DOUB(ref_doubler_en) |
 				 ADF4371_REFIN_MODE(st->ref_diff_en));
 	if (ret < 0)
 		return ret;
@@ -529,7 +540,8 @@ static int adf4371_setup(struct adf4371_state *st)
 	 */
 	do {
 		st->ref_div_factor++;
-		st->fpfd = st->clkin_freq / st->ref_div_factor;
+		st->fpfd = st->clkin_freq * (1 + ref_doubler_en) /
+			   st->ref_div_factor;
 	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
 
 	/* Calculate Timeouts */
-- 
2.48.1


