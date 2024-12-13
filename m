Return-Path: <linux-pwm+bounces-4336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8829F1285
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 17:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F8C163CE1
	for <lists+linux-pwm@lfdr.de>; Fri, 13 Dec 2024 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B781EBA0B;
	Fri, 13 Dec 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="FNarnT0B"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240EC1E5732;
	Fri, 13 Dec 2024 16:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734108313; cv=none; b=WUmO+mp4sjS7doHPUTKqlUE/G9TWQZHvsQEd8+OMuwTqoFntfRjgztzntEYNsq3znOmXuWqaJlBqTEv4QWGXpOhfo2wDppzatkhBbIB8guhkZl7UTINdTOkw08pb9coVQIGIq89zR4hYDVZubYKtnhomBY2lKTW46TUFi03IDaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734108313; c=relaxed/simple;
	bh=vsujtD2CT69r2BcVhAVDCmo6mwEeYr98X8qCvXQxM9U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ub/kh5ju6DdhQtURkij1WerPZDZ39R+UGDvb8eJ8lIf/cMMXbbKbpk1RFZypkmiR6B1ZxCE4mJJcW+id6J1x71o9IczOHt94x/aJs7H+Dl4MqZutppyFQrE7xqLD6bQcsgJzm1Ei12TqpPJcjLDZ9tVKLNHU0JEPi4uK0Fs3ziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=FNarnT0B; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDFFsjR023478;
	Fri, 13 Dec 2024 11:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=e7JVf
	5ZNAaRRZy11S/GUyWYCvCXnpMDjbu0TqpNGHpw=; b=FNarnT0BIncB/sK5h1HtB
	U0p4jPk52MNBKrw81pidIRDy5zab5rONjQn8VTWik/yXqGoTSc4XVnK0r0TiOCGu
	mWRA9rhHKEtUa3US49BA6nZIYvZojpTkYAuwfIfdomharA6EyE1oh1FQjlA9eErZ
	kEcvW9cFveUuXgDSwtuj1F94xz70GU3BOnC7HXZvuAc72qyh6DqXhtW4nNmraBtC
	XSc9i1d/2/NYMDXAWFiwt2vCd6vRkke/jtVZj6s6OdTztOJvBWVYrRUOqVrYJj20
	cYeenVXk6QPpeMm1YS62m33VNN/TE63xC2Cpexveoea13Y7QSoCy/vMX0HpumPIP
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43gju79jq8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 11:45:07 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BDGj6ge030754
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 13 Dec 2024 11:45:06 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 13 Dec
 2024 11:45:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 13 Dec 2024 11:45:06 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.187])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BDGipcD025509;
	Fri, 13 Dec 2024 11:44:58 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v8 3/8] iio: backend: add API for oversampling
Date: Fri, 13 Dec 2024 18:44:40 +0200
Message-ID: <20241213164445.23195-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213164445.23195-1-antoniu.miclaus@analog.com>
References: <20241213164445.23195-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: WNoKzJBaB7_PZS12eRQ3OiC4DIzzyikM
X-Proofpoint-ORIG-GUID: WNoKzJBaB7_PZS12eRQ3OiC4DIzzyikM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 lowpriorityscore=0
 mlxscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130117

Add backend support for setting oversampling ratio.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v8:
 - pass oversampling ratio
 drivers/iio/industrialio-backend.c | 15 +++++++++++++++
 include/linux/iio/backend.h        |  5 +++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index ea184fc2c838..e56b1e96652d 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -681,6 +681,21 @@ int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
 }
 EXPORT_SYMBOL_NS_GPL(iio_backend_data_size_set, IIO_BACKEND);
 
+/**
+ * iio_backend_oversampling_ratio_set - set the oversampling ratio
+ * @back: Backend device
+ * @ratio: The oversampling ratio
+ *
+ * Return:
+ * 0 on success, negative error number on failure.
+ */
+int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int ratio)
+{
+	return iio_backend_op_call(back, oversampling_ratio_set, ratio);
+}
+EXPORT_SYMBOL_NS_GPL(iio_backend_oversampling_ratio_set, IIO_BACKEND);
+
 /**
  * iio_backend_extend_chan_spec - Extend an IIO channel
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index 59b6651b7eaf..1bde32689776 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -94,6 +94,7 @@ enum iio_backend_interface_type {
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
  * @data_size_set: Data size.
+ * @oversampling_ratio_set: Set Oversampling ratio.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -132,6 +133,8 @@ struct iio_backend_ops {
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
 	int (*data_size_set)(struct iio_backend *back, unsigned int size);
+	int (*oversampling_ratio_set)(struct iio_backend *back,
+				      unsigned int ratio);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -183,6 +186,8 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
 int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
+int iio_backend_oversampling_ratio_set(struct iio_backend *back,
+				       unsigned int ratio);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.47.1


