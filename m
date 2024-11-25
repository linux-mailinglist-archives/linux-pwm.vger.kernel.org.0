Return-Path: <linux-pwm+bounces-4143-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 644129D8467
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29960285C96
	for <lists+linux-pwm@lfdr.de>; Mon, 25 Nov 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61740199920;
	Mon, 25 Nov 2024 11:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dvEQKzHx"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E2C199384;
	Mon, 25 Nov 2024 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732534034; cv=none; b=snRMrjOKzHmYpxWXj6USgakURJzHqv5LyjleQPCbzMJpdsM62hM7/N3eMp1bHuiL6Nbqj43GvveXSA7GUjwNr+0e7aEUfUtiNBeojfvz4MbblKraz3zTCAo3Q707U/0WrQMc8NjxVol5fQvDfxVs0xejEgoxqAWReWdfTM79EIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732534034; c=relaxed/simple;
	bh=zsdkLjfKIS7ym8k7MZJOfE8iGpa+ungfaX6tE6YL1IA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CwkfvPPhXqUxcmtH/NqcEAaSLaeOCv8ncRUwPhfLWTHcLFGo3Yr0YuRKSY8hzy4MMXA2Oa+BMrOssKw3O4mn/ql7l3GTJrZlEHqe0mdy5Xkr0SpG7paPnHFIY3Lh5OwVM1QpTWtjbDPBpl8NgRDsEXJSwAyViIXOp2hjfxOfxHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dvEQKzHx; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP98A76014880;
	Mon, 25 Nov 2024 06:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=pEKfzssVGjT4ZBP3IaYmvZ6iNe4
	nDCmepCNLwlDUjzs=; b=dvEQKzHxLOhK7UuLRRb7F/GToWm1NZ0Lw4wev08vLTc
	UA58LOsQNT5Ohfog+8OSx2soGYy5MO6cQVUX0KcGHvS95HeftXcH3h+bgbv8/LMK
	FTg40Ou+YQWF84wJy9mHaOvj8xLpzRSUn7GKqOGj5IGkj28WdqJMjjH+09TpHN6z
	cQJL9OXEQl16mqFBd+Th0aDlFFKSJm14WYkXnissJRlHIZe1Qi8yHEZFh2/PAB9p
	p/cq0CsJBZRtUnTT/aHckpnsKaB0dKo1rDKTbZCQ66EO2UFChgfDp9tQk4BcjkRX
	AbBWO5O4BypnO83aIYgL8/bn1G4bvwBNJ0YVlA1SC0w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 434pbd0hm8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Nov 2024 06:26:57 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4APBQupN035533
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Nov 2024 06:26:56 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 25 Nov
 2024 06:26:56 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 25 Nov 2024 06:26:56 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.168])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4APBQnwd016096;
	Mon, 25 Nov 2024 06:26:51 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 0/2] Add ADF4371 Reference Doubler and Reference Divider
Date: Mon, 25 Nov 2024 13:26:39 +0200
Message-ID: <20241125112643.10459-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: gu6lj8nHjRvz2YbfeyJsBz7sH9UyDgNx
X-Proofpoint-ORIG-GUID: gu6lj8nHjRvz2YbfeyJsBz7sH9UyDgNx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=909 clxscore=1015 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250098

This patch series add support for for reference doubler block and reference
divide by 2 clock block within the ADF4371.

The doubler is useful for increasing the PFD comparison frequency which will
result in a noise performance of the system.

The reference divide by 2 divides the reference signal by 2,
resulting in a 50% duty cycle PFD frequency.

Both features were requested from customers that purchased hundreds of adf4371
parts to use in their project. They need a way to adjust these blocks either
from userspace or devicetree.

The patch series aims to both satisfy the customer needs and be compliant with
the current kernel. The devicetree approach was chosen since these kind of
features are already present in the mainline kernel for parts such as adf4350.

Antoniu Miclaus (2):
  dt-bindings: iio: adf4371: add rdiv2 and doubler
  iio: frequency: adf4371: add ref doubler and div2

 .../bindings/iio/frequency/adf4371.yaml       | 11 ++++++
 drivers/iio/frequency/adf4371.c               | 35 +++++++++++++++++--
 2 files changed, 44 insertions(+), 2 deletions(-)

-- 
2.47.0


