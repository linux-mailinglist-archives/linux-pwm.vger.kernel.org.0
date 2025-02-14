Return-Path: <linux-pwm+bounces-4901-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C13A35EC2
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 14:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF2547A314D
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 13:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291BA266182;
	Fri, 14 Feb 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="XxK1In2g"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445B726560A;
	Fri, 14 Feb 2025 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539227; cv=none; b=Xuef2kNi6+Fr3QEoz03pCLmP8lSQpOPleUJ16DpWd+LAkAkI5VE14NvNP79rIIqJDpAo5Ayd57RxkV3zWBM2IXSbJqgd/kRodmwvXvEdkMIuLGLb1a9U+6/lfeXArOgzZBA5P2jthSHi1Ah7dLpQktzzz8+Yr6w0Y/1hjOvMEoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539227; c=relaxed/simple;
	bh=A6nmidYyBO10hthF0jfNWgebsPOdCl9XcVrc+GsqKXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X1NKMeatB9ixuGaZxODU3dlNWhffp7lRwSawQs6mKbepJeYs6HVPysCa5AjGk2bKEkHSTOWHggp4+bmD+Sjehq0JNP6KoKkeocbdQIzSn6WS77mEAE+X3IVEoSRpv09p5vR8f7Z1FQbXcHAOJ8lGB871MmnGW4Q57F3fcqp9dYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=XxK1In2g; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51EDB7jl027738;
	Fri, 14 Feb 2025 08:20:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jCEQJ
	xXGV020vphNByeLaToTzvr3c/trYIsUl1IBkvI=; b=XxK1In2gnIHcZSrOYFB6m
	WRoi8Gr/X1fWImIshJeU9tp2RG97tIoyLJsLNhdj068QnPC2FrHmZ1WhXQLd5T+e
	nzMoT3jb/lInNMsDvesa9gluu2UlQuRPr8lWEUpGiKBWzqEcrsGKS1BV8Sh+Mdco
	zcRxujuIGNL1BriYlgS+PKHp1ofQ01SsB9Y5NPurwVyTQxjXB/KYfdqFN9UZvx3d
	XxLwbSwalTCnPhMzevzomiiyACncHOSYtEB/lgWfb48OcjU9WTY89UZjEtYFMA3y
	GukcxxkOjJSmbDi2sWBbcPXr+LLk8sopejvc2ZgGMRU3NygdaMcL8jAUrHxjSrxa
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44t1nm96nu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:20:15 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51EDKEjh022823
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 08:20:14 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:13 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Feb 2025 08:20:13 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.172])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51EDJuUT020604;
	Fri, 14 Feb 2025 08:20:06 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v13 3/9] iio: backend: add API for oversampling
Date: Fri, 14 Feb 2025 15:19:49 +0200
Message-ID: <20250214131955.31973-4-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Ysr1R5YX c=1 sm=1 tr=0 ts=67af430f cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=SEKP2kRsAAgZN29P1c8A:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-GUID: AUuB8RlNNlGMkwv6p9flrtlUTQgQnLYP
X-Proofpoint-ORIG-GUID: AUuB8RlNNlGMkwv6p9flrtlUTQgQnLYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

Add backend support for setting oversampling ratio.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v13.
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


