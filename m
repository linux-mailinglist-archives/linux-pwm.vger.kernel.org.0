Return-Path: <linux-pwm+bounces-4897-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27E4A35ED7
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 14:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C7F3AA528
	for <lists+linux-pwm@lfdr.de>; Fri, 14 Feb 2025 13:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D546264A78;
	Fri, 14 Feb 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="NRAxYVUb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE1263F4E;
	Fri, 14 Feb 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739539224; cv=none; b=VJ3ktSlUqo8zQa35hbp6yitvEAjc8KjRBOBNeMIC2UIOMgstRtNcODOo+gJ8VmdviOUFHgrXs7eR8dEFWhBh1w62GTQLbKaldSQXqXy4yU6FhIYaKCy20nZ4PbUZNca9iVFh41U9L+VGfqdk6KM4GdHz2e69vYiHqcqziu5nGIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739539224; c=relaxed/simple;
	bh=I5YAFylcdgbMrBkjs5BD+OtCHvqUDDURBdKHMS17LU0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PXTUHCx34ybYSBTYn8r0/da3NaIXlEFQvPnfTVRxrzV5uJC9Y1XTOEgw2AZu0r5bj/Q7QJL0l9U9eHSBI3/yta7o4OFk1BQy2bt42Dlh3Pqg7csgI+xKt1fijWzny8VzhGJ39/cWvbMoru5ci6gnmom+ss/XvQT48KICHkMBuP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=NRAxYVUb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E8XV4I025000;
	Fri, 14 Feb 2025 08:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Kmv32vNSCQMD5XPcscN2RcKHaBM
	mKbuga6YUUuAJQrY=; b=NRAxYVUbcMymZIuhvCMeMlAXJz7tKIRvQxOgfyqtkSZ
	SLHCRUVo7XsGEhvgNhnkmFqY521c2bcvuVrBMC1hWFmx0XdSjxZYnkLerS1a4VA7
	fE0K4brhP7VcrEvrZ0mg0+aAn4j4JPVLaDL1pmofRKExww0aOnTwGzZ7hrjXVGbI
	pMh5klCo8VvVIL5Qe2GAMAcSDJM2AZyBuaUAA0OVXgwo8+8aAAQab2TU1Ne5p3+B
	/orn3dm45r3cSpBnAd4huclTP/K8EeEE9jhZ/hqLClz9IA1js5/KncQUFfTgAaRl
	IFeFCzlpxH0rkPSSg87lsG9SqkL8qrFkoxP8edGS8ZA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 44swyda6e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 08:20:08 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 51EDK7JA022814
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 14 Feb 2025 08:20:07 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:07 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 14 Feb 2025 08:20:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Feb 2025 08:20:06 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.172])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 51EDJuUQ020604;
	Fri, 14 Feb 2025 08:19:59 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v13 0/9] Add support for AD485x DAS Family
Date: Fri, 14 Feb 2025 15:19:46 +0200
Message-ID: <20250214131955.31973-1-antoniu.miclaus@analog.com>
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
X-Authority-Analysis: v=2.4 cv=Pc4Fhjhd c=1 sm=1 tr=0 ts=67af4308 cx=c_pps a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17 a=T2h4t0Lz3GQA:10 a=H4ADBwE-jcidW2BkoBwA:9
X-Proofpoint-ORIG-GUID: jdEQ_afGgi-qiBri1Nqju96p4mc7PNtL
X-Proofpoint-GUID: jdEQ_afGgi-qiBri1Nqju96p4mc7PNtL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_05,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 priorityscore=1501
 phishscore=0 bulkscore=0 mlxlogscore=972 adultscore=0 lowpriorityscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502140097

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
 drivers/iio/adc/ad4851.c                      | 1315 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |  148 +-
 drivers/iio/industrialio-backend.c            |   60 +
 include/linux/iio/backend.h                   |   19 +
 8 files changed, 1703 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 create mode 100644 drivers/iio/adc/ad4851.c

-- 
2.48.1


