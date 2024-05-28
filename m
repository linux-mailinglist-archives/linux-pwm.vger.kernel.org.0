Return-Path: <linux-pwm+bounces-2275-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31E78D286C
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 00:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 682951F29FC6
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF16813F006;
	Tue, 28 May 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="xBWDYjzI"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647F13E8B0
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937008; cv=none; b=c7wr59FzEiTYiVt2UUdigV4C+PV+mcjmTbfJwXBQdzntVSFO+WV0Fti6Wv8LdWQtTjUJwYWAYhptetFyAKRR0HMmbHgg3084kExnmDajBF5M5tCn8BVySxPq1Rtd/BxCLNxXZ8W9culajDbYe7cDIJ0O978Mct8zXSGv0U6AukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937008; c=relaxed/simple;
	bh=mLKZ4Tk6OaRbmpp0CDtq7YLjSHV+nhJ+kV4iqYSkBW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1ClDthe6r7hs/AHwteQFbuWsjhZJyznNRYh9nnTEippL6l7eZ395VQlAK17A61usNuS1qTqaxEQTtg73PWakOTF9YowNGT2yaI9eMBCJhJHsIxELoJmFOKqcQmBVYx9oLgp/RrmZlyCfRC4pXL0vDI+t4rdmJYFuFVZPkPKNzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=xBWDYjzI; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id C5B872C02E0;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716937002;
	bh=BRccYZsVdGxDK04PwUo4q3c1Pp+x2GNlfA7P/Dp31d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xBWDYjzIDFZMOkbEE+JejTtA2GMnPkC1g4jvrx4r+h1bWZhNjMEMdxofXrAusgfWO
	 C52KaylEtX19leQ/ZJWqh1CNxHUXdHQ/3aB3oPaoEZJsMjffhHdhlj6ZINf+UaejFt
	 7rttalJ7j8z/Fov2/YO9Sg+XYVKfzGMk3PVvA+KqaU2kWM17LTznBYJjY4qA50s6oT
	 bf8U5u/TSGsEM22nmJMczKG6zwlPDSl1p9QE7/nG+V+SQfp+20Nx16QTiPri20Wk2A
	 hgm1cSo/3BRvSvRLX1nMsWLWM4ZiZvfK6S7OWsD92+UjSuHWRoo32IYfUOmVQzhJds
	 aFukd/Hs5Qt9A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6656612a0001>; Wed, 29 May 2024 10:56:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id A8DC913EE6D;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A47A7280048; Wed, 29 May 2024 10:56:42 +1200 (NZST)
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
Subject: [PATCH v4 1/3] dt-bindings: hwmon: Add adt7475 fan/pwm properties
Date: Wed, 29 May 2024 10:56:36 +1200
Message-ID: <20240528225638.1211676-2-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
References: <20240528225638.1211676-1-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6656612a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=nd0hpPEdzzsPhCuWCasA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Add fan child nodes that allow describing the connections for the
ADT7475 to the fans it controls. This also allows setting some
initial values for the pwm duty cycle and frequency.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    I realise there is still some discussion about how to express the
    frequency and duty cycle. I have a personal preference for using hert=
z
    for the frequency and 0-255 for the duty cycle but if the consensus i=
s
    to express these things some other way I'm fine with doing some math.
   =20
    Changes in v4:
    - 0 is not a valid frequency value
    Changes in v3:
    - Use the pwm provider/consumer bindings
    Changes in v2:
    - Document 0 as a valid value (leaves hardware as-is)

 .../devicetree/bindings/hwmon/adt7475.yaml    | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 051c976ab711..bfef4c803bf7 100644
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
+      - 1: The pwm frequency in hertz - 11, 14, 22, 29, 35, 44, 58, 88, =
22500
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


