Return-Path: <linux-pwm+bounces-5194-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF68A617F5
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 18:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6ED3B8DB2
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Mar 2025 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F7C20487F;
	Fri, 14 Mar 2025 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NLZzZFNa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBFF1FFC60;
	Fri, 14 Mar 2025 17:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741973685; cv=none; b=U2PEIhQerFFGl/ptlenxKE9eeJyVEMjngzw0qi338vNbk+X/RwOeXkorXE5RpHzsXBojBACX6Hg+D7AP9706rds55irVvM44kR5oakBlQxsG1mthy6v3yB6PWY8R6yYgwdfMsI6J77QXilkU7gQ6Si0G73yDkd5zWHxMyktU/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741973685; c=relaxed/simple;
	bh=0UnlsJ/QMPp3en93prvQfDrfGSRGtCvMeCyLsWlTT+o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fv/r1b9K7a3kdeCr92FmkoU+FY8JLdpxsOIvyjDuVAjuGi3GFJioIWWDBp/1F3nu3jFjNOUQzcurZnMIwWQ7sQkNIvi1vBISU8005i9cQsLjoOb43e569fIkFG2tt4flvkaYKOY/uhyrZO80XNJkOp1AkJ3AQZD67G8vI3fNabE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NLZzZFNa; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52EDke2E027886;
	Fri, 14 Mar 2025 18:34:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	2wY6Dic8hzBm+S2wld/DgwBFhKKy9RZVyTbW8u8LUKQ=; b=NLZzZFNaTFhpYia3
	zIwTPaiqdlnOWgVcyZy3qcYBc67FCn06QIA17ArpYzlM2L1MzzEvTNc11CHR0h+J
	jqulFlQrQHBtyr4x3Dh0F6kwQEB9jzGl6IaUUCH+f9v+aV1TzH5tbW9qlvGGl6YK
	vNwqMrwbNd0XtEumsk0FTKzAe0++dQPAovXFEkXE8cXCyInoQt4F2DvROPn3WiLx
	VAuKU7VkJmf+X0y0uLFjHE90vUc8fGrKnxldW8sGsdG9mSgay0UdrrdStUQjIyT4
	+pMqIYoK25ifbheX4Ky2R1BLW3E+Dp4m6N9YjqvpdDmj0OvRj5fxH501tZw5wVvV
	PcqPHw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45au3p6xct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Mar 2025 18:34:18 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 458FA40064;
	Fri, 14 Mar 2025 18:33:01 +0100 (CET)
Received: from Webmail-eu.st.com (eqndag1node4.st.com [10.75.129.133])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BDE96DB61A;
	Fri, 14 Mar 2025 18:15:10 +0100 (CET)
Received: from SAFDAG1NODE1.st.com (10.75.90.17) by EQNDAG1NODE4.st.com
 (10.75.129.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:10 +0100
Received: from localhost (10.252.1.141) by SAFDAG1NODE1.st.com (10.75.90.17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 18:15:10 +0100
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
Subject: [PATCH v4 8/8] arm64: dts: st: use lptimer3 as tick broadcast source on stm32mp257f-ev1
Date: Fri, 14 Mar 2025 18:14:51 +0100
Message-ID: <20250314171451.3497789-9-fabrice.gasnier@foss.st.com>
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

During the low power modes the generic ARM timer is deactivated, so the
the tick broadcast is used, based on LPTIMER3 which is clocked by LSE on
STMicroelectronics boards.

Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 1b88485a62a1..242115863ab4 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -190,6 +190,14 @@ &i2c8 {
 	status = "disabled";
 };
 
+/* use LPTIMER with tick broadcast for suspend mode */
+&lptimer3 {
+	status = "okay";
+	timer {
+		status = "okay";
+	};
+};
+
 &rtc {
 	status = "okay";
 };
-- 
2.25.1


