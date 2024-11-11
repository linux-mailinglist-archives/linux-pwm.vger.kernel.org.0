Return-Path: <linux-pwm+bounces-4056-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDB89C3E17
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 13:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9197B22388
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Nov 2024 12:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD9419D060;
	Mon, 11 Nov 2024 12:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="m/CVh7iW"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B50A19C569;
	Mon, 11 Nov 2024 12:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731327153; cv=none; b=XKiM/jkA8DqS8amd2b9bnLWuiKTiK5wvuBCzZz6cQ8eO9K0ZraWG9poTaHnAy4etHXnadYKu7REvY8e9hmMh188+RfYK2ZGoTh5NceNDTXTnx/NK3v4Bi6IHLva6xptvu/Nsw8Cba9PSeBbTaY+HAaHnojipGwJspXVxwJ2m4So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731327153; c=relaxed/simple;
	bh=Zljfv92krEPvd9pBshB3SSyFBSh2rKBlbOMEX0xCtTw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dghFV60lkNVm4sJtaBJx3KED1lOGizIVSHD3mtp8qIenLmos2i13B9satoY6Xqnk036xqQM1oECrlelbB/yAzDXi2C72c5+OyC09Gry4omyB465OqoQqhn7YlidB8ZdWcaAHeuM+u5o8y1PEhL0OTTqn8n7vYjy0XcvSpmA4TWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=m/CVh7iW; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB8p5gN016099;
	Mon, 11 Nov 2024 07:12:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=DomZdjxDJxOIJzigVdyuwK3ZEyR
	ZY4e/zacRd1lbIHs=; b=m/CVh7iW0BX8V1xgTVBT7qS99wfvprxbM3IKvQn+XEE
	XxH6XFLOyiidbAdohQATl4z4vczxBnPaXP08bsQLaDHSpLxf4UCP5VDWIuGsEV67
	f/OdJk1BMWLCQ+7wmtxYrVe+o40Tm115TYphfRWuW7bmbnbNHWf66FNdtXMFzhvS
	Sg2zmdbygFfAG6+ysV1HVjWyok6INkesGagZR7l69tmF4Gt0qugegY9mLauT3oqt
	L/GBhjwlRLHbGQS0156ZiAwGh5U8G+D/8QrfDdLvpovKm4iJpQfd3aCiYI/VMQ01
	fbKNdN0w4qnW/8B/5BB16ZWua4TbH1Wb9arw3OUxEpQ==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 42uesdgr95-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 07:12:27 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 4ABCCQi1025098
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 11 Nov 2024 07:12:26 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Mon, 11 Nov
 2024 07:12:26 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 11 Nov 2024 07:12:26 -0500
Received: from amiclaus-VirtualBox.ad.analog.com ([10.65.36.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 4ABCCFEJ010000;
	Mon, 11 Nov 2024 07:12:18 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: <jic23@kernel.org>, <robh@kernel.org>, <conor+dt@kernel.org>,
        <dlechner@baylibre.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC: Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 0/8] *** Add support for AD485x DAS Family ***
Date: Mon, 11 Nov 2024 14:11:55 +0200
Message-ID: <20241111121203.3699-1-antoniu.miclaus@analog.com>
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
X-Proofpoint-GUID: MZ4n5VYq51pabZOT0SiY6rk7EmEnJzj2
X-Proofpoint-ORIG-GUID: MZ4n5VYq51pabZOT0SiY6rk7EmEnJzj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110101

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

 .../bindings/iio/adc/adi,ad4851.yaml          |  103 ++
 drivers/iio/adc/Kconfig                       |   13 +
 drivers/iio/adc/Makefile                      |    1 +
 drivers/iio/adc/ad4851.c                      | 1190 +++++++++++++++++
 drivers/iio/adc/adi-axi-adc.c                 |   63 +
 drivers/iio/industrialio-backend.c            |   59 +
 include/linux/iio/backend.h                   |   17 +
 7 files changed, 1446 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad4851.yaml
 create mode 100644 drivers/iio/adc/ad4851.c

-- 
2.47.0


