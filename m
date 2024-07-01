Return-Path: <linux-pwm+bounces-2647-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2534991E684
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 19:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02241F22216
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 17:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30FF316EB7E;
	Mon,  1 Jul 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="OjvS0KAd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5906416EB44;
	Mon,  1 Jul 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854437; cv=none; b=I331dvAar8Vpvq8HibB/0RsrlHN+R++fP2ed18G05l0b3KxkG/7/nDqLINi6S77CgBJ/CrARloR38MPRVTMSs5ih5EDF6hIfxrxoy0FSs75tm+AGOglNYvixH/3QhxrHoZzc6H5VYBdLjb2h92awvtXgPcbQmqeNAZ6n+aISSNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854437; c=relaxed/simple;
	bh=oMGxMij320FnXrlNJ1UPrPbMoD+rcMcr+C/mf55fP1U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U9bKDmI+9S3GGX2NJyMkTDCe48MKITITBh6Ov/NqZ9gwE0e+c4Wu+BwHO8ZzZEFS0zI25co21sEux2pkombEvdpukRcvEbUBJTCti22zmLtZVxJu6uwl6VHkbhN0vvN1430qdpsvc6H4mqX7eBEuh0Aih3gDrfDrKvxlAQRyTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=OjvS0KAd; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id B9F1C12000C;
	Mon,  1 Jul 2024 20:20:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B9F1C12000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719854424;
	bh=MVrEHcT3w02APU44tB6WifIiHTjFlslKUbhO+5L4/wA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=OjvS0KAdRHucfTWybqd5mlVuBALqzpYPe5zNyxAuCiMEjGtU47J9QMAF4+hZrUc+4
	 +PJseiFkhtdIMU8JXJZvJdTZ5FepXZNdNwiLLvC+DNHmO+9/txib3lmrTtk8ZRh69B
	 3jd1/GMUVIUm4PaUGMyc/Y1X8ZAvXwqJWFXo6Uvs0Fl+LbnZyohw9eQXPpfbFuWpDD
	 zicYQ7KOgAEi9GoNAAB0R7oTgu0IJldVaGp4RJ5zeHNyZFf7kwnzq4jPnxgfj8mNkP
	 fv09zpI59Dg8BnPvlT8sHKBYSUJIPeFEJssYw5qHkPDqVDZr3OIbn3EhBCvm+21Vyc
	 1lVz3H3zhyWiA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 20:20:24 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 1 Jul 2024 20:20:23 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>, Dmitry Rokosov <ddrokosov@salutedevices.com>
Subject: [PATCH v2 1/3] dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM
Date: Mon, 1 Jul 2024 20:20:14 +0300
Message-ID: <20240701172016.523402-2-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701172016.523402-1-gnstark@salutedevices.com>
References: <20240701172016.523402-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 186247 [Jul 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/01 15:14:00 #25789329
X-KSMG-AntiVirus-Status: Clean, skipped

The chip has 3 dual-channel PWM modules PWM_AB, PWM_CD, PWM_EF.

Signed-off-by: George Stark <gnstark@salutedevices.com>
Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
---
 Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
index 1d71d4f8f328..da22cb3ed878 100644
--- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
+++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
@@ -37,6 +37,10 @@ properties:
       - enum:
           - amlogic,meson8-pwm-v2
           - amlogic,meson-s4-pwm
+      - items:
+          - enum:
+              - amlogic,meson-a1-pwm
+          - const: amlogic,meson-s4-pwm
       - items:
           - enum:
               - amlogic,meson8b-pwm-v2
-- 
2.25.1


