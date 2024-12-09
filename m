Return-Path: <linux-pwm+bounces-4290-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C089E90A3
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 11:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EE8280C8A
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Dec 2024 10:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A453E216E36;
	Mon,  9 Dec 2024 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="C+Zsfh5c"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F377412D758;
	Mon,  9 Dec 2024 10:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733740974; cv=none; b=A92BfYWyV9zTXU29K1uJBP1C1+RoFzEuIC9xvjfS/zSZ+Zg+xuM2p/Eojbjupe/Ww4O2MSacW+7Zqo8tbrRoHjurRJWK6wwY9/6hVHf/e97ZdhneOm8kzHxDCMfa+wM9WgaQRYblZE+uLbrMBmuBP6YhSaP+vKOkeBPCbsbHzbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733740974; c=relaxed/simple;
	bh=h17uuSw7iE4TfKcHSMiLy0W7uz798S2F5mihSRo09h8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KuS3ir7SGWoZ0FcNPSim85ygpHnM82BtFFZr+aVhxJ8NStG0tmg677yQOC3jgFQkNS9IhhxMrO23hMnyknUPwe0rGYhpSnN32G6a8ilpKzw90JICq4yqZaqCLVRakr6mo/ioJxg95zKlyHrcabfR+Closg1E4XJbddNah9y13Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=C+Zsfh5c; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98tLD2025159;
	Mon, 9 Dec 2024 05:42:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=V/1IBlK9w9X6N6BhBfAtefgRIm0
	4sNLsBXYhaxnlzzY=; b=C+Zsfh5c5SWGSJBROPLRkVV28OKU0+oRRtBaflHt07S
	BXWjq0fLuGFInTJM0yMfmKYWfgF4RRRUiOvzA+/UW2dpTw7brGotZ1YTJ1/ClBEv
	wEE2RCO/n/XwUaCt/w6MzLm8O9nNUNV/hKmVK3E0P35T96UtS+bLjkCfttVBrCfa
	YT/sziQS4NYRZ3mbcrnmKof/VAmWtjRetFOrR+C7R5BQ6eH5ZIEnHo+JJXpSvHIe
	hDhZXoI+EXtigt+l6HyBRBOHagzEJ8emnAuBt1VaegyT9bxvjz+123TP5IGYEj3A
	AiXNyZ6usH1QX3Vwvq9ZSTjUXmCZrBQDWnx0AhUuRWg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43cm557q76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 05:42:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4B9Aga9F037884
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 9 Dec 2024 05:42:36 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 9 Dec 2024 05:42:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 9 Dec 2024 05:42:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 9 Dec 2024 05:42:36 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B9AgQVR004359;
	Mon, 9 Dec 2024 05:42:28 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/3] dt-bindings: iio: adf4371: add differential ref
Date: Mon, 9 Dec 2024 12:41:31 +0200
Message-ID: <20241209104201.25205-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 8nAbxi4qj8lWbVUbOjc-qFE6DGRRQO0Q
X-Proofpoint-GUID: 8nAbxi4qj8lWbVUbOjc-qFE6DGRRQO0Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090084

Add support for enabling differential input reference.

By default the single-ended input is enabled.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - improve commit body.
 Documentation/devicetree/bindings/iio/frequency/adf4371.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 1cb2adaf66f9..dd9a592d0026 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,6 +40,11 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
+  adi,ref-differential-enable:
+    type: boolean
+    description:
+      If this property is present, differential input reference is enabled.
+
 required:
   - compatible
   - reg
-- 
2.47.1


