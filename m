Return-Path: <linux-pwm+bounces-3710-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F93B9A3BCE
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 12:43:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43141F2160B
	for <lists+linux-pwm@lfdr.de>; Fri, 18 Oct 2024 10:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ABA2022EE;
	Fri, 18 Oct 2024 10:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i0JxHTy9"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD5020127A;
	Fri, 18 Oct 2024 10:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729248199; cv=none; b=YDNiBaIzgDAhYNL7OV/9K9QLLH+pE0fi5pHq0pN8lOMzQm8QUsiz/DUHhoPHnfm//5EW5gPi7okWnIvpnx7lOC7kJmDtkTltWYvQcZ1TpQlA2DA7e+BudfskQpwc6bBTR+LAbGC9XwAh4/YLdDGAzTdTTUvBb54SWqVczP2kKiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729248199; c=relaxed/simple;
	bh=OSQZqIja1gYa/sGWSyqgT9C8RF/1220OO+zfkoq0gYA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bxpVY41qJz0vn748Vb9VSZ4NTvhjtzNo2URQc1+6i0BTa7HSmDxK/SbfASnBO708uPYE2RqiHwbDcithsX1wM90ja5WVfxpRjSCyZMpdu5LOaFYyUDdGTDXBbNvN7ExMsJ9TbEA48L6S8eOVY2VfmBzMwOfr+uZwxV0LUM58NWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i0JxHTy9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IAIONi019455;
	Fri, 18 Oct 2024 06:43:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=NnAHu
	0PevN9ovlKbxr2yVS4vt3t1tZWcJhtfc9bV3ak=; b=i0JxHTy9rPMrjyV0mWLx9
	3dtjvINMFhhNd2KFZ50ZZVbJ2B1Q5W2K30KrlbcF4+ftjJQUsFRMKjkm10w/m43U
	OUfJ424w86BhP78xaWmraZDYAaIPYjZDh1XuAX4SWxqpwvO/ttVsGXdU0Wvi8/rt
	JLE/Vs1RaYfWgeYuHWNOWbd2pKxL4FnrHNuS0xVKJ3mVuZrFxvGYpcr+Q4MXyKQI
	kK2/iLrXRQMzYw6ahIuPG0v3xkvQ9f64dEFh0Sbi7TjGU1AeVERnkXPWH3hPO+Zv
	VFnTcc1FoUrw3ni4y8wzFBsgSgqZzOtQYFvhg5646UExH144HiKqxXS5Wgu/Ztml
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42bckqtg6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Oct 2024 06:43:13 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49IAhCF6060200
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 18 Oct 2024 06:43:12 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 18 Oct
 2024 06:43:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Oct 2024 06:43:12 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.189])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49IAh2iL028631;
	Fri, 18 Oct 2024 06:43:08 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <nuno.sa@analog.com>, <conor+dt@kernel.org>, <ukleinek@kernel.org>,
        <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 2/6] iio: backend: add support for data size set
Date: Fri, 18 Oct 2024 13:42:06 +0300
Message-ID: <20241018104210.51659-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241018104210.51659-1-antoniu.miclaus@analog.com>
References: <20241018104210.51659-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Lc6WMGKO9jEdezW34uBaqGdp-xcWUVR7
X-Proofpoint-GUID: Lc6WMGKO9jEdezW34uBaqGdp-xcWUVR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180069

Add backend support for setting the data size used.
This setting can be adjusted within the IP cores interfacing devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v4.
 drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ef1fd4cb0b24..2cb97c294ba7 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -473,6 +473,27 @@ int iio_backend_interface_type_get(struct iio_backend *back,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
 
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
+size_t iio_backend_data_size_set(struct iio_backend *back, size_t size)
+{
+	if (!size)
+		return -EINVAL;
+
+	return iio_backend_op_call(back, data_size_set, size);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @indio_dev: IIO device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index ad9fa0ada9b2..c2ffb61c5a92 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -90,6 +90,7 @@ enum iio_backend_interface_type {
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
+ * @data_size_set: Data size.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -124,6 +125,7 @@ struct iio_backend_ops {
 			    const struct iio_chan_spec *chan, char *buf);
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
+	int (*data_size_set)(struct iio_backend *back, ssize_t size);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -155,6 +157,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
+size_t iio_backend_data_size_set(struct iio_backend *back, size_t size);
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
 				 struct iio_chan_spec *chan);
-- 
2.46.2


