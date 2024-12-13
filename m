Return-Path: <linux-pwm+bounces-4332-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E99F1275
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 17:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA3ED2834DB
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 16:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2271E47AE;
	Fri, 13 Dec 2024 16:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wat7oYKD"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD301E3768;
	Fri, 13 Dec 2024 16:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108309; cv=none; b=Jte4c28JZXy7hlxnaah2/FmpIodZBPR9VmLbo+UEg7JZbSNMFWFA09gkF70+OQI0aOI0XLiPpcgBmK3F+pFN8gW5nvi+smz4eHZ85S49Pm5EMRTt7vngX1rHg60kN/dTPXgT3AjYylMl6FGSb18cwa1KVT2xNcWY0F03aJz9m58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108309; c=relaxed/simple;
	bh=JNBkkepurpgHeASQaR3aUsznEaPj2i1D7foUAUgsB/4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IbaAQAubExy15oMJ4mMSPQSqYoQSdgtn7jUUQdCwQWdcvzAQGz43H6nr4OKuHuZYrbkSs/JkRpMDzlHuPQ4nZ77ikdBoa5Yi++ZOBqxnbCrvD3F8tOOEYQM9P7fMc8RVku+4g5R8aqa8S9vf7yFh/I1sFCNWRQ9uZAyzv00fdZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wat7oYKD; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDEpigI023598;
	Fri, 13 Dec 2024 11:45:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=dzBfCB9/vbqiH0wk4MKNk5Ia2ZD
	Pe3glozDw05djSlQ=; b=wat7oYKD0iMNEjxSbiKJqPAiJZ3j1qOVKYi0l8F/MgK
	ScszZ3OU5DHZrITmhW+4DSuGX2kKg1UxvWyjchVeWT2IgSvoPL2OdhK72s7h0CvL
	iyrtn3OTVAFO9TmBtPcgdnorm/OvNcpVGE9APtY/S+13ILBNp3T1W905fiTEVQQK
	sN7ghuVogRm1WKJ96fUiDi53iLbg77csUNx/h2bDaQcbFZACDK9YX66w1GSk0CRm
	Q8RxBt9hTWn+sGcOE7r4JD/wAdZofpkinWHJKAYxbDDmiE23kR1Sn7DyX59w9KVX
	6IVw5EWZ4hX0g+Uu+UchD8fBGKgt6i3I68AB9pRTz0w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gju79jpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:03 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGj2D4030688
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:02 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 11:45:02 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 13 Dec 2024 11:45:01 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:01 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcB025509;
	Fri, 13 Dec 2024 11:44:53 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v8 1/8] iio: backend: add API for interface get
Date: Fri, 13 Dec 2024 18:44:38 +0200
Message-ID: <20241213164445.23195-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 81UuiPXlAvWEEZMY3_DulBxUHST97-qN
X-Proofpoint-ORIG-GUID: 81UuiPXlAvWEEZMY3_DulBxUHST97-qN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

Add backend support for obtaining the interface type used.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v8.
 drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
 include/linux/iio/backend.h        | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index 20b3b5212da7..c792cd1e24e8 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -636,6 +636,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
 
+/**
+ * iio_backend_interface_type_get - get the interface type used.
+ * @back: Backend device
+ * @type: Interface type
+ *
+ * RETURNS:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type)
+{
+	int ret;
+
+	ret = iio_backend_op_call(back, interface_type_get, type);
+	if (ret)
+		return ret;
+
+	if (*type >= IIO_BACKEND_INTERFACE_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 37d56914d485..e5ea90f1c3e0 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -68,6 +68,12 @@ enum iio_backend_sample_trigger {
 	IIO_BACKEND_SAMPLE_TRIGGER_MAX
 };
 
+enum iio_backend_interface_type {
+	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
+	IIO_BACKEND_INTERFACE_SERIAL_CMOS,
+	IIO_BACKEND_INTERFACE_MAX
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -86,6 +92,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @interface_type_get: Interface type.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -121,6 +128,8 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*interface_type_get)(struct iio_backend *back,
+				  enum iio_backend_interface_type *type);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -169,6 +178,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 				 const char *buf, size_t len);
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.47.1


