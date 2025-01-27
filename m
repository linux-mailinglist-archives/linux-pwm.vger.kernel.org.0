Return-Path: <linux-pwm+bounces-4732-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFDBA1D425
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2072A188835D
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3631FE46C;
	Mon, 27 Jan 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="RJewJ6O5"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CAB1FDE05;
	Mon, 27 Jan 2025 10:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972658; cv=none; b=SQ1txhOsE0+6mSZGX8zO+YIQ32O1Yk9Gr5Kws1wrvkcOGjPNhhzIxRR0dMMw11k//Oo/+ntuvI4hh9ItCpkvqwGdxNdolV0+N286VjOrn1ffuD8RRoEZvwCIoJGNUCjsAxLoFGIyyrOnmxq0gHtODHiM+ErT/Up5GFuCKuWuNU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972658; c=relaxed/simple;
	bh=8TYFmB8Iz/GvlC+nH11+ke7/roKq01wbW3UdF2rRV2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SGc0F+ENjH65Kmh5CV8R85MXckFRu1IMjoJE8kTCVA+Ivhl+ZAwrBraUDIc+BzoThz7An9WtiOmKUQt+oB4vHJuWmGAvxD1egTCJE6sKJMtNu9XRXjF5JdBGBJUIHKMBxo/GA8+SD1SEny3RN/9rNc/6QkY79Ryyv1glcEag4zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=RJewJ6O5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R777nI005722;
	Mon, 27 Jan 2025 05:10:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1aKFo
	BaTPNcLlcJDiUgNc8WpYW0VlMO9Id+YgPann18=; b=RJewJ6O5l+k5+arXcwxSK
	Qs6Ko8CjPYd0GqULCb3CAElL/bZVmeYjnwPvq21VpPmtA//XQsWndtMO0KqtW6iJ
	2YBWdUqCOtrVMRcNs0qQJHxNQK0MRbzZqJtNJeFjOqpaUlKxF3YVwV2nPaO1+zgS
	Rx2hgdYqgXaRmcjMejTj0v0+u7QiFV5BWCZdw4NqSMrDRjJPiOgk8ypRK0b0YoaE
	fcUIKzAM8DedbjiuTfpQVsJUHuZKIYZWyhjW/aLNH+Ze3rW6sTGKq8idIs9pKILh
	VT5UHq2y0qBdhGZ6fijRk8RWnmQHZzedLMni0HH20Xp/mkSvofeGFcxcLopaZyKD
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44e0qwhn97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 05:10:42 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50RAAfsd000499
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 05:10:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 27 Jan
 2025 05:10:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 05:10:40 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RAATiD016396;
	Mon, 27 Jan 2025 05:10:35 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 1/3] dt-bindings: iio: adf4371: add refin mode
Date: Mon, 27 Jan 2025 12:10:21 +0200
Message-ID: <20250127101026.5320-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127101026.5320-1-antoniu.miclaus@analog.com>
References: <20250127101026.5320-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: udZVR_5JGs-p_06P7LdWf5_8PHtimS_G
X-Proofpoint-ORIG-GUID: udZVR_5JGs-p_06P7LdWf5_8PHtimS_G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270081

Add support for selecting between single-ended and differential
reference input.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v6.
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 1cb2adaf66f9..53d607441612 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -30,8 +30,9 @@ properties:
 
   clock-names:
     description:
-      Must be "clkin"
-    maxItems: 1
+      Must be "clkin" if the input reference is single ended or "clkin-diff"
+      if the input reference is differential.
+    enum: [clkin, clkin-diff]
 
   adi,mute-till-lock-en:
     type: boolean
-- 
2.48.1


