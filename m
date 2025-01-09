Return-Path: <linux-pwm+bounces-4560-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AFCA077C1
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 14:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BABC7A319F
	for <lists+linux-pwm@lfdr.de>; Thu,  9 Jan 2025 13:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A3218AA0;
	Thu,  9 Jan 2025 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mUPTFCOc"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A082421A427;
	Thu,  9 Jan 2025 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736429857; cv=none; b=jvOP+Ht2UIxamPdktGrqPQO7E5rMNcVyQEQe1nB5ZmHoqZcJOvQeWUleOrXniGbV3pkD1xqKlOYhdFMk35kFj091OK2v3BsKL72Q2V8CrIn9cA4DeGeLhE7RRlbf144MN/u8Vuw5LkP5Oqfz1gISRxuQWqs/jOfOIct6LiTuir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736429857; c=relaxed/simple;
	bh=nXPAqnWuVPkfiVnJxIJs97ENhtRx1OFzApP7YuJOtmw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MztymcBOpLCrluIWmH8kXDZBy14zODEtXOPESbHkYiG+jL7NHdlMLvCsDf8PG5TatFebCEL1E0RI6VTnvvC4UnBz0UH58dYIDcTdi7aFugfqbQ1nL5Z9OhIRgCoFqKSSNBYNkZlZTjQnPFnhkMfMf+dsrHeZPgrUUeO1vY+CzKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mUPTFCOc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 509C52M2017205;
	Thu, 9 Jan 2025 08:37:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EHl0sYNt+jh8jmqcKhdvq1sPXnb
	0zUrXr1fUoAzWZTs=; b=mUPTFCOc+bUiNHW20+wH6fXod4Kwu0c3djium8eRTKX
	P2Hxa6nizuODa6zljI/AozmDf027EQ+mbTFnZWkeK4qvASK8mfFhkEs8sO58xoIQ
	a3jaIDR4WdCow613y4EwFeg7zdF2ROEjnlNliEfWYdk4ANhyJ/Gy35QTs8r0AT1h
	ndjdrT5zI3SCoddRQItqB10By3r7+f7DaNMvjuscZM/kUNrkuv8fKquSRxi/nY0l
	fVaJdt+Jjg1RXEED9UyFZSrjLg8qja+5a+TAnQrgHWrxIWg5o+luF8iYF9ESryu0
	ZjBvAmPeT25cdgEKoc07RR989Pq2ftmwabCDlF8CQ/Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 442e57rasq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jan 2025 08:37:19 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 509DbITg010891
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 9 Jan 2025 08:37:18 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 9 Jan 2025
 08:37:18 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 9 Jan 2025 08:37:18 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.136])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 509Db9iX009541;
	Thu, 9 Jan 2025 08:37:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 0/3] ADF4371 refin mode and doubler support
Date: Thu, 9 Jan 2025 15:37:04 +0200
Message-ID: <20250109133707.3845-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: pAF_koNrOpRexJtTLR5O-i42h09CqNYD
X-Proofpoint-GUID: pAF_koNrOpRexJtTLR5O-i42h09CqNYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=972 lowpriorityscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501090109

Add support for selecting between single-ended and differential
reference input. By default the single-ended input is enabled.

Input frequency boundaries are change based on the mode selected
(single-ended/differential).

Add support for the reference doubler. This feature is enabled
automatically to improve noise performance if the input frequency
is within the accepted range.

Antoniu Miclaus (3):
  dt-bindings: iio: adf4371: add refin mode
  iio: frequency: adf4371: add refin mode
  iio: frequency: adf4371: add ref doubler

 .../bindings/iio/frequency/adf4371.yaml       |  7 ++-
 drivers/iio/frequency/adf4371.c               | 44 +++++++++++++++++--
 2 files changed, 45 insertions(+), 6 deletions(-)

-- 
2.47.1


