Return-Path: <linux-pwm+bounces-4291-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0212E9E90A7
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 11:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9063B280F05
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 10:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A2F21765D;
	Mon,  9 Dec 2024 10:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mOKT+Y6X"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097E52165FD;
	Mon,  9 Dec 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740975; cv=none; b=Q0ar0ty6FBE7PjfkYlxy7QPZd5jGpDDvKrpttW7PjSYsg4kmUHjP3kO3Uru/11bDP5QFS9gEhbSK1/BoHW5z1JNYqJZeR+pyuspd4dkOeBtuWwA9C93fNTcNi5OgWKz//1bAaM2PpR9OMx2X3V5b8evXVLMecVI65Aao5ST80ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740975; c=relaxed/simple;
	bh=SM6swpyt8jyb0ikai78MJrCg7kSAZsAaAumPcFkP1i0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE8tmaoSEKp8dZDucLP68CvEljGktNP3S9bFa/PAbKlRRCkVLD2IZrocRfFlj+7E8HUVgqwoLARtmH+9xlbTOUrFY0fcoQaW07RyBbOESDcvf3nwDWzaFk3yQKNP5Lr3HAGOqNYYEwlctBEWJdhtnrAMCXl1aiW6Eqf8XN1Z+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mOKT+Y6X; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B97E6Nr024881;
	Mon, 9 Dec 2024 05:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tYhmV
	12hRFOk2EbO6khmI3eie7oSghHEWzk+IUbPKBY=; b=mOKT+Y6XvIL/Xv1X23BrK
	tpSqA5N0HYW9G+1pfTmma4NisKRJmEWYhl0xBQsaqfeP3HrH3PUa9J1YHVHzH3+6
	W0kEYCHGk0hxCjSYVjRtt77GM4OA9GeONthrbBdcRlYxBJZX6aRaatCDyEhoCLUI
	fKPEF4KdDsG/5OWgiJKWIz14DGJCW0O8O6tE/NsNTHK3YcarLa2O24jS9YKcY3A5
	vpcv4NqOFEDvlPTZ/5gFVxvUN8a8o4Q7S+hEu6REBTYO++wgMyRECzfI1OhFta8O
	OjBL2tRO2pleNtZ9sL+aIvQ5oUP1eS6CfKufZBZaUsEFlFp2S70rsc6YKUnEqZrg
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43duyw8vuf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:42:37 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B9AgaP7010907
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 05:42:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 9 Dec 2024
 05:42:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 9 Dec 2024 05:42:36 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B9AgQVT004359;
	Mon, 9 Dec 2024 05:42:33 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 3/3] iio: frequency: adf4371: add ref doubler
Date: Mon, 9 Dec 2024 12:41:33 +0200
Message-ID: <20241209104201.25205-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209104201.25205-1-antoniu.miclaus@analog.com>
References: <20241209104201.25205-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4HeFODJ2jYYahXkO8ttp9jO48FsUlMom
X-Proofpoint-GUID: 4HeFODJ2jYYahXkO8ttp9jO48FsUlMom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090084

Add support for the reference doubler.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - drop redundant brackets.
 drivers/iio/frequency/adf4371.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 55bee06fb42d..fd33a6f1cd9a 100644
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
+	unsigned int vco_band_div, tmp, ref_doubler_en;
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
+		st->fpfd = st->clkin_freq * (1 + ref_doubler_en) /
+			   st->ref_div_factor;
 	} while (st->fpfd > ADF4371_MAX_FREQ_PFD);
 
 	/* Calculate Timeouts */
-- 
2.47.1


