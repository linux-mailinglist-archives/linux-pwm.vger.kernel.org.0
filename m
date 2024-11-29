Return-Path: <linux-pwm+bounces-4159-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 057579DE98D
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 16:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BADDF282F24
	for <lists+linux-pwm@lfdr.de>; Fri, 29 Nov 2024 15:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B461474A2;
	Fri, 29 Nov 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CsXBu3NV"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F90E82D66;
	Fri, 29 Nov 2024 15:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732894465; cv=none; b=UxZCmwNuHOxmE7fxQ+eooCgDNsuZHZJALQIojPmC84y3VuAAKNZQqZxtSre58g+saHiG8IMe6oyTU4eFkL+VUmwfmzMzLAG3O3OP957OoL+z4cedctJ7cOxlkknBCPmmhCx3/8x1A7aatJwOKKNqntZ6bFmleuL+nzlYc+romzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732894465; c=relaxed/simple;
	bh=IJGxZkgoWTY7Wfw1SGyX0l4otEJwnl2iVbh8953L6i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iDRbU/QSh/GczJyZDs7x8Q0/D4OoJXufbkKlL47Q75XpjFWGn/E4P6q9+7dYCC1nMasM3yn753Ao7c/5yr8k2oC0bwAbdgfC4CHvoo8SHeIAb1e/qN0iTmaIYM6xpsqXj60gk2sElEmywxf6Hi+1NPNZ2QdTyMpj6fE9ecwIoyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CsXBu3NV; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ATF3Xcm014486;
	Fri, 29 Nov 2024 10:34:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=C4CHmsEhR6j8aMddpIlJLOsME+z
	8+iYUlRZC9fGZI8M=; b=CsXBu3NVjr50hX/gjoaDQXU12ZdOQ6+s89wvqM2xVtd
	7l9o71IC9cpG7Js13+/a54ocY8QMDnBQKW7JwR3HsmEXOgAvKAEbwgtnZMtW+Nua
	lO42Pskn3qVGLX89Cg/Bf396IpifcJsR13AVnZzbkWS/0wCWing6Sv7rTtN4mXzG
	AfPlSd5pHGELlSMB47D9Pb5oaZQ4UztDxKZpmfy4o6OSbyXl1KExmzgujjdshoxn
	JUMD0zVVoVsmtBmHeyRjAqN21LfGVsLS1C7GRnQYFBlG+h76IU9ZOFs0NE4tsV5I
	rZd/qJRAnRoK8cW7JkTflQFMPl/mfgc25nw4NiRRgHA==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 436716tmn2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 10:34:21 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ATFYKY4008695
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 29 Nov 2024 10:34:20 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 29 Nov 2024 10:34:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 29 Nov 2024 10:34:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.161])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ATFY6dj001089;
	Fri, 29 Nov 2024 10:34:12 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 0/2] Add ADF4371 Reference Doubler and Reference Divider
Date: Fri, 29 Nov 2024 17:33:51 +0200
Message-ID: <20241129153356.63547-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: Y9hiWc3R9eLnpeqdsTtZnybOsVLY16vT
X-Proofpoint-ORIG-GUID: Y9hiWc3R9eLnpeqdsTtZnybOsVLY16vT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=915 adultscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290127

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
 drivers/iio/frequency/adf4371.c               | 34 +++++++++++++++++--
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.47.1


