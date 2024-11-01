Return-Path: <linux-pwm+bounces-3993-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CB09B902F
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97152B214B3
	for <lists+linux-pwm@lfdr.de>; Fri,  1 Nov 2024 11:24:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1612199E94;
	Fri,  1 Nov 2024 11:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CqPusi1I"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D51E14A62B;
	Fri,  1 Nov 2024 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460285; cv=none; b=pW00sETgEcbK8aSsLXmrUJF+r8bVwXseLFofEG4Ajgzz3umsoxk5901GKxuyFrgaRP56/u8lFAjCU8gj8ph3yfA6QQY4FLbB2XNS8pUoZ0ELfjvw5ynqIL5zdMkuHoSS0yN5YAlMwtHoVNyn3GsSI82qPITdwYixtC4eZojfE8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460285; c=relaxed/simple;
	bh=53IWbInwjlO7Z5VBHcWpCMQqe7HNtwdsn8Flx18kno4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WmGoFScptbPNUBncKxGdCD0+CDSR3c22UE6+StE+LUJYxNcVJxp11MMTqn3AGfTenh/fKj2EUy0cttHoPLgYu1wv6pqVZOvVdfp3fRqMJ15vHNW+JT8fsyc2K9+5StcKlqpgx0UE4Y4/4J+DSduNL9AB7ynQlrDBBCKTAMi7MJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CqPusi1I; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A16R460006546;
	Fri, 1 Nov 2024 07:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=4ytrpuro3bSWG9Tt8uGzvDdhz3t
	76ddrHBtHeXSYhV8=; b=CqPusi1I/vd9NYupPnGaEIjVHNKJFR5vjIyuNghzplz
	4n6gcl+1ICB3rUlDoyZLDrHbpNe2Tj4NSlFxsPyfoJtebp0EPaCHdVIg44CbjKlz
	JUKch4L6lAHt15XGzMM/MeJwONIpF5JMxV+IiVNIH9uWL6se15pZTxmtDwFPP8Dq
	1VzjctAuuRTTezxEo9UWyQ4Lqy3+fjZwziUd/nkBdMscOQAVFxfG9sJUNS0xHL8p
	NV965wyNclaOwqeYd7CjZOmYbbab/WiFyrCWIFPjYIrsYlXh9P1VA4kidnx3QSZJ
	JdiIud+86mcg538MNptCd5K+ypefH2Dae3eKE0kyquA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 42k6yveu14-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 07:24:38 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4A1BObXX038436
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 1 Nov 2024 07:24:37 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 1 Nov 2024
 07:24:37 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 1 Nov 2024 07:24:37 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.114])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4A1BOP8i016631;
	Fri, 1 Nov 2024 07:24:27 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <conor+dt@kernel.org>, <dlechner@baylibre.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH 0/7] *** Add support for AD485x DAS Family ***
Date: Fri, 1 Nov 2024 13:23:52 +0200
Message-ID: <20241101112358.22996-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: Vvu0rksF9wL1-mYRZm3GyIPdVvirzoH7
X-Proofpoint-GUID: Vvu0rksF9wL1-mYRZm3GyIPdVvirzoH7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 malwarescore=0 phishscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010082

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


