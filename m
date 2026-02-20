Return-Path: <linux-pwm+bounces-8127-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNPaOF4VmGki/wIAu9opvQ
	(envelope-from <linux-pwm+bounces-8127-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:03:42 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3AA165780
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 09:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CED383019528
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Feb 2026 08:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BBC334C2B;
	Fri, 20 Feb 2026 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CnDtwPMs"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1652BD030;
	Fri, 20 Feb 2026 08:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771574619; cv=none; b=bHse+eaNTg9Txw0WEaxzxCKe80HYZ+O48tMASykkBLUv6U2nIVZBUXbaP2CJdpF0vQd5OXYGYkzPER7SCoqrX77y/+OQhYp/VDLBFKvJ/agubHMTf+cGRAKVwCPzZHk1KLYLEvBxGjiv222tC+Himx6nlQzGTERof5dvYQGCfjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771574619; c=relaxed/simple;
	bh=rdg+WvcgTHwxUToTjGpltcYnTxEuM/c3FCcFSm3cDnk=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=HKxth+956K04jwj6KeM0bg4A+73ZFRidlc6HvVZIhMSxCiF3IXwyXi0tk7b9ko+e8Abhf/8JyKU1kDhM0A5X2PS/oR+LfmDVkaqVtSS8hU9pXV3Db9m0qXas88bY1Q4JdjIrQ7F1WDq3i8utcnJWHR0Y/imNPIg/D1Awen/XrAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CnDtwPMs; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61K7fOGq1910533;
	Fri, 20 Feb 2026 03:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=sFUKuEAOGg/8VS3rJA6dd7J2jAL
	azPjOuX2xUKFhSUY=; b=CnDtwPMsTZFo4J6YbUD0naZT5hsafnicgSpVFNaXwf6
	NzGs4vLlanoQTA9Aa+lS4053bv3/4neg/l1TMsLk9ZfW/sjPvwZWz1PBUILPDizy
	YxIkt27i3hfCMNQZzK1eXz41FYZySid0IBBT3aqUGu5iKVO5yqdCO02cJYLtwzFm
	bWR74zj0UpR9fVEqRh5FW2Zy0wqo23LrNnYvBDo1T2Fz0LKwEkJHhf/C36Bebyv+
	yQ5Tf7fqeqEWRfcc/PoK26PlZCWd0nOcrhAKB4aL4zkY8hlolq3CsXH90VPLjkQa
	f0dFWMaFkZvRRV34PcUF+mw5GcjprydReDl4DAppQ8w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cdanw91wy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 03:03:13 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 61K83CEs028659
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 20 Feb 2026 03:03:12 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 20 Feb
 2026 03:03:12 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 20 Feb 2026 03:03:12 -0500
Received: from ATORRENO-L02.ad.analog.com (GGONZAL4-D01.ad.analog.com [10.116.20.162] (may be forged))
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 61K82vY7007405;
	Fri, 20 Feb 2026 03:03:00 -0500
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH 0/3] Add support for AD5706R DAC
Date: Fri, 20 Feb 2026 16:02:55 +0800
Message-ID: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8VmGkC/x3MMQqAMAxA0atIZgtpoIpeRUSqiZpFJYUiiHe3O
 L7h/weSmEqCvnrAJGvS8yjwdQXLHo9NnHIxEFKDROhY8hQ5tNiYI49BPDN1cYZSXCar3v9tGN/
 3A180FJldAAAA
X-Change-ID: 20260220-dev_ad5706r-2105e1dd29ab
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        =?utf-8?q?Nuno_S=C3=A1?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        Alexis Czezar
 Torreno <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771574577; l=1841;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=rdg+WvcgTHwxUToTjGpltcYnTxEuM/c3FCcFSm3cDnk=;
 b=cRdinfDPtaEoRKt0Ufrhq2x8CY96MBDKvkVXajBYiRwqEExspdJI/EO6lvAUeowqmX9zBgqAY
 MsH/v+kcYEVBJMv1D03vAyrbi4sRMM493fXIveoqCDLPNJBE4zJ+GjA
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDA2OCBTYWx0ZWRfX/3GCuQBSoE1v
 js1wAG+zcHVseyuYAxSXFog+Iu8vyDdCjCTuUj8CFGB2UJ8vXf3shoAmCUENIbbxZYefpSGhISv
 sSz9D6AWqT4Xc0VpBVeeWvCPRMG1LPQHpZddOq7rdIjUakqilzMace58MJIXRBE83qMvDSLWAG0
 0487IBVR2RjIJqK1+b/ES+qOLKEmGSN6CUKnIyDbcCJM/MMH9yZq+Te3uNcDDNrSuFMvaYYNhng
 /NNR8pjKI0AXueI5FDVcUvC+rowSLx+Rn/I3oTUvB8bbsls69ExKksYNgttCzX0l90JA3yzuyRN
 813RdEZ6v9wuMKF2rCez4/jbJTxm4IWIIvpfy2Z1xZsGTW1RpuzrQ6MFRMBKzso4N3QSTYvBpjL
 SRQBlTakKt23U214HO3dPP0vT4NGgcsntH2rIS8OKNOHZb50o/h5RLrzFo6iHF635TPIu1QLsOB
 sG4f4IvmdahOwENuebw==
X-Authority-Analysis: v=2.4 cv=TtvrRTXh c=1 sm=1 tr=0 ts=69981541 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=gAnH3GRIAAAA:8
 a=pX8K7AMcFWmkIJv9s54A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y7SwsgOBMjTq7kYRzm6AYRQMxg98CNPL
X-Proofpoint-ORIG-GUID: Y7SwsgOBMjTq7kYRzm6AYRQMxg98CNPL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_06,2026-02-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 clxscore=1011 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200068
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8127-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:mid,analog.com:dkim,analog.com:url,analog.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3C3AA165780
X-Rspamd-Action: no action

This series adds support for the Analog Devices AD5706R, a 4-channel
16-bit current output digital-to-analog converter with SPI interface.

The AD5706R features:
  - 4 independent current output DAC channels
  - Configurable output ranges (50mA, 150mA, 200mA, 300mA)
  - Hardware and software LDAC trigger with configurable edge selection
  - Toggle and dither modes per channel
  - Internal or external voltage reference selection
  - PWM-controlled LDAC
  - Dynamic change SPI speed

The driver exposes standard IIO raw/scale/offset channel attributes for
DAC output control, sampling frequency for PWM-based LDAC timing, and
extended attributes for device configuration including output range
selection, trigger mode, and multiplexer output.

This driver is developed and tested on the Cora Z7S platform using
the AXI SPI Engine and AXI CLKGEN IP cores. The 'clocks' property
enables dynamic SPI clock rate management via the CLKGEN.

Datasheet: https://www.analog.com/en/products/ad5706r.html

Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
---
Alexis Czezar Torreno (3):
      dt-bindings: iio: dac: Add binding for AD5706R
      iio: dac: ad5706r: Add support for AD5706R DAC
      MAINTAINERS: Add entry for AD5706R DAC driver

 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   |   96 +
 MAINTAINERS                                        |    8 +
 drivers/iio/dac/Kconfig                            |   11 +
 drivers/iio/dac/Makefile                           |    1 +
 drivers/iio/dac/ad5706r.c                          | 2290 ++++++++++++++++++++
 5 files changed, 2406 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


