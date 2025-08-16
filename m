Return-Path: <linux-pwm+bounces-7078-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C8BB289FE
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 04:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19E6BAE47DB
	for <lists+linux-pwm@lfdr.de>; Sat, 16 Aug 2025 02:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA035215077;
	Sat, 16 Aug 2025 02:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LT/nxOV4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8C71A2390;
	Sat, 16 Aug 2025 02:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755310711; cv=none; b=O0iXjeZVhRUa7mLC7e7iCg/7MYZLGg50dEoYn/9RJ5apWNqhbOmm6scJHmQ9WW+DaSeCXtPiT6SwPjrs1eDMBcMH2nRCiJAQhijEWgDEvL9AAkT+jRM2EkEH+iLU96JK0Ocx/MDMF9GrB8Hu5cmK4YVqwtwaT7x4HXZrXSjLdJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755310711; c=relaxed/simple;
	bh=LTAk80ojjlxDjMNbAIhSaXgRHd6phArsoagHfBi65pY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TpD79gRhRtMW2jHw0b4/30Zvy6IEIUQZ41AigyOnZzkerD8f+C9EvgZy2JBQA2YwCIi5jKftQvy0crNc/FWHmuCn2VuwevUYcB+XkSLWO+TpGx/9azi65NirS6n/MZKrQZg5Cnru6d1eEy3Uwbw5yKQ55vVBluksgFodqhTIL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LT/nxOV4; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b9e4147690so1507145f8f.2;
        Fri, 15 Aug 2025 19:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755310708; x=1755915508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CndxzlsZCtg7d9Z//XgRlEI2JhvocYMg+RhFNFhIuE=;
        b=LT/nxOV4eqrHY8tjN/veWj53Z6t2b1fFhag1ly+nfO8YN0krthpEntyhQ0FgYswvcD
         Xn62QTupl48cIQcj49a0xfJYnLYC7BHzs4izHZ52zkTimlS/7My4eiqRHMHyJACHRE9Q
         J7Sisp6ElG0w1b/T9xZKr84j2zVKIEXReP7DLSpWsuQrzLJfWhcty/TXPKFszUTevPEx
         ZblMi+eO8x1j90fnsiqAShkRSsSxrymPcCeT+gcvwVnossRvBq8tapR6vnvTMWYNzeNZ
         tvGWsuO6iX5uIw0L8X0uW+nRU4hq68dymDUaNdCQ7rxf5HUgKmYRZ8IHpDFPhGyRlxDR
         N+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755310708; x=1755915508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CndxzlsZCtg7d9Z//XgRlEI2JhvocYMg+RhFNFhIuE=;
        b=rR3aiCbXpEelVrC5kuuQ0/3slu8LtjVAPv9HR7MehOh2a7RbF6G/t2q3cLNIEfDSWy
         PI+q3fEX3ySO1lm4DV/SV4O/qGljCYWrXp5PRha2XoN33F2zIpyLw+Kd3Z+sSdmsK6t2
         1QEAJHiBXAwGbgg1Qyv6TH/WDnC4e9b41setqSSp4t1RGJF0sCNGJMl31hZtmFmKF60C
         YKkTDxdwkZvbWgvHwJOXPgkUdrWgUCKvSqT7lhAIzG/GvC04LWwuxzW/qH0IvOeI/Bgg
         7XyFOlpVvjtktF3mTsvoFMQGKrE+At/xM5Lsxd43Nz4xHRwSSt52pY1W9Scx71NUIbU6
         fI2w==
