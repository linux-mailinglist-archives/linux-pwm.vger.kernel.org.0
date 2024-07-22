Return-Path: <linux-pwm+bounces-2882-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727E093872F
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 03:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187A61F21357
	for <lists+linux-pwm@lfdr.de>; Mon, 22 Jul 2024 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0130DDF53;
	Mon, 22 Jul 2024 01:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="zCEVQkxz"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62151748F
	for <linux-pwm@vger.kernel.org>; Mon, 22 Jul 2024 01:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721610520; cv=none; b=Bkq4SbaAsp/HoDafkz6oAo/4Sd99ERfNv4IJ5cLsfucbHc0OgleNfpOlVYAYEV4/rOd0Ut8mJiLixDop+zDL33eqtvuF+MU3+b9PG9ddU9XUQOe7xf8d8KD9Wuh/J3qbih7/sGMalO6Vms9wRqvqmwZgHZ3n09sn+uk+d17u4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721610520; c=relaxed/simple;
	bh=sBAG8CgQvJNf1n1v9OA5RdPMZATzxBlvnrmNXiecv08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3mImJPezGDecjFjvfQtr1d3JuT00b6oYUW4j/M9GkcPU6GhAocOch+Xz9b3daluX+sgCX1w5DyxPlg6p3fBawT33f1DxezlSM/vMxSMYimHPxA0zByqobVboa3FmOCAOZaxXVEea3mVfSMc7wXRZxDSlHj7cBs1YUMdxb5s+ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=zCEVQkxz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 8E0142C0E30;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1721609921;
	bh=CEQoIEZwGjggOOe+cMGdGFt8ELGSd5VDRabos8qlvQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zCEVQkxzbS6k6P9vF8NkLfxGpsx5COsZzlU1m626EWug8vYY1qsBK6vyW/052rcu0
	 KHDk9JZd/LPotcfbT+h8jI4ymW9Dya2avGe23sixicctmI+/QizCNWjdmlOxe2sFlS
	 UoApyrQxs3a9Ku1ViIvnFkKVluKwsEea6Kev1fpzJDC65TCh3WJk2B6q1NP9xD8fRq
	 KMKd9DOpx5ttq9QbPlvXJSDkLTCTjdEbaW0R/am0fzosc65ZR0MLuCQMN7qoSYGZFn
	 uw3zERKWnt6fgrp1YQ8vdznhnxR2AI79PTwV8aIeaVKcIzocfsfOttNFUpIRtH3814
	 6QKzTs8MhMYAg==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B669daec10001>; Mon, 22 Jul 2024 12:58:41 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 38D0613EE6D;
	Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 34E522808D5; Mon, 22 Jul 2024 12:58:41 +1200 (NZST)
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
Subject: [PATCH v6 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Date: Mon, 22 Jul 2024 12:58:23 +1200
Message-ID: <20240722005825.1800403-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
References: <20240722005825.1800403-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Gqbh+V1C c=1 sm=1 tr=0 ts=669daec1 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=nd0hpPEdzzsPhCuWCasA:9 a=3ZKOabzyN94A:10 a=MKNsf3uAAu3gLl-MH12z:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add fan child nodes that allow describing the connections for the
ADT7475 to the fans it controls. This also allows setting some
initial values for the pwm duty cycle and frequency.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---

Notes:
    Changes in v6:
    - Collect r-by from Rob
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


