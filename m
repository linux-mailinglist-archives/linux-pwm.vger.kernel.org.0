Return-Path: <linux-pwm+bounces-1784-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC0987DCFC
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 11:41:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D374281724
	for <lists+linux-pwm@lfdr.de>; Sun, 17 Mar 2024 10:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB1E18EAD;
	Sun, 17 Mar 2024 10:40:58 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D409E17984
	for <linux-pwm@vger.kernel.org>; Sun, 17 Mar 2024 10:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710672058; cv=none; b=E8o3eEmxiQwNcL5AMyhh3FezWIhc/bvh8EIoUny4iLTELmqUSZ2YJc10XrgyXJuPsRaOrpt2mQWxwYLHdm+2yG3m0z4DgV4ZkjMnvkrtvGroyBE1YCs+p78wp5MEqZ+mLg4j7Q84WC6BMb0DmwwQisn+CxWPKNIWfIW0/mxZ6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710672058; c=relaxed/simple;
	bh=fs59cnUdx6Lj37sKccMDB1aCfsDJsVT37Vt+S8/sLfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pg2T5/G8LkOhPB5AA5P1oRblj167s8qnGVAI+dmxBYEPBzcdFQZOfhzXbLgC/YPgur3X7LHNUbtEutFyx15dKItcu+wH6TlVTpMb8Qx/1p2qOdQEJJ5WTkkdGGDS6df4rkv1xOTW1oO5JmhQbA6QUc7I4ZR5vIIHdBvwe9t69MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwd-00029Q-HI; Sun, 17 Mar 2024 11:40:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwc-006rff-RP; Sun, 17 Mar 2024 11:40:46 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rlnwc-007aCv-2T;
	Sun, 17 Mar 2024 11:40:46 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-pwm@vger.kernel.org
Cc: kernel@pengutronix.de,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH 0/8] pwm: Add support for character devices
Date: Sun, 17 Mar 2024 11:40:31 +0100
Message-ID: <cover.1710670958.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2528; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=fs59cnUdx6Lj37sKccMDB1aCfsDJsVT37Vt+S8/sLfQ=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRvJxYsaufN39XgfXrBvIQF1e6v41KZjC8+TmOfnTX5e 9fxnD/5nYzGLAyMXAyyYoos9o1rMq2q5CI71/67DDOIlQlkCgMXpwBM5FwYB8M28/f5NyNsN0gI cMfs7cq6/9WWXbL4p1vVpVJOuxaz6yc8TEpVk6PPcmyV8bVbYr331V6zxH28DHu5dmiG7Y8O9L2 S0eDOF142LTFn+6nvx3Tk+t9o3a0zlWcvf/gm+JVO9dmPho8u2ey6UuJzWa6ij9XNp65b5nbylp mzFVeHh2YrPatabVtQfqlBLNK0ar05T0x60XUn71VTXdTdGk5pOs+p3S2TaLakK0LuS97WQhOTA pWVjwsu1ga++PktSlCNoXVLeMy9qI3Tg55bru8/9nU50x2LDw8YBRjfZn7ekcQTNcfbXu422/Tz fq65Kwoy5j8Q7pz376uZeEIB6/1n1zJnZc6ua5U46P4UAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pwm@vger.kernel.org

Hello,

After the necessary changes to the lowlevel drivers got in for v6.9-rc1
here come some changes to the core to implement /dev/pwmchipX character
devices.

In my tests on an ARM STM32MP1 programming a PWM using the character
device is ~4 times faster than just changing duty_cycle via the sysfs
API. It also has the advantage that (similar to pwm_apply_*) the target
state is provided to the kernel with a single call, instead of having to
program the individual settings one after another via sysfs (in the
right order to not cross states not supported by the driver). 

Note the representation of a PWM waveform is different here compared to
the in-kernel representation. A PWM waveform is represented using:

	period
	duty_cycle
	duty_offset

A disabled PWM is represented by period = 0. For an inversed wave use:

	duty_offset = duty_cycle
	duty_cycle = period - duty_cycle;

. However there are some difficulties yet that make it hard to provide a
consistent API to userspace and so for now duty_offset isn't (fully)
supported yet. That needs some more consideration and can be added
later.

A userspace lib together with some simple test programs making use of
this new API can be found at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/libpwm.git

.

The start of the series is some cleanup and preparation. The lifetime
and locking patches are needed to not crash the kernel when a character
device is open while a lowlevel driver goes away.

I look forward to feedback,
Uwe

Uwe Kleine-König (8):
  pwm: Ensure that pwm_chips are allocated using pwmchip_alloc()
  pwm: Give some sysfs related variables and functions better names
  pwm: Move contents of sysfs.c into core.c
  pwm: Ensure a struct pwm has the same lifetime as its pwm_chip
  pwm: Add a struct device to struct pwm_chip
  pwm: Make pwmchip_[sg]et_drvdata() a wrapper around dev_set_drvdata()
  pwm: Add more locking
  pwm: Add support for pwmchip devices for faster and easier userspace
    access

 drivers/pwm/Kconfig      |   4 -
 drivers/pwm/Makefile     |   1 -
 drivers/pwm/core.c       | 988 +++++++++++++++++++++++++++++++++++++--
 drivers/pwm/sysfs.c      | 545 ---------------------
 include/linux/pwm.h      |  51 +-
 include/uapi/linux/pwm.h |  23 +
 6 files changed, 993 insertions(+), 619 deletions(-)
 delete mode 100644 drivers/pwm/sysfs.c
 create mode 100644 include/uapi/linux/pwm.h

base-commit: dd6c6d57ab61d496f6ff7d6ca38611062af142a1
-- 
2.43.0


