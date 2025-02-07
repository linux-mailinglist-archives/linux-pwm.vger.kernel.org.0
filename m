Return-Path: <linux-pwm+bounces-4821-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD53A2C4E9
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144AE1677ED
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A78234981;
	Fri,  7 Feb 2025 14:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="uMmu5QIM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4AE20B1E8;
	Fri,  7 Feb 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937408; cv=none; b=eRIWLwsTT3Jk6Fi2KQX+Qbjipw4/SPSomLqw1pPx6vN6s1vlraDLh9GbpgsvdNMFn9REryKIY8HHWkl8++fRr7WoJH5wQyWZQ1UhypW5n7jcc/O0ti3c0ZBp9QmC5fJEPb50lpmrcLpo5w7GBSCA08OTKTRcrl2I/W+ou1S/nHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937408; c=relaxed/simple;
	bh=taAb9tKGQC2dNVYPwkyIsSc/9ldug2jlhT5kb+i3E4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CKf5qhVDSD4hJpUO1tfomFUPnc95dsYakvhhGDVvmhkj67DZx8JeLEIkLAaB1LnACsIJjUPRvk30ImLQ9Hw0JbjP8DWD9DzGRhnXzvhxRDxBd62yD9QiXjYcbjFr7QVOdJRIBqUUNCROYJxbgkJ+dkftkBUxfcCKe+5xjDd282s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=uMmu5QIM; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DZn9G012069;
	Fri, 7 Feb 2025 09:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CpgAS
	zMyCgnEvVLYEpGgxK81IKPg+JJZRpBxJw6YC8o=; b=uMmu5QIMcBD1UmYAbMzvj
	kidFy0exTdTCMmmWSWaSWvb6nZf0/5UupMxobEOmJCIzi94+cI9XP7qj3Qetrdyr
	0SW8Oo4IFN+QhPXwsEoeK2LOaHhwB1mEEsHlpUjcaS/5rARbrtGhnNa7nxQrJysS
	mMFQcXuzvEWyO8SqjUf+Z3GD2dvAxYXrERCFz7k0EMNEchEW00Emp3kDAq7JMrLp
	qgtM1pjDOGkXrebV/4Eh7o+W09acFwJIqkblrB7qbukn0HkZuEgl5PJsMaX114R8
	Cp+V3rTRSVnWTmsGlzk4loVtf7xvI0o8IHw5nboJnyls0UArXAlNOdkMRl5IjT9y
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44nk6v847e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:09:56 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 517E9srJ008518
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:55 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:54 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:54 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:54 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4q015095;
	Fri, 7 Feb 2025 09:09:47 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Nuno Sa
	<nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>
Subject: [PATCH v12 4/9] iio: adc: adi-axi-adc: add interface type
Date: Fri, 7 Feb 2025 16:09:13 +0200
Message-ID: <20250207140918.7814-5-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: r6cS6WmNK5ih_1GgR2KV0bbWiTdnFiKe
X-Authority-Analysis: v=2.4 cv=fZNXy1QF c=1 sm=1 tr=0 ts=67a61434 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=96MRRoT68iXq4l_OMrEA:9 a=oVHKYsEdi7-vN-J5QA_j:22
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: r6cS6WmNK5ih_1GgR2KV0bbWiTdnFiKe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
IP.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v12.
 drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index c7357601f0f8..d2e1dc63775c 100644
--- a/drivers/iio/adc/adi-axi-adc.c
+++ b/drivers/iio/adc/adi-axi-adc.c
@@ -39,6 +39,9 @@
 #define   ADI_AXI_REG_RSTN_MMCM_RSTN		BIT(1)
 #define   ADI_AXI_REG_RSTN_RSTN			BIT(0)
 
+#define ADI_AXI_ADC_REG_CONFIG			0x000c
+#define   ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N	BIT(7)
+
 #define ADI_AXI_ADC_REG_CTRL			0x0044
 #define    ADI_AXI_ADC_CTRL_DDR_EDGESEL_MASK	BIT(1)
 
@@ -290,6 +293,25 @@ static int axi_adc_chan_disable(struct iio_backend *back, unsigned int chan)
 				 ADI_AXI_REG_CHAN_CTRL_ENABLE);
 }
 
+static int axi_adc_interface_type_get(struct iio_backend *back,
+				      enum iio_backend_interface_type *type)
+{
+	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(st->regmap, ADI_AXI_ADC_REG_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	if (val & ADI_AXI_ADC_REG_CONFIG_CMOS_OR_LVDS_N)
+		*type = IIO_BACKEND_INTERFACE_SERIAL_CMOS;
+	else
+		*type = IIO_BACKEND_INTERFACE_SERIAL_LVDS;
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -337,6 +359,7 @@ static const struct iio_backend_ops adi_axi_adc_ops = {
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
 	.debugfs_reg_access = iio_backend_debugfs_ptr(axi_adc_reg_access),
 	.debugfs_print_chan_status = iio_backend_debugfs_ptr(axi_adc_debugfs_print_chan_status),
 };
-- 
2.48.1


