Return-Path: <linux-pwm+bounces-2182-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CEB8C981A
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 05:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D297C1C20F95
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 03:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F2AF9C9;
	Mon, 20 May 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xhltVXsE"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F0D9475
	for <linux-pwm@vger.kernel.org>; Mon, 20 May 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174218; cv=none; b=WuL09QoiP4lScnlZUMJ94dyxfSER7rzK+vO0nFhVXw8+RApjn9Rf79p67dh0XD1kHCh2d4kfzNdc8B/RB9njWFPhZEFSriIHY9mGPgEyA5f/chMMZuVE9BVT//Ov22SFIugp6A5pBZJCWACPMT0qLGX6WihTP6daPHJS+tQ+dGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174218; c=relaxed/simple;
	bh=vYPIVnU/6/vOoV/WNN88mzsJ22V4J/K72IQvoqz+eQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWsWn3d+vK3qf2nLioRxvPRaKZxzxwLsmitpNBfTY3sKxfQHBt9unZcvrVevrCQtxN9Q9PpEqkbfZRFNveFUPR/Cl76MZAJWZ6tK9t6GFL4q9w5WzJ/diJhI1rop0vh0RmTxatEhMZT1ZGV2a/Q9VKcKcqIw9vpm6OjC9bzss5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xhltVXsE; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 913B22C031D;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716174206;
	bh=GpDG4VenMkr2tJn/OuFbp9IDJ9KdkQr6+CcyVhSPNIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xhltVXsEX8V5z2M6/mwihRQ+sYAWyarBNWQzf597Kuqz1NNOuqQa8BW3FCNLE2qbN
	 hlVkyNbdDD8pQisRu42cisQuPX9G7D4YEnHEyQrSqQ9G0VxGJC0QcsHaYdH8AUZU5V
	 3yMXmGHB2Jzd7ba2GT6FeqyH3VniVaK87BdlldgrMjxKLJyQtYdlSP2vqt7DbIc+R3
	 eoQsokVzxOEb7Bp9VdKiqCPml9gZoF5SNYSa+nOdPFf+TUsw1YBbCff5nVQdXEThuX
	 K2bzRM9LJcfKUu2xtlIf+/gNVGeKwuA9KJLeFyPGm/9cTgOrXJ50SX2rlIUTVpx8or
	 6+UPiIg+myI/w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B664abd7e0001>; Mon, 20 May 2024 15:03:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 5F24113EE4F;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5B2E9280420; Mon, 20 May 2024 15:03:26 +1200 (NZST)
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
Subject: [PATCH v3 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Date: Mon, 20 May 2024 15:03:19 +1200
Message-ID: <20240520030321.3756604-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
References: <20240520030321.3756604-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=664abd7e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=nd0hpPEdzzsPhCuWCasA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add fan child nodes that allow describing the connections for the
ADT7475 to the fans it controls. This also allows setting some
initial values for the pwm duty cycle and frequency.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Document 0 as a valid value (leaves hardware as-is)

 .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 051c976ab711..99bd689ae0cd 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -51,6 +51,15 @@ properties:
       enum: [0, 1]
       default: 1
=20
+  "#pwm-cells":
+    const: 4
+    description: |
+      Number of cells in a PWM specifier.
+      - 0: The pwm channel
+      - 1: The pwm frequency in hertz - 0, 11, 14, 22, 29, 35, 44, 58, 8=
8, 22500
+      - 2: PWM flags 0 or PWM_POLARITY_INVERTED
+      - 3: The default pwm duty cycle - 0-255
+
 patternProperties:
   "^adi,bypass-attenuator-in[0-4]$":
     description: |
@@ -81,6 +90,10 @@ patternProperties:
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
@@ -89,11 +102,12 @@ additionalProperties: false
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
@@ -101,5 +115,14 @@ examples:
         adi,pwm-active-state =3D <1 0 1>;
         adi,pin10-function =3D "smbalert#";
         adi,pin14-function =3D "tach4";
+        #pwm-cells =3D <4>;
+
+        fan-0 {
+          pwms =3D <&pwm 0 22500 PWM_POLARITY_INVERTED 255>;
+        };
+
+        fan-1 {
+          pwms =3D <&pwm 2 22500 PWM_POLARITY_INVERTED 255>;
+        };
       };
     };
--=20
2.45.1


