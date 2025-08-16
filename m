Return-Path: <linux-pwm+bounces-7072-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A67B289D6
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC32D602383
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8FF19F12D;
	Sat, 16 Aug 2025 02:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX7+sNB2"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826B849C;
	Sat, 16 Aug 2025 02:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310699; cv=none; b=dJpRFe51Zeov2yeUD6xko9WH5E4kHTsiyXrZFTtNZKX617B2kfBSvArj1ykRqeuNYqzsELaCQl4hMxF/HGnmJElVOZahn/72/C04KQun2aAiUWDuBg0+BLZ9IB0WrWTmAt2Ubaap7yBL3+kgMaUloEntfK/uajiUmRFMoREVeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310699; c=relaxed/simple;
	bh=aDy0qVp2q5+Lq4LeUAw8NC+sBlWqtCUZDD8aXWVCbdw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ue3UfX1hI1OTScbOaScLzCbZyH9OAxqSep+cTgqWx0k4+SlLNmzjNNZD1xkdVaOSPZu/4VhfWZCgZo7kA3PwCzXA40xpQYV56c/Xz6YG3Tm4fXfH5u8UtqVvvhoMeuQW2H0atojRpaNwrq6rJxbuSo91wP5ZdBaPP0yhC8v1cOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX7+sNB2; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b9e418ba08so1357638f8f.3;
        Fri, 15 Aug 2025 19:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310696; x=1755915496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uIJKDcBWWluZRtog13Tx7W4gOZJkTvCgk5uA8HdkcN4=;
        b=gX7+sNB2l/CedCUUBVxeuaj1I1VXW9nEAGZ52tXoAVXIQz3iCFJdblxYhFEVlanlGc
         aarpjzEGE5M8YvtFiSvinmgxbUHzQlHP/Msfi1CBJz56kEt8LX36BKzP6jHm/BrT3UjH
         gS1LALi4D4mPWWSnKoFQn8IQ8iaoMBioPBVELmFCnkVm702SIMxfhMCFFIPB+6khu2DF
         i1r+tgIlmzhuiltHWJT364jNKA+rTeySkNVJeggGw9FUnsoiL4IcC0V/fterwJWkPlOw
         oEShRifMpSgFtfIrvXAQ4VUjXCflIgDpBb6ENRzWc5nULsnaiQBlD6h70g14brm1XeQ0
         uFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310696; x=1755915496;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uIJKDcBWWluZRtog13Tx7W4gOZJkTvCgk5uA8HdkcN4=;
        b=Ct2WQ4KEmr7tRULOClDKGYfGFV2kwc8/DmhJ0JvWcLeSXSnob1edrYnF2UdTHdAhUs
         sQGGgA9BBryCtHbMWllMYVwymX6BdoGTWZtA0DwIocxKvqqC0TvkTGmA5tx2qBlMVAHD
         UqhmnVFt426zUY9qnP+jUeAJ4ZRoTq6Jqw3Qw4AMb0/gYqwAT+h45FUCWWgE/JuGxTsK
         T5pt0v3MT218bF4eW3SPDoM/Igc9h7DlaUGPjOpGfbZo5jZCA56VrMuAARUmSP3zY6mO
         qGH8LW2X01/1At5IGRrmqsUcXdkTQCun4RYAuTvSXiz3SFvHQ799DbDBRwtVrn5L/N9d
         IdWg==
X-Forwarded-Encrypted: i=1; AJvYcCUA/wHqDP1H9MCRDu2DT2YYJd+fty0PzlZ7Zk81yoD5bAyOvxgGvUZqnwIVIDYfQagk6vybSZWb1z4CCg==@vger.kernel.org, AJvYcCUdSx6tPsV1/R3MCO+W1dwDrcZ9XKhUr2daEYS8Y1ju1xvmfx0fR55skQGht105yXis3k6xxnKkQcz1HR4=@vger.kernel.org, AJvYcCVbk/bJzbAiIKzDsSCaPdXcJ3z1Ps5Kib3TCQ5f7g5u8yfaduDrWItaqoadgvNuXZ4s9OJulvVu2tnB@vger.kernel.org, AJvYcCVwhUOS+LePzbelR75rJV0eQa7PlYpUbBSg3nOEy5xe71Tvp7OAbbfKAty67Yuz/IKMWn6EYmNU9hALAPo=@vger.kernel.org, AJvYcCWOmMEap6Wg0M4Fw8PYsPexZRbsCLqPNS5RCWB+W5BCU1x6Msi4JSZFIn60DiSWsEpZhrHc/2SxQo3nBA==@vger.kernel.org, AJvYcCWgEjFdCMxwkPZDLxLoTHfSLoEAhZRwhmWrigpQIqlbiqpLn0eKe0Pyy+xi6lGAF8GbIWZjNbDa7FEF@vger.kernel.org, AJvYcCXGZzij2QSCdaae7Zyv7JRDxwcU3nsYRfAMSmpAzSwKSBRm7zO57wQVaBoMyQAsUDous5BIg1m/zwkE@vger.kernel.org
X-Gm-Message-State: AOJu0YzECpEZ4aHJOCFiqI5LQh6MqvIBzOOcCM4f5xaAawOPkcWpD7jz
	+vRPIjcwbmSsIVALes4fGWMaZZN0Lceh+ZR6vuVOcA8eNsBU6FRdPt0rWfwKhok=
