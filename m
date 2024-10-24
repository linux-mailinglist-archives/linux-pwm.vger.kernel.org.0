Return-Path: <linux-pwm+bounces-3797-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4199ADD5D
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 09:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2B03B22684
	for <lists+linux-pwm@lfdr.de>; Thu, 24 Oct 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD01714B2;
	Thu, 24 Oct 2024 07:15:53 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF05078C9C;
	Thu, 24 Oct 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729754153; cv=none; b=aq0HKZrqK9T16C33h/qi/NnzQyeOjpzltXkmZoAyatCu2No+vlvq9917evFbLbyC0+jEYA8xtsC+ruXeG2b+m1z5EY8vDtUD1KdANKXMpRyGa6Jjq8AHqiLZpuuGGa/cMEnYDpuNpbNhvpWPOAVoOi9KCPMuKGCl7K6CXXzBBbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729754153; c=relaxed/simple;
	bh=rsbgrNHNb4PGhRjN3KC2IH8pOcG2KkW5OnYWL5YpX9c=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=e8XhmcYu/IEqFN6ZYgYNZccB8YQLVJbLjtN0QU2Atv7gaKUpAewRuajaXAhxtSMLQmsBi7dzPmhgBrGnsWrWEmBSy7uCJN8erIi6SCYYR3O99j/eN68rlo+SZKDy4fAil/9sbgQQ0e+ix4V+msj50vNs6HHzWAss0/MtNKm+6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 24 Oct
 2024 15:15:48 +0800
Received: from mail.aspeedtech.com (192.168.10.10) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Thu, 24 Oct 2024 15:15:48 +0800
From: Billy Tsai <billy_tsai@aspeedtech.com>
To: <jdelvare@suse.com>, <linux@roeck-us.net>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <joel@jms.id.au>,
	<andrew@codeconstruct.com.au>, <ukleinek@kernel.org>,
	<billy_tsai@aspeedtech.com>, <linux-hwmon@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
	<linux-pwm@vger.kernel.org>, <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 0/2] Enable WDT reload feature
Date: Thu, 24 Oct 2024 15:15:46 +0800
Message-ID: <20241024071548.3370363-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Aspeed PWM controller has the WDT reload feature, which changes the duty
cycle to a preprogrammed value after a WDT/EXTRST#.

Billy Tsai (2):
  hwmon: (aspeed-g6-pwm-tacho): Extend the #pwm-cells to 4
  hwmon: (aspeed-g6-pwm-tacho): Support the WDT reload

 .../bindings/hwmon/aspeed,g6-pwm-tach.yaml    | 25 +++++++++-
 drivers/hwmon/aspeed-g6-pwm-tach.c            | 49 +++++++++++++++++++
 drivers/pwm/core.c                            |  6 +--
 include/linux/pwm.h                           | 10 ++++
 4 files changed, 86 insertions(+), 4 deletions(-)

-- 
2.25.1


