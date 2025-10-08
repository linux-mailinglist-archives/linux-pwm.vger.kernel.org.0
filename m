Return-Path: <linux-pwm+bounces-7404-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE73BC5498
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9404F75AA
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCA3287271;
	Wed,  8 Oct 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XpgkCwxW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC01286408;
	Wed,  8 Oct 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931462; cv=none; b=Ut1E1FTM9XIvTrhCimsYT3BHAja7w+HEbqNcc/TYUQDHuGx5I/tiUBYrXNMfIeznS/xfN+/o05tLu0b1i5mUm72YcH6tiHCG8e7meElA0zwcuyD1gAEPbnvgHSM+rOv+0AMHiLqREhIECf9bj58VVZkHGkOyHvxSl7zTEpR7rI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931462; c=relaxed/simple;
	bh=mMvQO9gUvkU4ydX38HzUe1NFpnjpQb6EoaNFMHqTHoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MehVTOUq6Sp+Tpxj6mJylID8mM1iA/ISo8eCXtE/XHD3TEYjEehsTVBWuGuwh7sUQU2SVoi2EMCKE6GiVjYA69Y6OtesdTuZnuNnqAOjkOdq9xw0U7U2T1q53sMZL94XFUUpWZTJkK/s6rY38NYVGvo08DAtDqXj91RTGY5quxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XpgkCwxW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598DOslm027046;
	Wed, 8 Oct 2025 09:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1Xf3P
	4FaNtw7plQ3RNniLL6fpn0T247BbYMIn6GhM7Y=; b=XpgkCwxW9qqupRpHTx5cG
	QwLqkRD+wsx2Ani5n6gjhg4lq4HQ+gyBgIe4olAXlR3HDNHkkhLY4KEMujfveOcx
	9H/9gvEHiQj3vXXr4H1x3xTxGS+j+a6NmOaoHZ0hfVgqHJtyORi/vSGUpy0rC46/
	pxV3ppwzxRXzWD+Pl9BMEP5GK106xjwPC4rM7BcghSAEu/z8J1nN4/jbra/UNp87
	rdURN12ZyU/MBN4mjck6iZGD+ptGTm/E6w7HHf+PWSng6D3HY6JZaSrUty9S1r8M
	1tPxx21Ft6AVN999QUWtdXoEbfLKbwRBQwyGinDkeWb9dsPTgai89SL6j5/nQQ4S
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ndssugn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:50:56 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598DotBq034765
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:50:55 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 8 Oct
 2025 09:50:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:50:55 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DodVo023157;
	Wed, 8 Oct 2025 09:50:42 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        Conor
 Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 4/8] dt-bindings: iio: adc: adi,ad4030: Add PWM
Date: Wed, 8 Oct 2025 10:50:39 -0300
Message-ID: <b61b5ae8af34ed104ed931bbd71a7fd45000783c.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAwNCBTYWx0ZWRfX0TprBU8aneXz
 ojqimeL1mSfL/mCkF81JwbowU0RA+I14pZCA+Dc8Badk5nHRkdJAFJqgD3mG8fsHHPNXj8wqWdP
 g9rcxMOW4ZbZ6jJjz/3K+ClLiLeyU5BlDCky4Xp4Qc3DIBcekMRf7GRNb3oqWXmDgN4eDR2abY3
 aRc300v59XCNk9ZiqWwzvAgZoG/YtGREpRF+s9bwY3LXA0NEB3RzoKrUJa5TgXEAs2azxr/9mQc
 jPUBJcKUsQDsAbt/PPLQTxa5VMrKA0FsLeGMzaUSgjRhAkkcFtnbwhs8BULndut6vxJNVRDHbip
 C1JsC3+/I/h44PHtdR427EWMqN+9rjYyzIcZbKCPScBS68wvXAly2g4bCq6exWHaWWJ6QKHdRZe
 fErrBD+EiW9og0WkA+3BYfxKU4bcUQ==
X-Proofpoint-ORIG-GUID: 8TKFLgtTOfaADDRXgwp2x43nBGF2OYy1
X-Proofpoint-GUID: 8TKFLgtTOfaADDRXgwp2x43nBGF2OYy1
X-Authority-Analysis: v=2.4 cv=e4ELiKp/ c=1 sm=1 tr=0 ts=68e66c41 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=IpJZQVW2AAAA:8 a=XYAwZIGsAAAA:8 a=gAnH3GRIAAAA:8
 a=DUOLLnRY7vFq0fwDtzIA:9 a=IawgGOuG5U0WyFbmm1f5:22 a=E8ToXWR_bxluHZ7gmE-Z:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080004

In setups designed for high speed data rate capture, a PWM is used to
generate the CNV signal that issues data captures from the ADC. Document
the use of a PWM for AD4030 and similar devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
index a8fee4062d0e..564b6f67a96e 100644
--- a/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad4030.yaml
@@ -64,6 +64,10 @@ properties:
       The Reset Input (/RST). Used for asynchronous device reset.
     maxItems: 1
 
+  pwms:
+    description: PWM signal connected to the CNV pin.
+    maxItems: 1
+
   interrupts:
     description:
       The BUSY pin is used to signal that the conversions results are available
-- 
2.39.2