X-Gm-Gg: ASbGncvUyVd2rL+6odRmNYme8tlz4eOcHjFg4mbcZ8LW8f60UZPIJyUDQ4c+lYHwPS9
	PJezIVrbOSxn03N3EBDqwvxT+AkQ8LtaA3QhgiSSDgVTe8fmhsNfL1yKqk7mrN6/krudLDWJoQ0
	v0RuqV6A3HNzvMYcyXcVvdrVZHpyT90oQllGHh+wPVtRhSQ9oOR5d96NWMMdIFWomuj365tcGQG
	aC9vYZc2XnR2Guw3GQCU2zaySJt0fxGnfG3+fRODgJ8LjEeE2zrT+lQMT2AnZTuFmth6cBThW9H
	bt++wOq5PB9BCAVzIpo1eYmfFSxKxrXYBcDBlxJIFTI7TujFi3psbhaus+tNwgtxelFqTbcGiuM
	F2zkB9S0/5STkPDx/U3vsJN2lAFLHfDQgGj0NJT2/cOvt2Pw=
X-Google-Smtp-Source: AGHT+IF1htkecc9HAJQpPjefp7HjSurwKvKSIKB7tOJ4/onjIyj3P7jRr6l43jLYoWPhKfwlfQ8Ulw==
X-Received: by 2002:a05:600c:4509:b0:456:19b2:6aa8 with SMTP id 5b1f17b1804b1-45a26784353mr8573715e9.19.1755310695624;
        Fri, 15 Aug 2025 19:18:15 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:15 -0700 (PDT)
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
	linus.walleij@linaro.org,
	brgl@bgdev.pl,
	aaro.koskinen@iki.fi,
	khilman@baylibre.com,
	rogerq@kernel.org,
	tony@atomide.com,
	linux-gpio@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-omap@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v3 0/6] dt-bindings: Convert TWL4030/6040 family binding to DT schema
Date: Sat, 16 Aug 2025 04:15:17 +0200
Message-Id: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

This series converts the remaining legacy TXT bindings for the Texas
Instruments TWL4030/6030 family to the DT schema format.

This v3 series addresses extensive feedback from v2. The main changes
include consolidating the simple power and PWM bindings directly into the
main ti,twl.yaml binding for a cleaner structure. It also adds a fix for
an incorrect schema $id in the ti,twl4030-gpio binding and corrects
various properties based on reviewer feedback.

This results in a cleaner, more accurate, and more consolidated set of
bindings for this TWL family.

As requested, the unrelated ti,twl6040 binding conversion has been dropped
from this series and will be sent separately.

Thank you,
Jihed

There is a typo in the subject, "TWL4030/6040" should be "TWL4030/6030".

---

Changes in v3:

  - Dropped ti,twl6040 patch to be sent separately.
  - Consolidated power, pwm and pwmled bindings into the main
    ti,twl.yaml binding, removing 3 patches from the series.
  - Added new patch (v3 6/6) to correct the $id in ti,twl4030-gpio.yaml.
  - Made 'linux,keymap' a required property in ti,twl4030-keypad.
  - Marked (very) old ti,twl4030-power properties as deprecated.
  - Updated commit message format for omap-twl4030.yaml (PATCH v2 7/9).

Changes in v2:

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

The following six patches are included in this series:

Jihed Chaibi (6):
  dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
  mfd: dt-bindings: ti,twl4030-audio: convert to DT schema
  input: dt-bindings: ti,twl4030-keypad: convert to DT schema
  ASoC: dt-bindings: omap-twl4030: convert to DT schema
  usb: dt-bindings: ti,twlxxxx-usb: convert to DT schema
  dt-bindings: gpio: ti,twl4030: Correct the schema $id path

 .../bindings/gpio/ti,twl4030-gpio.yaml        |   2 +-
 .../bindings/input/ti,twl4030-keypad.yaml     |  59 ++++++
 .../bindings/input/twl4030-keypad.txt         |  27 ---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 191 ++++++++++++++++++
 .../devicetree/bindings/mfd/twl4030-audio.txt |  46 -----
 .../devicetree/bindings/mfd/twl4030-power.txt |  48 -----
 .../devicetree/bindings/pwm/ti,twl-pwm.txt    |  17 --
 .../devicetree/bindings/pwm/ti,twl-pwmled.txt |  17 --
 .../bindings/sound/omap-twl4030.txt           |  62 ------
 .../bindings/sound/ti,omap-twl4030.yaml       | 102 ++++++++++
 .../bindings/sound/ti,twl4030-audio.yaml      |  90 +++++++++
 .../bindings/usb/ti,twlxxxx-usb.yaml          | 125 ++++++++++++
 .../devicetree/bindings/usb/twlxxxx-usb.txt   |  43 ----
 13 files changed, 568 insertions(+), 261 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,twl4030-keypad.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/twl4030-keypad.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-audio.txt
 delete mode 100644 Documentation/devicetree/bindings/mfd/twl4030-power.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwm.txt
 delete mode 100644 Documentation/devicetree/bindings/pwm/ti,twl-pwmled.txt
 delete mode 100644 Documentation/devicetree/bindings/sound/omap-twl4030.txt
 create mode 100644 Documentation/devicetree/bindings/sound/ti,omap-twl4030.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/ti,twl4030-audio.yaml
 create mode 100644 Documentation/devicetree/bindings/usb/ti,twlxxxx-usb.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/twlxxxx-usb.txt

-- 
2.39.5


