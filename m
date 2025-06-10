Return-Path: <linux-pwm+bounces-6271-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A410AD2EE7
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 09:36:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99ACD171751
	for <lists+linux-pwm@lfdr.de>; Tue, 10 Jun 2025 07:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FA6280CE6;
	Tue, 10 Jun 2025 07:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="SSMIWlDK"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DAE27FD6B;
	Tue, 10 Jun 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749540932; cv=none; b=N0vibb5nx8ycnsiISxKwKkx6M1YUSeg1/CENw9X7H1kkKLdqEthFk+9K1TvLTxrfYgcb4X2rBrsKnDDw0AqfWhq9gksuwttgjBe36LzD+/aWucO7d+prF4fYSdeVG+/doelnx4V4G7is6ccEi2gKNb7gS06bnck+8DbrP5tTEIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749540932; c=relaxed/simple;
	bh=LpB0tn2W8J57FOE/gT31lMBVVdtKo2lsnkxO3IobWoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=hCmH5nqYmggPw+OM2kQPt5cIz/af/m9PDHi5DtavaaVt3RWZRBjlSEi+ujxC19nDMVB92B4hrU5skagyOv2dw/fZT5al81Fy/VDfFUBso+rJYpE1wcT3xWdeT7zZokANv1+awkjb+xmKhMrutW2JNSELsiluvVxyPpgPTAPNIV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=SSMIWlDK; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A6lCQ8030659;
	Tue, 10 Jun 2025 03:35:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=adjeN
	tw0XQXx7CGsSo6c8VElZl2N4SywtE1Yxk4K2KQ=; b=SSMIWlDKKBk8Olhs6chpw
	5xp/i+Fne5fp1I3OAjmRUUQsZSORrvQw1+BbQtwmRFN/WfQg4FidSl6FIGLD4Tsz
	PRwUDfXjjNw5h9iFTRlE3D7dCU1PrZjPvQdaM7SCRBkDMwuLjJuPdJbfAnTv6n+z
	n6aEq5LEmBo/5mepGSBaGmFTKrvUxQg2KqfojvFBqveq6UGFYPjn66hoMYoeQkM8
	lR/PrOMQUgKEtxOYkW6s8Xlj3JNBLeJ8cMHG6+KwYQtc2dxnkjPPB24w0845MQ2N
	7dKx/HxtTXPUSgiUiUuwA4FQ9t9s6RraHIqwveVG7MEeY4CRnF3sVv6MIaosyFIa
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 476fc30bkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 03:35:10 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 55A7Z91X056157
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Jun 2025 03:35:09 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 10 Jun
 2025 03:35:09 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 10 Jun 2025 03:35:09 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.51])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 55A7YkMj002608;
	Tue, 10 Jun 2025 03:35:03 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 10 Jun 2025 09:34:38 +0200
Subject: [PATCH v3 5/8] docs: iio: ad4052: Add offload support
 documentation
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250610-iio-driver-ad4052-v3-5-cf1e44c516d4@analog.com>
References: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
In-Reply-To: <20250610-iio-driver-ad4052-v3-0-cf1e44c516d4@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        David Lechner
	<dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, Jorge Marques <jorge.marques@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1749540886; l=1826;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=LpB0tn2W8J57FOE/gT31lMBVVdtKo2lsnkxO3IobWoQ=;
 b=gASwBhMMaHdCRv4Vgk2/VpMe65RuPPDsnn+Uyu5xAKCfhzYFNe5zhAftG5PKERUGOlwbJFxro
 qLHyKV2qP84C2D9gJ++nH7Txq5M7F6b6oi76mFdgRVd3IIaxPxwLSrx
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: EYNPHrycvRh5RSJZAG4llzmJl9D6xp_R
X-Proofpoint-ORIG-GUID: EYNPHrycvRh5RSJZAG4llzmJl9D6xp_R
X-Authority-Analysis: v=2.4 cv=LtaSymdc c=1 sm=1 tr=0 ts=6847e02e cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=wI1k2SEZAAAA:8 a=gAnH3GRIAAAA:8
 a=d3jCkwYfNc7Hc5xPy-QA:9 a=QEXdDO2ut3YA:10 a=6HWbV-4b7c7AdzY24d_u:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDA1NiBTYWx0ZWRfX3Lbf+Jp+a27B
 LIOj4O2rONhlQ2H1Lwr0nGPAotpSdxMN3fdD1UsWWBYUYjAopojWACWGZqYoloOueHOhEFqrHp7
 0gXD2JaZwBpnPrFRO2y+jVDamWWaFNHxMATmAuOzmGcykYcPjchBJUulApqKjjzt98xDY9nK1WH
 U9Ho8nm7LhAnAMdiD3RZRgGn9fzyXabEXdeQ1gMF/AusdiHZo3oVMPfLFmkmQRhTk/1tT6hTbhz
 Xofp/MRCt8a9kSK5mdPRegzh6OliU6QVa5dwTgdM6JQSEes+sB/kVHAu0dySuFIy0orVTdCCkUx
 +6oCmfUzm16hFBg9luDgsektuQjeziiBDmnMV83+kfHAzwLypCETfpLFxZPQFugS5D30b14cVZ6
 rnpoKAhI5ltL8XfGHBbTXe+vA9LLvjmiQeeqt8N8GdlT8v4HMvMdydyv901CSzkIi28wsosa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_02,2025-06-09_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 mlxlogscore=906 impostorscore=0 mlxscore=0 spamscore=0
 clxscore=1015 suspectscore=0 bulkscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506100056

Explain the AD4052 support for the SPI Engine Offload.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 Documentation/iio/ad4052.rst | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/iio/ad4052.rst b/Documentation/iio/ad4052.rst
index 25e55eb72e167bd2b2195ba789b45ce402869b0f..2ad1c7712766118b03c48929d1f2b7670d5f8d41 100644
--- a/Documentation/iio/ad4052.rst
+++ b/Documentation/iio/ad4052.rst
@@ -49,6 +49,12 @@ The ADC contains only one channel with following attributes:
    * - ``in_voltage_oversampling_ratio_available``
      - List of available oversampling values. Value 1 disable the burst
        averaging mode.
+   * - ``in_voltage_sampling_frequency``
+     - Set the sampling frequency, only present if SPI Offload is being used.
+
+If `gp1` interrupt is not set, the driver will not wait for the data ready
+assertion, and will result in reading a sample before it's ready, particularly
+in oversampling mode.
 
 Also contain the following device attributes:
 
@@ -69,3 +75,21 @@ Low-power mode
 The device enters low-power mode on idle to save power. Enabling an event puts
 the device out of the low-power since the ADC autonomously samples to assert
 the event condition.
+
+SPI offload support
+===================
+
+To be able to achieve the maximum sample rate, the driver can be used with the
+`AXI SPI Engine`_ to provide SPI offload support.
+
+.. _AXI SPI Engine: http://analogdevicesinc.github.io/hdl/projects/ad4052_ardz/index.html
+
+When SPI offload is being used, additional attributes are present:
+
+.. list-table:: Additional attributes
+   :header-rows: 1
+
+   * - Attribute
+     - Description
+   * - ``in_voltage_sampling_frequency``
+     - Set the sampling frequency.

-- 
2.49.0


