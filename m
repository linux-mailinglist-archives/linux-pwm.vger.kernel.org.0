Return-Path: <linux-pwm+bounces-5726-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96175A9E37F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB45E1899C6F
	for <lists+linux-pwm@lfdr.de>; Sun, 27 Apr 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 405421A8F8A;
	Sun, 27 Apr 2025 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1erEWoz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C827199385;
	Sun, 27 Apr 2025 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745763916; cv=none; b=BOL582egVV0xOnFuha1mBW0ZEzNuwaPu9n9r+Xm7mAi/XjToShxSQ1FlPx3QzPPoykBX4ZtVm+NzRBfcT3XmDKx6ILPrpbDy32rpQLagICxafdr6vsG34qGw/tWlZk6650LHIa/eqaLoxJ/e96yMY38/jcZXIpdeRekWGZbj6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745763916; c=relaxed/simple;
	bh=4RuQwRBAdLPTYq/a4FeieIjOWizMZ9M2PNfdmCov5UQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k8Uibvv5zA9yoFr81/X2kjb7uj2g1uwAtVdKOrpuH3MZgzvv9DNs7Hu3n+F6Ls5RiY7Z9He3Omk6Hlj1lUo7wm0bSa/06ZGe5/GYwDKP8MRlYUHMI/fjkbwrulnDkS0lRaI64wiLQdXQA2/3t1Fen5yXBQ7onTnBR25sfEhY0RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1erEWoz; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3105ef2a071so38683191fa.1;
        Sun, 27 Apr 2025 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745763912; x=1746368712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+/h+HUw5Fa9i+auYLXdmFTVTqLMJ8IF6VQixN6G/8c=;
        b=R1erEWozsynBtkY7tq/1Aeruwl9LB18PPTgZs/rSW4RzH56ck/NMaQ+GQQNtF5sKkV
         udHAzE3Hs3JVx2M3BtkcBPAwCS4pYyPudodsUWQQVeDSxf27aP1bxazq73kCt5+EOZ4b
         EzhMQl53HOaOR16KIS+SJhKHc8ar2Di6n/8iM6uT+jGT0igRsVptxttEpXu722lujPZW
         jOD8HDFjF2MD/HUv9tQnF/5Rrw37iyBZjP8j2mE7uu6KMn1T2p61pZluNCxNRXkGrJ8N
         PA1B+z9JOTK85Ue89iU9MNhRNCFqAxW621d87dhwhMIFWRaDBgC5yLTaHHHl211XbIqn
         M3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745763912; x=1746368712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l+/h+HUw5Fa9i+auYLXdmFTVTqLMJ8IF6VQixN6G/8c=;
        b=OseQftm9+hyneiUMkf5f9V0HqYwFwlYGNm9PQgl/hrop+v3+LxYbDDKe9Gh+hgOsPB
         RKGU3ad1CUEZ5F0KXM9yD2dP9mjXjZexo/+G4o29/Qan2qPz6bBNS0ZPHfPnIa/wksOI
         NHJy0tbazx/zX/TWXDMTRZfzhnXws1MAY6fwqJDvz/Sg5AJ+Hwh9miwocZodlEiN4HZF
         UOOjIl41YIluPumGHeNEG83nvXt1TIOE5uHzU5c/d0uMPrB7ipgvtt1uzCHmhqVMt/i/
         H1eai9cPpa1E9gbYZA6D9vdUaLUuvKY+DsKm1xI4s44AOZlf3zpGKojXmkxRlaQN5134
         ti5Q==
X-Forwarded-Encrypted: i=1; AJvYcCU29g8sj2ci/Ce0CGvlkaedNrkOVhdUuChDSnYK/5Nb3qnMTku+1rKL5eVVRJWh+o4i8IyWBo3caVOH@vger.kernel.org, AJvYcCWyXc3oe3VC80lpvLtpTJo8gN0NslybCWo9P83BJQoyoKGceaZgKh407GnrX1VybXRxz0UE2LueK3cZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw24Cm6DPdtKGak7+0sVgPoVbJXafFAJoJOiTNnA6JDkoxxWudp
	dU6XiSLnvb0A0cgE1RMEtWFfYWiaIxHdW7uZ3ThOc2Ys4gmrGisyLTaARmhc1UVu
X-Gm-Gg: ASbGncuRhV+7b+ZSAIo2C9DfNHQKSp44BkSor+OqbZ9oy4ZvaIZGLEOZFbO9Hch6FmJ
	HtHWkEfYD8ndsghe6mw3S3JaRaetzjMyfP3t3lL9W7LOoOPvtTKGFBt+N0N9ww/9PuhSJ6/XH+5
	427pVzRrEM35RmKDRb+2rZf4RinhFt551Q+pM+X6QtjMPqqr7vkdpg/+7upUcKdRGrhmC265W92
	eX3L6m09IFibn4H8cSUELOe33fhbusIzq3bSs6WsdosgYrHtZ3HPH7UKgXzYMKGG/xykjwDnbDy
	9fSVOWvB224Ycvynphla8Bs6iRulv2mk6zBztm59R3y+Zl3jJjZj4wEI
X-Google-Smtp-Source: AGHT+IEZEKc9Vnf/efSmBJgLhw4tTfU2F09GmxdHClCejQ/XhLFf9brnK906waqbWQ74zPb6LP0ysg==
X-Received: by 2002:a05:651c:158c:b0:30b:cd68:b68d with SMTP id 38308e7fff4ca-319dc02035cmr14537211fa.10.1745763911951;
        Sun, 27 Apr 2025 07:25:11 -0700 (PDT)
Received: from localhost.localdomain ([178.176.177.108])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-317cfb482b1sm17659191fa.29.2025.04.27.07.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 07:25:11 -0700 (PDT)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v12 0/3] Add support for Allwinner PWM on D1/T113s/R329 SoCs
Date: Sun, 27 Apr 2025 17:24:52 +0300
Message-Id: <20250427142500.151925-1-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2:
 - fix dt-bindings
 - fix a remark in the driver

v3:
 - fix dt-bindings
 - fix sunxi-d1s-t113.dtsi

v4:
 - fix a remark in the driver

v5:
 - dropped unused varibale in the driver
 - fix dt-bindings

v6:
 - add apb0 clock

v7:
 - fix a remark in the driver
 - add maintainer

v8:
 - fix compile driver for 6.8-rc

v9:
 - fix a remark in the driver
 - fix dt-bindings
 - rename apb0 -> apb

v10:
 - fix a remark in the driver
 - fix compile driver for 6.12-rc2

v11:
 - fix a remark in the driver
 - fix compile driver for 6.14.0-rc2

v12:
 - fix a remark in the driver
 - fix a remark in the dt-bindings
 - check driver build on 6.15.0-rc3

Aleksandr Shubin (3):
  dt-bindings: pwm: Add binding for Allwinner D1/T113-S3/R329 PWM
    controller
  pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
  riscv: dts: allwinner: d1: Add pwm node

 .../bindings/pwm/allwinner,sun20i-pwm.yaml    |  84 ++++
 .../boot/dts/allwinner/sunxi-d1s-t113.dtsi    |  12 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sun20i.c                      | 379 ++++++++++++++++++
 5 files changed, 486 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/allwinner,sun20i-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sun20i.c

-- 
2.25.1


