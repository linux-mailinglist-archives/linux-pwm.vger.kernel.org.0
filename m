Return-Path: <linux-pwm+bounces-4227-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BC99E4A6E
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 01:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCA1283E42
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Dec 2024 00:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EE0F4ED;
	Thu,  5 Dec 2024 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="RgdLtt4a"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A52B11185
	for <linux-pwm@vger.kernel.org>; Thu,  5 Dec 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733357479; cv=none; b=AoTX/zBuDH37F3dTEHBveEpzUQapMQOdWEVOAzOHYR+MnSh180BNLJB8fEADpI2H7VW2FcV5EK6pH01/c03f0nzcsqFCthjDEZXNplJHdgIgRvs6I3gii/3hcq6OQ946krUllWM2/WzK7gyHSlIm0bi4JA+MF2zU6LLzeYSzE2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733357479; c=relaxed/simple;
	bh=bVxN+FZOfleQVmg6RLp1YA7VWhpbCqAopfI4NI1NFnA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pAWWtXi4T877QznBmx+wBeSJS99Fj9ASc+e9/u4kSvAwqcc+6ljmXy4HYzLZR3ssDYx69lp3wB7sgT1rdTv7y51iZIJXKavJ2RvfHTwCmBxP+FFGiATBGo3s6wkNSb3x8B24vjyiVtwunYgEbs+OVkQHjgnNbnh3O7pC7irHtGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=RgdLtt4a; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1733357475;
	bh=DunB/Cza6j0J9yIEJF1/KVIA9ohiToydy/mrGuBe+NA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=RgdLtt4aFUOiBVmeQIiZeK+R6ebchgvxS1CGK9QWDm4fi6XycK0YPKcDXkKNxrZr5
	 +xtKJ6H39Xui76oDfpCSXqE4tOoHj+7JRKbj4DGFJPikLBsnyakQ3Xyf+JLqlKC7CK
	 1iPow4BKS8sS9bw1x59FVLT9xfEl3k+Mc0/6jz5b7NLkO/DmqJqcNFgQu0wVbjwsXU
	 Vez16J5yD5UiaIoqpK2YdcUIWiYXCDQsuTIMOmqYqY4Eo8Zr6SReR+T8g09hoZ3KNz
	 oiPm9MB2Q+TBtqrBbITTNRuqKFrVD/luXwZshbq8FNuVBnC76FT2njYcWtNu+JfgdE
	 cxzKF4ATBNsmQ==
Received: from [192.168.1.26] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id BC22B80026F;
	Thu,  5 Dec 2024 00:11:03 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Thu, 05 Dec 2024 08:10:10 +0800
Subject: [PATCH v3 01/11] libnvdimm: Simplify nd_namespace_store()
 implementation
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241205-const_dfc_done-v3-1-1611f1486b5a@quicinc.com>
References: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
In-Reply-To: <20241205-const_dfc_done-v3-0-1611f1486b5a@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Zijun Hu <zijun_hu@icloud.com>, linux-kernel@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-sound@vger.kernel.org, 
 sparclinux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-cxl@vger.kernel.org, linux1394-devel@lists.sourceforge.net, 
 arm-scmi@vger.kernel.org, linux-efi@vger.kernel.org, 
 linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-mediatek@lists.infradead.org, linux-hwmon@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-remoteproc@vger.kernel.org, linux-scsi@vger.kernel.org, 
 open-iscsi@googlegroups.com, linux-usb@vger.kernel.org, 
 linux-serial@vger.kernel.org, netdev@vger.kernel.org, 
 Zijun Hu <quic_zijuhu@quicinc.com>
X-Mailer: b4 0.14.2
X-Proofpoint-ORIG-GUID: jHlIOqjc_AeZK-9ZUrdqIW7FkzMuYDHV
X-Proofpoint-GUID: jHlIOqjc_AeZK-9ZUrdqIW7FkzMuYDHV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-04_19,2024-12-04_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 spamscore=0 mlxlogscore=902 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2308100000 definitions=main-2412040186
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

Simplify nd_namespace_store() implementation by device_find_child_by_name()

Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/nvdimm/claim.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/nvdimm/claim.c b/drivers/nvdimm/claim.c
index 030dbde6b0882050c90fb8db106ec15b1baef7ca..9e84ab411564f9d5e7ceb687c6491562564552e3 100644
--- a/drivers/nvdimm/claim.c
+++ b/drivers/nvdimm/claim.c
@@ -67,13 +67,6 @@ bool nd_attach_ndns(struct device *dev, struct nd_namespace_common *attach,
 	return claimed;
 }
 
-static int namespace_match(struct device *dev, void *data)
-{
-	char *name = data;
-
-	return strcmp(name, dev_name(dev)) == 0;
-}
-
 static bool is_idle(struct device *dev, struct nd_namespace_common *ndns)
 {
 	struct nd_region *nd_region = to_nd_region(dev->parent);
@@ -168,7 +161,7 @@ ssize_t nd_namespace_store(struct device *dev,
 		goto out;
 	}
 
-	found = device_find_child(dev->parent, name, namespace_match);
+	found = device_find_child_by_name(dev->parent, name);
 	if (!found) {
 		dev_dbg(dev, "'%s' not found under %s\n", name,
 				dev_name(dev->parent));

-- 
2.34.1


