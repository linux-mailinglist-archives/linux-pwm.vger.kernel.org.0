Return-Path: <linux-pwm+bounces-7005-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A105B21891
	for <lists+linux-pwm@lfdr.de>; Tue, 12 Aug 2025 00:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7368C1903B75
	for <lists+linux-pwm@lfdr.de>; Mon, 11 Aug 2025 22:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D27D1F463B;
	Mon, 11 Aug 2025 22:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeJZz4iz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6993C1F948;
	Mon, 11 Aug 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754952470; cv=none; b=LQPT6wSjagSpFhJskd3qrJx3chWAN/uBAELuRToI2x+HVhpnrsvq/qAV8JWWmGHtA9ZfXQk7opWb5rS/82YhcLEhYnw0PPkpeyKfAEOxuyaF/rQ04epL8J4F3b2N1OjQrU4qf22AqpiF/bq/RRyYR1ZFFQMZ2b7xTMsx7pP/X8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754952470; c=relaxed/simple;
	bh=IcUTq5iwG/KanHRp34pDfsV1t4ZOxfXSCyrMBmgGyH0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vb0Eu9SOQVO1N1UURSDc3RmCFB1Syvr/VqzWCz6Ne4q101XaeiePMZBYPc6xDdeG+YjIyA+4qnyNgqTNMND5G61S/Bc47/edH9vZGp2GTogpgQBWHB3rPfGrRbjhIlA376Dm3xcI3P0pTwTzYZGhJ0RnhKrhC7ODx7/ajcWlgww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeJZz4iz; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78b2c6ecfso2628654f8f.0;
        Mon, 11 Aug 2025 15:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754952466; x=1755557266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gh502WkusaTkmyG0Spy7bcgdYWp2HJ8npYN0OFby5Zo=;
        b=PeJZz4izIPupO5KuQQAxsjAkZUcBIsuJMGeJrMyQYMq8XS4gBFzM6BBgbjdm4ZirXi
         tjPK11UvUdZJZtD5iDwAqkgX/s4SdBQEaCNFk0Sy/r8opfaOqdVhoiseRfYdmU7YYtx4
         P2DSZJz6tyTZnX5H1gwp4HByyBZ6HVxkfIG7QDeE8WJtZyB82y6iRijAVm56CqI8zvxK
         Qc9OsUmZ25hjtNfSMTdkCoV4uki4htjE+C3S8JEPJUExyRdQcPmPvnNcxBPZd9TOeqXv
         bTRPbW+PpDWmgWmX8U03XCduyfulDRMJWsWZ0OZgeHVLWG3Y41EwMnr/gf91o0Yrt3L/
         ouig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754952466; x=1755557266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gh502WkusaTkmyG0Spy7bcgdYWp2HJ8npYN0OFby5Zo=;
        b=jkurnvp+bg2BqxAGXalG3pIbOvSNvfUx4zfDe7X4yLZ7XyhhuCczO2wKvOyCgx0lsY
         9Q/93GzJuKpV0pRFtQ4GI0Ix5agpWUta7AnsEi/ELKFsWtIr5u7agTVZLLcj4vbXNc0o
         sfrtDGCRulzaiDpYRF2iFWIS6Jjj2vQ7KqnusY1N3qjUDOWAAekavNzUbYw9t4bn4umy
         sagb+2IF9OA55FYoj0jtLY/le6ZEINRqSau0MuKKF93rh25MTsUVB1YPDgNq0Wp8drCD
         SFUFwNxyP+Qbv99lw2TqBka7wuHYUJSNjxQR4DXxk8EhDqL35+lu4ALdJ/aitTob3KoH
         Q5DQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3+h0Vgyvm+CSDFEeliwTEEmqY+oNkIWs46UgednUVziijULUrdkv8To/mZK+MnDsOzg4dtIIlA+nc@vger.kernel.org, AJvYcCV9Viy/EhB9bt7Ojha6bm5e4Q1nt6GcGo4AF/k8GO6eIZ4bibn7NyYbtFKz0ztQUaU7VQlUrKInefPi@vger.kernel.org, AJvYcCVzLq+/Bow7d7ykRYi6xNQIAdqL+FPSO/uB4+qlpZU8ShEyNRKOSitECoZC+9KacVB/tA6H9g9dWamm@vger.kernel.org, AJvYcCWxIUr+T3bGyWR3A7CXb19MNkC1Go+G4ezIdGJ+ud9hrL6aD2OeItHeojtftK55nxjCiHrjx3PHQYRTQGk=@vger.kernel.org, AJvYcCXotcqN4fvVFT+1Bmp66yQOrrA2ruRyxMIhOLkhDStrWfbcCmDJzXA8YXfH2JabpC0e9W9BwFFY1NF/gWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1FtR2xr4NmxB1u7c3/gjyYhc8koOnMlgg9yiYRvt5T7ocEtgf
	TqHGKyra5iPd6RU7VuPqH2sTezyXoBW0k/kUsQlHM8kXRtCxA2Fm9mGALe2PL9yiYg==
