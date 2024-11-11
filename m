Return-Path: <linux-pwm+bounces-4059-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544FB9C3E23
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:13:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6AAC1F2201F
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43B19EED7;
	Mon, 11 Nov 2024 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mQjWUgil"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5D119E997;
	Mon, 11 Nov 2024 12:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327160; cv=none; b=kHisJVObj2Is0uHYp6ddTKnWFKJoB6b48R6KLGBTT/FgZVFSPBjGLMSOVcw4kwIYFq+Awh0r5J/t6hZYvI+i+yRsAJJTeeT97q1KuP198J2Dr60DYYYilBi+DvzO31tykQe0/tHI4zQRFM8sKyd4Xwl6evke0P2koMeJ7A1lCSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327160; c=relaxed/simple;
	bh=DPX+1Ql+9H03Oju6y/3FEvyoPe1XafQYonZ6gblW1Pw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFiw3ntX3+V/cyhPqaWl5Q1WLvMGcVgeZWrBDArIJiKnJMxpJzDf2QnlUZ1uOv1vbgfAf4Xlf7Ia3ocw+4fxlq02WULa0/Ey9c8vT/qnxQyr0MmDf4c/Ce12LylwCWXiN719AkacH6bUR6hYjLEt+Bq0X+KdhUVjpuJssGi0q9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mQjWUgil; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ABA1xV2027560;
	Mon, 11 Nov 2024 07:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=bdhA3
	YaNxnrOz5RzgsjoHnTurDvNHsG6dbtH22brN54=; b=mQjWUgilt8Oh2qPLNnMn4
	eHSzl8W8kxf3uJdBXFQ+iUCTWwQSyaHHqdSnjMHySg0xJsZxqWyQNK0oFdJRLA+R
	916rJmw4rMG16vhH8LyLxAn3GyeL315nuSwYAsYa27/xoYOUsFPuEQpc/d90Zz0/
	7/iqVCJQv5Ke8ECpEVAzYPI2nHccvu2BlZRbA9/oggyo7/YBGyxr8YEd55yyY2mV
	pQLaDNbt6ejbZ4KHoEMGUgAOmQdciIlxwJ8fh7HV7uYpyw+V20fjRcEPlg7cNF+6
	SGoCj1g1aYDL9eMhXeA+KlsgX+FsnvUWCghCyVP6m94fx5iOjZ7pg/EOd7rKeeGr
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42t5h5xw34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:32 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCV69025108
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:31 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:31 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 11 Nov 2024 07:12:31 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:31 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEM010000;
	Mon, 11 Nov 2024 07:12:25 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 3/8] iio: backend: add API for oversampling
Date: Mon, 11 Nov 2024 14:11:58 +0200
Message-ID: <20241111121203.3699-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111121203.3699-1-antoniu.miclaus@analog.com>
References: <20241111121203.3699-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: FJHFDdkjd-eipz59409HxU7RStMm2VFY
X-Proofpoint-ORIG-GUID: FJHFDdkjd-eipz59409HxU7RStMm2VFY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101

Add backend support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - add iio backend commit for oversampling enable/disable
 drivers/iio/industrialio-backend.c | 14 ++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ea184fc2c838..6ba445ba3dd0 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -681,6 +681,20 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
 
+/**
+ * iio_backend_oversampling_en - set the data width/size in the data bus.
+ * @back: Backend device
+ * @en: oversampling enabled/disabled.
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_oversampling_en(struct iio_backend *back, bool en)
+{
+	return iio_backend_op_call(back, oversampling_en, en);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_en, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 59b6651b7eaf..b8f63823b3db 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -94,6 +94,7 @@ enum iio_backend_interface_type {
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
  * @data_size_set: Data size.
+ * @oversampling_en: Oversampling.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -132,6 +133,7 @@ struct iio_backend_ops {
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
 	int (*data_size_set)(struct iio_backend *back, unsigned int size);
+	int (*oversampling_en)(struct iio_backend *back, bool en);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -183,6 +185,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
+int iio_backend_oversampling_en(struct iio_backend *back, bool en);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.47.0


