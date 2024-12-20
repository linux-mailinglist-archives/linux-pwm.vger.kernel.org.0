Return-Path: <linux-pwm+bounces-4416-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60E9F8F6F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 10:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39ED21897559
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Dec 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603D21BC073;
	Fri, 20 Dec 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VfM+/K4F"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DA1AA1F4;
	Fri, 20 Dec 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734688602; cv=none; b=MjYxdIH+ok66xYpfvCJq+WsdcdG5ltjiURKMQA8wFFruEyRfiiar9JdKZQh3NBv4rEND/5tZwubGMVVRb0fdbLmdMc6eGHyDlXv1Yz+Rc6gfvvjM6sPP/m35mL5aa1OpqiZGA2n9U7CNHCVFdbxfz98U1arZZ/IlPZbm8fy2RKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734688602; c=relaxed/simple;
	bh=h70jEkjwDWoMMWgwpubkSckWpzRGWO+REXBSil5mb8E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SPR6Jkq2HMzwUkSfFF/qy23KBHbJmfhg3zDtvadyLHkD09kbZvYZneH5mCTA+t5yUXNrv7d9cZ23DKJn5JqsWUdvLXF6Gwv4z9Y+D6CtphQWs44CqEjuHX2Q+Kl5JJ78fHJRPAwKUPn0HOf2D0/NkDJ7unVvqkGueaoNJCPrv34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VfM+/K4F; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BK8i79w014094;
	Fri, 20 Dec 2024 04:56:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=g9ViHUI+OVFBQSue1RmTlAEXr1i
	ICB3gG0ilQTSt53E=; b=VfM+/K4F+VwtTrxMw+l8qrZlqrO/tl3ugmOEmhz9iiq
	T0aUx7j410FlMDcQI0W1n3RDumjGxIhR/xFkF7wQe0d/wTgIlrOw5UcWQGuHKEm6
	WrdBYYl5S1l49XtWWKE4M59GtU5dig+bn4FsMIJW1yNM3F/cHUmLtAgUGUvrDiCO
	/L63RH2zvLshxN3QYdArQESc+yDO1G+6Exe2gWrgLpJdkXDL8hwYK741dE07qWqS
	D6GWnPF7LtufhGO9F0ibq7A/iIwy849XG02drD/L2mCjswrDPVL5uc/JhaseqYU7
	cfEvROpMQRDXZd8MwRWeZ+qCmB68OuJwXwj/W53SnAg==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 43n5b589by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Dec 2024 04:56:37 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 4BK9uadH002452
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Dec 2024 04:56:36 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:36 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 20 Dec 2024 04:56:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 20 Dec 2024 04:56:36 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.133])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4BK9uROU023622;
	Fri, 20 Dec 2024 04:56:29 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/3] ADF4371 refin mode and doubler support
Date: Fri, 20 Dec 2024 11:56:12 +0200
Message-ID: <20241220095620.4918-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: n4TAAU2UetccHrS3yXVIVWnMjQ-YukFG
X-Proofpoint-ORIG-GUID: n4TAAU2UetccHrS3yXVIVWnMjQ-YukFG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=962 malwarescore=0 impostorscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412200081

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

 .../bindings/iio/frequency/adf4371.yaml       |  7 ++++
 drivers/iio/frequency/adf4371.c               | 38 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.47.1


