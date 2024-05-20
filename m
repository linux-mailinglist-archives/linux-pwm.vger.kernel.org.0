Return-Path: <linux-pwm+bounces-2183-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6F8C981F
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C185BB20F99
	for <lists+linux-pwm@lfdr.de>; Mon, 20 May 2024 03:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E15FC1D;
	Mon, 20 May 2024 03:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="HI34v6Ch"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320F6D2F0
	for <linux-pwm@vger.kernel.org>; Mon, 20 May 2024 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716174218; cv=none; b=XWDYeucXuBXWbWnpqOf5iao1pOhBvRPPCRJXP3lk77YS9TspIozOjCyqczBojp7LQYheJwkl1shtSkvKIhOI1R4lNJCQciqmkBhiunGdLqep3+ZjqfiCcZk3ZmAT6OMVh+NKK9UsqRaU196NvUOqRcdqYaCkstTF7nAVGngxIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716174218; c=relaxed/simple;
	bh=MBxTA2zQx0pZlq6BZ7RD1+lBsfooOF9aS3XEvy31nVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwxsg6TRnsO/OnkRIORkTzOa23gA+cfxTCG59Tgx3JJb1Q+qCoNgaUE2YTOtsITRU6YBtavYjDNECbOl2suj6+5UmkNvPVmRbQ9Cm2yFsfihXDJgVdfXWJYlvsLqQ/k1S80vWFFCiXkKOMQaiyedhh6RBpfiXKw3QNj+2APfNeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=HI34v6Ch; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B6FF02C05E6;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716174206;
	bh=PP8I/h6TurMIh4d3JTHdZaDPCLL7yfRyKCJAU8JYWEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HI34v6ChIVhoaIMRiMTYaOTPwgpKJXCm43jt8hL0/yxFQ1vEnCQq0zDOF4+oVCVTK
	 tAvjgTUeodwn4LL1Q8eZ8g0xpgxXRHRNv0F6WSk5dAhSrIp8VihFUGIuuYzOW3dppY
	 CDfTtnGC8YTHfbLb/i3QvvOKADTfGkRw0ePVGOWB0uNYxN8p5hpz4OgQhWJVXCJc6u
	 Gt9acR6bHy+WEhr4hyxg6t6fRlop6VwgM/xBEc3oLlaORsg2GyKNspG6oqMU10ciF6
	 6eD6iBJNMOG+JE+9EFR4OFXawmFQ8pN6YX1e/HEh1Qpmz5laobLfC2DBRBy6iE3mwL
	 37IJToC0sth5A==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B664abd7e0002>; Mon, 20 May 2024 15:03:26 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 625D913EE83;
	Mon, 20 May 2024 15:03:26 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id 5DBCE280CB6; Mon, 20 May 2024 15:03:26 +1200 (NZST)
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
Subject: [PATCH v3 2/3] dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
Date: Mon, 20 May 2024 15:03:20 +1200
Message-ID: <20240520030321.3756604-3-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=664abd7e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=A1YWOaG1RMH6ymt1ZYoA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Now that we have fan child nodes that can specify flags for the PWM
outputs we no longer need the adi,pwm-active-state property.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---

Notes:
    Changes in v3:
    - New

 Documentation/devicetree/bindings/hwmon/adt7475.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml b/Docum=
entation/devicetree/bindings/hwmon/adt7475.yaml
index 99bd689ae0cd..3d4f9266f0e3 100644
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
@@ -112,7 +113,6 @@ examples:
         reg =3D <0x2e>;
         adi,bypass-attenuator-in0 =3D <1>;
         adi,bypass-attenuator-in1 =3D <0>;
-        adi,pwm-active-state =3D <1 0 1>;
         adi,pin10-function =3D "smbalert#";
         adi,pin14-function =3D "tach4";
         #pwm-cells =3D <4>;
--=20
2.45.1


