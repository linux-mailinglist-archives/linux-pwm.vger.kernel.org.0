Return-Path: <linux-pwm+bounces-3995-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF019B9034
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 12:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E6C71C20F9A
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 11:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155619B5B2;
	Fri,  1 Nov 2024 11:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="0wO3QjdW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C451199238;
	Fri,  1 Nov 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460286; cv=none; b=K7YewNH4mj79gP2CYUVlOtrk2zCfBbqKaSBER7tzwnmQGJZZfx8GhJRrx5KyhJj3ZtRICzsgWQJNfgiCyP7lafoGQyV+o6O+0qMgQE/4uJXLc3gJIM0qCuemaaMyNtiiAHcLczMNe66SqEp1Oa1iEXqkw/yFNJUC2Toq19pdxFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460286; c=relaxed/simple;
	bh=8x+1xEiv69jkt1lS7KwkpdGU1JM4Bpy3GvTMu9O/D0g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4wsX8/fThDiwArcDSNx4izz8pXURlji8ylMng3u3hUAXP81qn7Hajl+debi7az/z5uf4RM7h8hHhGiKAhYVYnyAv7kDNoKeAHB3Fl28R5vLYQJck6Dp9z0svpWOwhTI6omUpkNq5QxNhxTmX/HMV9YnAgLNZug3gVKSpkvxTVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=0wO3QjdW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1A9EOh026695;
	Fri, 1 Nov 2024 07:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yXm7v
	5uQjnJZYYC+xZRLv6EHQ7qpPeVgGKQiwtZ30Y4=; b=0wO3QjdWpmhf3gvHaDB6z
	+3qIclHQy+WkfRdeOtRnAInBsf/PUsK1cZHP8O/qN+GXGi/v8unjrI1VLGHE5Nfy
	i/JeUvmYS6XYSw4KDqJ1o8E74Oc3mC9BQgIv3LVKRdJJyjO2jKehRIxEEcZrMlV/
	SYmjFqM89gxy8bZGmnD/KswimfNayLGWb1pWOWEjip8IFWBWUXpuFbRHPmsSihSb
	VP3F8Xf1boTzSWjLZIgNMfOvptSPUq88XBO7DjgmF14Zm2+nfV1ZOw6D80FOl37O
	1ljaQw1W+9F6yhkIoqkiSP/SlT+x5DY5cG/kvV+LCDgK1fYGNrEXi/DUgweKY/nC
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42m2gmq3vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 07:24:40 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A1BOdXH038443
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 07:24:39 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 1 Nov 2024 07:24:39 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 1 Nov 2024 07:24:38 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 07:24:38 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.114])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A1BOP8j016631;
	Fri, 1 Nov 2024 07:24:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 1/6] iio: backend: add API for interface get
Date: Fri, 1 Nov 2024 13:23:53 +0200
Message-ID: <20241101112358.22996-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241101112358.22996-1-antoniu.miclaus@analog.com>
References: <20241101112358.22996-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: pLLA_zUC0bw1_OMtuEW-EK82dRmvWcce
X-Proofpoint-ORIG-GUID: pLLA_zUC0bw1_OMtuEW-EK82dRmvWcce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010082

Add backend support for obtaining the interface type used.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v5:
 - drop IIO_BACKEND_INTERFACE_LVDS and IIO_BACKEND_INTERFACE_CMOS from enum
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
2.47.0


