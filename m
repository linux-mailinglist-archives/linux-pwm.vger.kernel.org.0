Return-Path: <linux-pwm+bounces-4506-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9979FBE36
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 14:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69520166E56
	for <lists+linux-pwm@lfdr.de>; Tue, 24 Dec 2024 13:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176981DACA7;
	Tue, 24 Dec 2024 13:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uqNL6UzM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from pv50p00im-tydg10011801.me.com (pv50p00im-tydg10011801.me.com [17.58.6.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0F1DA2E0
	for <linux-pwm@vger.kernel.org>; Tue, 24 Dec 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.6.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045712; cv=none; b=IzWpFUxDgdTp06vYpRROPV7hwalhpnJNogdAYiIRxd/8fG553NHlY9/x9rlwpg+piKlwyJesLnSE9W1GumKe/4RTuLhq7KH4A3rfrgkyVGRfxHGKWtjxfWPDAy0E/4pyWKA6RyNf/T4YZq5zaaNXdPwEtOPncRNqH1VaoA2PoWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045712; c=relaxed/simple;
	bh=TjYAYrGnnlDD9+uQXHrTG9lK+k+7G830Csz2OBeKoxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGdugAQIqFJYjqEzONw8Tf/STeTyS252Yq5wR7M6pfyDonoLy+4hTZdupAvJX+gwRN0YmQFq/nwGzVgBdU1qsCURUKctwIIPfmYR0LLCXf+vPYcEJmzZfNpTVbdCTZNdGsDbQApKiNZ2ylTCWlsBtRrgABZIy+fLx/8mHRIVKqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uqNL6UzM; arc=none smtp.client-ip=17.58.6.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1735045708;
	bh=+yGUG7zM85pZUBo4aKiXR8NxJmaVni/DBipui/2ga7s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:
	 x-icloud-hme;
	b=uqNL6UzMZ9xbXl/yB/W7v0P0lvedviF3xswnJKZ5wNgUy2VS6inXSiyXH1OAdasyi
	 gHbb9BDAXynlSZU29Y9aS50RZIb6ocJWuHfTLC4fhTK8IUTEr94XSHIJz4yxbJDaSu
	 jm0QjM0dbQBoClJuxzR4nPJVJAy0ZAR5jWqpGFZG4jMhsWXl0Ed/IU7F0IMiGQfBDb
	 pmioHk10qHXZd2vcRHZkNynhC77QNei0o0NC1IS/CY5Y4WeVBK54awTU5E1BS9fv+K
	 2PvwMJLrDTlRU9ndTETvK8n5HTqphbMzbyCyKqNZYS+nQ8fOoJSSRPz97X0AChhBPn
	 3Q035aDAH/Xlw==
Received: from [192.168.1.25] (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
	by pv50p00im-tydg10011801.me.com (Postfix) with ESMTPSA id 0C8AB800259;
	Tue, 24 Dec 2024 13:08:13 +0000 (UTC)
From: Zijun Hu <zijun_hu@icloud.com>
Date: Tue, 24 Dec 2024 21:05:06 +0800
Subject: [PATCH v5 07/12] slimbus: core: Remove of_slim_match_dev()
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241224-const_dfc_done-v5-7-6623037414d4@quicinc.com>
References: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
In-Reply-To: <20241224-const_dfc_done-v5-0-6623037414d4@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
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
 linux-usb@vger.kernel.org, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: ebzPQ3g0bCIFd40xi_hZmQg5KTHQbxMX
X-Proofpoint-ORIG-GUID: ebzPQ3g0bCIFd40xi_hZmQg5KTHQbxMX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-24_05,2024-12-24_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 clxscore=1015 mlxscore=0
 spamscore=0 mlxlogscore=857 malwarescore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2412240113
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8

From: Zijun Hu <quic_zijuhu@quicinc.com>

static of_slim_match_dev() has same function as API device_match_of_node().

Remove the former and use the later instead.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
---
 drivers/slimbus/core.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index ab927fd077cb4fe1e29c004269fe52b2896c302f..005fa2ef100f526df5603d212b6334c06a366c94 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -385,21 +385,13 @@ struct slim_device *slim_get_device(struct slim_controller *ctrl,
 }
 EXPORT_SYMBOL_GPL(slim_get_device);
 
-static int of_slim_match_dev(struct device *dev, const void *data)
-{
-	const struct device_node *np = data;
-	struct slim_device *sbdev = to_slim_device(dev);
-
-	return (sbdev->dev.of_node == np);
-}
-
 static struct slim_device *of_find_slim_device(struct slim_controller *ctrl,
 					       struct device_node *np)
 {
 	struct slim_device *sbdev;
 	struct device *dev;
 
-	dev = device_find_child(ctrl->dev, np, of_slim_match_dev);
+	dev = device_find_child(ctrl->dev, np, device_match_of_node);
 	if (dev) {
 		sbdev = to_slim_device(dev);
 		return sbdev;

-- 
2.34.1


