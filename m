Return-Path: <linux-pwm+bounces-4646-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B07A15019
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB6D3A5316
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CF71FF7AD;
	Fri, 17 Jan 2025 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cqR2EGUZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343C1FF1DD;
	Fri, 17 Jan 2025 13:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119248; cv=none; b=Yr4RIfxXOCYEDNUZsiWlHe+vR4sbCe1ZCo2vBstxR+BppShDbMPYkAEXp56EF6XD8XOoIKWsgMY030PIkysX00+0Do42lcGpO2/wf+aO9RSmRWUTCxkBNB7iDcYNQbIC9+3hGDZi39OiDHUOs4CsU6TCOPe0cSBat46/1Uq8LlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119248; c=relaxed/simple;
	bh=6FjhyjkdhR5Qg6ywt6Zp8Q2D49xDMW9FDFkv+iaXNgM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dp2eZHFN7MLmVEM3srVuBUZjCI+2j8/YMT5ZJ4HZsKxvKYLGBK7ppLFvgzmsAs7TOSMjnXrnQYFiP+RLxbPhAsk9bd9AAGvN2zvqJ9kXA2RLWppbDo/X1l8mRecKxTavtuOG9DkOHx+EtXUKXHNBfMY4qUdXwPQH5ruUct9SIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cqR2EGUZ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50H90CCv025697;
	Fri, 17 Jan 2025 08:07:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tqeLa
	gfwij8IxhQVm6Hv1i7bsTyL+Ku6DhE/e6PIRl0=; b=cqR2EGUZDWvXocKLhBwJN
	DUm3LOsIurpyICSMVGyoRGtgUZeimoPS2qxXDMatuaKbPmw/NPHdb6WYhzTt+HP0
	dgwf+Wh6KsknsMRXTPRXWEHGuUh6ExZq0LVnxYMUpT3gRRuUDMmHw5naP5EBNGQ4
	DdQj0lu64gxVFOpjujcDZVKR3IEfAhcFgvHv/Vj5n+eksW/Se3ff9zicflBQZXTR
	6FYq3U4RoiUvInbR4DXrORRMHDrCFlL3tdppT1O8SRQm2bgwMeTnqhGmm9SnpCde
	qJVfbFihP88t2wqtjMhAX8oTpCQPxhoQXoibD+1zylg/upDPNFi88IgZCnzK3vBb
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 447m6nryjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:07:22 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50HD7LTN027801
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 08:07:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 17 Jan
 2025 08:07:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 17 Jan 2025 08:07:21 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50HD764l013564;
	Fri, 17 Jan 2025 08:07:15 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v10 3/8] iio: backend: add API for oversampling
Date: Fri, 17 Jan 2025 15:06:57 +0200
Message-ID: <20250117130702.22588-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117130702.22588-1-antoniu.miclaus@analog.com>
References: <20250117130702.22588-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: SV4iO-Ka9fLNZNZNGTtw19t_F0whlntr
X-Proofpoint-ORIG-GUID: SV4iO-Ka9fLNZNZNGTtw19t_F0whlntr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501170106

Add backend support for setting oversampling ratio.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v10.
 drivers/iio/industrialio-backend.c | 15 +++++++++++++++
 include/linux/iio/backend.h        |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 2088afa7a55c..d4ad36f54090 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
 
+/**
+ * iio_backend_oversampling_ratio_set - set the oversampling ratio
+ * @back: Backend device
+ * @ratio: The oversampling ratio - value 1 corresponds to no oversampling.
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int ratio)
+{
+	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, "IIO_BACKEND");
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 9ae861a21472..e45b7dfbec35 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -96,6 +96,7 @@ enum iio_backend_interface_type {
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
  * @data_size_set: Data size.
+ * @oversampling_ratio_set: Set Oversampling ratio.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -139,6 +140,8 @@ struct iio_backend_ops {
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
 	int (*data_size_set)(struct iio_backend *back, unsigned int size);
+	int (*oversampling_ratio_set)(struct iio_backend *back,
+				      unsigned int ratio);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -200,6 +203,8 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
+int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int ratio);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.48.1


