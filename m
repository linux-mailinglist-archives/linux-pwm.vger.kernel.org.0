Return-Path: <linux-pwm+bounces-2771-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A1E92F2B8
	for <lists+linux-pwm@lfdr.de>; Fri, 12 Jul 2024 01:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903C22837D3
	for <lists+linux-pwm@lfdr.de>; Thu, 11 Jul 2024 23:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C48516DEA5;
	Thu, 11 Jul 2024 23:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="fhBelTAo"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55D9160865
	for <linux-pwm@vger.kernel.org>; Thu, 11 Jul 2024 23:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720741581; cv=none; b=HC7wdP3ESTK2MxRI8vEsdy82wVnjiJ11rY4RaTkRLq9/1dogzNoE2joP4I8wPmo0QBLUUJj/BQCvppI3RKiLzUJrzVoLSQ0PQxwDD2YFH+i0mwL5lMVkRgEAwnZTsEVb8kfjwZFF5kjygKe57GigE1//IFhxiWLyW9jnijNHumw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720741581; c=relaxed/simple;
	bh=A6UbHtt51ryxjEQ56nmE97SbAYAIhVAvX6o9Y8W6vR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWMEq1336rjAIjGF3G6tNIacInWPRIvUlaNVD5gb1JU4bUvYzRWB2WJIUW2SKjQSLe8j29h83IXzEKBbtY9uza9D3M8v1K8LEnxyD6iqAedRh7U+tYfaWQFXQBsg3VFq7Erj4wg8FaiR5VJwU4byLbNQZCV6nUK/mRbWoqNRcvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=fhBelTAo; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 805032C054A;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1720741576;
	bh=Mv6CJIE83p5kF2aun4rUSQtQtj6Pahz/PyoQynZs19Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fhBelTAoUbasZux8UFJI3o11oI1YUGtcFPklSITPEsXhuKmoWBFD0YHg2R5K7oXF7
	 hgkbsFQoyY+7MuCTOwcmsc47G3swJNg9d2ocpXJPh4FlMVZV4A5WSLWbf2O0Q07axX
	 kn7Mqw6Jtv1tkaYZwDy3lmSFE+ZBay84d+6x4JF0WHM+WKdW7tr8Z7pn6KjBckBvMl
	 bpgvRPj7mDUdoTCpt79fhnMiQQEQk2UytTlKO4IPFP8NKUqBrs6P94jhBYFOCJyCir
	 qAbgyufMMn8NiJsiTeoeSZxg6i+ozeM8Y60WZV/GKVNk5xNmoxOBHhnVtHWauGyaei
	 XR5vvzxXQRjKA==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B66906ec80002>; Fri, 12 Jul 2024 11:46:16 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 444C013EE85;
	Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 3FC48280019; Fri, 12 Jul 2024 11:46:16 +1200 (NZST)
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
Subject: [PATCH v5 2/3] dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
Date: Fri, 12 Jul 2024 11:46:13 +1200
Message-ID: <20240711234614.3104839-3-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=PIKs+uqC c=1 sm=1 tr=0 ts=66906ec8 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=4kmOji7k6h8A:10 a=VwQbUJbxAAAA:8 a=A1YWOaG1RMH6ymt1ZYoA:9 a=3ZKOabzyN94A:10 a=TmF2cBh53Nm6oE2QjmZc:22 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Now that we have fan child nodes that can specify flags for the PWM
outputs we no longer need the adi,pwm-active-state property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
---

Notes:
    Changes in v5:
    - Add ack from Rob
    Changes in v4:
    - None
    Changes in v3:
    - New

 Documentation/devicetree/bindings/hwmon/adt7475.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index df2b5b889e4d..79e8d62fa3b3 100644
--- a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
+++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
@@ -45,6 +45,7 @@ properties:
       the pwm uses a logic low output for 100% duty cycle. If set to 1 t=
he pwm
       uses a logic high output for 100% duty cycle.
     $ref: /schemas/types.yaml#/definitions/uint32-array
+    deprecated: true
     minItems: 3
     maxItems: 3
     items:
@@ -121,7 +122,6 @@ examples:
         reg =3D <0x2e>;
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
-        adi,pwm-active-state =3D <1 0 1>;
         adi,pin10-function =3D "smbalert#";
         adi,pin14-function =3D "tach4";
         #pwm-cells =3D <4>;
--=20
2.45.2


