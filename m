Return-Path: <linux-pwm+bounces-3062-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96ABE96703C
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C769D1C21688
	for <lists+linux-pwm@lfdr.de>; Sat, 31 Aug 2024 07:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C6F16EBEC;
	Sat, 31 Aug 2024 07:59:24 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD63B13A885;
	Sat, 31 Aug 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725091164; cv=none; b=Fd6WpEBlt/z4k4DUfv1d4gR+7Qyr/nezVOAOGU+rvjdpFy8wNxzkJ8y8cZwEO/kpZTqriIijbzGBcKqERNBHbztRptHgQ65FCnuahfdhj/VjwQGgSee0bbOuGgTYdTqV1jeE8hYtU6H4y6ZTjYwm3Iz4EHxrnmZ+dsTVg+3isps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725091164; c=relaxed/simple;
	bh=yFrfAlGm8Gi9nd6jx/MCHS3aL6q9XfayKwfYM7wKyo0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wage3VrMmN30vkjbvcW0llnY9AdjpglcmJ1BWhidOOkJkmKnIElo7/ohIbhsmHQnm3DS9pN8UYqfBuOTdGW6OXKgebpI6SNnYswlQDCs8PKp+RcPDQ+FffgJRLKj1pMI7tA+0JmEwiNwuHArqPI8nEvEGXA6jWJ2CGJX6Wv2Ll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WwnTh4yhQz1j7Y6;
	Sat, 31 Aug 2024 15:59:04 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AB031400D7;
	Sat, 31 Aug 2024 15:59:19 +0800 (CST)
Received: from huawei.com (10.67.174.77) by dggpemm500020.china.huawei.com
 (7.185.36.49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Sat, 31 Aug
 2024 15:59:19 +0800
From: Liao Chen <liaochen4@huawei.com>
To: <linux-pwm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <ukleinek@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@tuxon.dev>,
	<liaochen4@huawei.com>
Subject: [PATCH -next 0/2] pwm: atmel-hlcdc: workaround
Date: Sat, 31 Aug 2024 07:50:57 +0000
Message-ID: <20240831075059.790861-1-liaochen4@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Hi all, 

This patch enables the autoloading feature of atmel-hlcdc module. By 
registering MDT, the kernel is allowed to automatically bind modules to 
devices that match the specified compatible strings. This patch also
drops trailing comma from definitions of device table arrays, which
makes the code robust against misrebases.

Liao Chen (2):
  pwm: atmel-hlcdc: Enable module autoloading
  pwm: atmel-hlcdc: Drop trailing comma

 drivers/pwm/pwm-atmel-hlcdc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.34.1


