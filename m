Return-Path: <linux-pwm+bounces-8129-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KAaKXkVmGki/wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8129-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:04:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 052911657D8
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07FC33041A78
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 08:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BB03358B0;
	Fri, 20 Feb 2026 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dy2SvQCr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E36BC308F3E;
	Fri, 20 Feb 2026 08:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574621; cv=none; b=MkXbO+X/i66kKun+vTBWOOy91087aC6q0ovLaPgFD58qzN9LISpDGsYiuK/+1VA7tGXG2ugjef55bHbEeyE2j95sFvvjsVk4Qiz0Ff1rb6pvcnyoq0zOj7xBRKgNodTgDiKHDQTJYZ9nYQh7ikro8u42jAbNLXXqFrcRpUPZioE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574621; c=relaxed/simple;
	bh=0vwk/t7e+N98O3dRc6umTi6LPT0THtjJc5XgKAA5aM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TxcvjxssXMwwDzjKVnwYDejNF5TM6dmWMPCbjh5N4/qlxe76rK4mXw/oUZlUWQPN4p8alzi7UXtlmIFym7c4bPwSh2dfHWoliXftZwEZZpDaW+EkhgDCBc0rxGwp/tRPDFGIlk+IqUPFY/SjSYKiGr6hgBFxd2wJ073yfK97O6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dy2SvQCr; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K7ojva3993164;
	Fri, 20 Feb 2026 03:03:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=hOgX2
	Sclojuztsks4mF8mfqm7nO/sZ9cLaInugoxoAw=; b=dy2SvQCrqyDDCP36M/b6/
	Qrra1HlsuZvwcFYwHunyABLIueuTwaPl/B2iC07dgF2dWYBUb9gfG7e9Kkgv9Jm2
	BJ88EvD9F1PmF+i/hAI1wMc2PG+12++NLwxSZPiB1qohzUpAeYQN4XwhHlL3nW0m
	BaUP8bWJ9aYodrHTxbcyaIKQYUhF0BKyO7OXA4PPrQWIhdXPPX04RAVXblrKdL6U
	dzJrQN4XyJr3mW73fFy72mgTRlqni9EK2t7Apafa0wGQdQDtQgIN0V1foaoRDenD
	aKOwTuIJU/st645bsVUfoDD2k0xYZWvfh+LV4tvEyPDNxJK+n9gjT/c0hx9Pwu5T
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ced6f99yu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 03:03:25 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61K83OjX028686
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 03:03:24 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 03:03:24 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 03:03:24 -0500
Received: from ATORRENO-L02.ad.analog.com (GGONZAL4-D01.ad.analog.com [10.116.20.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61K82vYA007405;
	Fri, 20 Feb 2026 03:03:17 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Date: Fri, 20 Feb 2026 16:02:58 +0800
Subject: [PATCH 3/3] MAINTAINERS: Add entry for AD5706R DAC driver
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260220-dev_ad5706r-v1-3-7253bbd74889@analog.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
In-Reply-To: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771574577; l=998;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=0vwk/t7e+N98O3dRc6umTi6LPT0THtjJc5XgKAA5aM0=;
 b=pmPCRvUlnEacaZZNXLSFee0yK8g7FjHPSPcT+r3FubLtFS8S0eDIZjt/Jozw5/c7Wlq+0O6SV
 uOACHNpCBwrDiPEiPRSH3aPbIbC9MkfUtcAAffSHKA3w+XLF9r5q4vQ
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: JA0J6EeNysBkxyBm7EeRhOAq8eaDNVzC
X-Authority-Analysis: v=2.4 cv=fPg0HJae c=1 sm=1 tr=0 ts=6998154d cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=U0jeqwZori4fDozOp0MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JA0J6EeNysBkxyBm7EeRhOAq8eaDNVzC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA2OCBTYWx0ZWRfXwwnssm//Ci+d
 HdqGIfY2mII5my2Fd+8borl9nb7Dks2t8DsKZb5L/LwSS4QXQ44cIqYkQTHxFyqCQmQz2F6o5KN
 QYVojQPqmSFsqEKF0aWLaL18aKI2RHOPKr/r3K3spsFGTPinexPontFHdKbQe793BFTKD2tH0Ay
 WbdXI3HLS/WcUAqgbatcLiRZZEUok6G7fXlBVmDHn/EMKdXDuWgMfVAmc5Y+73jQTPDtHkCOb+H
 YYqO2wUmB0LParGraTmOYxj7vbx+MtMICYg4FVM/IQG3y2iI3ehwcvwCKIaOXw7axxTPsEz+OLl
 ShnU0klMEONTPKABmI/pfuS8PIoo5CjaNlkJc5VVhqu6xlUQ3d7Kv8unBE5RFtMo4sfID+XcRKg
 jOwyzg21v56fMgbA9wGLyTdlw0IIwd/w9P00JuA+17WdGERJgmegtNy1oYNSx7NsC9jkTPGx6A+
 XOvZlycfFfir3QwSBmg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8129-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:mid,analog.com:dkim,analog.com:url,analog.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 052911657D8
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


