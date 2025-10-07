Return-Path: <linux-pwm+bounces-7395-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC01ABC2DAD
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 00:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCD7219A2DA1
	for <lists+linux-pwm@lfdr.de>; Tue,  7 Oct 2025 22:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A4F2080C8;
	Tue,  7 Oct 2025 22:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="hSqn9pR+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F721F63FF;
	Tue,  7 Oct 2025 22:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759875607; cv=none; b=c8J8yqH0R/K7xwErnUdn6iZ5TgVKlQCfs45vlRp6XXMWAf4FwXbV432kHEhAgRUV5qypz5MZ6FXYMre8LWJ2DZ0RLmOBAFo6Tpeb90QficN7n1UeqCbYvfqzKdTLGwLmls10s9l0EdbarazwwRIASlWcZ8g3E49vOzW2F8M4PiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759875607; c=relaxed/simple;
	bh=1RtDq0A1RZWwZjHU/cddoxGAZzdiIWeIfbGDh4YzFq4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ON+F4qXtF075dVlFOnXznWSyajCXDJ43VNCtrqmWeEdEBTW8Cttcur4Jkw7luo++fOCftTDU/LZPY8S5Zwr8tzi5bL3+tMxUZaKl6tJ1h0YdTDrqF0xRQ11fveIfrye+2pPtWRzRzTZZ/3FMepcgeUwymADIo9l7U4T9p48kGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=hSqn9pR+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597IUbpj010572;
	Tue, 7 Oct 2025 18:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=5bylmLC2D9Sq8ZZnNilvP3JpPRe
	J0dKy7HvUGEtpDsI=; b=hSqn9pR+WMbsm3D8tGlsSOBHtBSO2jtYM2msplrP0ud
	arv0Vyk9JlWvK2TVh/wC4El5nvcLWWRLPBDqAXpt1kQ/NC/1MaYZJNVcLy0ufzUm
	JYdAqMxIXy4pbjpNxJI2ejaF9wQApxXHYztXQsxxIACM4aLXtrBZVBXxEeh3F+PW
	CTLdwPp6lbhKzG6PAhThLHl/AKNb48vcgnjKmZ60T/JSpx1Es6MOHAX4827fC5PM
	dYJQpAN8PZUSi+NcR4hQBXv5Bjrmz2h2s3OE0aIexe4VIPInRfWKxmXL/UKGsVPQ
	nzRT/2Rp+jaKyBLf1CY2Q8dBwuHLmQr2Xuv4tQqX7vQ==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49jwe22pcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Oct 2025 18:19:50 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 597MJmH5049657
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 7 Oct 2025 18:19:48 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 7 Oct
 2025 18:19:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 7 Oct 2025 18:19:48 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 597MJcTP020093;
	Tue, 7 Oct 2025 18:19:41 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <jic23@kernel.org>, <marcelo.schmitt1@gmail.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] pwm: Declare waveform stubs for when PWM is not reachable
Date: Tue, 7 Oct 2025 19:19:38 -0300
Message-ID: <1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=Y7n1cxeN c=1 sm=1 tr=0 ts=68e59206 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=umOawDddDieID1hGUK0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Nw-7FBRIa7Sn_OZS7Y_NPGODW2hMG3pr
X-Proofpoint-ORIG-GUID: Nw-7FBRIa7Sn_OZS7Y_NPGODW2hMG3pr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA0MyBTYWx0ZWRfX+M8Z4c3DG243
 35MMGlQGbYldZTx26B3epmnZVa2KoLPWdsXwhzza8/NeRUO/zYlecf0PebG51faJRwqgKrNub0K
 bPN3QYkNICiF4JmSZ927+JNd55SN/JhyTZPX8Ivd5iJLwhI6WM2TW011z9fAMRiwe9n4ZueK9IZ
 YRtYmb3Nm2x+sjigc6O+Tqb39gzVoPp8fBsB5R2rEo8MBSTNbOUDcLyoupoxCbC0zoFUtOYuqEg
 OquKQJkutlrRYtBJjOp9EYQ09cJ9dnkj0T0jp1XZlr+ZAa5Fa5GjZD12MJbFEczV7slbPK70soJ
 SRooWLlOaF3VHlJ0YDmoL18JsYVm31mv6oCerBdDYkd6QhgnuOW/kU2f4586CvlR8I61c0MoIJ/
 bSL3ZV1yWPgbPAFi0mMXEgi7DCpgtg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 adultscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040043

Previously, the PWM waveform consumer API would not be declared if
CONFIG_PWM was not reachable. That caused kernel builds to fail if a
consumer driver was enabled but PWM disabled. Add stubs for PWM waveform
functions so client drivers that use, but don't depend on PWM, can build if
PWM is disabled.

Fixes: 6c5126c6406d ("pwm: Provide new consumer API functions for waveforms")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509272028.0zLNiR5w-lkp@intel.com/
Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Cc: Jonathan Cameron <jic23@kernel.org>
Hi Uwe,

This is a fix based on a report from 0-day bot [1].
We need this for a sophisticated IIO device that makes direct use of a PWM
waveform (in addition to indirect use of PWM through SPI_OFFLOAD_TRIGGER_PWM). 
I'm not very familiar with the details of how it works for series of
patches that update multiple subsystems. Documentation says such sets may go
through the -mm tree. Though, this is a small change and the consumer driver set
depends on it. Would it be okay if this gets picked up through Jonathan's IIO tree?

[1]: https://lore.kernel.org/linux-iio/202509272028.0zLNiR5w-lkp@intel.com/

Thanks,
Marcelo

 include/linux/pwm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 549ac4aaad59..a20ddc40a32a 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -504,6 +504,25 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
 				       struct fwnode_handle *fwnode,
 				       const char *con_id);
 #else
+static inline int pwm_round_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
+{
+	might_sleep();
+	return -EOPNOTSUPP;
+}
+
+static inline int pwm_get_waveform_might_sleep(struct pwm_device *pwm, struct pwm_waveform *wf)
+{
+	might_sleep();
+	return -EOPNOTSUPP;
+}
+
+static inline int pwm_set_waveform_might_sleep(struct pwm_device *pwm,
+					       const struct pwm_waveform *wf, bool exact)
+{
+	might_sleep();
+	return -EOPNOTSUPP;
+}
+
 static inline bool pwm_might_sleep(struct pwm_device *pwm)
 {
 	return true;

base-commit: 8f2689f194b8d1bff41150ae316abdfccf191309
-- 
2.39.2


