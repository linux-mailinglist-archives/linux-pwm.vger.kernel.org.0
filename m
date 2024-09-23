Return-Path: <linux-pwm+bounces-3329-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC14497E9A5
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 12:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AD791C2176C
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Sep 2024 10:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1116194A54;
	Mon, 23 Sep 2024 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zM/hHxDt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD846425;
	Mon, 23 Sep 2024 10:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727086582; cv=none; b=ol5bwQFTTQgeKGugmRSPZEs0sBJzyf1+QNwj9TgGVUJ0opFGQxNnKSBDq6A+x8vxPOAZRlabysidZ2HHMX4Crl2HW/YgiD757m+D2aUHKCH7rqOboerDRX+3VQ4gdzZcjLjiYyE8Ve+CIvPCx668GaHlSLruQcwl6wUQYHWZksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727086582; c=relaxed/simple;
	bh=53IWbInwjlO7Z5VBHcWpCMQqe7HNtwdsn8Flx18kno4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DGIn5uPj5LYWAyym7fpbHxHziE21M9q2usSAmhxJUGbAgBTAYeL9ewflMVh+3Xinl0YfwK2NzjbS2tdEoz8PbAd85yEvbxO/bZQVdSVA9GR1jL7T5sJseMe8zyduOKYYjLLjLGxTJ4iCu0PoKWOKjZOA2Aw2UEdH7YrjJAHAb/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zM/hHxDt; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48N74q7j015348;
	Mon, 23 Sep 2024 06:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=4ytrpuro3bSWG9Tt8uGzvDdhz3t
	76ddrHBtHeXSYhV8=; b=zM/hHxDtOgq1gZdpsEGCO1R84ERuefeoYW4hZGSvidV
	JfTwHUqg0NUw7SBa0fVnm40+syZKKDol5CHlv+QKTzrg8aGX6ARalSnLKomQ/urj
	27w9ilP4oW5mCM4LIF6ruzognXfJRyUQmSDX+1u+6gq3k02eAFzyha5rTqCpB8iC
	6ZCgToNwyhtjbRZkQ6jxNooX09comZWY43GY23GF+MjMhrK8Ewr9rFsHiSfDXwJc
	S3+4gCcDWs5WjGAL8ksqDPhkwZotzcHeWPUerw+5Jmat95IEoANrjBhrblad5yZg
	gmz2GorlFSKIll0xsFLzRgEDSPlyT8gDXB7STcPVPWg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 41u3frrqmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 06:15:39 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 48NAFbFk028020
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 23 Sep 2024 06:15:37 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 23 Sep
 2024 06:15:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 23 Sep 2024 06:15:37 -0400
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 48NAFIQQ001918;
	Mon, 23 Sep 2024 06:15:20 -0400
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
        Ivan
 Mikhaylov <fr0st61te@gmail.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        Dumitru Ceclan <mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Sergiu Cuciurean
	<sergiu.cuciurean@analog.com>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 0/7] *** Add support for AD485x DAS Family ***
Date: Mon, 23 Sep 2024 13:10:17 +0300
Message-ID: <20240923101206.3753-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 3KMmdx-vrpxJ5ksvCG0-7JpgEGy81Q2C
X-Proofpoint-GUID: 3KMmdx-vrpxJ5ksvCG0-7JpgEGy81Q2C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409230075

Add support for AD485X fully buffered, 8-channel simultaneous sampling,
16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
common-mode range inputs.

Some particularities:
1. softspan - the devices support multiple softspans which are represented in iio
              through offset/scale. The current handling implies changing both
              the scale and the offset separately via IIO, therefore in order to
              properly set the softspan, each time the offset changes the softspan
              is set to the default value. And only after changing also the scale
              the desired softspan is set. This is the approach we are suggesting
              since we need the softspan configurable from userspace and not from
              devicetree.

2. packet format - Data provided on the CMOS and LVDS conversion data output buses
                   are packaged into eight channel packets. This is currently handled
                   as extended info.

Antoniu Miclaus (7):
  iio: backend: add API for interface get
  iio: backend: add support for data size set
  iio: adc: adi-axi-adc: add interface type
  iio: adc: adi-axi-adc: set data format
  dt-bindings: iio: adc: add ad458x
  iio: adc: ad485x: add ad485x driver
  Documentation: ABI: testing: ad485x: add ABI docs

 .../ABI/testing/sysfs-bus-iio-adc-ad485x      |   14 +
 .../bindings/iio/adc/adi,ad485x.yaml          |   82 ++
 drivers/iio/adc/Kconfig                       |   12 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad485x.c                      | 1061 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |   44 +
 drivers/iio/industrialio-backend.c            |   45 +
 include/linux/iio/backend.h                   |   13 +
 8 files changed, 1272 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ad485x
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad485x.yaml
 create mode 100644 drivers/iio/adc/ad485x.c

-- 
2.46.0


