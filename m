Return-Path: <linux-pwm+bounces-3631-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFD099C65D
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 11:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE1C1C22E2A
	for <lists+linux-pwm@lfdr.de>; Mon, 14 Oct 2024 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D80415A87C;
	Mon, 14 Oct 2024 09:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ys48EEV8"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D69158DD0;
	Mon, 14 Oct 2024 09:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899384; cv=none; b=ZNtRFqfFHfnM/6yZSaUI3FegbteykDpZnvi5wnYDGuw1c52RAy48zdmG7hA5iWm7afGtBZb1ZTcUULtHA3V3XpW3SCJnzptiu3KQMzHoUSuTvT2ksdEGCCp72kbZXK3k18MldicqKMLAjjC11dAQedpEhghj/xdN4ueVF9aOJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899384; c=relaxed/simple;
	bh=A/Y4A97/+YEj/MeVKZ61Ldvp7m7CEea9ti/v9KEBd9Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB34l9dGNCZykUhJq8b5lpr5yGYCkyGo2jrZdUk5r0zHDbLRhxQhj9OEvgkCVmB71M0gX2dFgLlt+k7aABnJP+ACjKNyeTxoNOSy1miey+tAx4HpSUUrns6tZ8VRp57IIwaYdSnxCRX1nxlC76AhLIqv1FcZyb0yuZnUH9otMWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ys48EEV8; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49E8LeK9002023;
	Mon, 14 Oct 2024 05:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=kY35G
	ZIZRPz1Xc5/EGqa3vgrep4sPzLjo7ZnyeK0VL4=; b=ys48EEV8e8rrpPmcgrI/6
	E8Ilne+MBIughgidQv2ooO7CV9U5qBV5wu0c2QTQX8y5hNXfk9ex83zW1xy3ok65
	x18kl0m4WIt/PjUZpOur75lVIsjR7c0KNeSDIeu1Tzu7T/CZZq3iXDibyiSA32+k
	z5gmCQ1CTeHpjy/SpbfsfI1pQIO17H5D7NCr5mDrQt+rnDxIGFDDOAomCzPV2jnS
	ftcHF6KM7QCEAF2BTFlIaxY36LbzNJy9rPoL7fZJBWBcJHuUigtvHl8MLf5a4SUe
	tocO+zO35a8i5cqqzvkD8Ov/WIRSUawuWL2olJ099DTgy39d4FLHti3ILhlsEKzx
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 428yqm0apn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Oct 2024 05:49:00 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 49E9mwXj031606
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 14 Oct 2024 05:48:58 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 14 Oct 2024 05:48:58 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 14 Oct 2024 05:48:58 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 14 Oct 2024 05:48:58 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 49E9m0Gn024017;
	Mon, 14 Oct 2024 05:48:50 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, Nuno Sa <nuno.sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        David Lechner
	<dlechner@baylibre.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        "Mike
 Looijmans" <mike.looijmans@topic.nl>,
        Antoniu Miclaus
	<antoniu.miclaus@analog.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Marius Cristea
	<marius.cristea@microchip.com>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v3 3/6] iio: adc: adi-axi-adc: add interface type
Date: Mon, 14 Oct 2024 12:40:37 +0300
Message-ID: <20241014094154.9439-3-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: XbGv0AASbPK7kMwQBXwKCU25gQ3Hp89E
X-Proofpoint-GUID: XbGv0AASbPK7kMwQBXwKCU25gQ3Hp89E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410140071

Add support for getting the interface (CMOS or LVDS) used by the AXI ADC
ip.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v3.
 drivers/iio/adc/adi-axi-adc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/adi-axi-adc.c b/drivers/iio/adc/adi-axi-adc.c
index 21ce7564e83d..ff48f26e02a3 100644
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
 
@@ -249,6 +252,25 @@ static int axi_adc_chan_disable(struct iio_backend *back, unsigned int chan)
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
+		*type = IIO_BACKEND_INTERFACE_CMOS;
+	else
+		*type = IIO_BACKEND_INTERFACE_LVDS;
+
+	return 0;
+}
+
 static struct iio_buffer *axi_adc_request_buffer(struct iio_backend *back,
 						 struct iio_dev *indio_dev)
 {
@@ -285,6 +307,7 @@ static const struct iio_backend_ops adi_axi_adc_generic = {
 	.iodelay_set = axi_adc_iodelays_set,
 	.test_pattern_set = axi_adc_test_pattern_set,
 	.chan_status = axi_adc_chan_status,
+	.interface_type_get = axi_adc_interface_type_get,
 };
 
 static int adi_axi_adc_probe(struct platform_device *pdev)
-- 
2.46.2


