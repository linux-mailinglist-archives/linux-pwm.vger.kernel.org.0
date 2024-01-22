Return-Path: <linux-pwm+bounces-875-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21DB3835C7C
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 09:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D120328282C
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jan 2024 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB1820DE0;
	Mon, 22 Jan 2024 08:22:17 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1549A20DE3
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jan 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705911737; cv=none; b=fpvJVU1M7fyyYkFC2QRHF+dZIO/EQbSSsdYYZDo67JhUnFB76E55z6VuA3XuHKMqe4ybtCW1jR7TJ5TviuN6qKrCoQe81qQHmlC/+H3i/A9kJWIEffYD7rnv1BW3IVY9B989MfeY3nL7oVLC55o19ceGOMOBmxlhjVYyqUDHYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705911737; c=relaxed/simple;
	bh=Qpw7KJX/Is2HHYHC6lOg/lrTzU2zu5gCPJVq3BvXVhs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gBCba9rWmRWggtYdiu/kaEZd2pMQCUbT3BsngN8te56LWUcrg+x8Kn4OzUzSFCx6Kb3uIzmrD9dmmz3I6unzDkd3XF0ksauX+pQLDDEuhCU7kBPc9GZEtsxe7WzbcuzbvpQvp5r/D8LFSop3Sck8eDOb1zg8i85ecsbSix/9zwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40M8I3gN055310;
	Mon, 22 Jan 2024 16:18:03 +0800 (+08)
	(envelope-from Wenhua.Lin@unisoc.com)
Received: from SHDLP.spreadtrum.com (shmbx06.spreadtrum.com [10.0.1.11])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TJNFc2T3hz2Rb68H;
	Mon, 22 Jan 2024 16:10:44 +0800 (CST)
Received: from xm9614pcu.spreadtrum.com (10.13.2.29) by shmbx06.spreadtrum.com
 (10.0.1.11) with Microsoft SMTP Server (TLS) id 15.0.1497.23; Mon, 22 Jan
 2024 16:18:01 +0800
From: Wenhua Lin <Wenhua.Lin@unisoc.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
CC: Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, wenhua lin
	<wenhua.lin1994@gmail.com>,
        Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Xiongpeng Wu
	<xiongpeng.wu@unisoc.com>,
        zhaochen su <zhaochen.su29@gmail.com>,
        Zhaochen Su
	<Zhaochen.Su@unisoc.com>,
        Xiaolong Wang <Xiaolong.Wang@unisoc.com>
Subject: [PATCH 0/6] pwm: sprd: Modification of UNISOC Platform PWM Driver
Date: Mon, 22 Jan 2024 16:17:48 +0800
Message-ID: <20240122081754.17058-1-Wenhua.Lin@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 shmbx06.spreadtrum.com (10.0.1.11)
X-MAIL:SHSQR01.spreadtrum.com 40M8I3gN055310

Due to new usage scenarios, some upgrades are made to unisoc's pwm driver.
Patch 1 supports the change of channel offset on UMS9620.
Patch 2 supports more brightness levels (duty cycle) for backlight control.
Patch 3 optimizes the calculation method of duty.
Patch 4 converts dt-binding file from txt to yaml
Patch 5-6 update pwm-sprd.yaml according to patch 1 and patch 2.

Wenhua Lin (6):
  pwm: sprd: Add support for UMS9620
  pwm: sprd: Improve the pwm backlight control function
  pwm: sprd: Optimize the calculation method of duty
  dt-bindings: pwm: sprd: Convert to YAML
  pwm: sprd: Add sprd,ums9620-pwm compatible
  dt-bindings: pwm: sprd: Add sprd,mod attribute

 .../devicetree/bindings/pwm/pwm-sprd.txt      |  40 -------
 .../devicetree/bindings/pwm/pwm-sprd.yaml     | 106 ++++++++++++++++++
 drivers/pwm/pwm-sprd.c                        |  71 ++++++++++--
 3 files changed, 165 insertions(+), 52 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sprd.yaml

-- 
2.17.1


