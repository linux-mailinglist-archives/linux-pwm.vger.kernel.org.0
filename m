Return-Path: <linux-pwm+bounces-4814-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7489A2C4FC
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 15:16:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E92B3B004D
	for <lists+linux-pwm@lfdr.de>; Fri,  7 Feb 2025 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1641F754C;
	Fri,  7 Feb 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="HenR3/iJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780C1CDFD4;
	Fri,  7 Feb 2025 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937403; cv=none; b=FrhIfGwi77grUpo55DPAyoaxORQ2ayXYZ5IjCWLBszo6Ihp/c7JPT4x4dfhdzcBAkc+QIr4KC/gcEg3BKfvc25UfXVzJTh9CkbmUCp1T6YAbqqqEISbjiGlpX71wrTaGxnr9t6IxuECZICMSMG3QMoNpzwBREvQ2qhdz804feSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937403; c=relaxed/simple;
	bh=jk2ZpfckXcdeztgQDTCpDymGrolrpdR3IzlHWUSE9G8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MDLzn9oRqS1IKtmoFXsh45JAyDlSfqBfoOS4gzcwmKC2hhxuEDrzrVhqQZ4sQKcb1Jhi2S9o0mFIguux0Ico9De0pwslHzPKS13YwyJfXDZMW5RHRxZbbtAh9Uemp8YLa8Qj26LrRgPJtDn2qzFbr87pe9a2GskBMpywI6tyW68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=HenR3/iJ; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517DZoF1012100;
	Fri, 7 Feb 2025 09:09:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=TMWcwJErA0llBRLLZwi6BDVhozG
	WRibFaQkCpeRDfOA=; b=HenR3/iJtW3UxlHIFw1VJ2MshbMY1h7y5y0qYBCIr21
	tEgC/PhC6RmUsvyQCETsoQKtp1/L7m3LpRgQt0CRvwLP0vOsboNywFOXCZ5accJX
	9AsNyZNGMgrTTol2EbIVfdQLGJPk3qpZ10A1gflZY36Se2VPhnkA66qwGjW1IKhJ
	VBlqlv1vYvx7shYTCb6H2k2mBRpgbENI3pmqqeqTIhAeJm6heTTHQI0ukAv8s1LA
	KPNJPtr7ggTVT9HaVngeTY5f4NdeE9Dq4nvAUcAHpn5U5Vy9w+8h1uC1KLgw9T+X
	kC+QvBynropNiN2aAXjNwzFUOHpx3FUjsozwow3tZuQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44nk6v846v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 09:09:46 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 517E9iYv008512
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 7 Feb 2025 09:09:44 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:44 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 7 Feb 2025 09:09:44 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 7 Feb 2025 09:09:44 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.147])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 517E9a4m015095;
	Fri, 7 Feb 2025 09:09:38 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v12 0/9] Add support for AD485x DAS Family
Date: Fri, 7 Feb 2025 16:09:09 +0200
Message-ID: <20250207140918.7814-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: rRCUEsBpgS7mxMhr2jS7tD8APf2cROk5
X-Authority-Analysis: v=2.4 cv=fZNXy1QF c=1 sm=1 tr=0 ts=67a6142a cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=H4ADBwE-jcidW2BkoBwA:9
X-Proofpoint-ORIG-GUID: rRCUEsBpgS7mxMhr2jS7tD8APf2cROk5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_06,2025-02-07_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=974 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0 priorityscore=1501
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502070108

Add support for AD485X fully buffered, 8-channel simultaneous sampling,
16/20-bit, 1 MSPS data acquisition system (DAS) with differential, wide
common-mode range inputs.

Most of the review comments which make sense in v9 were addressed. Some of them
might have been ommitted, especially those that are a matter of preference.
Since we reached v10, I tried to cover everything that was pointed out until now.

Antoniu Miclaus (9):
  iio: backend: add API for interface get
  iio: backend: add support for data size set
  iio: backend: add API for oversampling
  iio: adc: adi-axi-adc: add interface type
  dt-bindings: iio: adc: add ad485x axi variant
  iio: adc: adi-axi-adc: set data format
  iio: adc: adi-axi-adc: add oversampling
  dt-bindings: iio: adc: add ad4851
  iio: adc: ad4851: add ad485x driver

 .../bindings/iio/adc/adi,ad4851.yaml          |  153 ++
 .../bindings/iio/adc/adi,axi-adc.yaml         |    2 +
 drivers/iio/adc/Kconfig                       |   14 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4851.c                      | 1316 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  146 +-
 drivers/iio/industrialio-backend.c            |   60 +
 include/linux/iio/backend.h                   |   19 +
 8 files changed, 1702 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 create mode 100644 drivers/iio/adc/ad4851.c

-- 
2.48.1


