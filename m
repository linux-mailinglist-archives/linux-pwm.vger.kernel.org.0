Return-Path: <linux-pwm+bounces-4165-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BBC09DE9A5
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD14163EBF
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 15:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88361189BA8;
	Fri, 29 Nov 2024 15:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="udr1oBug"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677E14A098;
	Fri, 29 Nov 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894582; cv=none; b=CeSNGrQXHQtOuvdrXzr0TzrNImyviUIjP/U/2s8t0Swt/rgf2+Y0HdhijcbBkEYKBK8zF3gQ+mndra7ULtfJBXvvoRXno8JPGCt4u7ahdHHkuzzDrTABseZosY+Pt0Ye0X8LlSqhTDS0RJHFKChqhp5CNoayFGWSO2rrorXJo70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894582; c=relaxed/simple;
	bh=ERillEXi32TmO291ueMdNu9zSZGnkoxQ11og5QEiJMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OyULiTDyf3UHDVd1JHIIH01HI2Ol60UB/N4aZDqTi6phDTQCZ/VUB6CiFQ8CpphrNX52jGrRHDVLM90icX+sssDCoJnOIIACjYisJMLulCf0gZp3qxXyfP9+KN6Jjwr8klFr43lujOgyWhaIRrVd4uhUFNhFhPlRptzOqfdW7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=udr1oBug; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATAbONY018135;
	Fri, 29 Nov 2024 10:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=b48RC
	y6VWcErH7vH95mW8mlryW/fGUCUB270Kp4aV38=; b=udr1oBugd2JI7CY2+XSVl
	0fn5AgZVSyu2FitbtkCaAT516xhLZjuLowipFaQiZfO92tg6SLzFS9vLMvDeed1t
	PtYsbJZo/p1MHmoecHanniO0SXCHISdXQgwKJJhGe5lp+RYLqipL+lki75vriqqt
	jzpO0WmoMMGPUSWe7AZQVcBTZoaIE/LFTysP/cwcgKrmXmn7d4i48K0XqPhrHxoW
	ZoWIRNPb6H1YacsFvTQuZKQ65PO9r+cOmsYo/utVFkkmqxRCq9iwUpRpaSn4ua3/
	Iyue9S2qg3J+iJKKUs1j4usoAsNqXvObNXiw3fX/hY5ghtUHhpgAGs1CP2uqbjEa
	Q==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436715tj51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 10:36:16 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATFaFoD008863
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 10:36:15 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 29 Nov
 2024 10:36:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 10:36:15 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATFa0m6001167;
	Fri, 29 Nov 2024 10:36:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 3/8] iio: backend: add API for oversampling
Date: Fri, 29 Nov 2024 17:35:41 +0200
Message-ID: <20241129153546.63584-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241129153546.63584-1-antoniu.miclaus@analog.com>
References: <20241129153546.63584-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Zg_4RRgZdAd8P1OKyM1auGfxakJUahoc
X-Proofpoint-GUID: Zg_4RRgZdAd8P1OKyM1auGfxakJUahoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290127

Add backend support for enabling/disabling oversampling.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v7:
 - implement 2 callbacks
	iio_backend_oversampling_enable()
	iio_backend_oversampling_disable()
 drivers/iio/industrialio-backend.c | 26 ++++++++++++++++++++++++++
 include/linux/iio/backend.h        |  6 ++++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ea184fc2c838..86237c1e7ab4 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -681,6 +681,32 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
 
+/**
+ * iio_backend_oversampling_enable - oversampling enable
+ * @back: Backend device
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_oversampling_enable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, oversampling_enable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_enable, IIO_BACKEND);
+
+/**
+ * iio_backend_oversampling_disable - oversampling disable
+ * @back: Backend device
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_oversampling_disable(struct iio_backend *back)
+{
+	return iio_backend_op_call(back, oversampling_disable);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_disable, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 59b6651b7eaf..789fa9b586ec 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -94,6 +94,8 @@ enum iio_backend_interface_type {
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
  * @data_size_set: Data size.
+ * @oversampling_enable: Oversampling enable.
+ * @oversampling_disable: Oversampling disable.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -132,6 +134,8 @@ struct iio_backend_ops {
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
 	int (*data_size_set)(struct iio_backend *back, unsigned int size);
+	int (*oversampling_enable)(struct iio_backend *back);
+	int (*oversampling_disable)(struct iio_backend *back);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -183,6 +187,8 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
+int iio_backend_oversampling_enable(struct iio_backend *back);
+int iio_backend_oversampling_disable(struct iio_backend *back);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.47.1


