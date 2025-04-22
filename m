Return-Path: <linux-pwm+bounces-5650-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC82A967AF
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 13:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1572017C080
	for <lists+linux-pwm@lfdr.de>; Tue, 22 Apr 2025 11:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A8F27CCDD;
	Tue, 22 Apr 2025 11:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="06pw2mYZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187DE27CB01;
	Tue, 22 Apr 2025 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321738; cv=none; b=G9Hvd2+eP1m+y5QWGbblsqR5F0bFGE5urZW0TZASehSJrZQPhsSrY1EJam3+jLIQqtuDADkc7DT9RsAnW/EYh4/q2JgpLOXK7xOPhA6FiVm7msBUfPlB+c+1oWKK1qYLbSv2m2reCETXKf3QvacAJHHJC9iPYoon13/6j+U3OnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321738; c=relaxed/simple;
	bh=TPF6Yw0kE744Z7BBYS2QEDueGGJOuHShE1E+wwdptnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=c8zy716eZ6Iqg8UyQ9hAKEkznu85EaIyOceDuST5xiog8Pl+UK8hiCTdsDKsQc9klhCu/dWN0AqJKBA+U0LVvZ8qZrazDTrQ1TCsx6B5xfLZLLLSeyrFUqrxgqU40wZS+O/IRTK8K7sIlsXb7C0mubwkaHum7fXTliew2bkK8Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=06pw2mYZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53MAHnTa021966;
	Tue, 22 Apr 2025 07:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=xCYWF
	yld7moiL86cRB/FqLC/2Ow1Lj7odmKSjlXGeow=; b=06pw2mYZQWofbKGV6AU2H
	2Q2uemP3wjrkY1RkhFE5eXeD5I53wUgDNr0Gwah0THn7736NIJzC0LcR1oC1lqAL
	+gK05/BCkJ3ey9Ffh+iXkVrm9axIwU6mVvqCnuSPJRocxpZ5mUQxH+6I/S3J7hto
	/wWFdQbA88dZ7BzzCUpFKhc1IKoM7NX3VV03qsLbj8ZHTVvZTtcwbK9pH6mfnMJc
	+Hpg0+cnPqmstpdO/+zsuyNyp2l9YXMW2r4lWKdJbI1qn8xUHtAL9Oc9NEWPY2dv
	mvj7AMUajY+xmf8niDbXDKQ3jS4vpDMdG9d+CPHn4hza5njlFIMOfS49eFKwPIh5
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4645p7q8rq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Apr 2025 07:35:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 53MBZLoC057912
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 22 Apr 2025 07:35:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 22 Apr
 2025 07:35:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 22 Apr 2025 07:35:21 -0400
Received: from HYB-DlYm71t3hSl.ad.analog.com (HYB-DlYm71t3hSl.ad.analog.com [10.44.3.55])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 53MBZ4Qp024350;
	Tue, 22 Apr 2025 07:35:14 -0400
From: Jorge Marques <jorge.marques@analog.com>
Date: Tue, 22 Apr 2025 13:34:47 +0200
Subject: [PATCH v2 2/5] iio: code: mark iio_dev as const in
 iio_buffer_enabled
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250422-iio-driver-ad4052-v2-2-638af47e9eb3@analog.com>
References: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
In-Reply-To: <20250422-iio-driver-ad4052-v2-0-638af47e9eb3@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745321704; l=1550;
 i=jorge.marques@analog.com; s=20250303; h=from:subject:message-id;
 bh=TPF6Yw0kE744Z7BBYS2QEDueGGJOuHShE1E+wwdptnY=;
 b=SHB/YIAswwLn6uqAO1+GKmRhhkFuy4bRiKdJGIArBOnTzWKr43CUWt1Mp62RHJBFMp8DMrsmT
 Uw9hAFNUmN8AEi3qraBY/iTerNC+spMmRcVnoY/bCiDCvmffD1cvJeX
X-Developer-Key: i=jorge.marques@analog.com; a=ed25519;
 pk=NUR1IZZMH0Da3QbJ2tBSznSPVfRpuoWdhBzKGSpAdbg=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=D4VHKuRj c=1 sm=1 tr=0 ts=68077efa cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=gAnH3GRIAAAA:8 a=5tS4fjQXojCEwv7GM0AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nymIAMSUyUu96HZzJV-UL5mSho6dDLZT
X-Proofpoint-ORIG-GUID: nymIAMSUyUu96HZzJV-UL5mSho6dDLZT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_05,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1011
 priorityscore=1501 adultscore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504220087

The iio_dev struct is never modified inside the method, mark it as
const.
This allows to be called from get_current_scan_type, and is useful
when the scan_type depends on the buffer state.

Signed-off-by: Jorge Marques <jorge.marques@analog.com>
---
 drivers/iio/industrialio-core.c | 2 +-
 include/linux/iio/iio.h         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 178e99b111debc59a247fcc3a6037e429db3bebf..bc6a2ac6415eccf201e148ea98c0b5982787eb6d 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -212,7 +212,7 @@ EXPORT_SYMBOL_GPL(iio_device_id);
  *
  * Returns: True, if the buffer is enabled.
  */
-bool iio_buffer_enabled(struct iio_dev *indio_dev)
+bool iio_buffer_enabled(const struct iio_dev *indio_dev)
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index 638cf2420fbd85cf2924d09d061df601d1d4bb2a..88569e1a888bde4d2bfb5b9f030096af1c15d68d 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -629,7 +629,7 @@ struct iio_dev {
 
 int iio_device_id(struct iio_dev *indio_dev);
 int iio_device_get_current_mode(struct iio_dev *indio_dev);
-bool iio_buffer_enabled(struct iio_dev *indio_dev);
+bool iio_buffer_enabled(const struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
 *iio_find_channel_from_si(struct iio_dev *indio_dev, int si);

-- 
2.49.0


