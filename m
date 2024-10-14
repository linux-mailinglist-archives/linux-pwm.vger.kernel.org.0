Return-Path: <linux-pwm+bounces-3630-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9021199C659
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 11:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F71A283223
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E351158531;
	Mon, 14 Oct 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PSYosXxk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE26014B96E;
	Mon, 14 Oct 2024 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899382; cv=none; b=Yg349x0big2fomCbSNvla4D6JHo+C7f4Jf2/pVd8/4tmC6ggEY+r4DT76K20R061LGGMvYaxrQo1+VLT38nimv/aJJ34+FJXKF1RCn7YGxKPzJyIduhbzkHspVZLmGFLJQqJ2ujYLTtIzKlb/hgBAeDc0SM5F/KM3Cj+ugtveSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899382; c=relaxed/simple;
	bh=W0JrzTuwXK4HiD7WbmI6A7kHSe5pWtzc2O7eyrk/7ig=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DaXTNKhBFTCyygU2bC7u1ItNqhu1/jiqJA7YFNj0wukHY6t7urzTP+ekt7vkxc7tW2wt4PBDjovJfLGnyNg5yJoC8gnVMCL+ZdVO3o9n7Dela7x8SwJB4J4obvch+tS9fDytxIl3boFDXt5x5yo9+nNNiIVZsdSRN4KxlyoquB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PSYosXxk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E4XD54006002;
	Mon, 14 Oct 2024 05:48:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yAIho
	fDwVWtNzgq74pxzMOyJQOsNHuvqYRdE18LW8Ts=; b=PSYosXxkf6UjrWNAee7T0
	PHD9/NgXcJyH/Hy8VZTSNSz9R6PERuybNb3D2AOb3Ps6ySbXreTuOlnuxsgongXD
	0m7vRGPpyiyyuDytj4vigQwP4KggaclHFm1pUq1NL3A3YqeOd4nsEeO6wPkdgaaZ
	YcAyzzfdgDH4jTN5aZ1b69Ec1QgZwCx3QNvexMA/FA0BDUePE/BQWlx9Ps80138F
	Nsuvci7qfe37ZAvRPf37MUoRjx2xlqZ0KLK80GilhRHP3ftjFgRxLuvi7/xJPod0
	q5o5TfLO6krTxstkQsnLG5jzP0ZjHhCs6QrUevDnjbxyepXhIw9RckIRVqi2XtE/
	A==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 427p136dyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 05:48:44 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 49E9mgU6027923
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 05:48:42 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 14 Oct
 2024 05:48:42 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 05:48:42 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49E9m0Gm024017;
	Mon, 14 Oct 2024 05:48:31 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Ivan
 Mikhaylov <fr0st61te@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v3 2/6] iio: backend: add support for data size set
Date: Mon, 14 Oct 2024 12:40:36 +0300
Message-ID: <20241014094154.9439-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014094154.9439-1-antoniu.miclaus@analog.com>
References: <20241014094154.9439-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: dc4rvUte0-rEi6rT7ele7IzonC1ADJSB
X-Proofpoint-GUID: dc4rvUte0-rEi6rT7ele7IzonC1ADJSB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140071

Add backend support for setting the data size used.
This setting can be adjusted within the IP cores interfacing devices.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
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