X-Gm-Gg: ASbGncu1EQz2nxOTpzoUTOmBj+83itqvXQ9e2/+NEQ+OkBUni+QvYXhjWBPo4d2bhLb
	QV3ZKxVpPWA6oy3A6ryAEz70q6DicJZq5U5lkP5TSb36KE1Le8MAKrYao5eW/fh10UtKX1IqdNB
	u1wAzoZQ3zqkZhL7jNEe8FR7y7N3udEMf+jdb6+CmzfG7ARO3koSaDzoW4wjnyW6hZfnQ+LDWMM
	KhX4+dCbGCdm3bQY5jEEDidDyp3H1dzB11aVo1dVAc2fpsUJMpFCGzQeIL7h6x5Ybd+pj+waZ+U
	gH4tN9+7noD11+BIDDwkKQPPKlTjGyTb360pSNnwOu3SEYPzGxa4GAgsfGo+VZsar9f7QM8E7KU
	70FBp47kttqe8FJqMw7lPAFXlHScjQ8xmBuZsS0x9ZLcX5os=
X-Google-Smtp-Source: AGHT+IGUJhjcdu0pxWoIH7hIgQBl2MWtDsz3IxGcteSPIo1lTpSxVwEgRTX0M5SzVOnQPUY7qp82tw==
X-Received: by 2002:a5d:64e9:0:b0:3b7:973b:39bc with SMTP id ffacd0b85a97d-3b911014b74mr1051233f8f.54.1754952466252;
        Mon, 11 Aug 2025 15:47:46 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:224f:9b35:8c56:5611:71e6:ca77])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459dbba5210sm343678175e9.2.2025.08.11.15.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:47:45 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: peter.ujfalusi@gmail.com,
	dmitry.torokhov@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	lgirdwood@gmail.com,
	tiwai@suse.com,
	conor+dt@kernel.org,
	lee@kernel.org,
	ukleinek@kernel.org,
	broonie@kernel.org,
	gregkh@linuxfoundation.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH 0/8] dt-bindings: Convert TWL4030/6040 family binding to DT schema
Date: Tue, 12 Aug 2025 00:47:31 +0200
Message-Id: <20250811224739.53869-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series modernizes the Device Tree bindings for the Texas
Instruments TWL4030/TWL6040 family by converting all remaining
legacy TXT bindings to the structured YAML DT schema format.

This improves the bindings by adding formal type checking, clear property
definitions, and machine-readable examples, which allows for automated
validation and better documentation for developers.

The following eight patches are included in this series, covering the
audio, keypad, power, PWM, and USB sub-modules.

Thank you,

Jihed Chaibi (8):
  mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
  mfd: dt-bindings: ti,twl6040: convert to DT schema
  input: dt-bindings: ti,twl4030-keypad: convert to DT schema
  mfd: dt-bindings: ti,twl4030-power: convert to DT schema
  pwm: dt-bindings: ti,twl-pwm: convert to DT schema
  pwm: dt-bindings: ti,twl-pwmled: convert to DT schema
  sound: dt-bindings: ti,omap-twl4030: convert to DT schema
  usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema

 .../bindings/input/ti,twl4030-keypad.yaml     |  44 +++++
 .../bindings/input/twl4030-keypad.txt         |  27 ---
 .../bindings/mfd/ti,twl4030-audio.yaml        |  91 ++++++++++
 .../bindings/mfd/ti,twl4030-power.yaml        |  69 ++++++++
 .../devicetree/bindings/mfd/ti,twl6040.yaml   | 155 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-audio.txt |  46 ------
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 ------
 .../devicetree/bindings/mfd/twl6040.txt       |  67 --------
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwm.yaml   |  46 ++++++
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 .../bindings/pwm/ti,twl-pwmled.yaml           |  46 ++++++
 .../bindings/sound/omap-twl4030.txt           |  62 -------
 .../bindings/sound/ti,omap-twl4030.yaml       | 101 ++++++++++++
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 121 ++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 -----
 16 files changed, 673 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl4030-power.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,twl6040.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl6040.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.yaml
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.39.5


