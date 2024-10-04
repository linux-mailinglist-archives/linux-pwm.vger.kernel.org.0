Return-Path: <linux-pwm+bounces-3465-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D27D9905B4
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 16:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E032B209B9
	for <lists+linux-pwm@lfdr.de>; Fri,  4 Oct 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521FE2194A8;
	Fri,  4 Oct 2024 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="feWtulwa"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB8B217304;
	Fri,  4 Oct 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728051194; cv=none; b=bMFxi8yVcD0AUYlzv7PoFMsvcfNwlCZ5vCe66YzNoQq2eth7aDP5I1Bto28B/wHg/4NG1wLgBCTJixBweLu0ROTQ5hNgCLKpLZYrDUALneSnTSf3lL8/qgzcbjXIxHLujom8sqGo2FmfA69Nwlx/88ClrZ2Eg1YYvCUoyUfRk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728051194; c=relaxed/simple;
	bh=uAq7LOKTJTM0nxXXvyUdoiwg8irtm++qAYb+DvlExws=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U0Eg7D2fE1+tyDt3gWiJU9tPGNWGeo7IureK6zNIVBd99AnzHYLhXKBGAiiZiwyXTvEnh2wuvtlm9ao/LHT+EOLYdOmw4nf2n1G8Z9Z02qdZjA3CCTFyuk2HCZowwMZAhdKpOjzK7MC9S7uG6pLeq+0X4JSeUMyNh2WUVbx1ljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=feWtulwa; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494C48Ad018577;
	Fri, 4 Oct 2024 10:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=0Ns6c
	KpXekNU/LVxVd6eQphUEDq2bnU24uk5tmxzSMQ=; b=feWtulwaqA4FLlp7H5gQQ
	HneJ3ZeDnfXhFN2ra+Xw8Dxrzm1g1IZ+WRrGWxDh/a0sj40BISpIem/YTlyTNRO/
	6/r9lpcMmPkvHTRMwV3+DETlZqs7Cs68euRd14OV3+nFdhhJQ2Agtq+md50X8vWo
	s/Q0StOBYbnoQuwclNNY1SV/Loc5j540ck6YQ7HIq0G5yx8/6m5T2ob/1M4n89C6
	bm58apYgEzdC8GuHsrWrNHOtJX9Sxq7iOD8H9VFhn3xc1YGyKs28EK0SV0w+OaM7
	D1A7AM5TiYXDcl5jAswl0FtD3yyKqHWLEdcuat6yLKolfA0/CxdPu1VdkKYK8cir
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 422043kx57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Oct 2024 10:12:46 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 494ECj6P002749
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Oct 2024 10:12:45 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Oct 2024 10:12:45 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 4 Oct 2024 10:12:45 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 4 Oct 2024 10:12:45 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.173])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 494EAps7001773;
	Fri, 4 Oct 2024 10:12:37 -0400
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
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        "Mike
 Looijmans" <mike.looijmans@topic.nl>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?=
	<joao.goncalves@toradex.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Alisa-Dariana Roman <alisadariana@gmail.com>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v2 7/7] Documentation: ABI: testing: ad485x: add ABI docs
Date: Fri, 4 Oct 2024 17:07:56 +0300
Message-ID: <20241004140922.233939-7-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241004140922.233939-1-antoniu.miclaus@analog.com>
References: <20241004140922.233939-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: W_s_ac2Gz9o3ctJLcwc1ZsfxpmcR588x
X-Proofpoint-GUID: W_s_ac2Gz9o3ctJLcwc1ZsfxpmcR588x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 impostorscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410040099

Add documentation for the packet size.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v2:
 - improve description for packet_format
 - add kernel version
 .../ABI/testing/sysfs-bus-iio-adc-ad485x         | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
new file mode 100644
index 000000000000..5d69a8d30383
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
@@ -0,0 +1,16 @@
+What:		/sys/bus/iio/devices/iio:deviceX/packet_format_available
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Packet sizes on the CMOS or LVDS conversion data output bus.
+		Reading this returns the valid values that can be written to the
+		packet_format.
+
+What:		/sys/bus/iio/devices/iio:deviceX/packet_format
+KernelVersion:	6.13
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the frame size on conversion data
+		output bus. See packet_format_available for available sizes
+		based on the device used.
+		Reading returns the actual size used.
-- 
2.46.2


