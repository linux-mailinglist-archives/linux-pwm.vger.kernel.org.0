Return-Path: <linux-pwm+bounces-4217-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 686739E31F1
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 04:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95774B221E2
	for <lists+linux-pwm@lfdr.de>; Wed,  4 Dec 2024 03:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7328525771;
	Wed,  4 Dec 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lR0DNHFr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6238632;
	Wed,  4 Dec 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282168; cv=none; b=rtEtleMhZqnkJIf7ZkMJjp68AM//0FjglRzmgMSfgxMODsuZ5gge1wHhzStf/USV4s2ynDeUZvVJ9IUHRfZp2wmaHAbHItUMXNdZZ4GqNnR6AgdMwMJVdBwpD7QsD89wsWo0KiZHYL0Oqo5NlptV+n4PhWQ1tkEs4hww3a9hHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282168; c=relaxed/simple;
	bh=bWjGLV1z2gWxVYUsVpMz3YhhRQJrKfI5xTXNtF+aWoM=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=mPNI5sd9n4K7LTwwl/4D+YEUGksKzm0gsflzJArDbPsuqUFiemcEUlMJ/535GW7QLvjJ76O1c4PwDZ2isw0+uLamHcNK41Ah4AQjVIX9pdYbqWbKewtHSt09zmVhBBicUzMfqkJhW1h5oX9AfMTHebN7h82AZV33jJbisKr9Udk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lR0DNHFr; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-71d4ff749baso2900031a34.0;
        Tue, 03 Dec 2024 19:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733282166; x=1733886966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=GOyvms7hCiUGAh/zJ3IBHgfljifBo6gdOG9XI1OMWo4=;
        b=lR0DNHFrSXPufnM0lxWAUNPMjxN3RZ37KTBRLul9RZeYRLDg8qDPvlz6lPC6ZsCFok
         Zf/pR1zl96YSJoNdJ+n7BG8F9WPrvqsabBNSzb8mHHICzRD4Z45Jt6Gm1yAeaemps5fu
         iBaGycYda9HVQA/RQUTnvDgLApBcHnUXuPYUcK9lIeeWsQCT8xXct9OaeD8Ew+tWmBSZ
         TeysHUbUz0SLOLPuGvtC/ZTlYpd8RCkF3SA3xGUKLjHBiJ1TYCPn4HIdWjngpk/ffUN+
         WWJh5FfOQNpHhGl7suRY7Xoa9A39IE7RHHSv7KCZ2IQJ9jFyk30eWm9qWhTrQtOCYudc
         2g/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733282166; x=1733886966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOyvms7hCiUGAh/zJ3IBHgfljifBo6gdOG9XI1OMWo4=;
        b=jeEdfWjba9mhjxumobGjxZSWZYwAIgZdaUtoEpxMYKWT3wqmW61biw7laaWCuAlSre
         3D3ThFSwD3kKF+DWoCBBI2FLsrzJygnTY8juVqsolbgBbFKdLNHZYmQMkmaDb+tCYlma
         Vpj2A6Dienl8T4Dd34GQkFvbEfhxLyQQi9xFi9bd+D8cuyzvYY8GEjRdMArfSvQP63A0
         KBaKRb3ZJEfaN0MROiqFg43WeVCLAt0EuU8s7vCZyTdFw2O4MnHdU7Rq7j/2uPbfKJ2w
         bDXp7gh47HJouEnSQRFB+yW3Rm6+AcNd/ynRgajjvoBzGQJeYIbShSM8m5rOQ3ynIhLd
         +GQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHg7qmbeLQMKGMNN1bHUwI5phrNh1VsB3DImtR30XWDHbdZf+yArEEhHOOSr/Dcnla2YfOMBxd085pbtbe@vger.kernel.org, AJvYcCVdGFUVs57lJVUTAIkSEWO7ml5bfA1hBJgEuhmO7xKcpwfZjMjdWDalAEUR6NRDFMiX2DnBWymEHNLp@vger.kernel.org, AJvYcCXy8NIACYWbwst8R8pEw3XevOqFKP0U9xPs+krS7PPSRA/g+XdCzN0w+hA0PhO2p/aRZqgjWJ0bxb2o@vger.kernel.org
