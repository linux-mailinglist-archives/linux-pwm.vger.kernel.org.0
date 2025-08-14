Return-Path: <linux-pwm+bounces-7043-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40573B2670F
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37F3117D95D
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E72FD1DD;
	Thu, 14 Aug 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htu5+Mgh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13B5191F92;
	Thu, 14 Aug 2025 13:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177707; cv=none; b=OOizPgKuLk3Q1WW87kzAFN3HjHchX6xDj+xrSpgQgmvX6iKRB35wOspqq0z+vsalmKGa5r7aKo/EWQJA0QqTl86JuNMgCN8B6CqIScXN3oHqGGlz3IDu9OES9Nimqa3Tvl/+ZgmTodIgA+CqrK7D3OT83SrKgU1KFBdur2Rj7TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177707; c=relaxed/simple;
	bh=0gNc8y0IxUkuy33DkYbXgIB1lUXVSIPD5J6S87Zz8uo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GercWxGBFgSkN93Ribzwo98tAzpmTZHUTmTw9LiTs8x8o4meEDfiyhgC8kXKO2TKquB/LdoCY2ajn47mKNlLy0iTq6kxDSHjzIbgcJUjr4MUYfHVK4MMdEjLbFnq0OuB5MFHtSOKmZAI43ZKX0yS4W9E+neZVYtF5oWXLBR6t10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htu5+Mgh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so6948125e9.3;
        Thu, 14 Aug 2025 06:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177704; x=1755782504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bMDJo186p2jEew+3Zrvp2fY8n4JWRnO1Ap6IS9F3qA=;
        b=htu5+MghSTtEpIvCtptHhN7BReJOz4mTY0s09QMrZqyOZ/Hw/fx4xJpZLAGVIBz4d8
         wWX/pKSgb6DPeoxiipf8pfVvV7CbjysSK94roSennAL65dzk7LuGA3Qu9UObqv7IU1bm
         BRT6rDpIZpOWMp4QkDQBA8TkT4fpGYjDCzIsFMbTG3JqNv3Au9hlinrX33L/jWIqyB4Z
         2d9fbgn4NIbepjCDapB2DP37bMczLOyU2DEmvAaTnC7cDpQ4HaU9ZCKKkhM3kwuSei1g
         2OBzVO3cl/kA8Z7IZrIzW8iPLhSmZInR+O/DyCsTYzKCuoWfl8XDfg7QqC/UbmVb8a4K
         Y2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177704; x=1755782504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bMDJo186p2jEew+3Zrvp2fY8n4JWRnO1Ap6IS9F3qA=;
        b=gwS/vcPtvvKJ9z8GFTDrTWs/ipdsDH3E5A9sHjO9cCH0pyYkrqOjgIn+R80E5GBx0/
         Zydv5x2zSmnYYrhMTMm4jswmWiyCRR5pmMl8YrB10sBvy8P65ScWXdPWGNiIlzI+isBY
         Br8QyvUieZK7rRn0Wy9r4xfqd2oA0fMDjNmkhbU7dy/Ec5+3ObJOVm1QGZY8BR2ttPLK
         TYemRWuiM6uwG5HhS7BPBJw3ITBsO15kAyoBqQ53yncWpybScHi28ZgrcdTKr8elXhlV
         Cni9ynCiC3Hxqr1nTHkvTiXyv61q/pKC4vSZnat62/FlyZZuoaSdxPPFLSnFPOg/t3+p
         iuMA==
X-Forwarded-Encrypted: i=1; AJvYcCUBs0rH07hJLLnDNcyjFyz/jHPAXX25DjwTqv+qgZ3WiSdd2I0KXJkYqjfd03w0LZHrZtzGIS+eqe2U@vger.kernel.org, AJvYcCULeoNynuPt8uAjJGFxH8V1ytSYsX3mn3948FYwXRombIC3OWDBs8Q0ge+rWwP/69Bp4uUf+qp9vUAqADQ=@vger.kernel.org, AJvYcCWCZl+ms+q+rWOL4QnlsRktBVw6RYJ9O9FYUQY1B79dvkh4x4HNhrACLghxgBQqknBnDe+IEOMx2suv@vger.kernel.org, AJvYcCWVGalRs8yw9u1CKOViC9gtTco8wlIJQzWP6476MCJkLBdHi9lHNQ1kFeCq1D1aWoMt4iOjnMEXiEaHwic=@vger.kernel.org, AJvYcCXVXlrciv1OG8eZbelCGQRX1TxGNwV6uTbjHSpy8NoYoLhbl6z/8sif50WQKyq/2qW//GVLd4kAa7TP@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxrUlgBgJ/LejtZlyBPEFniEXUhMNteoxx8XFQ+E+IHQahU17
	duoYXAENPVeFfGzsKJVzXWsv7Dbc1xGdLKwToiM50E44Bc+mXZKD/a/NmzWF
