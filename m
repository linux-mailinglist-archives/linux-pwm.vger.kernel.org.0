Return-Path: <linux-pwm+bounces-4418-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BA39F8F76
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB09E16C14F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 09:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754321BD9CE;
	Fri, 20 Dec 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OT2y5n3O"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32BB1B4237;
	Fri, 20 Dec 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688618; cv=none; b=YAMWJd2SPIWMF0cMmPO8Wx9YC1LJ8gRjIKEX09prYHzfIGRS85KblM046zW+XJdIvwgRVgu0b4r5ctvCavtqF+eAWK7qQbDQQxJRnnkW0EiRfNK710DWDzJRetYZ0RRpuNd8kKIqY3xYhOXNFx0347Ru3UkFggp1R4IOSGZekiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688618; c=relaxed/simple;
	bh=j1Z97RR9ZGRu0VecUNl8FAARVXyajzps9es1P5etqCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X6RA2kob9CPhD//rNOHJsyDP8Fehq8YuZDPLI46vXRsqT4J9XYqbtBqQqP3cfXkxZmWLOy0nIEsu3HqsudEFwXZyTzLDJRy82/drHLRXvjxqiX7mjAO9/D0Yq8OrseWbqDoDOiwwT+qoIVKz4fB5W2XMOc5PGdM4hhbmrEM/t5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OT2y5n3O; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6tvTv026657;
	Fri, 20 Dec 2024 04:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LczxP
	/ItOE6qabCIGfsaeZQmoiD2ClJiKZFUxFP8gO0=; b=OT2y5n3OoDrGzlEkitg52
	3h5QnOYZacugYf7VYDw5+RHzkKwB3EH0rqE6FLE3BCiJ1QLv2IRPAcQ6RRO1VfRx
	iRI3U8t+jABrn/Kb/dJwEjpfkX7VYIe/OfDJXjUrUCIQ1y1zjz6oN5+V0Ck6Ruh2
	n5/sqyJqAwgtL//BZkmybZ3ZAdqt/vl+CGaOjk4Mc9X2YiGDZNvDlswBS1Z34+t2
	6HwvjN++8nE3aRUwigw24Aj00/Z2uS9ef0A45xq87iW+eeZUWg5Y1PgNFhkegvCy
	NxnOPLTgC5XM1SJgvsWbRy/0uK7IqHpY7j1+KaphPDDHrfGYGOY5uODi8vkZhH/V
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43mxv09x2q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 04:56:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BK9ubbB002455
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 04:56:37 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:37 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Dec 2024 04:56:37 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.133])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BK9uROW023622;
	Fri, 20 Dec 2024 04:56:34 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 2/3] iio: frequency: adf4371: add refin mode
Date: Fri, 20 Dec 2024 11:56:14 +0200
Message-ID: <20241220095620.4918-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220095620.4918-1-antoniu.miclaus@analog.com>
References: <20241220095620.4918-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: PSRi3Dqb5LesPlPT0QW2ezoggyjRyrNb
X-Proofpoint-ORIG-GUID: PSRi3Dqb5LesPlPT0QW2ezoggyjRyrNb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200082

Add support for single-ended/differential reference input mode.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - parse refin-mode options.
 drivers/iio/frequency/adf4371.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iio/frequency/adf4371.c b/drivers/iio/frequency/adf4371.c
index b27088464826..34fb75c379b0 100644
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
+	bool ref_diff_en = false;
 	int ret;
 
 	/* Perform a software reset */
@@ -497,12 +503,30 @@ static int adf4371_setup(struct adf4371_state *st)
 			return ret;
 	}
 
+	if (!device_property_match_string(&st->spi->dev, "adi,refin-mode",
+					  "refin-diff"))
+		ref_diff_en = true;
+	else if (!device_property_match_string(&st->spi->dev, "adi,refin-mode",
+					       "refin-se"))
+		ref_diff_en = false;
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


