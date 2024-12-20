Return-Path: <linux-pwm+bounces-4419-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED23F9F8F7B
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4431616B269
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 09:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5AD1C07C2;
	Fri, 20 Dec 2024 09:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DoGceU9x"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4981BC077;
	Fri, 20 Dec 2024 09:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688619; cv=none; b=Vz1iWvdhJobjn8ShNbn8Xw4wdghPRUbTw52Zt2j8SpC5oDLvAmly1vF8Aio69MVuXDjxEoGOT4aLTWEep1RrxiCtiF/5k3ugIV4CgYqIeFdMnLAY+R/TF21jWIxR4jNvMChbDa1AIaBd9zgs6IQmeL17pjaiB8O1ywto9RcVdeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688619; c=relaxed/simple;
	bh=VoOyaY0QWxPey2QVd7s1JiZJ9f+uDDzmBlhY87ItAYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kTkDT7tOVCrbuKXuAnlnvX7r2x+3SnLGyxR7j0wnA2zZ7aRYa0RF6i9j5Jo8VmJG0TSsTsIT0j+7dJRVxrSZrG5gxanVo13eEuhGy8KIzA6I00pLVM9Ae9vp6czaHEUXmzNLb2UvipEi2s1yJ+9V+PJLojOCArirbMocS5h2BOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DoGceU9x; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8i9x6014129;
	Fri, 20 Dec 2024 04:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OiAl4
	QX88Q39bwrOiLDGxQZP9++AIGG098upwcBsr1k=; b=DoGceU9xXLh/T1jvfxVLP
	o/4IamvnYAK3KsuCon5QTzadQ4SrghFX7IY3FNO4F2txBIgC5gqdSmIMTWBBHm0e
	5txhOZ+SUP/FNeGV5c9ScqhiB7rsYllWGMAMJoOohxcaXFAq/fmgNmeimBkwsZp2
	SYFIGMVn4KgGSBKdS8bny2ETLi2Ux25NEsCaMB/RbjZkbYkj6YET6e+4nP4p5vVZ
	57LzVTdYdwm/wf3z6NY1SQnMyxkNGIe6unyrjXe3+zHpRP56lcg5hkuR91Ih6DfX
	qcu+Bjl8NC8W6I+cCe5ytwo5lFSVY0rpIcPhxVts9MXqdQfpRyPGzC13XPszy4nb
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43n5b589c1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 04:56:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BK9ucrL050103
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 04:56:38 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:38 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Dec 2024 04:56:38 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.133])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BK9uROX023622;
	Fri, 20 Dec 2024 04:56:35 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 3/3] iio: frequency: adf4371: add ref doubler
Date: Fri, 20 Dec 2024 11:56:15 +0200
Message-ID: <20241220095620.4918-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095620.4918-1-antoniu.miclaus@analog.com>
References: <20241220095620.4918-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -j_NKXuJOjr-mF0D7OROxVF-aqH0KW-I
X-Proofpoint-ORIG-GUID: -j_NKXuJOjr-mF0D7OROxVF-aqH0KW-I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200082

Add support for the reference doubler.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - fix uninitialized variable.
 drivers/iio/frequency/adf4371.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index 34fb75c379b0..f889da110efa 100644
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
 	bool ref_diff_en = false;
 	int ret;
 
@@ -521,6 +526,10 @@ static int adf4371_setup(struct adf4371_state *st)
 	    (!ref_diff_en && st->clkin_freq > ADF4371_MAX_FREQ_REFIN_SE))
 		return -EINVAL;
 
+	if (st->clkin_freq < ADF4371_MAX_CLKIN_DOUB_FREQ &&
+	    st->clkin_freq > ADF4371_MIN_CLKIN_DOUB_FREQ)
+		ref_doubler_en = 1;
+
 	ret = regmap_update_bits(st->regmap,  ADF4371_REG(0x22),
 				 ADF4371_REFIN_MODE_MASK,
 				 ADF4371_REFIN_MODE(ref_diff_en));
@@ -536,7 +545,8 @@ static int adf4371_setup(struct adf4371_state *st)
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


