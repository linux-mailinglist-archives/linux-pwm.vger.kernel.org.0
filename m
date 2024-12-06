Return-Path: <linux-pwm+bounces-4276-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA49E73A7
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 16:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF2928ADA9
	for <lists+linux-pwm@lfdr.de>; Fri,  6 Dec 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7B1EC013;
	Fri,  6 Dec 2024 15:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Ybjvw7ZQ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E033E148832;
	Fri,  6 Dec 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733498569; cv=none; b=jXtjkQ7nK2yr/TtLhzeJtsjJATiz1eb0vcsv1fRZLyEP79ha9a4sCRNRb0PiB+Yq+UahD1HgwB8DG8/ZtBONLkWLAKDnfjJqOSXzMkVv6NEG6esi5bnbJQl0sgfGRa+iqrJxhwrfEXp+JhXLj8lXTCVR4YVhIAfHpinohjpC+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733498569; c=relaxed/simple;
	bh=DhbQchCub9U5elTP6juJG/8cBmU+WUrbG7WOjeZ0sEg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rn1QHlLMOS1lx8okCmyL/KD3t7KGsiimU5y51sbCjzib1DNAry+qGEMWJFDyhO4Tb6/yNFvpLIGtNe/naQU0Yzz3Sav5cTSgTXISyO/ZEQpfmLO5yEPfkRYECjIpNiXSHX23TKvWiLWMtNyq1S4JT0kxkukRVTduns2yM32TZ7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Ybjvw7ZQ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6CI5NC016048;
	Fri, 6 Dec 2024 10:22:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=xxpIuAj3vCkmCNrV10X2ET//KfV
	tu4n49xBopSsZDXg=; b=Ybjvw7ZQW3xW/KjULS5G9DEIsMmPetQhcAVqnjumsrl
	fyXbkIgtOpw1rcTk1Y/y3qlcTINJ24yMbn6b2edqjLIAW7VvU+1gYVqWDUtf3Ecu
	SKMWqEXW740zbIeJr+psRw5nA/nzI2mU6babvoPtqwHw+8UVUruKBoaGtqtFwZ5K
	tkapRAnMyMwJ5XCl++NM7Lua+YD5a9mfHj34uXCPSn3Xr++MdGEVhvnuz9q5YI4f
	OMuoVgN1sc8A8BztOnQOl+Wt3glH8t1me2GxtkKjGtrPFoiJhN/uCCqlhJB2aSde
	7RFJiSRV+4jl/gHk0uD3pEOt7ShBq/uWNS2wAWQv6zw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 43c15c8qe0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 10:22:33 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4B6FMWTg020888
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Dec 2024 10:22:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 6 Dec 2024
 10:22:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 6 Dec 2024 10:22:32 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4B6FMM1b025340;
	Fri, 6 Dec 2024 10:22:24 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 1/3] dt-bindings: iio: adf4371: add differential ref
Date: Fri, 6 Dec 2024 17:22:04 +0200
Message-ID: <20241206152207.37928-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: qtoTppQDTkhRj-VdQE3V7b-EW4i2m4Zw
X-Proofpoint-GUID: qtoTppQDTkhRj-VdQE3V7b-EW4i2m4Zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412060116

Add support for differential input reference clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
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


