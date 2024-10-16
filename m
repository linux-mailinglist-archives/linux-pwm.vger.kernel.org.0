Return-Path: <linux-pwm+bounces-3665-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F88899FD06
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 02:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24DB1F2489A
	for <lists+linux-pwm@lfdr.de>; Wed, 16 Oct 2024 00:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB4114A1B;
	Wed, 16 Oct 2024 00:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bFc1FLxv"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C09D11711;
	Wed, 16 Oct 2024 00:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729037955; cv=none; b=iaur70aG+1bYc+j9H3BZTqJzrVYO6gZo15KG6i0JI5D+r07bCsPUfcC8uth/nnaP8UzCqVKO0s4NQPcbNCru5Z16NY/e2K8JTXTR3wcCMw7cljcwIDx9AxkG/dt2kf99ab/x7Qv2Ydlbp24PTiWan5Qw/MDkqT0n6bLJutDKJTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729037955; c=relaxed/simple;
	bh=xT43Gbv+g6D/On8PZU52CO5NxqCl2Rm9CD/i6DLRJDs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ICzXBsG6ERtroSkx7Od/AU2KPL161WzHnC99PpG+Ish3pIKGI3jjl/4C1hdhIi5Qux27cE6uQfEPbFtf6/VMueZjGMtBfF8uFhzudIL4hYiJmqTUXIRaGWLm5jsnYX5Nkha+K9ZKew+A5XSGqKDkyY0IW/P0CjmPLVbeM7TuInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bFc1FLxv; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e9876999cdso2972914eaf.3;
        Tue, 15 Oct 2024 17:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729037953; x=1729642753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=05Y/2FGPgyvbyYFbGsJUnsosQK0HSJiBFrb2Qq6aVrA=;
        b=bFc1FLxvKQ+mN0+/yCWqEhhoHD34PjDfnoDPXidGVZZRO2SfLpioFXWRi3pOyjaR4i
         2IlOKwHbrJyH0XuYac8/2THQmweLTOSboT3BK8nkg9IxDITr54Hfi93Y0wf5U9Kb0Tpb
         15/bq8n4IPEZix3sNIz9n7PktEaXoyTE2rDdNKxKqeIHOGF5Pf0MT5v63Iw1T7PQe5L5
         du4DTdAYkOChBF5WFqrP0LG9hbcQtBd732WXh8qMFmxqXjKKONtGNCHIbFTtfXXPDl7m
         v3k9fW9zVDwm66thWxV3XcZO+byzcj6+28ysVhfyNxNsOMyM7ZWdUFEvivBPrKHHLsGq
         NL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729037953; x=1729642753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05Y/2FGPgyvbyYFbGsJUnsosQK0HSJiBFrb2Qq6aVrA=;
        b=fHSMEb4qHIORIWoYUnK5vqS1XqrO3lezU05lxN9BDYMYAQlWHXjohRfLWx8h1oDjrd
         TucJC/FK2cm2sBYpl5JNl/1BOSIIkFjRwsyHGnA6abJ2eg3VleVT7GfljD/bzqIppbv6
         EmRpgzleWj70plOTw1pae4B4CEJ98dOWf7D6bQMR+FzJdlyi7mFznAgJpn6CyDvgrVns
         ZWH58VDcDS1OI+IrsZy6nMauqC9zxGbXsOWc2HrUBepEqqi31ImDSiF1pLGJymT+tI/M
         t76DZHdDGjDy1J3xvo6mJxuvrVAEHmTDaZIR4Rt1gz7Cm1rF1GEGcOFfJvQ8YYA7lG86
         m/Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUMD12JHiZlslmuKJMDSGiuC2GLItkc4x6Jo/6FwQRHS7Rkp0FUzI2lc2QGxfF+1cPqPC4qoeDCbl6s@vger.kernel.org, AJvYcCVN034jlfIWcmHgcs6joWupWKHe5IdBQu5egshaOc8uP0riRkNPavjAwuEZnekchckQ7mbzvOfmASztXwQT@vger.kernel.org, AJvYcCXAUWRblpA8qEgaVmPsD87zme9ewDPXioreUaX3ysSEQb1ZGi2+uMIcjED1HS1BA2qW8J6uat5ar+/9@vger.kernel.org
X-Gm-Message-State: AOJu0YymcK6LhIWgelMw7jDa5Lpb71GTBdtPkACJ75x+T4tZP5jX5z3I
	cLK32ed8jrxWR1wxTjWBv88IXN2l9L+s8/lPkflP+DkJE4FuDwOQ
X-Google-Smtp-Source: AGHT+IE9HgCJhRnWQptiUjrKLZ5T1fYrbMbRfHuh8vb+zUtRxBOmbU+I5UJ/VxKiwNcLxD7n/D+MFA==
X-Received: by 2002:a05:687c:2c0f:b0:25e:940:e934 with SMTP id 586e51a60fabf-288874e3a90mr6210798fac.47.1729037953127;
        Tue, 15 Oct 2024 17:19:13 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-288daddf03csm621459fac.36.2024.10.15.17.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 17:19:11 -0700 (PDT)
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
Subject: [PATCH v4 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Wed, 16 Oct 2024 08:19:03 +0800
Message-Id: <cover.1729037302.git.unicorn_wang@outlook.com>
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

Changes in v4:
  The patch series is based on v6.12-rc1.

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
---

Chen Wang (3):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM
  riscv: sophgo: dts: add pwm controller for SG2042 SoC

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  51 +++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   8 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 181 ++++++++++++++++++
 5 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.34.1


