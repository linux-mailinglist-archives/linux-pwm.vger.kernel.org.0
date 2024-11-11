Return-Path: <linux-pwm+bounces-4058-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E60FF9C3E1D
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:13:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A861C21921
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8CF19DFB5;
	Mon, 11 Nov 2024 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AdLISc7L"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7919CCF9;
	Mon, 11 Nov 2024 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327156; cv=none; b=jYAwgRc1XaepeWrgcDXyV0PqCNXUrzCBOO/DeLWUAtZAV40FzBTQyW2Bd3CFmeVE9fHjjGeOuTFg716g8RmFe7zlFuxKB3nXDbULq/Evd/i7Wlizh2mENq4EovWV6zIR0m2PUoLoScP8Om5dwb5vws2HDpGxnmbNW/6/bGN/MnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327156; c=relaxed/simple;
	bh=TIc/VGU8iWqUuOpsnwMcPNK1TE5iwfxoxI2yfpHWm5A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOaGhQNuKjuuOlqg+ZpTWOReyQ940XUGLBwtgcxtaZenPY0hk9/AnPdJje0lU4wUuJtBvRvcUQjHBWaA4ETABJUmVquvDqLT3id1jn1PnWHDfC66zI4OPp23KFI3phrMO7OztzXtweFO61ZDmPS7SuLwtHphiTpp0A3mg4eKzCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AdLISc7L; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB9WFkY027704;
	Mon, 11 Nov 2024 07:12:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Dv21a
	cndmhRPjMqdOV1AGbYX/rmOEUHpFefVs7gDGn4=; b=AdLISc7LqgIeU4v8HHsrT
	nSqhEoKP+hfYd1me3N8QyeOPrAHMzwbjhEm2me2lwKPXAgiG5xqxXI156iHFg7BP
	s8R8MWYJJZV9W360zselhtO8odP+/65VoF/KrfN/S5LleHscWlF2cE9l4BEPmduT
	yyXJ9zoW14cc1ierzy/AbOpg740bywssO37WM8JXCt5SoX9ESsH5kySMLQS9abZq
	ZyBnWpjVbfiH/Z/cdRGmI5fHltWwv4ZioNBmDzNC6l/qlL59CLurpmdWzVLWKODQ
	9cPgiwmPWiKRH33pDyGlxH3Filkt+B9xXi57VNw+hTo9lsVxCw2QNbELH92PXzKf
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42t5h5xw2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:31 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCTaA031073
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:29 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Nov
 2024 07:12:29 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:29 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEL010000;
	Mon, 11 Nov 2024 07:12:23 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 2/8] iio: backend: add support for data size set
Date: Mon, 11 Nov 2024 14:11:57 +0200
Message-ID: <20241111121203.3699-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: uJkcC1x-72rvh3Ff5QIdPpP2lnHoJaOS
X-Proofpoint-ORIG-GUID: uJkcC1x-72rvh3Ff5QIdPpP2lnHoJaOS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411110101

Add backend support for setting the data size used.
This setting can be adjusted within the IP cores interfacing devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - drop size_t
 drivers/iio/industrialio-backend.c | 21 +++++++++++++++++++++
 include/linux/iio/backend.h        |  3 +++
 2 files changed, 24 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index c792cd1e24e8..ea184fc2c838 100644
--- a/drivers/iio/industrialio-backend.c
+++ b/drivers/iio/industrialio-backend.c
@@ -660,6 +660,27 @@ int iio_backend_interface_type_get(struct iio_backend *back,
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
+int iio_backend_data_size_set(struct iio_backend *back, unsigned int size)
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
  * @back: Backend device
diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
index e5ea90f1c3e0..59b6651b7eaf 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -93,6 +93,7 @@ enum iio_backend_interface_type {
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
  * @interface_type_get: Interface type.
+ * @data_size_set: Data size.
  * @read_raw: Read a channel attribute from a backend device
  * @debugfs_print_chan_status: Print channel status into a buffer.
  * @debugfs_reg_access: Read or write register value of backend.
@@ -130,6 +131,7 @@ struct iio_backend_ops {
 			    const struct iio_chan_spec *chan, char *buf);
 	int (*interface_type_get)(struct iio_backend *back,
 				  enum iio_backend_interface_type *type);
+	int (*data_size_set)(struct iio_backend *back, unsigned int size);
 	int (*read_raw)(struct iio_backend *back,
 			struct iio_chan_spec const *chan, int *val, int *val2,
 			long mask);
@@ -180,6 +182,7 @@ ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
 int iio_backend_interface_type_get(struct iio_backend *back,
 				   enum iio_backend_interface_type *type);
+int iio_backend_data_size_set(struct iio_backend *back, unsigned int size);
 int iio_backend_read_raw(struct iio_backend *back,
 			 struct iio_chan_spec const *chan, int *val, int *val2,
 			 long mask);
-- 
2.47.0


