Return-Path: <linux-pwm+bounces-4417-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5B59F8F72
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEC018974CB
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411FF1BD004;
	Fri, 20 Dec 2024 09:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ctDEvyWx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6201AA1F4;
	Fri, 20 Dec 2024 09:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688618; cv=none; b=QBwK5Q8OKaGuINq3SYWqYULl4IV6eJoZhVNo9QQKhQnRwPBQm/IKerEysqMv0QUqWsS1cYfkYKtTvuFLiqoseCOKWmpsgAaqRuY02qghyye5zy03PUb5ns3gczvTvYAujBV8CgKmLwplu4fDmnaG3CKqNjnWAkmaCivxO7qxvHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688618; c=relaxed/simple;
	bh=WFCAty3T5OlZTVXtz3EXQOL8iEJyNRBY4SckHO4UzTE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frRD+sVXVb2y5yrtg1dlmXm/Zu73PKJYBOmxzuOsVwxNf+ae0mWBHNR8xAy4CuqmIxlyiEHKXlP7Xk5mzT3Z36ZRO6VJJ5EcxeuRFlmfRy/6RtSexhMyYNPO6nZYOCZYPwJ42AEyzejVaDOqtu21BuU2WDvNHUFs3IF68CZ74jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ctDEvyWx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK9Ugmm001674;
	Fri, 20 Dec 2024 04:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=nGNo+
	y7yEdnfOVIlU7Lnm+js2gsKnUSiFTcoyykDQY0=; b=ctDEvyWxTyzf1T98LLfLC
	8qcBcypm5U15zIEHXyheKTpRsdQ5R9nK197rsotADf9Av8wC3R6z87yyINsESeSp
	NBz8s0dYXwkyg3ooE131cRzIxlT8nrhj5Ll0je5RtPAGs9RFUFMsfRTwI3tYsI34
	pKtVMPMc5VU+kIAQJXP570Zyjm5z/3q84Lq6WyD57988BEIlnrV3bAJH3tlxIdAW
	fTiznXB9BkshbSQ47jkvYE9iFOk3WO5Sdo5vL6rmrtv6CxksjZjM5CBLE0ZEtAL9
	oVSEjkrDBJsdLyGj30WSS1S7fFAnnY1F0ocqC1G0zgSYgCVWGIvZ2x+OLODB9u/6
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43n60ug3v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 04:56:53 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BK9ucvc002458
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 04:56:38 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 20 Dec
 2024 04:56:38 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Dec 2024 04:56:38 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.133])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BK9uROV023622;
	Fri, 20 Dec 2024 04:56:32 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: adf4371: add refin mode
Date: Fri, 20 Dec 2024 11:56:13 +0200
Message-ID: <20241220095620.4918-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: Iph49NjI6xGHxJJJ3C_wLgAUUTCfwol_
X-Proofpoint-ORIG-GUID: Iph49NjI6xGHxJJJ3C_wLgAUUTCfwol_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200082

Add support for selecting between single-ended and differential
reference input.

By default the single-ended input is enabled.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add option to select between refin-se and refin-diff
 .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 1cb2adaf66f9..f927d3af9f43 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,6 +40,13 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
+  adi,refin-mode:
+    description:
+      Choose between single-ended or differential reference input.
+      refin-se - Single-Ended Reference Input
+      refin-diff - Differential Reference Input
+    enum: [refin-se, refin-diff]
+
 required:
   - compatible
   - reg
-- 
2.47.1


