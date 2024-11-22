Return-Path: <linux-pwm+bounces-4118-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE399D5E1F
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 12:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25F67281552
	for <lists+linux-pwm@lfdr.de>; Fri, 22 Nov 2024 11:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29921DED42;
	Fri, 22 Nov 2024 11:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SJ5aoE3o"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B3A1DE2D2;
	Fri, 22 Nov 2024 11:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732275191; cv=none; b=B8laCzP2o3fyKtzdfkqiGoDK2Paf5F3HHqHwqfx9t9rGHdS/ZA/akRA7NCljpGtP9zfYpfNIVw8cNjQ9vwLFVFDN3LEo2Yhw5D40T6kaakv31fslaURE4XpcTprwPRtNiSj0cruZ1ktLwtUujjxPg/U3u1aNbKCx5W7i7Htro+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732275191; c=relaxed/simple;
	bh=TeNwswg1hkcm5NrYEE4/qOtpl/kIp4I7ZBECogJ/1o8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MUh43XmofAUneTAQWHJxm6UMoQAySqBKR8AEhVD6jroAnyPCsX8sWJSTplhKKg92DvBJz6yBkta7JdURnW7W9FjiutTHdpjdctbBrM/rpIhnlsVa6Gk/Lmk+Mh1MW+mueh/OinMxZ9w6Ok750+Yj85E7x3L8ccn1PcMFhmLh+1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SJ5aoE3o; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AM6e4rO015518;
	Fri, 22 Nov 2024 06:32:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=SFHUr+0ffpzpCmFD4QpoGc4xgUW
	Bwn015YdQhBOwfMw=; b=SJ5aoE3oYPvgVAWUzZAgDdHrKJUSAM7SKLoBdEbfvtk
	65C4HAP2wrfRkcF+dHK/F1KwfbIs6DWTKeY7bd5GfYksn2H0JzYLjX6wZDqfGDaQ
	5BAs+1vWtS9PkIgt4/OZOCKMzlRjVT5BguOxeqMozpxm5eaKd6V6UsAnKKFB7TIq
	OxA9cKM6vbVI6I4mtbyqMjHWp11pftz1WZ7BVuoNoaCvHilOxBBM+7K+dt5LJ1+c
	WwIuSL75lJpY0LoN8ehfDZ3AaJ32ym5yTxIazm/HEntr8mFFhm+rEChtFKa0c/Ev
	7h10PNoi/QDP7KbrVpLrvuCpNcKQmBe+RaftG1MpFxw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43170g56ug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 06:32:54 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4AMBWr3J054996
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 22 Nov 2024 06:32:53 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 22 Nov 2024 06:32:53 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 22 Nov 2024 06:32:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 22 Nov 2024 06:32:53 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4AMBWhjH011707;
	Fri, 22 Nov 2024 06:32:45 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Date: Fri, 22 Nov 2024 13:32:13 +0200
Message-ID: <20241122113226.49346-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: llMGW39BNZAMSCuCIOeJsupQEczoVbLt
X-Proofpoint-ORIG-GUID: llMGW39BNZAMSCuCIOeJsupQEczoVbLt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220098

Add support for reference doubler enable and reference divide by 2
clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../devicetree/bindings/iio/frequency/adf4371.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
index 1cb2adaf66f9..ef241c38520c 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
@@ -40,6 +40,17 @@ properties:
       output stage will shut down until the ADF4371/ADF4372 achieves lock as
       measured by the digital lock detect circuitry.
 
+  adi,reference-doubler-enable:
+    type: boolean
+    description:
+      If this property is present, the reference doubler block is enabled.
+
+  adi,adi,reference-div2-enable:
+    type: boolean
+    description:
+      If this property is present, the reference divide by 2 clock is enabled.
+      This feature can be used to provide a 50% duty cycle signal to the PFD.
+
 required:
   - compatible
   - reg
-- 
2.47.0


