Return-Path: <linux-pwm+bounces-7052-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F9FB2672C
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 15:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3502B687269
	for <lists+linux-pwm@lfdr.de>; Thu, 14 Aug 2025 13:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2524305E37;
	Thu, 14 Aug 2025 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhqqC1m/"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13A303CA0;
	Thu, 14 Aug 2025 13:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177729; cv=none; b=eiRjK/jcUMbvIULBX9sVTllHThdP3AlNqUrkt3lvi2WCX+cIbUV8c0QrJOIKUPk2DVVRM4LNnqcB6kwrFpElvjvuvX+kWrRO1m7j1n3yAsaJT9C/P4dsGNz9TPhaY9wDUpgxwErlZnyFYS/+QkdHqt8gi2oJfXudXe+ds3gcqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177729; c=relaxed/simple;
	bh=qLrLbJ8AJh3khNsEkYSawcE/YIrXHGXesmQXIlAtOdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EDlfoR+6GYjCH13wR2JbXJb2L5DbtaNWfZ/x5wDT/XS3nwa9lINRQPDsJPkgoICCLZ+PO79thHM1O18WSbUn6ZGFDFo0ksFER8mfrAyVgxNx/jj4OVB98yf3ffRxh4Ai4R8ctudl0WBtmqTQU8E2onj+epCNIZFIQQMyvK+ZsFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhqqC1m/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9dc56ff66so470937f8f.1;
        Thu, 14 Aug 2025 06:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177726; x=1755782526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V9gf+UMX7IgdZsLYIXWD9mcyJlocdIHrenFz3ChndAE=;
        b=RhqqC1m/eu53Cqu5dd3DoCuWmH6xAXlcVJ6IMBdmSxHPT3h7APmH9vqKhadNsZkEaP
         +0tUDgyGcuNrU9IdRRNDWYSO7IG0mki8gzIIvsS/rwGADDjJyllVXfr9dbHqmaK2LoU8
         oHrMNBqvKPqj528QryTQiyaHP2X+7wHhpbpcZpvsEd5YacyUVVBj2a5C1gZ/bCF3wN1S
         ymH4IbnW+8wCipNMOAzZfNFZ34TDdgqEKcQtN9vdVmD35aFwLPDMqzIbHJ4xwwidOufv
         BJiMP5IdItj1f5CWrlB31MfqBo5b4iE/4g+pIAee4TWMU9ZE1gjymraZ2G/wERc2mMtf
         eQBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177726; x=1755782526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V9gf+UMX7IgdZsLYIXWD9mcyJlocdIHrenFz3ChndAE=;
        b=BXdolWrxGLypZWXu6RhiPX5+2vqj4nntp0Lkje6SwEU+LkGPj30Vcu4wGBobWXYcek
         buxbUgMxA2i8IdPa+Y5I+IfteOQbIOGiXfb8sCAHwpw+QscCh/wG+3ivBeOGLgSiAC3W
         DziYbsIS64EdfiFJ5DF1CBtBlWaEnAuGthSmEgS9cAevKOpDrtFBr7nxAi95gm4cM5kb
         aecT0zNCgUjmOYV3MxZvWlxjVDcBTH4DiDqs69c7kauTkffAnORNwgz18RyDlqCmLNG4
         bq7/MSc2K22f5l8DijkNB8RwiEfB8868YuclHP6RGAQhNzguSn79wBbnB4Z7T/E96S0G
         sALg==
X-Forwarded-Encrypted: i=1; AJvYcCU7f9hx5JsuqvxA9LTLg2yYKKMs/7WcBWm8pH4Ry04CGGuc5cwqU8xXL6SY/ICaFPX1MaYLFtfbVPAcIB4=@vger.kernel.org, AJvYcCUt7koTD+OZ76lILYWOuJEevOzlKSxxZbT3ijPKh+Wp/6yAwA0F4RtbhoQzSknJ6E9Dkh4Wj7ziuS16rsM=@vger.kernel.org, AJvYcCW9eKrV8Xo1X2XDqSToiyB0dDO3StyWmJPyEMpbqxuCUKg8Icw652eZyPcdvj1au+fAjvqlW1yFq/hK@vger.kernel.org, AJvYcCWQ2jJ/TGzi2/EzHdOtuBrk0vEZhLfRGXNbH/vC4Ndnpt2QP45VZMmPrQT1y/Br+oqXKW2SltqLa9xT@vger.kernel.org, AJvYcCXaF6eebn6KXRA6vQRXUbLU2IjfFwlBYH5VxXqgLwaUlrLtcu/+5vl0ghW4Ebe88NUrLj+11N4fRZ7x@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwriwQUwneCaj79vyuhiUubVIt/Roe6T35CYkCzBNW6r8c5j5
	ndXh5PveSXiUeLwx5wGYzDMQNXO6SA+4dPXG8261BBpAt6Ehj574exJKku1+
