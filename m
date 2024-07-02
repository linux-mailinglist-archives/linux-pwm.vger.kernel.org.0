Return-Path: <linux-pwm+bounces-2659-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0213D923DFA
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 14:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B1E288E0F
	for <lists+linux-pwm@lfdr.de>; Tue,  2 Jul 2024 12:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E016716F0E6;
	Tue,  2 Jul 2024 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="sl8bjlNJ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D673216D9A7;
	Tue,  2 Jul 2024 12:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923683; cv=none; b=Y+H0qEg4tTv1WsrsW/7p381ENThLiFd3sTbnSaAkt/CCZYdoc27h9O3L4q5efIqTUv+zrrgdlLvcVNWt4Iy6wtTri/939lyiQhJeOLB4lPfRbGeKnaadpp0M9Bojk/OXZsivdkpIyUfbNgqoj0svbZwf3rkcLdAu8QKvocvj0hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923683; c=relaxed/simple;
	bh=WfLjHUDjhk3GKVAYvgi/wSaxXjEoqkb6L+4xQpCpkRE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nJctu4D6fGovRGZsY75c+5j7oZft3o67q/JbqyU+OTuZ6mWaIbBNLmo5ARMxdDqOLuarml+Grg1wYeqXw+GaK84Ti8MOhaxC7ZVtYH6zdnmfVYNqUdWYsI2h4/FGY3rPmAHafeuulVV+kYgkrbJMqF7d+h4tcZ4H/hWWunx1HqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=sl8bjlNJ; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 7731E10000C;
	Tue,  2 Jul 2024 15:34:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 7731E10000C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719923678;
	bh=+BMRFgVBIuPaIZdMG3D0mF67l9umTV7y8YA0DsYyPYs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=sl8bjlNJ302qbicuiJzAb2510VGm5tkQah5SQIwuoL3vMOci486jncsWBXQBxMEVg
	 drL/d5IC7EDfN5RMcavLPtI8eEcGzeu4Dwi1iyntWysVnhV/cuHWepd550oMuwojYd
	 cjrQkkong/6fyy5RwrTmHbIZmnsbj3vmT4m/GQfhnRvu+h9Zj0+eM9xsRFmKymmqeE
	 DycPvrf7YNl2Vvyr+/LBjnxn5mTS1L3DITD20of+JIYU10na+QlvHSaiGWjx8/fu4W
	 bRYZbOAvzFZP6LkP3WBsgCUEyVa8zcxk8ovwftLkVRzpxj6SJ42UHRGjAcGiVUDZeA
	 NmyIJIXHQJj8g==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Tue,  2 Jul 2024 15:34:38 +0300 (MSK)
Received: from work.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 2 Jul 2024 15:34:37 +0300
From: George Stark <gnstark@salutedevices.com>
To: <ukleinek@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <neil.armstrong@linaro.org>, <khilman@baylibre.com>,
	<jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
	<hkallweit1@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-amlogic@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel@salutedevices.com>, George Stark
	<gnstark@salutedevices.com>
Subject: [PATCH v3 0/2] pwm: meson: add pwm support for A1
Date: Tue, 2 Jul 2024 15:34:23 +0300
Message-ID: <20240702123425.584610-1-gnstark@salutedevices.com>
X-Mailer: git-send-email 2.25.1
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
X-KSMG-AntiSpam-Lua-Profiles: 186278 [Jul 02 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, lore.kernel.org:7.1.1;salutedevices.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/02 10:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/02 10:26:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/02 07:59:00 #25796134
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for Amlogic meson A1 SoC family PWM

Changes in v2:
  add patch with optional power-domains to pwm bindings;
  fix syntax in a1 bindigns patch:
  - use enum over const for amlogic,meson-a1-pwm beacuse adding more devices here
    are expected
  - leave only base compatible amlogic,meson-s4-pwm in check section
  dt_binding_check and dtbs_check run ok now;
  previous version: [1]

Changes in v3:
  squash power-domains patch into main bindigns patch
  add conditional to bindings that power-domains property is required only for a1
  previous version: [2]

[1] https://lore.kernel.org/lkml/20240701130113.433169-3-gnstark@salutedevices.com/T/
[2] https://lore.kernel.org/lkml/20240701172016.523402-1-gnstark@salutedevices.com/T/

George Stark (2):
  dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM
  arm64: dts: meson: a1: add definitions for meson PWM

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |  17 ++
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 215 ++++++++++++++++++
 2 files changed, 232 insertions(+)

--
2.25.1


