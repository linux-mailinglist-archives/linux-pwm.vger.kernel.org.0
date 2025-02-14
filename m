Return-Path: <linux-pwm+bounces-4902-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4082A35F03
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 14:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7127E1751B2
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 13:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CB6266582;
	Fri, 14 Feb 2025 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0d1YoNSE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A525265CD1;
	Fri, 14 Feb 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539228; cv=none; b=uXxQ2oQXzEmMW8FsN6J3IF9c7WdJPjdR0UwdqUCcrw4QAnw+IIJJS3Fy3CGWHii6iLdUtHz3SEZ5xhZdxNw2/GYEjnVuFC0fLC6Vac4HYdGCjHx1wdzOwRw+sDhQjEb8Rz3VmYM+BQf6jhXJdPWBkX8FFFyZ6PqfUdospssr92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539228; c=relaxed/simple;
	bh=MsfqIDpXFmYDD8f+pq3zKmhMty4ZVxjFkgUTBBQmWJc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUzwAP3TBBHAWuUJkBgm0kyjs+i9Ch4mpKV5LpB7KR1itkvHHNK+fhKZ7UtE8L03kK/naQygqxacqJDDTKSxZBz7psIhGJ1Cqqc7K76S2ya1OvuZBPgaUSXvbd1NHcFK+vWXBEiIGM4NPFtlLV1gvMcckCzUxUcfp/BbbN1k8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0d1YoNSE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EAA3SS021192;
	Fri, 14 Feb 2025 08:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mFmkq
	hVCs1K8IBQu1T3YswIp5mR3V724h+5GhgdJQ1c=; b=0d1YoNSE98PC56fR+byZd
	BwBnz/Uf0g4RDYOyI83cNbLndlXuQ8YyH4cJd3H0pqvadBTuD4mi/i5DKTAXKAhh
	H5Th0i5baPgMvNt36QNhW7kAEDjP35+u/TfXJtpvSqHyWlO0oAYhXAnjJH4GKQkr
	BtEmgWppCxYg/ks7sw+i8YT7H9XqWip4TDsFE+M5iaIKtlw5u2jsJEA1v8tpLqqD
	LCIn8NrgCnjrFpUkyxt3RtNxDqoeMJfeAYazEBUGIg7MHhXiey0pCdwlo3bIy6cz
	wptsM/e8pAPQZ9u7O6YhbNWZtTLxEGNddKWEtYNT70ugxSWcxw2h2EBDN/4fyC82
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44t3uc8n1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:20:15 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 51EDKEcQ018373
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 08:20:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:14 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Feb 2025 08:20:14 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.172])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51EDJuUS020604;
	Fri, 14 Feb 2025 08:20:04 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nuno Sa
	<nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v13 2/9] iio: backend: add support for data size set
Date: Fri, 14 Feb 2025 15:19:48 +0200
Message-ID: <20250214131955.31973-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250214131955.31973-1-antoniu.miclaus@analog.com>
References: <20250214131955.31973-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PZcFhjhd c=1 sm=1 tr=0 ts=67af430f cx=c_pps a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=JY5jBUxdzKL8h0s2lDQA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-GUID: 3gtN4IMiV9IFk7c1AvKviVf7dAymFphx
X-Proofpoint-ORIG-GUID: 3gtN4IMiV9IFk7c1AvKviVf7dAymFphx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 impostorscore=0 clxscore=1015 mlxscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

Add backend support for setting the data size used.
This setting can be adjusted within the IP cores interfacing devices.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v13.
 drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 8bf3d570da1b..2088afa7a55c 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -660,6 +660,27 @@ int iio_backend_interface_type_get(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
 
+/**
+ * iio_backend_data_size_set - set the data width/size in the data bus.
+ * @back: Backend device
+ * @size: Size in bits
+ *
+ * Some frontend devices can dynamically control the word/data size on the
+ * interface/data bus. Hence, the backend device needs to be aware of it so
+ * data can be correctly transferred.
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
+{
+	if (!size)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_size_set, size);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, "IIO_BACKEND");
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index a0ea6c29d7ba..9ae861a21472 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -95,6 +95,7 @@ enum iio_backend_interface_type {
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
+ * @data_size_set: Data size.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -137,6 +138,7 @@ struct iio_backend_ops {
 			    const struct iio_chan_spec *chan, char *buf);
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
+	int (*data_size_set)(struct iio_backend *back, unsigned int size);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -197,6 +199,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
+int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.48.1


