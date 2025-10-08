Return-Path: <linux-pwm+bounces-7401-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDABDBC5449
	for <lists+linux-pwm@lfdr.de>; Wed, 08 Oct 2025 15:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A845351C07
	for <lists+linux-pwm@lfdr.de>; Wed,  8 Oct 2025 13:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA1328724D;
	Wed,  8 Oct 2025 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YIDEM6bE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C173182866;
	Wed,  8 Oct 2025 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931413; cv=none; b=Ht8BIVakMRUJsX37Rye3ppUBPTM575zhIbLQwGTkKv5LUJ8aUmlKDhXUgjRK6FMxqcXtFqIOlHnJ7KWmc1HfA/sDuzxCRsCJxCFbpuV0W0XOdiaxTSizyCk6spG/xy36LD6axVQNMcrbplj9gZItiDbZ0eQ2RPjmnpS7agRJ/wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931413; c=relaxed/simple;
	bh=mt6mk92G8Wp/LF9LoiJvv23Qnl+30b3PYrh3xYovCOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iG4lIz5AUIP8d8GrstAlLajjbkWnFSGukFv44gtAIkkLmmsra1nia+/oKbjfND4IpvEw3b2TTwRNqHHN8yZ86prk+rb51daeeuVAZRTPLIoSQScp3qObyoatZWOkEkcD7UgHnQQpp4lkCYp9iIoA2hmAkPOwkd/nx38OaLioAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YIDEM6bE; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 598DhLUD027014;
	Wed, 8 Oct 2025 09:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IuAEW
	CIZinH7WwhYHqYfX3yHq02iuYjqR8hz5gpwK5w=; b=YIDEM6bEAFXi4w5jHl3D0
	SXszt+KdbQNqDbLkDpKrzPKonmBcV/lAMB5wRhMxJCfkBA1INP6btxi3m3a5HwWr
	oB1eiPb3SqzsSPQcXp/pkck/L3MUSgxm90/Pv3+OKZv1v3ZkLluOHtWK8Xc93bqQ
	ZdpXvdlR196UXgzJOZYn54pDYxt3xoqM1ZAHZVLIwlVsRtHKvYo7iKFY7T8aa++X
	FzR+W82SWq8xHDLjjARUQcUhtNscQ3aAbnYqc95iQG2t8bkvY95m3klg6ovlmEoy
	jk+3W8v65YcxFy4AFavAPkLXeFyIZlLtBO0mKlM+YVWqKAAoWY3wxWOnfQY8J0ZN
	w==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 49ndssugg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Oct 2025 09:50:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 598Do1pm034447
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 8 Oct 2025 09:50:01 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:50:01 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 8 Oct 2025 09:50:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 8 Oct 2025 09:50:01 -0400
Received: from work.ad.analog.com (HYB-hERzalRezfV.ad.analog.com [10.65.205.9])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 598DnjCv023104;
	Wed, 8 Oct 2025 09:49:47 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <ukleinek@kernel.org>, <michael.hennerich@analog.com>,
        <nuno.sa@analog.com>, <eblanc@baylibre.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <corbet@lwn.net>, <marcelo.schmitt1@gmail.com>,
        "kernel test robot" <lkp@intel.com>
Subject: [PATCH v4 1/8] pwm: Declare waveform stubs for when PWM is not reachable
Date: Wed, 8 Oct 2025 10:49:44 -0300
Message-ID: <129ff5c5b7f7be4f4f3f9cf8aa3e1957d713acb7.1759929814.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1759929814.git.marcelo.schmitt@analog.com>
References: <cover.1759929814.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDAwNCBTYWx0ZWRfXwTOj6bstowOt
 XY1ZKaaJ/bn9N54YTNBwVHv+Jxgl0t6VKNnNjKYdyV/xRrwtp9dd5axGfndCvljxQEXJKN4DYEU
 /HkOfY4N/+pguK1Co/CKO3ty5X5ydOKvKO7Jmh8EZmyJOHM/XZESIX7wEwjHw7UBVtUv9f3kmy3
 XmtIP3BSy+gZstvmMnltNnqMKWfN/epvzsfXEz9szsjIP8E9K1u9Y67kpgkWgJoZe55+2okFPip
 ZiFH9O64NR/GdwlIooz3e2/JM4GiogZegXEyemk5OU34Tx/nwQUOsQ7b5sFjF3Tx3H4+uClb7tS
 yJnLeXa84z7EugQGe/sKf+x3G/CSnMXnEYvajc+HPFpsItW3i95m9i/i6iDM8AcDQRuprkjXpaC
 zW7aUQyCW57ldMLEexyH/DdCI9uZSA==
X-Proofpoint-ORIG-GUID: fvzaIIYYuTt2bSUnMeuFDQE_JXvRxcwL
X-Proofpoint-GUID: fvzaIIYYuTt2bSUnMeuFDQE_JXvRxcwL
X-Authority-Analysis: v=2.4 cv=e4ELiKp/ c=1 sm=1 tr=0 ts=68e66c0a cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=EaJPzwpAO8ApEi7CHwMA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_04,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080004

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
I've included this patch in this series because it should save us from being
notified by 0-day about the build failure this patch fixes. From contributor's
perspective, it's easier to have this patch together with the rest of ad4030
series. Though, no objection if kernel maintainers decide to pick it [1] through
the PWM tree.

[1]: https://lore.kernel.org/linux-pwm/1ac0fc529e02744aacfcb9140ed597ff60886f39.1759873890.git.marcelo.schmitt@analog.com/

Thanks,
Marcelo

 include/linux/pwm.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/pwm.h b/include/linux/pwm.h
index 8cafc483db53..e79545c0cb89 100644
--- a/include/linux/pwm.h
+++ b/include/linux/pwm.h
@@ -501,6 +501,25 @@ struct pwm_device *devm_fwnode_pwm_get(struct device *dev,
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
-- 
2.39.2


