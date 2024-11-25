Return-Path: <linux-pwm+bounces-4144-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B729D846A
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 12:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE43616206A
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861D0199951;
	Mon, 25 Nov 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="oI9mghsj"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DCD199237;
	Mon, 25 Nov 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534034; cv=none; b=kMM6VhEGYeFMPVHx9uH3Ud02DV6PIfKtGSXcSygsqAuYR4nag0SMbKX/xCezXeBQSVktIZnGgf/Oe+ar3qOvAHdwHtehsWvx5pz8KU8sppGrluhHvPWmz9OTpzuZ3fEGt2pTPpbM9lo7Rm1cXM5KtdWtSZg5e5ma5W/B+FM8WQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534034; c=relaxed/simple;
	bh=DRGspjbqjN23LtA+APoSYqNdcPUZTf5iTyaAJ+zmeGk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNQyz8hbelWoeny0ZsKBWF3cMgcZfZODC5FfI+WvQDUbbAOX9tIa/GG5FSOYOcHDnqr4kq0JkxkzBUz0QYhRqFIi3G8JJZ+gndWxk12hbMqf9K2R5dpLJ2Ke8hyPCWdy2tk7DIa/kR5JMQEK/E4IPPzHgZr2KhfvzmUbIvapNAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=oI9mghsj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP986xQ014718;
	Mon, 25 Nov 2024 06:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HKgF6
	rVrPKIh3iIxTmAJXjuqVMT/IpO9S0vn9hEgoyU=; b=oI9mghsjkP6xfsKuL4D9o
	M/NjXYlzgbLa2SJSOaOPG4Tx7tzpCPezOvchc4RliRTQlL57I/nMJyDuqnxr8x84
	QV/JvU/H/Vn6fDi9/3QTEz1GLvu/Yvdkie22XXOxt/1tozgMt8VWiNeCMCsP/JAD
	q6upgyVO10SrFtjS0aZAGxldAWgWCoz9a3xFqH63hzN1ckcBv7ase4eZ7RKGHwht
	mnw94fdfKmQ5FlFMpacpx1qk1AdIVzqqvguTeSwc+s+eQt6x68LJw6BzJIjhe3AO
	zCo8FP6xuXBEcxWgNLSMrGv5cyliEqULkTIcy6VYvVi2WNdw/IdByNES8Qg/X9cB
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd0hmb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:26:59 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4APBQwSO027097
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 06:26:58 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 06:26:58 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 25 Nov 2024 06:26:57 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 06:26:57 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APBQnwe016096;
	Mon, 25 Nov 2024 06:26:54 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Date: Mon, 25 Nov 2024 13:26:40 +0200
Message-ID: <20241125112643.10459-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241125112643.10459-1-antoniu.miclaus@analog.com>
References: <20241125112643.10459-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tGUemzwA1c3DRqz8kQrLrdSPqOyJKFK0
X-Proofpoint-ORIG-GUID: tGUemzwA1c3DRqz8kQrLrdSPqOyJKFK0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250098

Add support for reference doubler enable and reference divide by 2
clock.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v2. (added cover letter as requested)
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


