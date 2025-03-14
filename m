Return-Path: <linux-pwm+bounces-5195-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C31A617FD
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 18:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04DD61B62D01
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 17:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C06F204F73;
	Fri, 14 Mar 2025 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DPt6T1vz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD39202F7B;
	Fri, 14 Mar 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973688; cv=none; b=kiNigxuukuck4yyqDQKK37kYSzPKR4GRGT5Ce3fpx0MNT+XXJ63CTIhh+QdUDFkDSv5ld0+3gonVfy14+zNnkxgwsGTZKk9zdeHcPI1tBqOQDbXzvK9ogmCaHh1mbUp9NSh2p14vqQhOK46/v30zXzzzLH8gHo9+fzwcyxENwSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973688; c=relaxed/simple;
	bh=Jo1F+SpndTahZzn2NeV6YMgPnUybfbIKse3Y/YgP+5c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cgDTSYi2cPKVwv4l47jgPQng29sl5P0t1O2wBf0OPlIes3iNq6fdNBTVrusj8p3f6sdg6/Tej3S7ifsNwStPxH3OBh5ydzkR+oI1E9/7IEFIBmMblswKdUSVqv66EYD0WsloLsBbgRnRtOxJlqLNa/hor4nYZ93SsfAwIyvzqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DPt6T1vz; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EF9eMT024112;
	Fri, 14 Mar 2025 18:34:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NeK5d7dLB9+0vrbA7blChOQTxW3J9mnj7OUQ3K6i/f4=; b=DPt6T1vziGOjzJF3
	+thTGjKlbuxk3MZmJFUYvaHP6ZCBG9RkMRfo2eh8ReJl4t4VotSxQE5Kmj7pKB93
	hWI1jdo8ETHKrf+8hG/bdz3A6hrvnXCevEREMaE+8kWpnicOSUQhjWxQr5v8DF8T
	eG7wp1QwnDd1wugA87Y0hPJLK45ozpLo3ZRpkmrOuwNwrNelxu7IjNyAmDQL0yjC
	/nGOA8OyM7cym1X6GQYl9nDX2jA/ZPkuTLLiCpu4uFyK4kDbumEE6QKBLeSITusU
	MBEXsOIP68w06fmZIVkqXKtgWqabnCBxeoTfNQu7CuQtPMCKc4PKG4x8Z9FqKRJw
	FPON4g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45c2q157np-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 18:34:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9134D4008E;
	Fri, 14 Mar 2025 18:32:55 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node5.st.com [10.75.129.134])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B69036D8E6C;
	Fri, 14 Mar 2025 18:15:04 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE5.st.com
 (10.75.129.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:04 +0100
Received: from localhost (10.252.1.141) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:04 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To: <lee@kernel.org>, <ukleinek@kernel.org>, <alexandre.torgue@foss.st.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <jic23@kernel.org>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>
CC: <robh@kernel.org>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>, <wbg@kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <olivier.moysan@foss.st.com>, <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 1/8] dt-bindings: mfd: stm32-lptimer: add support for stm32mp25
Date: Fri, 14 Mar 2025 18:14:44 +0100
Message-ID: <20250314171451.3497789-2-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
References: <20250314171451.3497789-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SAFDAG1NODE1.st.com
 (10.75.90.17)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-14_06,2025-03-14_01,2024-11-22_01

Add a new stm32mp25 compatible to stm32-lptimer dt-bindings, to support
STM32MP25 SoC. Some features has been updated or added to the low-power
timer:
- new capture compare channels
- up to two PWM channels
- PWM input capture
- peripheral interconnect in stm32mp25 has been updated (new triggers).
- registers/bits has been added or revisited (IER access).
So introduce a new compatible to handle this diversity.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in V4:
- Add Rob's Reviewed-by tag
Changes in V3:
- Fix yaml indentation issue found by Rob's bot
Changes in V2:
- Use fallback compatibles, along with stm32mp25 specific compatible
- trigger identifier can be up to 4 (e.g. from LPTIM1..5)
---
 .../bindings/mfd/st,stm32-lptimer.yaml        | 40 ++++++++++++++++---
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
index d41308856408..4eabafb8079d 100644
--- a/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
+++ b/Documentation/devicetree/bindings/mfd/st,stm32-lptimer.yaml
@@ -21,7 +21,12 @@ maintainers:
 
 properties:
   compatible:
-    const: st,stm32-lptimer
+    oneOf:
+      - items:
+          - const: st,stm32mp25-lptimer
+          - const: st,stm32-lptimer
+      - items:
+          - const: st,stm32-lptimer
 
   reg:
     maxItems: 1
@@ -48,13 +53,21 @@ properties:
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
+        oneOf:
+          - items:
+              - const: st,stm32mp25-pwm-lp
+              - const: st,stm32-pwm-lp
+          - items:
+              - const: st,stm32-pwm-lp
 
       "#pwm-cells":
         const: 3
@@ -69,7 +82,12 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-counter
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-counter
+              - const: st,stm32-lptimer-counter
+          - items:
+              - const: st,stm32-lptimer-counter
 
     required:
       - compatible
@@ -80,7 +98,12 @@ properties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-timer
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-timer
+              - const: st,stm32-lptimer-timer
+          - items:
+              - const: st,stm32-lptimer-timer
 
     required:
       - compatible
@@ -92,13 +115,18 @@ patternProperties:
 
     properties:
       compatible:
-        const: st,stm32-lptimer-trigger
+        oneOf:
+          - items:
+              - const: st,stm32mp25-lptimer-trigger
+              - const: st,stm32-lptimer-trigger
+          - items:
+              - const: st,stm32-lptimer-trigger
 
       reg:
         description: Identify trigger hardware block.
         items:
           minimum: 0
-          maximum: 2
+          maximum: 4
 
     required:
       - compatible
-- 
2.25.1


