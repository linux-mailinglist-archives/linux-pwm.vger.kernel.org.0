Return-Path: <linux-pwm+bounces-4563-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D19FA077DD
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 14:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA5793AA36F
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 13:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E09A21C16A;
	Thu,  9 Jan 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GREVaYVf"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38121A43D;
	Thu,  9 Jan 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429860; cv=none; b=B6/p18oXYKu/fMi16oug88LG8LIp5dH86L9Xgv1lFCOcccEiYZNqNBXIv6/ewCVCzdcSzYbkWbFLo9kVmcHqy08jKsLPNH0T0FE2g1kSMQTkNABW8AZ2dfnxn2Mz6wsKvw3orIWFwkWlkt5XFQWRHlk/f+5BdTmrOajoBTAx8Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429860; c=relaxed/simple;
	bh=3TL3P93zsKqoSmdqawghwIZScPoVGIMXCBLWVPbgvS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FxGMOq56Y9gaB9JwEXeZQySdW6J9aREKhEypiipXxb/v59cEjCqahJAZ1W+wspUEd51BsiHcD0ukYV3k8QfaGs8MBRHApcP0WReqQKdsKG3cVKOTHs95iUaINyA4Pf72esv182zL63LRFS9R+7e4ulRctv+hAgFizvZk27b/nSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GREVaYVf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509C52M4017205;
	Thu, 9 Jan 2025 08:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S2O1U
	kOQM2r++5AvEamDfVch6tdzv16Qf0BFujw6rmU=; b=GREVaYVfWwnhypzg3jdzs
	oLnPplwoDhAnjRgaH/BOvXF9Yn5MX8rWeT9HVkaz3aaeFlUQ+qNg1nSckAoIFEX5
	ryzHxX/zxKAcOw8fdjAVC1F9C4D4xrVcIcGY0+VCgnM8SZD5seD5SPQkjHhOR8V9
	k9CJjdmhCtP1zjaKO4Y8UZ+HLXcTtUN0T/PCAlgk65gUo9yVp+9rHLyayAj6ZlDl
	MYWXRHyFTcpAPhh8q4MqHeJmPbthWUGNBkM8xNT04ZDhLxWbvjrzkUst6VFJHBOd
	gJ1ROT98wjyeQyfsVr/mlHsJGwhUrVlT5wOVfjv5q9leKu0q7Xfnf2w6fotrIGl7
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 442e57rasu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:37:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 509DbJdE055645
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jan 2025 08:37:19 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:19 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 9 Jan 2025 08:37:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 9 Jan 2025 08:37:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 509Db9iY009541;
	Thu, 9 Jan 2025 08:37:15 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: adf4371: add refin mode
Date: Thu, 9 Jan 2025 15:37:05 +0200
Message-ID: <20250109133707.3845-2-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: 6WqyO_37_t2If0ebT7x8qSJBXjVCT4pv
X-Proofpoint-GUID: 6WqyO_37_t2If0ebT7x8qSJBXjVCT4pv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090109

Add support for selecting between single-ended and differential
reference input.

By default the single-ended input is enabled.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - add enum in clock-names to support both se and diff input.
 .../devicetree/bindings/iio/frequency/adf4371.yaml         | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 1cb2adaf66f9..9ad5b22c59d7 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -30,8 +30,11 @@ properties:
 
   clock-names:
     description:
-      Must be "clkin"
-    maxItems: 1
+      Must be "clkin" if the input reference is single ended or "clkin-diff"
+      if the input reference is differential. By default single ended input is
+      applied.
+    enum: [clkin, clkin-diff]
+    default: clkin
 
   adi,mute-till-lock-en:
     type: boolean
-- 
2.47.1


