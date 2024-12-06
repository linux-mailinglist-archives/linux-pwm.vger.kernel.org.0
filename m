Return-Path: <linux-pwm+bounces-4278-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB6A9E73B1
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 16:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7018728B01E
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 15:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA320C475;
	Fri,  6 Dec 2024 15:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZNf4rL8k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4C1207E1A;
	Fri,  6 Dec 2024 15:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498571; cv=none; b=nziH4xK4zKkOGpkWA6yoelZ1JzkNzubyp8YZEIz24DxaD9y2LrfHXKpUuHgeMxQ51dWxRWlLamcUkhoYkS6Ypkx6w27qMbUWJj1PghyGUd7MoOIpw0k5hnX/xc/rm1997nlJ+ChczR/AFATa28vexPT5p/wSSbU/bgvBIISGfWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498571; c=relaxed/simple;
	bh=ue0zjSDUKAz6ZdL96QI8A75tVCwRwgeQqRXoZImt3JY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PU/jpFQ9mjRnlYp0sR+qx9vxioYiDz1HazUIe33gKojtRxzI3BFL9V8bc7glKQuM+MpEqUc9aE1E0b/NFigUtqK4TWkV/lwv2AcIuzj1RHYfqsEpnjOqKL1zv1wLcScmruan3zv9DXMxnpxQhFqR12GDMRTVkw5h8yO7ebdbeSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZNf4rL8k; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6E3xAQ001605;
	Fri, 6 Dec 2024 10:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XgUbt
	M5YUPS4JP50Lpqpp/hIlUxc1ohCAAG3h35M6tw=; b=ZNf4rL8khlr8zJdrKwLKV
	KW+dMgw6GSUmznEmuzpPHShvcW2l06s/wdtteAcN96rDWalaHBjRK8jk7Y4FQDAT
	G3cj5LCdoMQGCk1a8UBOSELPmuEdWc6VBjlCLax7PoSw+pgEH1Lk6IjnKSIT9CbT
	jf5dL4WYvsAAkLuPFcL6n4icrHT0ckOFcRHCsrU7Nme4FwuynHKuN4HS/CJAz2LK
	hNL1IYjedV6vKc4ewJOm0rFkNg4jzoWh/bltyzy+2EKZ4x0+C4gAmqGI9PezCJai
	t0vIR5g/3AOL4hlNrs0iHKqAnkjtCKNeC5Lz4C+lZbitZXc+H8/AAnwCrlplEuur
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43bbcbxym1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:22:47 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B6FMkL9020909
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Dec 2024 10:22:46 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 6 Dec 2024 10:22:46 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 6 Dec 2024 10:22:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 6 Dec 2024 10:22:32 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B6FMM1d025340;
	Fri, 6 Dec 2024 10:22:29 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 3/3] iio: frequency: adf4371: add ref doubler
Date: Fri, 6 Dec 2024 17:22:06 +0200
Message-ID: <20241206152207.37928-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206152207.37928-1-antoniu.miclaus@analog.com>
References: <20241206152207.37928-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: G6Vc7pkpStBiCNo0MxgSYbZ3wlgH8chi
X-Proofpoint-ORIG-GUID: G6Vc7pkpStBiCNo0MxgSYbZ3wlgH8chi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060115

Add support for the reference doubler.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/frequency/adf4371.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 55bee06fb42d..dc01f2aafb9a 100644
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
@@ -480,7 +485,7 @@ static const struct iio_info adf4371_info = {
 static int adf4371_setup(struct adf4371_state *st)
 {
 	unsigned int synth_timeout = 2, timeout = 1, vco_alc_timeout = 1;
-	unsigned int vco_band_div, tmp;
+	unsigned int vco_band_div, tmp, ref_doubler_en = 0;
 	bool ref_diff_en;
 	int ret;
 
@@ -516,6 +521,10 @@ static int adf4371_setup(struct adf4371_state *st)
 	    (!ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
 		return -EINVAL;
 
+	if (st->clkin_freq < ADF4371_MAX_CLKIN_DOUB_FREQ &&
+	    st->clkin_freq > ADF4371_MIN_CLKIN_DOUB_FREQ)
+		ref_doubler_en = 1;
+
 	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
 				 ADF4371_REFIN_MODE_MASK,
 				 ADF4371_REFIN_MODE(ref_diff_en));
@@ -531,7 +540,8 @@ static int adf4371_setup(struct adf4371_state *st)
 	 */
 	do {
 		st->ref_div_factor++;
-		st->fpfd = st->clkin_freq / st->ref_div_factor;
+		st->fpfd = (st->clkin_freq * (1 + ref_doubler_en)) /
+			   (st->ref_div_factor);
 	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
 
 	/* Calculate Timeouts */
-- 
2.47.1


