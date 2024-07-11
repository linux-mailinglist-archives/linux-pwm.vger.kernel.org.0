Return-Path: <linux-pwm+bounces-2773-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3782D92F2BF
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 01:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB007B21B2E
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:46:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2638216C879;
	Thu, 11 Jul 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="0Ff6iu6V"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408B15EFC4
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741582; cv=none; b=NBlwZgUf/VAm5CnH5vDdy/ShGpMuNp9JGFECTMNX0uxj1r3LMikby4BCpkS8vmNJG8uWY07sClgSiRYOgiMCwPeCBruAQIcHiLmucU3jbKOcUBLTZosIkPEy2Ak89lYpNtuHvV/oKCw74AjYyiklC8ipuiB0U0e/DaO+MhwQ9Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741582; c=relaxed/simple;
	bh=L7u64Rt38kesaLb/o2TulvuPEP0M5BedulVmbUr6rqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oD/1xM72koQWWajl97u6LRJvC0zT/dSXOAHK3v+I4k7Ea8nx2tHPfAxvEE3dN97E2EAhRy6eiGOgZQX/9mhwE6FPmaFUF8oo0oammd239XbGC+zL8JrOSZKnLgcrr1b/wY+GvlPh9FB6iBVG9UKjEEmrmj/hm1P2g2Z9UP49vA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=0Ff6iu6V; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 90EC22C05DB;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720741576;
	bh=oVb+M2qq3CiAzzn2CgRisOAaF/17YCYSDMxeBi/C588=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0Ff6iu6VcOUeiWJMhbWl02i4UVxwD7sJHRJ1/uFjwVNSkYQ8/f5X04r33JCQtyRo7
	 ioLOEJA00xG6AzuSfQDg9RAgznzUIWF+fkv579jKfJTGbxzQF+A9Ao3jtRbWTy2jRw
	 BuIbZeIIikn4y4F6kemm8f76+Ysnv5PFGDiXZLUX5JqHrvSU3Fi1mionxxglgUJgCA
	 EkRbYQkE2t0mLYQ/g/iRZ/vSTFLfWucjr3IIUpsaiAypgkdKRGT7pHnYSB7TAlyNzr
	 bSr7N98mi7nlBH0VVBXAiRbW+SFZHCNVeRPbevJ4p37h7xv6GmHf/fyNxRnmzMdS2F
	 zKyNJg1cMRxCg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66906ec80001>; Fri, 12 Jul 2024 11:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 3EC4013EE5B;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 39FD6280019; Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
From: Chris Packham <chris.packham@alliedtelesis.co.nz>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ukleinek@kernel.org
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pwm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH v5 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Date: Fri, 12 Jul 2024 11:46:12 +1200
Message-ID: <20240711234614.3104839-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240711234614.3104839-1-chris.packham@alliedtelesis.co.nz>
References: <20240711234614.3104839-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=66906ec8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=nd0hpPEdzzsPhCuWCasA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add fan child nodes that allow describing the connections for the
ADT7475 to the fans it controls. This also allows setting some
initial values for the pwm duty cycle and frequency.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v5:
    - Use nanoseconds for PWM frequency and duty cycle as per existing
      conventions for PWMs
    - Set flags to 0 in example to match adi,pwm-active-state setting
    Changes in v4:
    - 0 is not a valid frequency value
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Document 0 as a valid value (leaves hardware as-is)

 .../devicetree/bindings/hwmon/adt7475.yaml    | 35 ++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 051c976ab711..df2b5b889e4d 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -51,6 +51,24 @@ properties:
       enum: [0, 1]
       default: 1
=20
+  "#pwm-cells":
+    const: 4
+    description: |
+      Number of cells in a PWM specifier.
+      - 0: The PWM channel
+      - 1: The PWM period in nanoseconds
+           - 90909091 (11 Hz)
+           - 71428571 (14 Hz)
+           - 45454545 (22 Hz)
+           - 34482759 (29 Hz)
+           - 28571429 (35 Hz)
+           - 22727273 (44 Hz)
+           - 17241379 (58 Hz)
+           - 11363636 (88 Hz)
+           - 44444 (22 kHz)
+      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
+      - 3: The default PWM duty cycle in nanoseconds
+
 patternProperties:
   "^adi,bypass-attenuator-in[0-4]$":
     description: |
@@ -81,6 +99,10 @@ patternProperties:
       - smbalert#
       - gpio
=20
+  "^fan-[0-9]+$":
+    $ref: fan-common.yaml#
+    unevaluatedProperties: false
+
 required:
   - compatible
   - reg
@@ -89,11 +111,12 @@ additionalProperties: false
=20
 examples:
   - |
+    #include <dt-bindings/pwm/pwm.h>
     i2c {
       #address-cells =3D <1>;
       #size-cells =3D <0>;
=20
-      hwmon@2e {
+      pwm: hwmon@2e {
         compatible =3D "adi,adt7476";
         reg =3D <0x2e>;
         adi,bypass-attenuator-in0 =3D <1>;
@@ -101,5 +124,15 @@ examples:
         adi,pwm-active-state =3D <1 0 1>;
         adi,pin10-function =3D "smbalert#";
         adi,pin14-function =3D "tach4";
+        #pwm-cells =3D <4>;
+
+        /* PWMs at 22.5 kHz frequency, 50% duty*/
+        fan-0 {
+          pwms =3D <&pwm 0 44444 0 22222>;
+        };
+
+        fan-1 {
+          pwms =3D <&pwm 2 44444 0 22222>;
+        };
       };
     };
--=20
2.45.2


