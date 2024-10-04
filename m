Return-Path: <linux-pwm+bounces-3459-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B166990590
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 16:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47C041C211A1
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB902178E6;
	Fri,  4 Oct 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xs5lVp5k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78E1215F44;
	Fri,  4 Oct 2024 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051104; cv=none; b=kn0uk4jAuQZ+e/3uICvKEUijblfpVWu5hU1OIHZbE0I0ZrSPSfYg9M1QkHa6CAru5hiNtMhPjZPgDcGg4bcW4tGfxZXsOkPc7+aJO1XKMlN4pTBAMxg5mZ/Djs7wbNB5rpFqpoEHOTUmHhysjD6JwSTKz2QiidnX4UVgUe70YL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051104; c=relaxed/simple;
	bh=QwUCQelik+i6A1CNkuyr3H1FyUX/TmP+s+Jg2M0467w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ea3m0R9OK2TiyABdiXZpfKpoijf0fT8eBZGhzqpC5rOBWobBeBmBn5mU+kh6bEQnpjHz+pvJmys6h54Oe1DIf3RDhRVLMX0gnpJw3ByicqEssyWohBo52cuxGJjF4WZ0Mpkn35tK6CdJvE5PhD1pwwDThLiqeeCzxq5NoD+Y/5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xs5lVp5k; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494CwJTL001362;
	Fri, 4 Oct 2024 10:11:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=//wQT8iUlWPMtMdf7cCIJhY2fqG
	xs6wkalMGWLlGMso=; b=xs5lVp5krrt1vGiKflxo1qXGR9y4fXUxM+ydFZohIGc
	t1KhGOCvqTj2Nj1/yU+drIIq8L+IxLGZX0Sj9WmOM88vT479ReudUWSHzkcbwY8n
	VLoAT9lcmYNogSC6VnEJfdbdUfe0IM0s2MjXEllrGxygY4hRR7iRuw4SNfZNC/7B
	2YedSV/CB13abRm7VVRB2TPIUeJOSnzbKXzgI6bke8T2fEW7DR+eans0k5tlzeqr
	PEREC6NqRw2FcqYNtaj60k+JXJBskATkF/lvu0jtbDgA1JHWnyIUjV5+ot1zptFR
	d5yt72m/hh928BDvs6o0okhm4f+viAHvDLXvdqiXuyw==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 422043410d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:11:15 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 494EBEod002599
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 10:11:14 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 4 Oct 2024
 10:11:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Oct 2024 10:11:13 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 494EAps1001773;
	Fri, 4 Oct 2024 10:10:54 -0400
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
        Mike
 Looijmans <mike.looijmans@topic.nl>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 1/7] iio: backend: add API for interface get
Date: Fri, 4 Oct 2024 17:07:50 +0300
Message-ID: <20241004140922.233939-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 9kRTFBQLyZTItF8hinWGCXcJG6G0jQPk
X-Proofpoint-GUID: 9kRTFBQLyZTItF8hinWGCXcJG6G0jQPk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040099

Add backend support for obtaining the interface type used.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - add IIO_BACKEND_INTERFACE_COUNT in enum.
 - add trailing commas where applies.
 drivers/iio/industrialio-backend.c | 24 ++++++++++++++++++++++++
 include/linux/iio/backend.h        | 11 +++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-backend.c
index efe05be284b6..a322b0be7b2c 100644
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
+	if (*type >= IIO_BACKEND_INTERFACE_COUNT)
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
index 8099759d7242..34fc76c99d8a 100644
--- a/include/linux/iio/backend.h
+++ b/include/linux/iio/backend.h
@@ -63,6 +63,12 @@ enum iio_backend_sample_trigger {
 	IIO_BACKEND_SAMPLE_TRIGGER_MAX
 };
 
+enum iio_backend_interface_type {
+	IIO_BACKEND_INTERFACE_LVDS,
+	IIO_BACKEND_INTERFACE_CMOS,
+	IIO_BACKEND_INTERFACE_COUNT,
+};
+
 /**
  * struct iio_backend_ops - operations structure for an iio_backend
  * @enable: Enable backend.
@@ -81,6 +87,7 @@ enum iio_backend_sample_trigger {
  * @extend_chan_spec: Extend an IIO channel.
  * @ext_info_set: Extended info setter.
  * @ext_info_get: Extended info getter.
+ * @interface_type_get: Interface type.
  **/
 struct iio_backend_ops {
 	int (*enable)(struct iio_backend *back);
@@ -113,6 +120,8 @@ struct iio_backend_ops {
 			    const char *buf, size_t len);
 	int (*ext_info_get)(struct iio_backend *back, uintptr_t private,
 			    const struct iio_chan_spec *chan, char *buf);
+	int (*interface_type_get)(struct iio_backend *back,
+				  enum iio_backend_interface_type *type);
 };
 
 int iio_backend_chan_enable(struct iio_backend *back, unsigned int chan);
@@ -142,6 +151,8 @@ ssize_t iio_backend_ext_info_set(struct iio_dev *indio_dev, uintptr_t private,
 ssize_t iio_backend_ext_info_get(struct iio_dev *indio_dev, uintptr_t private,
 				 const struct iio_chan_spec *chan, char *buf);
 
+int iio_backend_interface_type_get(struct iio_backend *back,
+				   enum iio_backend_interface_type *type);
 int iio_backend_extend_chan_spec(struct iio_dev *indio_dev,
 				 struct iio_backend *back,
 				 struct iio_chan_spec *chan);
-- 
2.46.2


