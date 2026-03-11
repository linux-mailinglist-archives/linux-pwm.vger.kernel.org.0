Return-Path: <linux-pwm+bounces-8223-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOmgAkS2sGlvmQIAu9opvQ
	(envelope-from <linux-pwm+bounces-8223-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:24:36 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 666CC259BF6
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 01:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51C893006B36
	for <lists+linux-pwm@lfdr.de>; Wed, 11 Mar 2026 00:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8A6327C00;
	Wed, 11 Mar 2026 00:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Budvsf16"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1B1684A4;
	Wed, 11 Mar 2026 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773188639; cv=none; b=fR/Q0jPe80Va/gVJM+hNZpn+7UKGjI+ytj5Aw6fx2DzM3PSWvGBF7If4M8238LK1ce+brnMvFgM7EgN01Kc41VfB1OiOlugKeTOH+i0RqhYZb5ASXw7ykZd6aO8sRL4It8KXDExxN+Wcf/mH8coqsZ820+Y+6ZrAuZqHg0f2Ywo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773188639; c=relaxed/simple;
	bh=RI7Y+NzuTz4/ZvZ/zc35Yv2tCf1ybPV3mQjEnjHhdis=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=r5OPeN8VQBNdLhEvWsBzCC1vZI2tFQcRxSYIKaXowjdPO1kCO5/3vUUGUsNaI+ZuqXKflogcT3tgiXq44F/iNWhELFL9VNp9jJ8z8WqboaqpwucsTWwyBREKhpdCzxZe21ADDREObX2ev6ygAzrrzlZ0oKWEK8CSMTo2gLNSRKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Budvsf16; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ANdwlk1139698;
	Tue, 10 Mar 2026 20:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=ZlPpDpun4T+5Dr7nrCGibGkXydm
	0OS0YCldEkDGEEyc=; b=Budvsf16alyRs2gcIEmksrsy2EUG9Xqte6bONIEpFwj
	XOjsL7jSAf5jF5bIYahbHRbD2SgS1zbG+d7ZL/qbKDoYpUWp0qJS4BptrEmBoOfX
	Ng+3QKixd0Nglb3FD/NKUBtcU0MS1h0L6sGIFbGAxE0ZK5aciJv3B9fLE72fmAvG
	BnN6k/rJW2SiBpiOUHJUGRhPJEa0JbjhClMdZpJ9Wpt34pI7Y6yLJR9pv838ploA
	4TdIw+Ywbqhh4TX7YsUU1qb54IgEnHUto/WoNnrjELdnByJVobZr8tO5ba9SOvZW
	q7XI7ssLZgszI7/W54anMlu04NysqQQHDMUGljZAAzA==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ctw6284c9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 20:23:36 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62B0NZ0R036265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Mar 2026 20:23:35 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Mar 2026 20:23:35 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 10 Mar 2026 20:23:35 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 10 Mar 2026 20:23:35 -0400
Received: from ATORRENO-L02.ad.analog.com (ATORRENO-L02.ad.analog.com [10.118.4.140])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62B0NJkN015383;
	Tue, 10 Mar 2026 20:23:22 -0400
From: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
Subject: [PATCH v2 0/3] Add support for AD5706R DAC
Date: Wed, 11 Mar 2026 08:23:16 +0800
Message-ID: <20260311-dev_ad5706r-v2-0-f367063dbd1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPS1sGkC/23MQQ7CIBCF4as0sxYzjLa0rryHaQyUsSVRMGCIp
 uHuYtcu/5e8b4XE0XGCU7NC5OySC74G7RqYFu1nFs7WBkLqkAiF5XzVtlXYRUESW5bW0qAN1Mc
 z8s29N+0y1l5ceoX42fAsf+t/J0uBQlF7MMaqY98PZ+31Pcz7KTxgLKV8Aa8je7SnAAAA
X-Change-ID: 20260220-dev_ad5706r-2105e1dd29ab
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
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
        "Alexis Czezar
 Torreno" <alexisczezar.torreno@analog.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773188600; l=2598;
 i=alexisczezar.torreno@analog.com; s=20250213; h=from:subject:message-id;
 bh=RI7Y+NzuTz4/ZvZ/zc35Yv2tCf1ybPV3mQjEnjHhdis=;
 b=kO0fO+4zQSLPkV/yhEyS1HMA+N4AeReYvjlwn1BulElEhTARoGGsMYBWw38UNeIywGh7dnkzt
 ccec5OZ8iETCF/qoTNLpgANsVIQPZ0cfxxvhW8LdfnmzyBCC0MymjUp
X-Developer-Key: i=alexisczezar.torreno@analog.com; a=ed25519;
 pk=XpXmJnRjnsKdDil6YpOlj9+44S+XYXVFnxvkbmaZ+10=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: fUX9IEgoZtVgbYD0MZO0lRGcKyLhIPGW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAwMSBTYWx0ZWRfX4FIg5wZjwToA
 QoeSdDnR3Idc1112OdbJJjVbcbt7PjP1kisaigVt1btDCvqqoWF1NnhKiAvbc4SUy54RrTvKdDh
 4RRo9eQdPiWoYDFJBtsFcPOgTJ2UFXQ94BifI8ZBNvtEDvuzuRZi3ep+x56aOgDVWeldnDrNtdy
 tH5xYo7CHBDQ9nEiY1iCFhyZuq4q01B36k5zknD/Pjc1gMvTaI77A1WAH0yq9jIEOo9ReZV0Rw6
 8c3ast3Vh6EzAgHaxsDL4xp7CPKtHV4JO43KuneQ+nX7dOuGJyCUZdd1nLUncs6IxT6fy99GIYq
 14HnPns64zt+BLp6rHBrH7WRSGSjTpvC8xwSUxN6BSzdWee9Pe0FMxUQBty9YZtalQ2OizN8Aq/
 ONI+ATrAKTjhRoaDGWIfiRgM7uJvuUOZTmT+igmkuEjJC2+lL+CN5yNT1hpMQKseTaaxkxHXzED
 +zIciEUtOsapckv2hzQ==
X-Authority-Analysis: v=2.4 cv=P/g3RyAu c=1 sm=1 tr=0 ts=69b0b608 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=VwQbUJbxAAAA:8 a=lAPpY2re-nV465j7mocA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: fUX9IEgoZtVgbYD0MZO0lRGcKyLhIPGW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110001
X-Rspamd-Queue-Id: 666CC259BF6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8223-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,analog.com:email,analog.com:url,analog.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alexisczezar.torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	RCVD_COUNT_SEVEN(0.00)[10]
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
Changes in v2:
- Stripped driver down to basic DAC functionality (read/write raw,
  read-only scale) as suggested.
- Removed PWM (LDAC), GPIO (reset/shutdown), clock generator,
  SPI engine frequency switching, debugfs streaming, and all
  custom ext_info sysfs attributes
- Removed regmap, IIO_BUFFER, and iio/sysfs.h dependencies
- Simplified SPI read/write to use standard spi_sync_transfer
  without clock mode logic
- Scale reports default 50mA range as read-only using
  IIO_VAL_FRACTIONAL_LOG2; writable range selection deferred
  to future follow-up series
- Simplified DT binding to only require compatible, reg, and
  spi-max-frequency
- Link to v1: https://lore.kernel.org/r/20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com

---
Alexis Czezar Torreno (3):
      dt-bindings: iio: dac: Add binding for AD5706R
      iio: dac: ad5706r: Add support for AD5706R DAC
      MAINTAINERS: Add entry for AD5706R DAC driver

 .../devicetree/bindings/iio/dac/adi,ad5706r.yaml   |  48 +++++
 MAINTAINERS                                        |   8 +
 drivers/iio/dac/Kconfig                            |  10 +
 drivers/iio/dac/Makefile                           |   1 +
 drivers/iio/dac/ad5706r.c                          | 208 +++++++++++++++++++++
 5 files changed, 275 insertions(+)
---
base-commit: 3674f3ca92730d9a07b42b311f1337d83c4d5605
change-id: 20260220-dev_ad5706r-2105e1dd29ab

Best regards,
-- 
Alexis Czezar Torreno <alexisczezar.torreno@analog.com>