X-Gm-Gg: ASbGncvsguQ6cLyPlLqMgPp/xSyHEJdSE+e+b6kW6szO6O3RIZ1F8q+iDGsMCXv+dhP
	nhxwnLTdSkKubagkC2U1gMIUoBgq7ctXf4vPG+QuU+l9BDlaPSgLWQJzOLP2iAyx+cEZVNT5FHO
	duqug+ugmA2tg5KejPCdRmyW5ZAcI7qVJGCeDvFrcrw0bAKHOar/qYFfM01idi9habJWPg/Fn42
	pZCxggWePo6u8aWP9mu1oj0fACoKwFZtZMDABUa+Lq+eWCoWZj8WQ3FwGLTDj+PWJjFbltf/FSS
	3KC4CcVVpr2lTD/gqIcef6dlthb3uAun2BMJ6blCD24aUKaLkSwUrBjTajmle1gjINCV6Gx3jiN
	PWt/ESnwhz1zRo2+da6LVSk0IzYVROSYaeGMRLOG/FUN3bTkLVkOOuLoLj6wiYommut9PhLDhf4
	lw39Jd3SupUHtqs6qvTOCSwA==
X-Google-Smtp-Source: AGHT+IHohGHq9qZiuSxAAi0iS3zzrY+43TieWM5WbOF8kEuQD7ciIQoQ6ArH7H4J9Z8aFPKu1d7O3g==
X-Received: by 2002:a5d:5f53:0:b0:3b8:d900:fa79 with SMTP id ffacd0b85a97d-3b9edfd2161mr2331716f8f.5.1755177725766;
        Thu, 14 Aug 2025 06:22:05 -0700 (PDT)
Received: from localhost.localdomain (lmontsouris-658-1-96-160.w81-250.abo.wanadoo.fr. [81.250.250.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3b9386sm50998831f8f.18.2025.08.14.06.22.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:22:05 -0700 (PDT)
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
Subject: [PATCH v2 9/9] dt-bindings: mfd: twl: Add missing sub-nodes for TWL4030 & TWL603x
Date: Thu, 14 Aug 2025 15:21:29 +0200
Message-Id: <20250814132129.138943-10-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
References: <20250814132129.138943-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the TI TWL family Device Tree binding to include additional
subnodes for TWL4030, TWL6030, and TWL6032 devices.

This patch enhances the schema by adding support for audio, GPIO, power,
keypad, PWM, PWM LED, and USB subnodes, referencing their respective YAML
schemas where applicable. These additions improve the schema's
completeness, enabling better validation and documentation of the
TWL multi-function device's capabilities.

The changes ensure proper handling of TWL4030-specific features (audio,
keypad, PWM, PWM LED, USB, GPIO, and power) and TWL6030/TWL6032-specific
features (PWM, PWM LED, and USB), with appropriate schema references to
prevent unevaluated properties.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 .../devicetree/bindings/mfd/ti,twl.yaml       | 63 +++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/ti,twl.yaml b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
index f162ab60c..81f9d8f72 100644
--- a/Documentation/devicetree/bindings/mfd/ti,twl.yaml
+++ b/Documentation/devicetree/bindings/mfd/ti,twl.yaml
@@ -76,6 +76,38 @@ allOf:
           properties:
             compatible:
               const: ti,twl4030-wdt
+
+        audio:
+          type: object
+          $ref: /schemas/sound/ti,twl4030-audio.yaml#
+          unevaluatedProperties: false
+
+        keypad:
+          type: object
+          $ref: /schemas/input/ti,twl4030-keypad.yaml#
+          unevaluatedProperties: false
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwm.yaml#
+          unevaluatedProperties: false
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwmled.yaml#
+          unevaluatedProperties: false
+
+        'twl4030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
+          unevaluatedProperties: false
+
+        gpio:
+          type: object
+
+        power:
+          type: object
+
   - if:
       properties:
         compatible:
@@ -115,6 +147,22 @@ allOf:
           properties:
             compatible:
               const: ti,twl6030-gpadc
+
+        pwm:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwm.yaml#
+          unevaluatedProperties: false
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwmled.yaml#
+          unevaluatedProperties: false
+
+        'twl6030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml#
+          unevaluatedProperties: false
+
   - if:
       properties:
         compatible:
@@ -154,6 +202,21 @@ allOf:
             compatible:
               const: ti,twl6032-gpadc
 
+        pwm:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwm.yaml#
+          unevaluatedProperties: false
+
+        pwmled:
+          type: object
+          $ref: /schemas/pwm/ti,twl-pwmled.yaml#
+          unevaluatedProperties: false
+
+        'twl6030-usb':
+          type: object
+          $ref: /schemas/usb/ti,twlxxxx-usb.yaml
+          unevaluatedProperties: false
+
 properties:
   compatible:
     description:
-- 
2.39.5


