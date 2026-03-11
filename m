Return-Path: <linux-pwm+bounces-8226-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG+jBYW2sGlvmQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8226-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:25:41 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E9259C65
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:25:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56BE430A6A2F
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 00:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC82134751A;
	Wed, 11 Mar 2026 00:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VJhPPpir"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5039340DFB5;
	Wed, 11 Mar 2026 00:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188643; cv=none; b=fT+vwQGelPVyLIrWrabK8PW6dj8KOYTf1PCklEaD/V55MrKAP1S/53x16L0Mc2JMTIti+EgNBHS8Llh8IRepJbq8k+zuDkU5oFrQKT2USCN61njzWRK3IzZ9kTNpqwDzqEcfCqWO7RtpTsCK1Dz9aQ/j9i5GTfHh6fmextn8fl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188643; c=relaxed/simple;
	bh=0vwk/t7e+N98O3dRc6umTi6LPT0THtjJc5XgKAA5aM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=etKZygG2lql39RcwBYxXiOC6t4bkmrsDqKJMmHc0IOxgmsM+Tu9MEee7/2qDchfTBUFywI7xXK6r9EhHQ5hUGon0TeAMgdMD4vl02uM+isYYY0rGZriXFgoP24oD4OZztTCkk1P721IzGkQzXt6y5v6nq0tpMy3k+upe/kyDepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VJhPPpir; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62AI9OOb2498765;
	Tue, 10 Mar 2026 20:23:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hOgX2
	Sclojuztsks4mF8mfqm7nO/sZ9cLaInugoxoAw=; b=VJhPPpirXqKkMqmJkRqq2
	jxu7NlXpBSt7uLuz83YQ5Qqow/w+r27LxNFp+kBeEzdws9NMi3HqmGiTjE0yhHEV
	omDkMnU/cXvi8k5zD7IbCkdDz1evFIucQbRdCi6tapfVNZWb/ntW00wOp9Tx0Q8c
	BNjm3UKy0R9WwDuxv0qnacuaNcvXoG1U5nGvBLPx9uZBGQaDv8PNBKxnfd/Qcrba
	enqzR5F7aLvbbHEWVzmUa5tvZUCo99Jta9D+JU27Ec+2MBSJPIXM5YqvEmZrGjK+
	iGExIMFZY/ydT+4tsItz77B3g90ouuIhOcHyzFpDMLJ3V3YmE8JX4cG0Ql4rHSDX
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ctggaukdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:23:47 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62B0NkBe036277
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Mar 2026 20:23:46 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 10 Mar
 2026 20:23:46 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Mar 2026 20:23:46 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.140])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62B0NJkQ015383;
	Tue, 10 Mar 2026 20:23:40 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Wed, 11 Mar 2026 08:23:19 +0800
Subject: [PATCH v2 3/3] MAINTAINERS: Add entry for AD5706R DAC driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260311-dev_ad5706r-v2-3-f367063dbd1b@analog.com>
References: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
In-Reply-To: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Alexis Czezar
 Torreno <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773188600; l=998;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=0vwk/t7e+N98O3dRc6umTi6LPT0THtjJc5XgKAA5aM0=;
 b=0eTQJBcuSEOXwtSW5XQHSFZXXjVylPFaiqvvFNzxwtiXihYiVUykgT/qnCz7Os9hozsDoCKMs
 mL+WeGbEVKpBlmFurnbGrwlBUaQ8ogYgc7elUOx1+hJZZvGCug5g8cS
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=IKcPywvG c=1 sm=1 tr=0 ts=69b0b613 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=U0jeqwZori4fDozOp0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 7FtHOekKewm4nj_nzy--FbhRJ9BwChwo
X-Proofpoint-GUID: 7FtHOekKewm4nj_nzy--FbhRJ9BwChwo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwMSBTYWx0ZWRfX6cqn1iJ5/gcd
 g2D6AIdpAq4LnKmrsxYqjy953ENqdgEm/NgNj9nYVn63mPP09WvBX0y4Z5jB8Rbq40+h18Y9TMS
 GmhnIAbhk9DnDmwOpoFWDP6CbdkjYcrGp5T/zMrRdPtNU5mQ9EXFpAGihe4zF4apYqZ7NbSRpxv
 m7X5CfNDKyHAQcT/CkL50fZ5ooi5TQocrI9Ovb49uY8pmfiDLostStPeOYSnVaZ8W3N6qt2j2Id
 ZauoXx18cjv9XRAiWwCX9u0C+Z7H5ePhC7mDF5llOKBD5wJAF8Ct5xZLFHA69wOI1lx2/+vVmLR
 tSfo2oRZNrqCpIAdhanQVlHGZhZnd3IeScAxfqfJMne1gtjwKs2t6Cw6U6fbCbDiPk2o0rRj2yt
 iuHgG1qwUA2luK5r4cbvCCnVxUMVyO740MoFoJQdCR2kEl/prACWiyT56nhWsvCY2TdL4GdGSij
 eVv0O91hxEvX0NHxamg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0 phishscore=0
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110001
X-Rspamd-Queue-Id: BF0E9259C65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8226-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,analog.com:email,analog.com:url,analog.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Add maintainer entry for the Analog Devices AD5706R DAC driver
and device tree binding.

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1251965d70bdfa990c66966cd77f7ab52ae3385f..3d7bd98b4d1b55836e40687a9a3ac9f4935a8acb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1496,6 +1496,14 @@ W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 F:	drivers/iio/adc/ad4851.c
 
+ANALOG DEVICES INC AD5706R DRIVER
+M:	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5706r.yaml
+F:	drivers/iio/dac/ad5706r.c
+
 ANALOG DEVICES INC AD7091R DRIVER
 M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
 L:	linux-iio@vger.kernel.org

-- 
2.34.1


