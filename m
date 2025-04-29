Return-Path: <linux-pwm+bounces-5757-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3AAAA0646
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 10:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C7101B65569
	for <lists+linux-pwm@lfdr.de>; Tue, 29 Apr 2025 08:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7510D28A1F3;
	Tue, 29 Apr 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="SCRRoWfe"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9517288CAD
	for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 08:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745916762; cv=none; b=axoqb9yV/1OeqPw0MYRDeLH/6Occ/rnVF7ajZbo26/hNiUEFfYSTfiQx/s5uD4QoZgnFINe1tgJQU0/PjGddnCV0/sEyT4Iu07nl7Hl6vdbWlEcdusOr5TCzuo8JBR8XulGEjQHlPv1Bjh7dZ17h/lp5FW3CRg7p08swys1AvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745916762; c=relaxed/simple;
	bh=snO5UlRxqymfMmKvVew8ZDq0Uh+aBwp66nsHilnsiK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bqRmxZKewkG4SFtuyHiPsZxlv7C2KitFZWXyQZ5Bku9T34t1nsJGahQFZyHM9dZbGOIbp4gGngtEhhIrnFydNxmKcYuV+6PAO+Gq4uprkWZSm6k0nmtQShP0dqMW8qPGkDHFLz+eRezGLu+hdveKFI5gTFESG80WzgfzkCqNiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=SCRRoWfe; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-22401f4d35aso69432705ad.2
        for <linux-pwm@vger.kernel.org>; Tue, 29 Apr 2025 01:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1745916760; x=1746521560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mEqVehBRCDyoxu9q2vBqacMHsZUXwyFpRPZVYhXUX8=;
        b=SCRRoWfedbJL16NYxzyE8b4wtFlqY+PhCtRsg9BMzyqBc0SP7X0aAgB2Ovr4QF3vGE
         K6XhrgoT+/iiL4CFUsNoUkMUyw2gdLDw/4tu7l/BGk7tg+dm2zHDnjcKB83LYceZNIxB
         73vZG66nl44xhHJLJcoZcZNGVCTGXIukd+lynH2uAPkrR0ofw16DgFLrHBcZNvAhFuAw
         CjmLGkh28N6YLXYW2qbk/43Au2eQe7fmvZ1aycQquA5UniCWtvlZECoXMG3nCdI/x+HZ
         uI5Uh5YSbVxtw3frS2Ac3CcPWfJPhqlEHhTUUzWh5oEgeP5hCrKWRIxnabJ+dDPFCKAV
         T1Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745916760; x=1746521560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mEqVehBRCDyoxu9q2vBqacMHsZUXwyFpRPZVYhXUX8=;
        b=g6wIAGlb4B5EE7CxMNm8u+X9ywfEPt6GL8tI7CB7KAcTzcSnRAehszLThY1PvqRnR6
         lcS1J40mfdzTMS57boFIqST7f6IdLUKGR4gtBI23OGDT9Vv6MKmtUxrPN0Ei++5fz2CK
         MSlJy5dLNy0T9r8uBga3ISEsKg1gNEChiJtWnYD2zGxnU77NPrSeM4KO45BusF8DVO3u
         +2QytIsH+BPkuMhq9ZEdsrZUANyf3+r3qnwdlJBMA5UlWNIa+S/t7eshEX1/dtQfs6Qi
         30BvKyFf6eRTU34gjJ315fW+8tVrs6D3+yc1yxtXREWrWSzlW4nTC7boPiFTaXt8DgQD
         hX/w==
X-Forwarded-Encrypted: i=1; AJvYcCW8ROX4WrCJjGkj0RnRqbeFcUcVv+84LJYTaEMKLT588vta66wYHMeIymFUAKPTqqThSZwC4Qq4New=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBpzR5uZCOUxdfIZ+Rfnrk7lNgzx8rqjN3f/YsvKkfR+QIcMli
	AmqXFPbdE5czERswWgLuqb/DzYQeisb6GYQtHTWU9k2s7rTvazX3xdajKeSZtnk=
X-Gm-Gg: ASbGnctZ0L5Fp+EJYttkal/6b/xkpZVhAVyFz9yN+c/5tr984A0FH33mGtwY1NES8iB
	w9/83YAl36Hm8npk0ik29dmFsn6D2ZUpTVUJORl5buP7ILj1ophgQbYi677x7F61a6TikoczyXR
	8lHl3x4mxYjD3NSjPe/ZnZS/I6OYd2L7vowECwvPDWMDbckaaTipPUZ7E32V+9S3afu1xCsMdX2
	RvtfbEJP1ZTUWuDuDxweNserN3Wc1JHEvrosQI637zCJgdt8rGEoeW/aXGczWgwzdKytg0NkEJz
	xOAaf7U2mWt1xwfShcFQ7BZP9sxHXkN26YdLIlKmuWZ7XejLrsSYaEYsNsIvAA/6NRTsBepDzQv
	a+obgxFuwdpktd0ghjmLwBurzuA==
X-Google-Smtp-Source: AGHT+IGnvzbUWhLI/YOaGHPG2HlwGVUVLczRsChSXyhLNMaAX1vRU5+feyFIpxGpmIkb1IMqyytUCA==
X-Received: by 2002:a17:902:e5cd:b0:220:fe50:5b44 with SMTP id d9443c01a7336-22de7037cb5mr28009905ad.31.1745916760002;
        Tue, 29 Apr 2025 01:52:40 -0700 (PDT)
Received: from localhost.localdomain (210-61-187-174.hinet-ip.hinet.net. [210.61.187.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15f8597e0bsm8550119a12.44.2025.04.29.01.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 01:52:39 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	dlan@gentoo.org,
	p.zabel@pengutronix.de,
	drew@pdp7.com,
	inochiama@gmail.com,
	geert+renesas@glider.be,
	heylenay@4d2.org,
	tglx@linutronix.de,
	hal.feng@starfivetech.com,
	unicorn_wang@outlook.com,
	duje.mihanovic@skole.hr,
	heikki.krogerus@linux.intel.com
Cc: elder@riscstar.com,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	guodong@riscstar.com
Subject: [PATCH v3 6/6] riscv: defconfig: Enable PWM support for SpacemiT K1 SoC
Date: Tue, 29 Apr 2025 16:50:48 +0800
Message-ID: <20250429085048.1310409-7-guodong@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250429085048.1310409-1-guodong@riscstar.com>
References: <20250429085048.1310409-1-guodong@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CONFIG_PWM and CONFIG_PWM_PXA in the defconfig
to support the PWM controller used on the SpacemiT K1 SoC.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v3: No change
v2: Changed PWM_PXA from built-in to a loadable module (=m)

 arch/riscv/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/configs/defconfig b/arch/riscv/configs/defconfig
index 3c8e16d71e17..3c4d9bb8f01e 100644
--- a/arch/riscv/configs/defconfig
+++ b/arch/riscv/configs/defconfig
@@ -257,6 +257,8 @@ CONFIG_RPMSG_CTRL=y
 CONFIG_RPMSG_VIRTIO=y
 CONFIG_PM_DEVFREQ=y
 CONFIG_IIO=y
+CONFIG_PWM=y
+CONFIG_PWM_PXA=m
 CONFIG_THEAD_C900_ACLINT_SSWI=y
 CONFIG_PHY_SUN4I_USB=m
 CONFIG_PHY_STARFIVE_JH7110_DPHY_RX=m
-- 
2.43.0


