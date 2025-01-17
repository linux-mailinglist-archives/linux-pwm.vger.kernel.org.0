Return-Path: <linux-pwm+bounces-4645-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5101BA15013
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 14:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E49B162927
	for <lists+linux-pwm@lfdr.de>; Fri, 17 Jan 2025 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D661FF7A9;
	Fri, 17 Jan 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xZmiauDT"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2E1FE46E;
	Fri, 17 Jan 2025 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737119240; cv=none; b=h9cxnbftj0+nY6Tl88Rw39y9x0aeoqhqKlFIWM+uxkJP0AeXQpWddTebYvEkN9GnwbK3bzW02yhVmMXVlav0FzbRv1uvFR3fmOdQ+sOnRcHnBcMZdW8cME2C4+EtYpta1s0hwHlXIrjZmdsbCVb956enwi61oKe2PhJPYs1a1kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737119240; c=relaxed/simple;
	bh=3fWhu+VDXrGSx6GgQAoPWywIBLijTUoeY6GZ7HuP/is=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t9X/XqiOiMttrz1B1sFKUN6WyosiHdZozveGaYIgV03AVskcIs71KxFVb47ykx9TG99dbytn8O13n6Yj3wxIwFVh4KWto7VJopfSlxHhip5APb/mKWKw2nMgOLA8Ubw/2SPg0Rv1rtoSacNo+rzkZ3YzQevJtqqBMLDn4Y5ngi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xZmiauDT; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50HAhRL3023572;
	Fri, 17 Jan 2025 08:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=gbSm8VRS0+oSTL1nAffhGR92WQk
	Nt2wZ2/i+N42uglM=; b=xZmiauDTcaRoVVd+bdLDpLDxAeFGEvoiVCAgKI6xStV
	QWOSsLYdRZnIT/fv8JMGzA+UwN75g4hQ3xLRNEHXP+hy+J4lmeO1dzoiSiA/zbF2
	Gc+vpgaGau8abezbA1ukm07Yst7++6WWRpVP17lkbUEh5J+rlL7JPFbOQjf8rvTT
	naAk75W42NNlPtkuiDvbtArVSDj5rWnHTj8iioNpwddw+WDNNtPdTsy1H6aD5bkk
	9AoebqK+VhHbCWhy0GoDs4+GKp1hLiSo6Zq2/lOm8dPPJmxZdX86k6ldnRMgL6Sg
	IXAL942L+ZbRCrdu+qpdefAT+V066rISoldWQTEigFQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 447nq10gdt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Jan 2025 08:07:16 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 50HD7EfL027780
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 17 Jan 2025 08:07:14 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 17 Jan
 2025 08:07:14 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 17 Jan 2025 08:07:14 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.159])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50HD764i013564;
	Fri, 17 Jan 2025 08:07:09 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v10 0/8] Add support for AD485x DAS Family
Date: Fri, 17 Jan 2025 15:06:54 +0200
Message-ID: <20250117130702.22588-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: 4iE18qSKZNaZHyFc9k-M5whRk-PLMI1b
X-Proofpoint-GUID: 4iE18qSKZNaZHyFc9k-M5whRk-PLMI1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-17_05,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 mlxlogscore=967
 adultscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 malwarescore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501170106

Add support for AD485X fully buffered, 8-channel simultaneous sampling,
16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
common-mode range inputs.

Most of the review comments which make sense in v9 were addressed. Some of them
might have been ommitted, especially those that are a matter of preference.
Since we reached v10, I tried to cover everything that was pointed out until now.

Antoniu Miclaus (8):
  iio: backend: add API for interface get
  iio: backend: add support for data size set
  iio: backend: add API for oversampling
  iio: adc: adi-axi-adc: add interface type
  iio: adc: adi-axi-adc: set data format
  iio: adc: adi-axi-adc: add oversampling
  dt-bindings: iio: adc: add ad4851
  iio: adc: ad4851: add ad485x driver

 .../bindings/iio/adc/adi,ad4851.yaml          |  153 ++
 drivers/iio/adc/Kconfig                       |   14 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4851.c                      | 1297 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |   88 ++
 drivers/iio/industrialio-backend.c            |   60 +
 include/linux/iio/backend.h                   |   19 +
 7 files changed, 1632 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 create mode 100644 drivers/iio/adc/ad4851.c

-- 
2.48.1


