Return-Path: <linux-pwm+bounces-7405-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FB7BC54D6
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29FB03E2C9B
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6958287253;
	Wed,  8 Oct 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Xk0rJV3f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C84A285C99;
	Wed,  8 Oct 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931480; cv=none; b=KrSttHs5WsEg8wUZ98JNzJFPc7Ld0NrDbZeQULzfw42q5nFe/moSjdapwEx+XjllLSCRXGg6yOk8xIn5YA4dX30F0NKz7JH8NbaDPl/BVjI1OPCBwl2WVMsoP2kqQIp3OINOp6+QYYLDasi78+48CcM2YVafFaEvDL3XpC65mdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931480; c=relaxed/simple;
	bh=ZOJXlfsfVxJTguGRwIyBrAg8MqZ0wAQgxBl2uSeInXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jT7FkJHPBS24iRSgG3IQO80f9BnVdDYJqRXFXAWeC2X0wfgyMYBYGugqPXW6VGrWdRvAZhaFCfhOYa4BGfWVGQW/RnM+kSLxdCXHq/AFV3OiZDwmjCev+jUiuoonM7BfITbbQvmAIS+qVJPmNeOXsS3D5gsLMOI4CK168rTuDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Xk0rJV3f; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598D9EHn010582;
	Wed, 8 Oct 2025 09:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4m0Cl
	nXe/fyz6rYlHrdMykmJwSxMKyWpBGHQnbxEM6U=; b=Xk0rJV3fwtdtXDFoCm8Y5
	RNoIEmIKZ9Kt5gn6cKIPm5FDAgZMlYiCtW1foTmdeA7qa3Nc6khpacvO/Mrch74I
	29JBBzUrimqXlBOWeNzrRUlQVbR5GcArNjpo1rvnHOtUvUNFT0Y1J+yLah1ozibP
	rx/QIQCDVEcV2wOSlJCfaPomgI/eA0SLWcsaFSVQg6GOK9gCrHU3NhHAX8cJJoZT
	PENCULToRhxbKS1gYBirG+27qgD5X4AsZx8kzmh1IRIWArZDjVLJ4DQUv28D9C+d
	hOalsNBBReKA3JzMZ+TyuTD9FdTKFPP4pMyW4IPdT+uN6HaC4UCRT8j0G9Z2QTFn
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe27473-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:51:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 598DpEFB040455
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:51:14 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:51:13 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:51:13 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:51:13 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DoxAq023162;
	Wed, 8 Oct 2025 09:51:01 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        "Andy
 Shevchenko" <andy.shevchenko@gmail.com>
Subject: [PATCH v4 5/8] iio: adc: ad4030: Use BIT macro to improve code readability
Date: Wed, 8 Oct 2025 10:50:58 -0300
Message-ID: <b90bd0c61853000d7f99b6652cb27d78908d8f51.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e66c53 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=HwBGVG7bte8kWS4IyKsA:9 a=br55WurUj89AL1qEz8Q6:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Up5MICLt6SRSLzbKJodLVucN1ljuARGT
X-Proofpoint-ORIG-GUID: Up5MICLt6SRSLzbKJodLVucN1ljuARGT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX2xdQ22z01zXG
 g36FJC2ncKqF5Q4abX4+VcPd3ZftkFusssdFLIKZakPvbg8S0R2oAJ4VxrG4/6fz3ychuOoU5VB
 nJpS1UahpLVurhHbOgvpDLTP9FKOgt4pKd6wdPS73MHmrF0F+1JDKapPBW39nD26TvLSDOsDVlQ
 WW75l2zrOkYry46ZmcYfh4SRhh1JKq1R8V/NkC439Z5gFTMNu2TSlAiMIIMD+iBdX3Wn1zYAnTq
 uEr0rQ8h6Gc3IdsCi1ZixSHtU/mtaKOOUIzBD3QnZr9mey2JrLkYQoO/cxi95TqxpN3dWiWDUaU
 lw9G1stObfNShPe6oyAbJy9z0XTAakmuEHswT35nqPFcF2uFkYYjP62P8sUaadpi7aCR4q23y9r
 SXA5xVz0JtyPxLp6fmPINZ3JQ9YBYg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

Use BIT macro to make the list of average modes more readable.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/linux-iio/CAHp75Vfu-C3Hd0ZXTj4rxEgRe_O84cfo6jiRCPFxZJnYrvROWQ@mail.gmail.com/
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4030.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index 4393160c7c77..b2847fd90271 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -233,9 +233,11 @@ struct ad4030_state {
 }
 
 static const int ad4030_average_modes[] = {
-	1, 2, 4, 8, 16, 32, 64, 128,
-	256, 512, 1024, 2048, 4096, 8192, 16384, 32768,
-	65536,
+	BIT(0),					/* No averaging/oversampling */
+	BIT(1), BIT(2), BIT(3), BIT(4),		/* 2 to 16 */
+	BIT(5), BIT(6), BIT(7), BIT(8),		/* 32 to 256 */
+	BIT(9), BIT(10), BIT(11), BIT(12),	/* 512 to 4096 */
+	BIT(13), BIT(14), BIT(15), BIT(16),	/* 8192 to 65536 */
 };
 
 static int ad4030_enter_config_mode(struct ad4030_state *st)
-- 
2.39.2


