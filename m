Return-Path: <linux-pwm+bounces-2648-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0000791E687
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 19:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E77F1F24B0B
	for <lists+linux-pwm@lfdr.de>; Mon,  1 Jul 2024 17:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B4C16EBF2;
	Mon,  1 Jul 2024 17:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="D84qxcVr"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DD016E861;
	Mon,  1 Jul 2024 17:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719854437; cv=none; b=dNueLegArB8ToJlsUfU8X0Yi+IwBRS2U2zlhnj4XBjm+3D3aLAUfyWcUcqJQH6AarrxLI6h3wlyekt2SKZ5xfOkg5gC7dicBVFiGU9+VkLkjk2vtlD7mjipBoXUftl6zgntGugHRZNRYHjlWvkDoGE5YpszYQLFFAuusVKoS23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719854437; c=relaxed/simple;
	bh=xHsSOd1hkxWUfI/3yBYsPKjjddKyD70FuNu1WMJtNyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FDdFB9oXnfMDTwVLNLOLsbBdLY775YjlcF+/Fnt1JrVlnrOKaaE+QYvqacNfSwIoJcMoOaNBpK4/4w2aZjGKZiFt254rRTUZ3f0tX2+9Duxk+/UcI++PaOZBAyKtanGRdTj22nv9MrUk+ajPWDpSZ7iw1jZcsfUaSuarmH4r+6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=D84qxcVr; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 91779120004;
	Mon,  1 Jul 2024 20:20:24 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 91779120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1719854424;
	bh=jFmHqby+Fx8yNhsf6UyntoGL3Ko7d35alQh7flkdYzc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=D84qxcVrWgEgllNTUhUQWXbvkoN0L4Qh+b0Hq26+gaDg1XmCHbe7QsAUHCRccoQ8E
	 NETvu5HwS5VuxHaoTx3k4GquywyQLFRHHwT+8upulB8QfJEBGLxz3RuxmWkjs3x3X9
	 Ov2wokGiQzDLKX1w9oKnKomHiUDtgpQR4NI0JlFNhPuSAw3PWIF3BGoPBp36iD6QQi
	 oH0zKA0UIp2KM+M76TycP3UU4PeJ4105hFaqihGTU2slzRwclnv7lattGY2bFswFUS
	 AzUjXSHs45Vd+iTJxVlQ3ER8eDXjmIl9qKxuLEAA7KdkpvzcYVu/oDA++09i3noFZW
	 E6zHxaX+aJryQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Mon,  1 Jul 2024 20:20:23 +0300 (MSK)
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
	<gnstark@salutedevices.com>
Subject: [PATCH v2 0/3] pwm: meson: add pwm support for A1
Date: Mon, 1 Jul 2024 20:20:13 +0300
Message-ID: <20240701172016.523402-1-gnstark@salutedevices.com>
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
X-KSMG-AntiSpam-Lua-Profiles: 186247 [Jul 01 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: gnstark@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 21 0.3.21 ebee5449fc125b2da45f1a6a6bc2c5c0c3ad0e05, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;100.64.160.123:7.1.2;smtp.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;lore.kernel.org:7.1.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/07/01 14:26:00
X-KSMG-LinksScanning: Clean, bases: 2024/07/01 16:02:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/07/01 15:14:00 #25789329
X-KSMG-AntiVirus-Status: Clean, skipped

Add support for Amlogic meson A1 SoC family PWM.

Changes in v2:
  add patch with optional power-domains to pwm bindings;
  fix syntax in a1 bindigns patch:
  - use enum over const for amlogic,meson-a1-pwm beacuse adding more devices here
    are expected
  - leave only base compatible amlogic,meson-s4-pwm in check section
  dt_binding_check and dtbs_check run ok now;
  previos version: [1]

[1] https://lore.kernel.org/lkml/20240701130113.433169-3-gnstark@salutedevices.com/T/

George Stark (3):
  dt-bindings: pwm: amlogic: Add new bindings for meson A1 PWM
  dt-bindings: pwm: amlogic: Add optional power-domains
  arm64: dts: meson: a1: add definitions for meson PWM

 .../devicetree/bindings/pwm/pwm-amlogic.yaml  |   7 +
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi     | 215 ++++++++++++++++++
 2 files changed, 222 insertions(+)

--
2.25.1


