Return-Path: <linux-pwm+bounces-4819-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3312AA2C506
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 574243A4095
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6D221E0BB;
	Fri,  7 Feb 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="W0q/TSIE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD191F8AE5;
	Fri,  7 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937407; cv=none; b=GdjNgksJ4mx/Xyd4XqV0e/gyHBbFwORCdmCcyNd8zkwcIHEBwC52mkM8RdN5DQwixT19m4d8JNlsUmWNeWI/pR8Cd271+WKfPOwl1Lb1CV8L/OzIqayoqdTF7yv1vIA+fQmQ0U2ssKaV0cq30ZPsGeuZERSbwzGg52REF7zmNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937407; c=relaxed/simple;
	bh=8uVLb/zJVob8hOs+JCMQWphpd1VmV+vwmjXgSM9OaYM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BNIDBU8e/yg1H21yCAef0WeYzJ4+k9XfhC0NZXqKrb8FM+U+nKdfPVgHeiU572LoGnTHF4NotdFIHp6UPeo9RiD9aF9rTS4VrukAfxZNcU8DvenWriljPjcNWSmS2+wL/3urD9D0OOm3w5tbZDG2c4EVNsBW2c/wIGK5+dJSmbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=W0q/TSIE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DZnxw012090;
	Fri, 7 Feb 2025 09:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=pGXF+
	XRuQRMsVL3IUac8qMLnGI+wsj82Tct5kLAcKh4=; b=W0q/TSIEns/ynkCvgXXjs
	w8iwH1kh4UiviVoDBqsnoXaUvK2+sxCWOztsWOnOC/CL15TERyCrvEGJqZx3TSSN
	zl+jYnZ2of9yq/oqPj5xCVOCOOCjQoq7wfjgk4LgQSlK99uPpk+6w3yMBsvkiXUv
	zVOprhYrQYHI/veC/uB3pExuEL1SatV3q/2wrYVQrr3E6fWO+RP7P9UC5LtSNaRy
	k49yZzJ91IIlBZN/Bt5od7oA4IvW9aFAjs29vucPdm0vXd+5k5Vsl/KbluPesmGE
	hgW1U3rUrr7KsZs8YbjUVHhFCMlBxVgRgXRu0wRq9RIGDLFKzhg3FNfgrWg1q7qz
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44nk6v847b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:09:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 517E9rtE008515
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:53 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:53 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4p015095;
	Fri, 7 Feb 2025 09:09:45 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner
	<dlechner@baylibre.com>
Subject: [PATCH v12 3/9] iio: backend: add API for oversampling
Date: Fri, 7 Feb 2025 16:09:12 +0200
Message-ID: <20250207140918.7814-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207140918.7814-1-antoniu.miclaus@analog.com>
References: <20250207140918.7814-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: RInuwqXHusAoTKcI9lkP2BrmcnmgkCoF
X-Authority-Analysis: v=2.4 cv=fZNXy1QF c=1 sm=1 tr=0 ts=67a61432 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=IpJZQVW2AAAA:8 a=gAnH3GRIAAAA:8 a=SEKP2kRsAAgZN29P1c8A:9 a=IawgGOuG5U0WyFbmm1f5:22
 a=oVHKYsEdi7-vN-J5QA_j:22
X-Proofpoint-ORIG-GUID: RInuwqXHusAoTKcI9lkP2BrmcnmgkCoF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add backend support for setting oversampling ratio.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v12.
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


