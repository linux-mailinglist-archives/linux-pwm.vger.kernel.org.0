Return-Path: <linux-pwm+bounces-4160-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C189DE992
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6553B23202
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 15:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3A51494C3;
	Fri, 29 Nov 2024 15:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="OxjrsYNp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BA31448C7;
	Fri, 29 Nov 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894467; cv=none; b=pHA7/easJsEmdsAuB/3TmEJmTId7IWebNIyfMG9YSVLFnKB3gaw6BABwp5Cy6XiEGcynH+cePfFb3IcatoJJkNM/b5sDUJQ4ZX2wB9G2wIbEzBmIZ9f1ktDSQHOx5YA4mpoyPNQnQui5y+WR/qiTk3XGpXbgJNtF1S7KETRv1kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894467; c=relaxed/simple;
	bh=t0HAjAem+ydTFDdgFLgq+dW66tILezKNBOI6mmNgl0M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mia0F26jYF4uvj94Kbh3B0XTo+D78RxDyEmZcZxGxJkgFI6eDqS/n3d17CyF+iDezHxzBo1kFp8uzyQxdCIMIbIJelXnzOMzQ1yx2D4BuOi27X/i/gCGSwerd/PMC8U9rSpRyYuXWC84Gu8gELqHwuNwBk8G4mRMziQ30ySwBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=OxjrsYNp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATDV3wt027433;
	Fri, 29 Nov 2024 10:34:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7HbOZ
	GzBthKHZirnVgGp4hvwJqT0FwZ44RsqDOO2CDk=; b=OxjrsYNpBuSqsrWFxnFVQ
	X+ZtirgoX5iArOr6U3NjsUTHmoWeHcA0L+xqN0WRFhy3mvkLQ+sxkwkl6EfwaQK0
	3DTLVHgaZjXfDWn1TzcdkrIcgpauikfC9dRuSSAjtZo+b+jI/SfuJ4TaMhnk5hKE
	z/2sRHjst9OUHSg7ErkyXzFyv07UrFrqn4KoFQiJk/2QBz1LmFZP+7T46XtnQSD+
	zv0+6vuHQXyLwU8IGSHE5nc5bzvwBi7DZMc7c7sLpGrovQRGPZ7fSlZA1oNzy8uf
	GRzqqbO3ae7V10diGGBTWP6wucZo6QdgE479inRxOW921TKSvJKS7T7fQDkjv5kn
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 437ejk0f3b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 10:34:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATFYLmP008702
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 10:34:21 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 10:34:21 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATFY6dk001089;
	Fri, 29 Nov 2024 10:34:15 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Date: Fri, 29 Nov 2024 17:33:52 +0200
Message-ID: <20241129153356.63547-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129153356.63547-1-antoniu.miclaus@analog.com>
References: <20241129153356.63547-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: e0XZ-V36WFK9zsP4NBX17Ux9Xk1BEfGU
X-Proofpoint-ORIG-GUID: e0XZ-V36WFK9zsP4NBX17Ux9Xk1BEfGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290126

Add support for reference doubler enable and reference divide by 2
clock.

Both of these blocks are optional on the frequency path within the
chip and can be adjusted depending on the custom needs of the
applications.

The doubler is useful for increasing the PFD comparison frequency
which will result in a noise performance of the system.

The reference divide by 2 divides the reference signal by 2,
resulting in a 50% duty cycle PFD frequency.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add explanation in commit body
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
2.47.1


