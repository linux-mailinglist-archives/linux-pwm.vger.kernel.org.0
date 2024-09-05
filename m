Return-Path: <linux-pwm+bounces-3096-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D658A96D7EE
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 14:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CC451C23501
	for <lists+linux-pwm@lfdr.de>; Thu,  5 Sep 2024 12:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0719AD73;
	Thu,  5 Sep 2024 12:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJYwX7+P"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B17919AA46;
	Thu,  5 Sep 2024 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725538216; cv=none; b=k2SlV48iJEtY4fcJxW9nUTjXPDBKw/oM2PLs7GfjBPVRFKagmXebBl8OaR9i7lU3131nOa1+yTe7LqsvPS6csNvfT7/1f1QB+zpXEoFH3J0nn4JOdIXY9cUxw4Eh/JDYA929b9N1aj+/88mqJGte5I4PROwfCtbM4Ph1J0rDHos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725538216; c=relaxed/simple;
	bh=elNe+0NPUsJUd4Jnk7nE7maLdMUl+rRNTDj/bWjr6dE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=tlX3nXoug2zE/E4BaLrxmqojJP06oupfpR3Cv2P+egbsx8hytn/slZRnGk3/XPk6VXjEhMTSBsepHfMV4/n8lvvH3jwAe90qXW+QJziz5h4v0E3hV+pw0MdwYl5fJSxvKEMtWhcjLcD04D2cNepgC/P9mtAeRCTb/J81x7LP41M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJYwX7+P; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3df07543ed5so508088b6e.0;
        Thu, 05 Sep 2024 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725538214; x=1726143014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5Zf1HaPH2gPY3Z++jYDIyKBqU5jbdT8Whm7IqAb2o=;
        b=lJYwX7+PsH+CXHJqUJc2E+iMEmmVIeuXQgj4icv0agl4I6pFO2tfD/M6o54EaBY/vf
         K5a6sHw5+y6EGsIWdkF88L1PrUsP2rFtZJaVTbPrV3i9vMHDSQlGsHK41XUtC32q/U/i
         zDVS8T4e3ULyZ0oWDxNQ9vYppbRE7l11NtOEIFzS5LFiha7oTtLbSD0p6gv9wrJHlC7y
         cmAdcj6iewhip5K1pKChAAnpQ9hYlKSMiUFAMvBOHRIp1uixM/3I9t64CCcYnry6VHAc
         K8hV+KLW0aS/ACf7NaJBiBEsRNcKI/orc/Gt0WQmNy1tP2cZq9z8NKZ7ICD4PVJaGnh1
         G/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725538214; x=1726143014;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha5Zf1HaPH2gPY3Z++jYDIyKBqU5jbdT8Whm7IqAb2o=;
        b=VLs5pfW1Df/H/a3VVvAbiH+dRVHfhfcPSEk3JHmqMrdlfL+wahW+jSFaax1nnR+thW
         eDewkk+wLIic9sCcu0LstGgAdZvmHg3XyBN3f5iL1fEP+BrOzsxmbxPOeU1Lvxph3qPO
         qYw0Sp02CXIVsMmJMj9ORQAMGtPjyd42L5rcbXt3WHn87iETRn1vO8/tPHh9oBXVJzZx
         OgurzXaueUyy7pThhHIIxMcSZQr7ua6gqoluZEPtICYaHF1L771pCssBqUIubLUWSMZj
         D9NPKVzvhJZtBChI4Ru8jvW9MiCGg//N8X++TBVcdA2vs/vP5GM5Mi+YPS1HE8kegiD2
         XRDw==
X-Forwarded-Encrypted: i=1; AJvYcCW972bQJ6vclsyNlW76Fy4ztYwxO+R/MoaDwzKAQZP2szYrC1MA+XlimtUFohXzQdz7b3gE2MUenpLu@vger.kernel.org, AJvYcCWVbvODv5TiPCgcmzaIZv7YTjaCzqDGVY5HKRsXDpbuIFGm98T3RFsVGjTM8P8DzcjwDisvkPRDYEOM@vger.kernel.org, AJvYcCWzxBWUqd8+uIJx3cCTKU0zWH9JlV3A/NzOBe+EEVBt4un6RPI1qBfY2JfOMD47/h03u7gbFTrsOThxnuO5@vger.kernel.org
X-Gm-Message-State: AOJu0YxpFwepnODEuLdXd+vckHTRWRqxGckqzOXHhNXPAX3oZ+2mHb+q
	yGZRwvPfnu6/MUF8bp20p8MLuiViP3Nl+AWSMfK0yT2RHpYPTrnssZGYQw==
X-Google-Smtp-Source: AGHT+IGJvHRHIxP0i3HI3L6UuZmSa++0i9QDMBoTgYvhTm3lYqbQEvy9GjgzIuMBQhis16h3LJn2mQ==
X-Received: by 2002:a05:6808:2e85:b0:3e0:1c90:cfd with SMTP id 5614622812f47-3e01c900ed3mr2516507b6e.9.1725538214078;
        Thu, 05 Sep 2024 05:10:14 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3df11882be0sm3187232b6e.48.2024.09.05.05.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 05:10:13 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	unicorn_wang@outlook.com,
	inochiama@outlook.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	chao.wei@sophgo.com,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	chunzhi.lin@sophgo.com
Subject: [PATCH 0/2] pwm: Add pwm driver for Sophgo SG2042
Date: Thu,  5 Sep 2024 20:10:06 +0800
Message-Id: <cover.1725536870.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for pwm controller of Sophgo SG2042 SoC.

Chen Wang (2):
  dt-bindings: pwm: sophgo: add bindings for sg2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  52 ++++++
 drivers/pwm/Kconfig                           |   9 ++
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 148 ++++++++++++++++++
 4 files changed, 210 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
-- 
2.34.1


