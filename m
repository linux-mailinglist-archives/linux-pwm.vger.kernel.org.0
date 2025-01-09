Return-Path: <linux-pwm+bounces-4562-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA08A077C8
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 14:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD9387A3407
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 13:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E60321A94F;
	Thu,  9 Jan 2025 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OwxXzOdE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85639219EB6;
	Thu,  9 Jan 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429859; cv=none; b=B8S+xV4sZwQEUlMNqHsgx+JpfH8h9lYE7eIWPQu41bwYJNuKkv3wIrdQtgTmTPqECcdWBDbtUGyKglWoMBhcM12VYf6W2XcbAlCNAs8guouWixWQnG965xt+/SLkKV3Nrl/HkKvDK78GKhzyCEiPgSfQ1ADDCCpZzV7tdS2NvV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429859; c=relaxed/simple;
	bh=XM8cc2cMsapuBBA5NQbXE/qOSJJeq4jDMOM0QP2EmNE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DZuCIVVcGkI1iw5S/yqmLMtC87sII6CLbW5HHQOmNhv2XUDwrEKr8DJD8QrkdrMFx5Qx8FVVjDN8um28RJMTyh8lCIXAUTqYI/wzIuMadP0vt9R8XF43ZRnrric9hlrUfQb/2r4Ghu2mG4dFD9Bz63is0ybl3P24qIxxTeGRWIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OwxXzOdE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509DXiAF023778;
	Thu, 9 Jan 2025 08:37:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=wz02k
	VKTF4YJF3KFhHO/ZY5Jy0O2O10nuXFSlWq9t0A=; b=OwxXzOdEuIBD6gGFtAhEY
	0PocuWwvsZJNCPFUhztXzQZ0yHNHVCtgS9ppwloDGNaMTaJq/t+UXsjj0ZzCau25
	/Vi23pvNehYQh53EAFFnQEUgHsdetRhpFAyOrOaGZHtXc1oiViF6N4tQ1yLoIasI
	KWdIKmTYHTwmbndqJKsygOvnrDrHCOz+XtLzQjNsfVs2oeZ0Ry5eR9QyiKU5Bnek
	E4qZ1+2pdpbuVCYNGAwBWxauTAxithfDrjTTPL3UKp8hW9yUY/9zWXiiu7g69wRT
	IHaJCf7wW1NRz5LjDWQdhKmSFePnHE7s0DgxB/9XmVl/JcFF9w5VOUkWp1Dm000/
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4425tateyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:37:23 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 509DbMVf010900
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jan 2025 08:37:22 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 9 Jan 2025 08:37:21 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 509Db9ia009541;
	Thu, 9 Jan 2025 08:37:18 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 3/3] iio: frequency: adf4371: add ref doubler
Date: Thu, 9 Jan 2025 15:37:07 +0200
Message-ID: <20250109133707.3845-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250109133707.3845-1-antoniu.miclaus@analog.com>
References: <20250109133707.3845-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: VHvzJdhUW31hIGf6JAbKQ5giydbfY9hJ
X-Proofpoint-ORIG-GUID: VHvzJdhUW31hIGf6JAbKQ5giydbfY9hJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 phishscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090109

Add support for the reference doubler.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
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
2.47.1


