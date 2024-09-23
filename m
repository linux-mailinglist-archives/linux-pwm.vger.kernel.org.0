Return-Path: <linux-pwm+bounces-3330-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A06697E9A9
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD31E1C2164E
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 10:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084D196DA2;
	Mon, 23 Sep 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YctEZN9f"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB53188588;
	Mon, 23 Sep 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086584; cv=none; b=fAfTMFoLDOW2FVVvOJ1zYLKiN5AX3t2v1gpZ7r5LZc93nxP5OnKKMYlWCu5YjV5BphYmr8ym4nXe4OP7tnn9vK1SCqGtDbIKtNtQ/K/5U9ZGBzgxL83yI+8a1hzwnfgrOtXYYl+y37eg4gBz2RZiLmtW3sNjHfyodyeBZGYTvcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086584; c=relaxed/simple;
	bh=nQkJkqtTXt+vHMKELvVHaTBPVlFWyrVEiAU696CCjN4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aewssYtDTqG8b4UttPyjak55pvIh+ifp5x31aD6DS6Y+JdYfDEzsxdaQ/v86OkyWrK/rhkPWdVzOzZHJlv0KvPM3wjpmpbEynKlUGqjEWJ2dWgyEX04ng/mJvrClbY7PSWJErtL4Q5xpjh7YVXjwwfxy8GbRW7IMq7k6A0Q3e2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YctEZN9f; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N4ufpX007142;
	Mon, 23 Sep 2024 06:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=oiuG8
	RdanECpWOA1XhHzaWvMa17Cklr3B8jH555v1NA=; b=YctEZN9fLKwA8+O/vhtyA
	Y9PecWPM54kct7NJH8qNKCgy2niKeULm0E6bdgn1XQQ0RA4zS4bSYRWTNqsY1Oxi
	koqC35OSF6HcUnDLmXP98NFbVJrgKqGtZYmscp21nFHTMgTYcNKSDy31ditrD2QD
	d54JeN4HdmMQVcOBsyo1tbOIToqw+oHK8Jzfdf0qolH49ntXArfuu7azZ8HZe7tt
	62xeXa3aScRD9a9y+2hjge8tQr+yxe1XF9nPAqWUvV/2nMI460RZsOQqKPN3MQYo
	lfFWr/y+YpqQyUbd6aZuazphU8hbZ07cuPG9Hm/faowoXbM20sj/crR44hIZpMtc
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41sr04qhcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 06:15:56 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 48NAFtfs026021
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Sep 2024 06:15:55 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 23 Sep
 2024 06:15:55 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 23 Sep 2024 06:15:55 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48NAFIQR001918;
	Mon, 23 Sep 2024 06:15:46 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 1/7] iio: backend: add API for interface get
Date: Mon, 23 Sep 2024 13:10:18 +0300
Message-ID: <20240923101206.3753-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240923101206.3753-1-antoniu.miclaus@analog.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: vnW6pvF3D4lQ-uFx3vLxQ3cN2hDzDG-a
X-Proofpoint-ORIG-GUID: vnW6pvF3D4lQ-uFx3vLxQ3cN2hDzDG-a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409230075

Add backend support for obtaining the interface type used.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
 include/linux/iio/backend.h        | 10 ++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index efe05be284b6..53ab6bc86a50 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -449,6 +449,30 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, IIO_BACKEND);
 
+/**
+ * iio_backend_interface_type_get - get the interace type used.
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
+	if (*type > IIO_BACKEND_INTERFACE_CMOS)
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @indio_dev: IIO device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 8099759d7242..ba8ad30ac9ba 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -63,6 +63,11 @@ enum iio_backend_sample_trigger {
 	IIO_BACKEND_SAMPLE_TRIGGER_MAX
 };
 
+enum iio_backend_interface_type {
+	IIO_BACKEND_INTERFACE_LVDS,
+	IIO_BACKEND_INTERFACE_CMOS
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -81,6 +86,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @interface_type_get: Interface type.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +119,8 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*interface_type_get)(struct iio_backend *back,
+				  enum iio_backend_interface_type *type);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -142,6 +150,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
 
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type);
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
 				 struct iio_chan_spec *chan);
-- 
2.46.0


