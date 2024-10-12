Return-Path: <linux-pwm+bounces-3609-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5391399B043
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 04:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE77D1F2319A
	for <lists+linux-pwm@lfdr.de>; Sat, 12 Oct 2024 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A860047A73;
	Sat, 12 Oct 2024 02:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="tQBV5FVv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08963DDC1;
	Sat, 12 Oct 2024 02:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728701778; cv=none; b=D+20XUuqAyF6kxzgrA28uZG+pIUhy24EklHH4UV6wb3NhoYmH6GHjMxQ7no+jNNJwezK/25vXSziO/BDcRjNpVtUHBDgtjjkWG66K3flChN3iwhmw4c9mgmJ/ZC2icCYMin9YFBAoN7J7uKdTgtk0rxTEOSURlFFczdIfLdBX1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728701778; c=relaxed/simple;
	bh=2MpnGwRRd9XBF6S6g8PVFWQLwXImpFcsPQL17bdYylI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s/EcoHnsJKEz0/2anRyJm8/DyjR5xwstt8iDrMvmmh6BCV16O6E+1Zv9XJWkZWBi/PFrmPUjwKOWgY00qKIp6Y//QQo0ylmkDqaNB2JPE01CrPM7OuhPB0ilsdXGs9dA7imyMo9sjBA5OwkBduCY9Jd6DiwnVKgr+7QFt6iaUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=tQBV5FVv; arc=none smtp.client-ip=192.19.144.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 33695C0000F9;
	Fri, 11 Oct 2024 19:56:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 33695C0000F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1728701770;
	bh=2MpnGwRRd9XBF6S6g8PVFWQLwXImpFcsPQL17bdYylI=;
	h=From:To:Cc:Subject:Date:From;
	b=tQBV5FVvi7PkRSqe0jcOG5N3IjEamaacWT0mOQL3K1jKBsRbt3RhaRUQCtokMHjU/
	 5Ye8xJ1zn/Wq76ehCuJ6m2XkCYxXirhZbW5HhFleQBwCL+hwbR5GtrXTmS1HZmr3er
	 oTz8WR4ACX6XOVSPqz13V3uHhZEeqoVgEK8LOJc0=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 57D8018041CAC6;
	Fri, 11 Oct 2024 19:56:09 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-pwm@vger.kernel.org (open list:PWM SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE),
	justin.chen@broadcom.com
Subject: [PATCH 0/2] pwm: brcmstb: Support configurable open-drain mode
Date: Fri, 11 Oct 2024 19:56:01 -0700
Message-Id: <20241012025603.1644451-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series updates the pwm-brcmstb driver to not assume an
open-drain mode, but instead get that sort of configuration from Device
Tree using the 'open-drain' property.

Florian Fainelli (2):
  dt-bindings: pwm: brcm,bcm7038: Document the 'open-drain' property
  pwm: brcmstb: Do not assume open drain configuration

 .../devicetree/bindings/pwm/brcm,bcm7038-pwm.yaml          | 6 ++++++
 drivers/pwm/pwm-brcmstb.c                                  | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.34.1


