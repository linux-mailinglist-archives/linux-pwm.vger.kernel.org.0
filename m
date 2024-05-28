Return-Path: <linux-pwm+bounces-2273-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B72C28D2867
	for <lists+linux-pwm@lfdr.de>; Wed, 29 May 2024 00:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BBD1B21EBC
	for <lists+linux-pwm@lfdr.de>; Tue, 28 May 2024 22:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63C2A13E8AE;
	Tue, 28 May 2024 22:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Unu/8OV4"
X-Original-To: linux-pwm@vger.kernel.org
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DE013E8BF
	for <linux-pwm@vger.kernel.org>; Tue, 28 May 2024 22:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716937008; cv=none; b=VDjfB8zbgLxiXqn/j5XY6k5TaloW3pkh78V8d2GKC1Pz3ihk/vTo+1iHYLsj04liLV89cM3l3RNzqyYXb7s7YuhWK/lq2whyrmDLEdDvzcT4bMdGZqAKBR0Ifo1sBgmobLIZhl37SYJuqprFRRl/PoIBeI/hlFzUcZ/vcu08/04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716937008; c=relaxed/simple;
	bh=MoBZdifaSqI2NHr0nmn2gKASKEYmukSHZLHs2m1hUrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IHKjn/kPqBKFNWO8zwkNlME3uIA4S2wMI9kv8ifPwUPFRHTTtY86cfVP+qjpEarYnRUdLyL0PDy7f5WM+zz+4Q517bKfMDui3a5MIMv5bOUdgm2DPuV+OgId4UUerFlQ52Qc7Xn/VZdME7juH5tbyTU1IhsJAUS7obJzQL2ia1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b=Unu/8OV4; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id F2A312C04C9;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1716937002;
	bh=dKxUdWjyRFZ7P/OPriJQcPXYZTrD81YV3THxrTM3wcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Unu/8OV4K+pZRd7js/o9GbVUiS7fJHAx8iTNCTZtUtE7Jdrq7MoHyT6AfJmePxykD
	 3Vcqa2CMN6aT5HDySSgvaXcMt9Q+PSmIdjrECa4UoTexxI5shi0z6DK82gG0MwOviT
	 e2CrA6HpnI0Ps+qOEMOz/Wg18PBv3zraEjoTaowl1zeuOouzzb1Kt2MeUUzvoakYBM
	 NzLGWWbPZGxslzyXmjaNUEhgE/KiITZCxBgI3JSFLBdUrmkM0YFLkVAzlDled4tF1f
	 FrBBiAh8uJU6c8mhSm54J2juenQLZFp+r6FJe7A8eWUODrKpllqhGRpLXIE/3TAeaX
	 w8zGc+SICJC2g==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6656612a0002>; Wed, 29 May 2024 10:56:42 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.30])
	by pat.atlnz.lc (Postfix) with ESMTP id AAF4C13EE83;
	Wed, 29 May 2024 10:56:42 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
	id A6614280AFC; Wed, 29 May 2024 10:56:42 +1200 (NZST)
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
Subject: [PATCH v4 2/3] dt-bindings: hwmon: adt7475: Deprecate adi,pwm-active-state
Date: Wed, 29 May 2024 10:56:37 +1200
Message-ID: <20240528225638.1211676-3-chris.packham@alliedtelesis.co.nz>
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
X-SEG-SpamProfiler-Analysis: v=2.4 cv=F9L0dbhN c=1 sm=1 tr=0 ts=6656612a a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=TpHVaj0NuXgA:10 a=A1YWOaG1RMH6ymt1ZYoA:9 a=3ZKOabzyN94A:10
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
index bfef4c803bf7..ed18984c2529 100644
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


