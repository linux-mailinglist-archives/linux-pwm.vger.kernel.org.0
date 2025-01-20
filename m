Return-Path: <linux-pwm+bounces-4682-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CFBA16BA6
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 12:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83D407A3C88
	for <lists+linux-pwm@lfdr.de>; Mon, 20 Jan 2025 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83941DF743;
	Mon, 20 Jan 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="U+sVPyKs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51874191F95;
	Mon, 20 Jan 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737372885; cv=none; b=aiIT7d0aDP5fRYuExPz+3QUVTHaFFQ1/XeQya8LAXS0QyGt55p/5Pd51iHNKgpbW/hU/9OE8d7JVRl+OwGNK5fOkyUnndzZj4vE6xJN5mcCZtMe4pVAh129+V9DqBoOc5vTy40FUKigJT8Sm6nShdWcKhi/hDKOxlFBWI0+HnVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737372885; c=relaxed/simple;
	bh=KY0d6LnwQGgOSB29A5j2A6iKjLfm0RFz2SChSuT45Rw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpNO+iyJ3Yd45MpM5B41xroBTkBKEgxX21OnbnFU/09wkuxoMmzNvaK5toJdvyybJEw8bUf92SHdkxQQWx5yHOmvAW3+1wrvgSnYSyNOgzgoq4+cWHJC/7BubjKnEg4GEmh4gCUAjC3JXJPaziyOFe7gZlGCGAX4QzWpaTJEReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=U+sVPyKs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50KAZKaN010170;
	Mon, 20 Jan 2025 06:34:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=OZngX
	Z24kqHgNuE62DAGuHxHbr8eaj10nYiXfAc+yng=; b=U+sVPyKssjM4zYOBReWmt
	rKq/feEaOoXVumnfyRj7kYupZTj4pS38q1l5+puprH1wgOD4hDXIYJlL22Yfkipo
	vEiNsGpleUgCSy6QfeMywCxwSSwXi8oBoYpUgOvUj/4QJI7hTqDSkeaJozbK8Eel
	BybPs4WpGQG2WSzn6I7j/+igP1GubeTlS88NNJdeCsujJBaGH62pQuWNN+2300hS
	8Z8IsLSKgh8vVVgj4r58r55H8iHybEFjCt4V93gdRMwkb1xZBqKQ8BtguwzXB2oY
	3H9MzjK5YMxjNwhQp1h0MHLZAjZgoBcfQ1wj0K4kPgQm8vNQusBSyAjHYzIHymhm
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 449mv9g6e6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jan 2025 06:34:29 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50KBYRE7001542
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Jan 2025 06:34:27 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:27 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 20 Jan 2025 06:34:27 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 20 Jan 2025 06:34:27 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50KBYEp0007657;
	Mon, 20 Jan 2025 06:34:23 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 1/3] dt-bindings: iio: adf4371: add refin mode
Date: Mon, 20 Jan 2025 13:34:02 +0200
Message-ID: <20250120113408.24395-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250120113408.24395-1-antoniu.miclaus@analog.com>
References: <20250120113408.24395-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: CTOGXvyH3Y6QJT8GBUVVVbh8myuYGHWZ
X-Proofpoint-GUID: CTOGXvyH3Y6QJT8GBUVVVbh8myuYGHWZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_02,2025-01-20_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501200096

Add support for selecting between single-ended and differential
reference input.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - drop default description/option.
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


