Return-Path: <linux-pwm+bounces-4906-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BB9A35F0B
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 14:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1928616FC00
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 13:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC0266F19;
	Fri, 14 Feb 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0kBq+DhE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC86D266568;
	Fri, 14 Feb 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539230; cv=none; b=lUJHPvfF73EQ1G8U7DFywEuBE3in9heqkYUImShvB+6YVcT2YLqE6UvPWB390ASTs4jW4/e8tMwYKTue3adxeNRfe+o24Ivh6iHH+3PN1bBgyfTwYo1/297kcpKpL+OOWWy3D7qZwTCbpxTmklnD6whvQK9VZ70L8gtWcLVF4IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539230; c=relaxed/simple;
	bh=So9Q1FlejRdM4gbAqhZQLc5a7c6cMmNLLlL5noONk48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ShzF97zPxy8sR5Nxe0nO42liGfYSYuSIw+bP4zC40DSioLNsNP2YFMUmjlhG8zSfwBxqaCCvjaY4/IPFquDB3Vr7VoSlaHfkKqaf7t5zFDLClwQox2ncVstlsZhBZ566EdzBYUbQolWsPJc7asiRlYGUM5WRF+ZjgKRo3Zz2SVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0kBq+DhE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EA9u9q020768;
	Fri, 14 Feb 2025 08:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Vy+qW
	HG9mUD/9kR6+Bn2cd9l0Cg5hXKEe56CVBDxRX0=; b=0kBq+DhEBeEs409iDjb3q
	80FSRDvDKKzB6dIgj8gZ3RSSSX6R45k+oJfwSrxfFAb5FYj5HBLxCNSlaBaIa2ll
	08dsahYQMgFD6ng3CMU6S8iD5KNgatEt+UAGhhUTwZ14jY0gDktOZXwTkLW/HZy6
	xyRmztKxm8voSx6kaW3LHm3LBDRjaSeGtGNHnyxH6byh3QcINUc2ATTr8iWdmkdt
	FwtCmwmRIN1Rj3sowTwQxLo8rsRmqZj6OxnTH5IqMKX3tUsfyYq/TqncLORFX2JV
	ycU/0SexR0EQPItqsyzUaojF6kFx/Jlj+ApcIG25MgsLpMu8+y2+0/AqPUG0qyi/
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44t3uc8n1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:20:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51EDKFFa018376
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 08:20:15 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Feb 2025 08:20:14 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.172])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51EDJuUV020604;
	Fri, 14 Feb 2025 08:20:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v13 5/9] dt-bindings: iio: adc: add ad485x axi variant
Date: Fri, 14 Feb 2025 15:19:51 +0200
Message-ID: <20250214131955.31973-6-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214131955.31973-1-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZcFhjhd c=1 sm=1 tr=0 ts=67af4310 cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=wI1k2SEZAAAA:8 a=KzTIvUCHwj9sjodXf8EA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-GUID: Ojfu9BTMlAvV5pBpTrmcVirW2ZLyScCu
X-Proofpoint-ORIG-GUID: Ojfu9BTMlAvV5pBpTrmcVirW2ZLyScCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

Add a new compatible and related bindigns for the fpga-based
AD485x AXI IP core, a variant of the generic AXI ADC IP.

The AXI AD485x IP is a very similar HDL (fpga) variant of the
generic AXI ADC IP, intended to control ad485x familiy.

Although this is not preffered, the wildcard naming is used to
match the published firmware under the same name.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v13:
 - adjust commit body and add comment on wildcard matching the published
   firmware.
 Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
index e1f450b80db2..f1b470f74069 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,axi-adc.yaml
@@ -19,11 +19,13 @@ description: |
   memory via DMA.
 
   https://wiki.analog.com/resources/fpga/docs/axi_adc_ip
+  https://analogdevicesinc.github.io/hdl/library/axi_ad485x/index.html
 
 properties:
   compatible:
     enum:
       - adi,axi-adc-10.0.a
+      - adi,axi-ad485x
 
   reg:
     maxItems: 1
-- 
2.48.1


