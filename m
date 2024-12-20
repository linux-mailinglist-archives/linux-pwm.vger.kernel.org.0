Return-Path: <linux-pwm+bounces-4436-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 396169F91D6
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 13:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 244C318976CD
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 12:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8AB1D63E1;
	Fri, 20 Dec 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="iJicjGJs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36871BD9E6;
	Fri, 20 Dec 2024 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696128; cv=none; b=GqP/qTqdMst2fJf0CE7Ui/p9gvn9WN/rYw3QENkJl3v91zDLsTTLruybWlUPoB+84ZhNgzIctpWlVRisgDwuPKNEMlyvE28bjH4bKTsHlihX0bSYpbQT5LeeE+fvml70Q8MK5B1G5FoVZhEty9ZecHbrc8ti0+JscvHsp2xFdZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696128; c=relaxed/simple;
	bh=e4oEl1y/KNuJI4lWFtOu710KpnLtZwzpwE4t7i759Qo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jE2mkiX1L+CIIorI31gigG7h0cqzEx+HpZu+Arq/7HQQrcazYEcTHJbpeRMPCDkLkR3v6c2s5dXAvrPjErEXl8LpsKxYgTqHyW3fueOuC8IaT/WQjo6EoW8aD/pZqF16SGiYaQJcpEDPFejwD0pVer9kDCB7NnkC03gIJQisFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=iJicjGJs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK6vISr026727;
	Fri, 20 Dec 2024 07:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CToHx
	hkCkYtEE6ZmrPKavzBL7gnOG1B6WCta8btm/Iw=; b=iJicjGJsqJS9KGp/jiHxy
	jlzIzpcnIXu2I/SenKtcP/qMt9aTOPJdOc7FRivx72+soQ9HsfOxsuoN58EvkzGJ
	gg4WHEkH0yzSPh/xghBFPypW07atkTM8Jp6rvWS20O93zEDubSIMPX2BA8ItXWEj
	55MsVrfoyZ+dyQTHvfmGGSKxEoIvYPZvRL0IHNeNikx4hT6KjTSBBCI7c7Qi55Pb
	qYV7uOsv2bdz2J03cyrIfacLZycJy3UtUWXKmXlDbf4ra1VwGubT4ip9tD4AjBGG
	1hWKYSOzrgUQhWPjqXWxwVZwV+IruiuyeyN3AM7gWzJpx8NBnxlzIK/W/S4e1HYy
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43mxv0acnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 07:02:02 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4BKC1sTY060593
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 07:01:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 20 Dec
 2024 07:01:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Dec 2024 07:01:54 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.133])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BKC1fDi030363;
	Fri, 20 Dec 2024 07:01:47 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v9 2/8] iio: backend: add support for data size set
Date: Fri, 20 Dec 2024 14:01:28 +0200
Message-ID: <20241220120134.42760-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220120134.42760-1-antoniu.miclaus@analog.com>
References: <20241220120134.42760-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: -njbtPSRXOp1RMP0X0z-SJ9FKJ49HQGa
X-Proofpoint-ORIG-GUID: -njbtPSRXOp1RMP0X0z-SJ9FKJ49HQGa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 clxscore=1015
 spamscore=0 priorityscore=1501 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412200100

Add backend support for setting the data size used.
This setting can be adjusted within the IP cores interfacing devices.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v9.
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
2.47.1