X-Gm-Message-State: AOJu0YxNVsLv1ou6Tpe+OSEcCE+aBoI2gWark5OfHrckpXeDa7jw95ZX
	dwtKJHrbvMNZmTZb74//umVrMxKI6gqPLuDD4FgOlizlMjnvvse9
X-Gm-Gg: ASbGncsMOcw2nnyPiHA4EblVRPzy2CUdVSytdimuSMP+NEa9IxvJuGw7sguFKUeJjsM
	ncggRKE684gIXt4V7I4uczzXD8rBpqtls8AmzJ2GWrBNvge3s2m5/MLqJA8yenpYWHQZeJZJF3G
	b23TFKrJgPfkq6d5cI5qPlsN0hx2Ne5/f9exlDKxi9Cmxr6/WbJuTQEmUOmmWtPrmkmM5uaNRef
	mG40TWdrWIzbyE7JS/ycALOQ609hXvDMHuNjoVynJ3hwYcxBif1Ppt3VSc1
X-Google-Smtp-Source: AGHT+IGruAdiQPp09SpGfoGobfJWtTNsSSBjp4bjL5mMGSCMPas6X73eLs63ILdcIFlTnNfvmn+huw==
X-Received: by 2002:a05:6830:490a:b0:71d:4624:3f55 with SMTP id 46e09a7af769-71dad606dd5mr4547915a34.6.1733282165754;
        Tue, 03 Dec 2024 19:16:05 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-71d7c820850sm2799340a34.73.2024.12.03.19.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 19:16:04 -0800 (PST)
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
Subject: [PATCH v6 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Wed,  4 Dec 2024 11:15:55 +0800
Message-Id: <cover.1733281657.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add driver for pwm controller of Sophgo SG2042 SoC.

Thanks,
Chen

---

Changes in v6:
  Nothing major changes just rebased onto v6.13-rc1 and retested.

Changes in v5:
  The patch series is based on v6.12-rc1. You can simply review or test
  the patches at the link [5].

  Updated driver to add resets property for pwm controller node as per
  suggestion from Inochi.

Changes in v4:
  The patch series is based on v6.12-rc1. You can simply review or test
  the patches at the link [4].

  Updated driver to set property atomic of pwm_chip to true as per suggestion
  from Sean.

Changes in v3:
  The patch series is catched up with v6.12-rc1. You can simply review or test
  the patches at the link [3].

  Add patch #3 for dts part change.

Changes in v2:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [2].

  Fixed following issues as per comments from Yixun Lan, Krzysztof Kozlowski
  and Uwe Kleine-König, thanks.

  - Some minor issues in dt-bindings.
  - driver issues, use macros with name prefix for registers access; add
    limitations comments; fixed potential calculation overflow problem;
    add .get_state() callback and other miscellaneous code improvements.

Changes in v1:
  The patch series is based on v6.11-rc6. You can simply review or test the
  patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1725536870.git.unicorn_wang@outlook.com/ [1]
Link: https://lore.kernel.org/linux-riscv/cover.1725931796.git.unicorn_wang@outlook.com/ [2]
Link: https://lore.kernel.org/linux-riscv/cover.1728355974.git.unicorn_wang@outlook.com/ [3]
Link: https://lore.kernel.org/linux-riscv/cover.1729037302.git.unicorn_wang@outlook.com/ [4]
Link: https://lore.kernel.org/linux-riscv/cover.1729843087.git.unicorn_wang@outlook.com/ [5]
---

Chen Wang (3):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM
  riscv: sophgo: dts: add pwm controller for SG2042 SoC

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  58 ++++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   9 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 194 ++++++++++++++++++
 5 files changed, 272 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
-- 
2.34.1


