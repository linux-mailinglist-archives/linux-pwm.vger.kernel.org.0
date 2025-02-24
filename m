Return-Path: <linux-pwm+bounces-4968-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A948BA42AD7
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 19:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA4747AADAA
	for <lists+linux-pwm@lfdr.de>; Mon, 24 Feb 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010E265CD3;
	Mon, 24 Feb 2025 18:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SEzwfKKX"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2997265CAA;
	Mon, 24 Feb 2025 18:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740420836; cv=none; b=Yo9r0F4JAf1JBvanQYGmKPb5wLkZUzhn29PRr97ipa8yjJ3WlwWrWOvVKHeST3eRiLAQA8l0kgSKimi5szqm0FIyoGkyb812VvTrJH+xwMp+BWNhjx6FsWVGXUaKY4q3zqcMBrfDbj2C+igKS4I6lkp01gHeQVKuuMBBreDjHU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740420836; c=relaxed/simple;
	bh=pnd3rIN5DaBJpVqAUwzguAS4ypgCyb7+UhxpV5ksvQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H//0+iQJd6dzJuABWSxAU4HH6XGr7c1i5GbglYaggrlym2bfJxrQOUptO13xG6GjhUKdQok0LvwGMKkgrtIkfBk+wzASeUquUMS2VejSVX3RP0lqtwP85rlg73y1Qmt7cIdoXTY2V6EAuUPy3+MN9WDcxb8VcOZgkMV6eEZwEhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SEzwfKKX; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OFKCXP023814;
	Mon, 24 Feb 2025 19:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	3Pv8LFCx4t6NMriqTItuy7XpPPudhzwAqEqZ8Lq4mjI=; b=SEzwfKKXhOi0idtv
	A6QNfbDuVgfR9QDuvk2NlwNvjRR2k17PvPHMp/2BgxeolZJ/7A1icFkNT5GdLttU
	Rs/I56jtDtEsLC208t0ujEia+MiAfKMcZMR3etFYpksvgB8ySlp+qSHCs9Y68JVD
	g6cJ008Q+5MbkcFSQrUMKm3HocBeNo7zHrzjny1418gl0H1KCd6RNqT0hvr6G8fT
	iCVoG93zwc3V2WUjEJNPg0GRSXxGJ7D9TpjoHeP1goDngUyCFQghC0GTGTUvfhI3
	GKYWk8ClQujK4Vjk33KTNbK82Pk/Z+EPgZAjK2fDG+jPbCwOruto868lDCi7cmoC
	XxvPjQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y6bh0hw4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 19:13:38 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 184994002D;
	Mon, 24 Feb 2025 19:12:21 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 933E553FC05;
	Mon, 24 Feb 2025 19:02:30 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:30 +0100
Received: from localhost (10.252.23.75) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 19:02:30 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <wbg@kernel.org>, <jic23@kernel.org>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>
CC: <catalin.marinas@arm.com>, <will@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH 1/8] dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
Date: Mon, 24 Feb 2025 19:01:43 +0100
Message-ID: <20250224180150.3689638-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
References: <20250224180150.3689638-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01

Add a new stm32mp25 compatible to stm32-lptimer dt-bindings, to support
STM32MP25 SoC. Some features has been added to the low-power timer like
new capture compare channels (hence more PWM channels, and PWM input
capture). Some registers/bits has been revisited to support this.
So introduce a new compatible to handle this diversity.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 .../bindings/mfd/st,stm32-lptimer.yaml        | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index d41308856408..4822ce5d0c76 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -21,7 +21,9 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-lptimer
+    enum:
+      - st,stm32-lptimer
+      - st,stm32mp25-lptimer
 
   reg:
     maxItems: 1
@@ -48,13 +50,18 @@ properties:
     minItems: 1
     maxItems: 2
 
+  power-domains:
+    maxItems: 1
+
   pwm:
     type: object
     additionalProperties: false
 
     properties:
       compatible:
-        const: st,stm32-pwm-lp
+        enum:
+          - st,stm32-pwm-lp
+          - st,stm32mp25-pwm-lp
 
       "#pwm-cells":
         const: 3
@@ -69,7 +76,9 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-counter
+        enum:
+          - st,stm32-lptimer-counter
+          - st,stm32mp25-lptimer-counter
 
     required:
       - compatible
@@ -80,7 +89,9 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-timer
+        enum:
+          - st,stm32-lptimer-timer
+          - st,stm32mp25-lptimer-timer
 
     required:
       - compatible
@@ -92,7 +103,9 @@ patternProperties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-trigger
+        enum:
+          - st,stm32-lptimer-trigger
+          - st,stm32mp25-lptimer-trigger
 
       reg:
         description: Identify trigger hardware block.
-- 
2.25.1


