Return-Path: <linux-pwm+bounces-3336-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABE797E9CF
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17F311F21DDE
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2513A198A10;
	Mon, 23 Sep 2024 10:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="GSNTyfyl"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F6F197559;
	Mon, 23 Sep 2024 10:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086697; cv=none; b=em1vRUvPouaKFiOl6P77/XC/GFvQd8TSY+wC+gkB4FYfUjkijQoI2f50xNmVyPU/QeMPVXYvl/hWfjfrG9Dz4BUWM/bojT1MqLWWcv3ElTc6fc43zFHquUOX2TufJFeKPSwkCDW3qgMVeiD0mCGyBWRb7g6sQcI0je6Yn3Nx1ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086697; c=relaxed/simple;
	bh=tkUqe/LKrD7kgIaybLBnBvhqgWzxpnjUHZlqmYgWO2o=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onTfgqEv4G5wcyMlBIIVP4yGZAhaT02LwkK/b2ufG1ZwqyByBfGR+BJEmtMxaZZADu0V/aFoIbcsQAWmf2eJ/C8dBZqedDs4Zb+1aVlspbzywTpOGann2klTwTz+X1Na5zQjaUmIqLxaHfOpRS6oAK/aINF0wRXHRG0w2BpLc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=GSNTyfyl; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N9j6E2007076;
	Mon, 23 Sep 2024 06:17:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jNhHT
	r95V5dva/i/UC/BUQydR60FrkjPPzsslHJYDzE=; b=GSNTyfylOaqT0+Q0u9xS1
	WEv3YLT4NmOSbTjynKtNx18VHpVtj9HBAmsLVFBvgOCHTiRViRoPPD1Q3K/LxbyQ
	TQB5CwS72ioD8vsWEsAue2tRG0uiFRyQ4CaBPj02sk1MPVxq5egK+Xlb9AYaFsfu
	ZRd/GmpfwhRGUgEQUHfQv2+zH5IuxPdGDoeqezoP0efzctJhnthl71+7X5Am7Izv
	HOSK3r9fM6VN3/S73xeA/nwGgOIdxCBDKS4exo9DLbgrakglA2+PCsDyMxYKXETh
	RxKPaF0bWxxuUe/XNeRzutJUy0chwGUqrG8peoYz4pwq6U27bgAwI5sVHF8ifi10
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41sr04qhje-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 06:17:51 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 48NAHXDC028122
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Sep 2024 06:17:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 23 Sep
 2024 06:17:33 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 23 Sep 2024 06:17:33 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48NAFIQX001918;
	Mon, 23 Sep 2024 06:17:23 -0400
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
        Ivan Mikhaylov
	<fr0st61te@gmail.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Mike Looijmans
	<mike.looijmans@topic.nl>,
        Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH 7/7] Documentation: ABI: testing: ad485x: add ABI docs
Date: Mon, 23 Sep 2024 13:10:24 +0300
Message-ID: <20240923101206.3753-8-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: idp7t9xVHLekVufSww1HhJ4nAQjfbAt5
X-Proofpoint-ORIG-GUID: idp7t9xVHLekVufSww1HhJ4nAQjfbAt5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 phishscore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409230076

Add documentation for the packet size.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x | 14 ++++++++++++++
 1 file changed, 14 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
new file mode 100644
index 000000000000..80aaef4eb750
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
@@ -0,0 +1,14 @@
+What:		/sys/bus/iio/devices/iio:deviceX/packet_format_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Packet sizes on the CMOS or LVDS conversion data output bus.
+		Reading this returns the valid values that can be written to the
+		packet_format.
+
+What:		/sys/bus/iio/devices/iio:deviceX/packet_format
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the packet size.
+		Reading returns the actual size used.
-- 
2.46.0