X-Gm-Gg: ASbGncvWDpYzGBrcgyACL2XH4qX3KfZFs1Eqivx40MS2AEPEs9iKSdW8I02p1NsgB2d
	2hvyzThaH3UAT8qlmtUogJUm84Kxt28ck74PWoDgfKZpdhGZeAQiVwuN3Yc5E4V1UpPaXXnkQKu
	CKe+4D/bzpJk7kfxj4rIR4TaRSIuw6JWo/gkOIQW3HmTSmrJ7+w9lodZ/abjC78/SWZZCsbI/jB
	KKpzWcgwZcvL+pR+5mwvimYn+661BWwAw5K6O1/qH3AfoivE8WrxMCd1PW9vkzSH4uD10l2eX7l
	6U+kOIKpwD1ZjXLUv9KFAVpIU5Wa08/2RCEHrC2lzdw2vmByicEmwfmnGH0Ef5S6N5DGzezQR94
	j+izdG86ObPC9mfSXWYJZr1dZ/fatBscP9dpZJoN1Kq8KAe8ymMF46qX0aqWH6RR0pgziNwzM2D
	kRKXQl+RikRTS+Go8eifVMdGMft3Y70z18
X-Google-Smtp-Source: AGHT+IGjryud1OAhsbQzG5opdza3J0arXvGMqqvPhb9Y/7Sf6esDDcwIpDPlr3q8nLe5TGjuWY/5zA==
X-Received: by 2002:a5d:64e8:0:b0:3b7:7936:e7fb with SMTP id ffacd0b85a97d-3b9edf3897emr2394083f8f.30.1755177703292;
        Thu, 14 Aug 2025 06:21:43 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:21:42 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: andreas@kemnade.info,
	peter.ujfalusi@gmail.com,
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
Subject: [PATCH v2 0/9] dt-bindings: Convert TWL4030/6040 family binding to DT schema
Date: Thu, 14 Aug 2025 15:21:20 +0200
Message-Id: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This series modernizes the Device Tree bindings for the Texas
Instruments TWL4030/TWL6040 family by converting all remaining
legacy TXT bindings to the structured YAML DT schema format.

This improves the bindings by adding formal type checking, clear property
definitions, and machine-readable examples, which allows for automated
validation and better documentation for developers.

This v2 series addresses feedback from the initial submission, adds a new
patch to fix validation errors that were uncovered by the stricter schemas,
and includes several other minor improvements.

Thank you,
Jihed
---

Changes from v2:

  - Add new patch (9/9) to fix the parent ti,twl.yaml binding by adding
    the missing sub-node definitions, resolving dtbs_check errors.
  - (1/9) ti,twl4030-audio: Moved binding to sound/, added enum for
    ti,enable-vibra, and simplified the example.
  - (2/9) ti,twl6040: Renamed twl6040,audpwron-gpio to ti,audpwron-gpio
    to fix a vendor prefix validation error.
  - (8/9) ti,twlxxxx-usb: Added '#phy-cells' property to support the
    standard PHY framework.
  - (7/9) omap-twl4030: Minor cosmetic fixes, retaining Acked-by Mark Brown.
  - Other patches: Minor description and formatting cleanups.

The following nine patches are included in this series:
Jihed Chaibi (9):
  mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
  mfd: dt-bindings: ti,twl6040: convert to DT schema
  input: dt-bindings: ti,twl4030-keypad: convert to DT schema
  mfd: dt-bindings: ti,twl4030-power: convert to DT schema
  pwm: dt-bindings: ti,twl-pwm: convert to DT schema
  pwm: dt-bindings: ti,twl-pwmled: convert to DT schema
  Documentation: omap-twl4030: convert to DT schema
  usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
  dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x

 .../bindings/input/ti,twl4030-keypad.yaml     |  44 +++++
 .../bindings/input/twl4030-keypad.txt         |  27 ---
 .../devicetree/bindings/mfd/ti,twl.yaml       |  63 +++++++
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
 .../bindings/sound/ti,omap-twl4030.yaml       | 102 ++++++++++++
 .../bindings/sound/ti,twl4030-audio.yaml      |  90 ++++++++++
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 125 ++++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 -----
 17 files changed, 740 insertions(+), 327 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt
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
 create mode 100644 Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.39.5


