Return-Path: <linux-pwm+bounces-2192-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01F8CA2FF
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 22:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E870B281BD5
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 20:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B713956A;
	Mon, 20 May 2024 19:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="U3DoIdXM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93ACE13665A;
	Mon, 20 May 2024 19:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716235195; cv=none; b=ixNA2jlm8iDki0+sT7aJfw6mk/9Wn9/aG72pCUlIkf5YcpnSAvU8R/CiVJ6EbR3TEUR+bt/F/0IM/Axy/i8Z69M2sTVr8YKKBmX0CbwCVA3nUhtOtAZY7dfL7UWFxgiemhoKBo6BMmODK6lNE367eYRWNDaClfRi4PcmYg0kK4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716235195; c=relaxed/simple;
	bh=pwfh1HNB6ejIfQ8JrKO9PRDbCXrx5uV4yhJeYYaiDvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tMCEhfEQ+wxb3ZMcYmwzxuvy1KnQKhTf43+4eqrYXXhEAxF3eQPyvw1HRqG86q5UUi1kDJtfrD4UT50aVkzeoFK45RK4IGPGFve/MVOBduJa0dDOGNZt/lffxfEjlChU6lQ0StVXWlmdEDiaH2qqD9hB1Sjt4hqBNvhv49BHPZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=U3DoIdXM; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 99EF7EBB;
	Mon, 20 May 2024 21:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1716235180;
	bh=pwfh1HNB6ejIfQ8JrKO9PRDbCXrx5uV4yhJeYYaiDvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U3DoIdXMI/EIM1O756bGUJlOIRbTUzw3se0GaiKuScuEfmjpPu8/hReq4Z+vzCFq6
	 s1HxhEHuOjXi26iHmaVkmVX3dUh0uZWOevR7HEKJ/vkvWTHGB1VS/mGJV1lmGLLoCq
	 qaL1cUl3hKwu8U0eZNjSlH8ahsVgxybx+h6tnw+s=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-pwm@vger.kernel.org
Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: [PATCH 1/5] dt-bindings: trivial-devices: Drop adi,adp5585 and adi,adp5585-02
Date: Mon, 20 May 2024 22:59:37 +0300
Message-ID: <20240520195942.11582-2-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
References: <20240520195942.11582-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Analog Devices ADP5585 is a multi-function device that requires
non-trivial DT bindings. To prepare for proper support of the device,
drop the related compatible strings from trivial-devices.yaml. They were
added by mistake, without any user in the mainline kernel, neither in
device tree sources nor in drivers.

Fixes: e5dddbedfe09 ("dt-bindings: add ADP5585/ADP5589 entries to trivial-devices")
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 Documentation/devicetree/bindings/trivial-devices.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index e07be7bf8395..59102d46b98e 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -39,10 +39,6 @@ properties:
             # AD5110 - Nonvolatile Digital Potentiometer
           - adi,ad5110
             # Analog Devices ADP5585 Keypad Decoder and I/O Expansion
-          - adi,adp5585
-            # Analog Devices ADP5585 Keypad Decoder and I/O Expansion with support for Row5
-          - adi,adp5585-02
-            # Analog Devices ADP5589 Keypad Decoder and I/O Expansion
           - adi,adp5589
             # Analog Devices LT7182S Dual Channel 6A, 20V PolyPhase Step-Down Silent Switcher
           - adi,lt7182s
-- 
Regards,

Laurent Pinchart