X-Forwarded-Encrypted: i=1; AJvYcCU15/FMRZTa1Gr5raVpGEsXCiIQxiDEnFThhgUPGf7jfoduxAZkvOUfUHTD4LYUM0VY/2ue4KzXXFPJ@vger.kernel.org, AJvYcCUfo2EaVSJoL7qRCJtK1ioG3vUHZPEZLyQjRiNeBdR8UCYCo/HoW9WqJGafT/68jkIqEOJ5eyiKKhZSQcE=@vger.kernel.org, AJvYcCUpsFXfR5S131nB+Ug0Qk1z+qmGwiob6/WYUHyZt3UylcQ0NJnFN8tL6A3hs5LRO2RoNNZreonAgte2xA==@vger.kernel.org, AJvYcCVr4w9GLKbym+BE0I6dAX52TCerZNIz0xoWZzJw28hKbs3VdmYScJ9BO/E8CYpitM5WWcq+opCnDqZ7Kdc=@vger.kernel.org, AJvYcCWityn1BQYWDa7B9Bu4+lnWCASdPgqGgb6YNY0bhl3dDtIoxf3IUIVG6k2M5BkhcqPIFIK0/nuW0/3GRg==@vger.kernel.org, AJvYcCWxZowLhTKugVOOsmrEB7bu/sbnGV9pTMEMRt+Flazn+8fh5HIOJXcAmJi8epuThN/dWAZGT6Ohn06f@vger.kernel.org, AJvYcCXIhZUWtNmmsSZLsWp5nKMDDwthNT5utfsdSjAdtzdiJhZcRbEQGPwjYK1RXRgDXky3iyQ8MHoTmZ78@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkvBW0mw5UKQQ987dizKA5tFhqy+X98cRvJpKqlBNQJU1140f
	ponMTQpnx5+XleB2ngLpzMlgrqCFxFx5HKh9jBpkFh92poYWBi9kms6KpbV9cps=
X-Gm-Gg: ASbGncuqJ0rNijXd8uwFqQ30UpuvhsXQpqvrMMxMgkytxuew9wHjaJC2m/xbQIPtUj4
	ssD7EilZ9Q5Tqsj3+WcjINAiRsH5nqT8UDB8dcN4yUPBmPqrfwhICXNDLLRSMP12Xf7+GklWLmb
	B/UZWVgkW0j+IAryz8hU20iUIGiBOJEHi9AqRgRWk7q8fqWD3cGvlvhwJQm1PqifxDUrxf7uto8
	6Mv63ovMZPaeS828N2nmRyTJ7iQptw0Untw/C//sQlhJ4amg7Nn2BpGb+CD/GDH8yEbvlIo1H/0
	jd/yB/zBkav5po/BFWOoGk7SFTVaVa2W7TGnnxkBFHFhWgzR3spMktcugdgefqE/Ytbzy0DFyOg
	kJvEvYG/BDXNDPG8ni9VCShochA/lri+0XNz1VlVp1MJReRQ=
X-Google-Smtp-Source: AGHT+IEXy+zIhMtHlBqxHaP/l0gZKZqeddXpLu+bDishkzNCk/VPNPCwjMO4/biZa0rdMq8hY9j0Sw==
X-Received: by 2002:a05:600c:5253:b0:455:f380:32e2 with SMTP id 5b1f17b1804b1-45a26784347mr7315375e9.18.1755310707825;
        Fri, 15 Aug 2025 19:18:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:212f:1af8:ee74:5774:2fc2:70a1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1fe2c019sm58712535e9.17.2025.08.15.19.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 19:18:27 -0700 (PDT)
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
Subject: [PATCH v3 6/6] dt-bindings: gpio: ti,twl4030: Correct the schema $id path
Date: Sat, 16 Aug 2025 04:15:23 +0200
Message-Id: <20250816021523.167049-7-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
References: <20250816021523.167049-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The $id for a binding should match its file path. The ti,twl4030-gpio
binding is located in the gpio/ subdirectory but was missing this from
its $id.

Correct the path to follow the standard convention.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
index 5e3e199fd..96d50d14c 100644
--- a/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
+++ b/Documentation/devicetree/bindings/gpio/ti,twl4030-gpio.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/ti,twl4030-gpio.yaml#
+$id: http://devicetree.org/schemas/gpio/ti,twl4030-gpio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI TWL4030 GPIO controller
-- 
2.39.5


