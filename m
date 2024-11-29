Return-Path: <linux-pwm+bounces-4162-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26549DE999
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7758028287D
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B28B1474C9;
	Fri, 29 Nov 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Pu8L9OZz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728DA82D66;
	Fri, 29 Nov 2024 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894578; cv=none; b=rZ47YiGoKVQkn/82W6EFKzNt3404ka1YGk7zhhO6jIkKaUq0AhsLElFI4BuOpp3A/5ndeSh3Ul2+oY5uZMN1y37tYPBNOtSMWlIJwDYXQEqKZXgUXNvNHhUN5BhfL5niGkEQ6PVF1G1Wg+N7rSz/YnLrYgcmJAQw5+iFrIoxjko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894578; c=relaxed/simple;
	bh=Nfv2coxAHHWAmFIknU2TD7262iV9gckepQHKoh2unjc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HnyF43qPH/HX7dXpFDOK/jgdCgZXDUO8WVwjfiwyWIR/RpAGVbYDWk2VZX8BfYmCHj/dG/xWUpBXyZs65muEucOTlNrELcj5gzMxVNkHH1vk0IH8hb+FjbMJkV5Sd74hOj3LIm1Z850F9bdwf7gpEuG+UWkXmMxsBByzJ8P46FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Pu8L9OZz; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATAtOZb014684;
	Fri, 29 Nov 2024 10:36:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5oTLt1necrQydMLFeEFGgi/tCAP
	/cAlK/9sFzwmMak4=; b=Pu8L9OZzSQT9cN0zyeQNFNcu9ha2g5MZ+PDnR1V8mDK
	j5cG6YJe2o6fo15q7dZyW3PVVyZzMCCi5nI91Zq+4CKeVJwSYIH8uzRs3rI303eT
	6bCmLS0NM6/2YUWk0A+2clCHwnOopaAk9QWuDdBK1NIXa/qMAF0XQe3629iN3NgZ
	Rzq45jvY8tNk7Kv6A3uyY5oRACPWfZaUA8FjT41WCMvTlnxSTiPrqJDQSUG67oS0
	rY2TorSVk08kgAKcPZxGlMJ0stlVBCRlgz2iUPQfTVI4zgWqWfFXIW24a479veQK
	LuYfzc6vMkKpWUOH+1Kja/IKziSj6pVdcVjhrU9sUtQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436716tmxc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 10:36:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATFaCxE008839
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 10:36:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 29 Nov
 2024 10:36:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 10:36:12 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATFa0m3001167;
	Fri, 29 Nov 2024 10:36:03 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v7 0/8] Add support for AD485x DAS Family
Date: Fri, 29 Nov 2024 17:35:38 +0200
Message-ID: <20241129153546.63584-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 9kxpA-5g82pupE7ZeYuxSUlqO9XPxnhd
X-Proofpoint-ORIG-GUID: 9kxpA-5g82pupE7ZeYuxSUlqO9XPxnhd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290127

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


Antoniu Miclaus (8):
  iio: backend: add API for interface get
  iio: backend: add support for data size set
  iio: backend: add API for oversampling
  iio: adc: adi-axi-adc: add interface type
  iio: adc: adi-axi-adc: set data format
  iio: adc: adi-axi-adc: add oversampling
  dt-bindings: iio: adc: add ad4851
  iio: adc: ad4851: add ad485x driver

 .../bindings/iio/adc/adi,ad4851.yaml          |  139 ++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4851.c                      | 1346 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |   73 +
 drivers/iio/industrialio-backend.c            |   71 +
 include/linux/iio/backend.h                   |   20 +
 7 files changed, 1663 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 create mode 100644 drivers/iio/adc/ad4851.c

-- 
2.47.1


