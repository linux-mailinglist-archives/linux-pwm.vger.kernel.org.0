Return-Path: <linux-pwm+bounces-4730-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9FFA1D41A
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 11:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F573A6F77
	for <lists+linux-pwm@lfdr.de>; Mon, 27 Jan 2025 10:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07C01FDA89;
	Mon, 27 Jan 2025 10:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nT+H/nPx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C271FCF74;
	Mon, 27 Jan 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737972655; cv=none; b=s4v0dI08d5yBA3WxOFwpG4TEGozJTTxSlZeTqwKwRFu9Ql53auwnEHA9334nRv9SXIqsGyRZZ98jH+ZeyWPHzq6nV6+OJZQZxp0q1+wcvuwSQzmnp2tQpGb8JyRi1Pg8LDLqpyrMo40emq347a4wwtYWDd00S4m1oBDnOrUo2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737972655; c=relaxed/simple;
	bh=JeSsDJHE7PLktIMdvwNcjG0HOolwGVyK1hu5hzEBugg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ew1gsy90KcuHBfHxLXsozKK3fm5tLet11ZtJjaFHbape4pohQfIUQcK8+NJqWLr9erujONYszolCbDMdOIPU+BdtfJOYZbvQDq4bxgRCh2EFXxFfIjV5bxwEbCdMqArf9ucejv5RHcwrkELQMtuqye2snkpBVLbwpy5Qh6lkvGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nT+H/nPx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50R9MICS010208;
	Mon, 27 Jan 2025 05:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=EWcfQC0gGV5WSXPpp1dlC5qOSOJ
	BYE72jSsfM7zcuok=; b=nT+H/nPxN7REGyC9bCmYEwHC5rbor4ZIMh3+RFwGDWS
	UPuRBBJthL1PH0kxz2X8pK3KZCDJ4kFwu+7T7JA9X6SYi9ooBpzSBMjOLF3H535p
	KSFGDpVPReb7DkFWBItQpJz+aY/SaPxTjnM/GHzaY2BrSG6U1MiQ4ONn2KWUl6om
	u8Hmd3bv7ReDQ2+yAixr1MU9UsJ6VkHBEtTq0xmE4Jxj4mXtxAAKK4CKWVISDJql
	Hj7lg7UCdG89mgq5sni8L7TJxy2g0H31EcjYX8dNnIv27VsFxmjkQvXXTz+upDQd
	AC4/kyn+SNT5AXyntB1uJ5gUQ/SPHOGVTkZe6FhBhhg==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 44e7f005am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jan 2025 05:10:39 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 50RAAbno013632
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jan 2025 05:10:37 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 05:10:37 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 27 Jan 2025 05:10:37 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 27 Jan 2025 05:10:37 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.165])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 50RAATiC016396;
	Mon, 27 Jan 2025 05:10:32 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 0/3] ADF4371 refin mode and doubler support
Date: Mon, 27 Jan 2025 12:10:20 +0200
Message-ID: <20250127101026.5320-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-ORIG-GUID: V5ngEwm9l-0yui5xZHbz7yejU2kxZK2Q
X-Proofpoint-GUID: V5ngEwm9l-0yui5xZHbz7yejU2kxZK2Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-27_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 impostorscore=0
 mlxlogscore=958 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501270081

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

 .../bindings/iio/frequency/adf4371.yaml       |  5 +-
 drivers/iio/frequency/adf4371.c               | 47 ++++++++++++++++---
 2 files changed, 44 insertions(+), 8 deletions(-)

-- 
2.48.1


