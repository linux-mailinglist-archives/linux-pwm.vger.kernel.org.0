Return-Path: <linux-pwm+bounces-3522-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AFA4993D37
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 05:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E9F4281B39
	for <lists+linux-pwm@lfdr.de>; Tue,  8 Oct 2024 03:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 528A625779;
	Tue,  8 Oct 2024 03:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+mhHZuR"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9212209D;
	Tue,  8 Oct 2024 03:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728356615; cv=none; b=BbE3lHKTw4BoCSiTFyXxnzolWzLGCdd989zuXv0sRZAxCX9yFkyB+GBlmQmpLTAFzD/XElB1Tuv7TbUvVmoFdJwcVlLVIJ7kGsIiPIe+1LMw7Cnyz9Cf8Q0Ekj07AfBdRq6m8kSpXAOIBbfWeh72tH++G8zcveyTJmDzXlkNCEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728356615; c=relaxed/simple;
	bh=mgt+A0mSURrJkSCX7lKfHsp4PJKezveacZRt+11sSo0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type; b=DUnEo86yOwB0+NF/UnPzKz8+t9MQUPHv+cLWu/o+9+XM3G7hDBkAwrpwqKd8S3C86t+8sVIx1uGOCfzKSMZUdGYuvwj/TRQU1V9LyFTs4zvtMblefCY/vR+nl+Ki4STqI9UAK2QxlaUXP4hWCMw+v1eyk3PBBtpQHoPOw0YWLGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+mhHZuR; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3e3937ef498so2716534b6e.0;
        Mon, 07 Oct 2024 20:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728356613; x=1728961413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OPCUUbWzHp8NM5YoGoqd/0bpMAXMv05kAUGjmLeDaoY=;
        b=S+mhHZuR2uB5GYOH0WIjgNb1CdDS8UiWpbQdLl6MOSzBaoXlZRF1dFyDPMOD6R/pO7
         vYFjVi9GBwD2xWAySFXgtiQbtTLqGQBgJQCHeSuyhyXWeABdl1g48lJb4Y05DiHYZmBE
         js3OyP4xTZdMXBADnWShMtp0mtH2HjJoIp0r/1bxsn+DTmyS1XySbG+PV0KPvACELu3v
         lPzxKKiEmvtNOr+iK0lYlevx2t0hp4dBjZFq3arCNqTPo1SO3aGDEEarRxo9pz4JAdsA
         8vhzQcluZXNrKQhKqW8nEfuPre/qN/0u6Q+LNlhI2y+NNaYbaCcTCsD59os1iJciop3r
         GMbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728356613; x=1728961413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OPCUUbWzHp8NM5YoGoqd/0bpMAXMv05kAUGjmLeDaoY=;
        b=ROt/bD76JmqIC3MfHUjU+J8cIF/E4DIqDo7hlurBfL4/fLjUYMGb++yU0rAo2pDAa5
         ebVxh2hQm1WEvPKP0rUG8Lr5mCpg4knNY72olgKqwn6D/jkjBt1O6U+u7dbdrBFQ1SER
         U5zPxQucgrjGmyua3hln+oP8ga+lU/u15aP3185sd/wU2qNpO/qfwFGTAxj1pK5IZcYW
         Qgm6VmpkIB+59C78P7LEBeipLxc78w+7NFl25HExskuZXuuK4UAAQ4AvF6mC123IvAxK
         TTkuY/tTJKzoEAkcYNXJOkccCtOPGCz9id4rognKs5VPLwbmfusPRe85LzyvCjcEc96D
         HgSA==
X-Forwarded-Encrypted: i=1; AJvYcCUrejX1j0ZclHtzwmC6pS2svBG2LPyqxYyu6HKE7hedGynAjZ2ePgjNP2fCdfj5hjURJvVEsmH/onMi@vger.kernel.org, AJvYcCUtHOiKgv+0FccUq8FkugqZ2Rb3F/ZmlQhGEZu/3idqSa2o77GQt8/w0zAZym7Ts4ZaA5BeKwdZdwvP@vger.kernel.org, AJvYcCX9VCIruHhUulvoPGJ3X4xKEoZ9ojvHs/MTwGufc1oJv4S0iKB9XV6SrHQkWNiRaIPB+it6VfVhjKAyK8u5@vger.kernel.org
X-Gm-Message-State: AOJu0YzYhk/p6UArdoSUttaaW9Z3qgm+NEcUpg2Rl+GV18JRJBjTpSot
	Y/Z8r0lF/gC+u+Gw8drnX1xo1Y8nZzNCZPIZ8Gt1WygXjJk+DsKX
X-Google-Smtp-Source: AGHT+IGWVTgoyLRP9RgqssySKhVHhNUcveZm74CAJE7t6Iy+N3hyk4eppTUua9qNSKLjYjXO6Aoh1w==
X-Received: by 2002:a05:6808:1b8c:b0:3e2:a1fe:f0c6 with SMTP id 5614622812f47-3e3c131703bmr12102671b6e.6.1728356612835;
        Mon, 07 Oct 2024 20:03:32 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e3c9013386sm1782749b6e.13.2024.10.07.20.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 20:03:32 -0700 (PDT)
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
Subject: [PATCH v3 0/3] pwm: Add pwm driver for Sophgo SG2042
Date: Tue,  8 Oct 2024 11:03:24 +0800
Message-Id: <cover.1728355974.git.unicorn_wang@outlook.com>
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

Changes in v3:
  The patch series is based on v6.12-rc1. 

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
---

Chen Wang (3):
  dt-bindings: pwm: sophgo: add PWM controller for SG2042
  pwm: sophgo: add driver for Sophgo SG2042 PWM
  riscv: sophgo: dts: add pwm controller for SG2042 SoC

 .../bindings/pwm/sophgo,sg2042-pwm.yaml       |  51 +++++
 arch/riscv/boot/dts/sophgo/sg2042.dtsi        |   8 +
 drivers/pwm/Kconfig                           |  10 +
 drivers/pwm/Makefile                          |   1 +
 drivers/pwm/pwm-sophgo-sg2042.c               | 180 ++++++++++++++++++
 5 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/sophgo,sg2042-pwm.yaml
 create mode 100644 drivers/pwm/pwm-sophgo-sg2042.c


base-commit: 9852d85ec9d492ebef56dc5f229416c925758edc
-- 
2.34.1


